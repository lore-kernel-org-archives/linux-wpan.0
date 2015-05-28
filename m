Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:54181 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbE1O1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 10:27:06 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t4SER3gh024224
	for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 16:27:03 +0200
Date: Thu, 28 May 2015 16:27:02 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150528162702.785e1f1c@zoidberg>
In-Reply-To: <20150528140934.GG11340@wantstofly.org>
References: <20150528140934.GG11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Thu, 28 May 2015 17:09:34 +0300
Lennert Buytenhek <buytenh@wantstofly.org> wrote:

> As far as I can see, the ieee802154 stack is putting extended
> addresses into packets in the wrong byte order.
> 
> For example, on an interface with address 00:11:22:33:44:55:66:00,
> a transmitted 6LoWPAN packet looks like this:
> 
> 16:08:31.735570 IEEE 802.15.4 Data packet 
> 	0x0000:  61cc 09ff ff10 6655 4433 2211 0000 6655
> 	0x0010:  4433 2211 007a 333a 8000 75be 030c 0001
> 	0x0020:  4f13 6755 0000 0000 ec38 0b00 0000 0000
> 	0x0030:  1011 1213 1415 1617 1819 1a1b 1c1d 1e1f
> 	0x0040:  2021 2223 2425 2627 2829 2a2b 2c2d 2e2f
> 	0x0050:  3031 3233 3435 3637
> 
> The breakdown of the header of this packet is as follows:
> 
> 	Frame control field	61 cc
> 	Sequence number		09
> 	Destination PAN ID	ff ff
> 	Destination address	10 66 55 44 33 22 11 00
> 	Source address		00 66 55 44 33 22 11 00
> 	Frame payload		7a 33 3a [...]
> 
> The on-the-wire addresses look like they are the wrong way around
> in the packet.
> 
> As far as I can see, the problems start as soon as extended
> addresses enter the 802.15.4 stack from userspace, when
> mac802154_wpan_mac_addr does this:
> 
> ===
> static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
> {
>         struct ieee802154_sub_if_data *sdata =
> IEEE802154_DEV_TO_SUB_IF(dev); struct sockaddr *addr = p;
>         __le64 extended_addr;
> 
>         if (netif_running(dev))
>                 return -EBUSY;
> 
>         ieee802154_be64_to_le64(&extended_addr, addr->sa_data);
>         if (!ieee802154_is_valid_extended_addr(extended_addr))
>                 return -EINVAL;
> 
>         memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
>         sdata->wpan_dev.extended_addr = extended_addr;
> 
>         return mac802154_wpan_update_llsec(dev);
> }
> ===
> 
> An EUI-64 address is really just a sequence of eight bytes

No.

> , with none
> of the bytes more significant or less significant than the other bytes
> as there are no arithmetic operations (addition, multiplication, etc)
> defined on EUI-64 addresses that would require disambiguation of the
> direction in which arithmetic carry should propagate (which would be
> the thing that would settle the question of which of the bytes of the
> address is the most significant byte).
> 
> But, the 802.15.4 stack has somehow decided that EUI-64 addresses in
> their natural order (where the OUI is at the start) are in 'big
> endian' order

That's because they are. EUIs (48 and 64) are intered by the user as
big endian numbers in the form of :-separated byte strings.

> , and has taken it upon itself to convert all addresses
> entering the kernel from userland to 'little endian' order,
> byteswapping them in the process, and so all addresses are kept in
> the kernel in the reverse format, where 00:11:22:33:44:55:66:77 is
> represented as 77 66 55 44 33 22 11 00 in memory, and when it is time
> to push a packet out, it simply memcpys this reverse representation
> of the address into the packet (net/ieee802154/header_ops.c):
> 
> ===
> 	case IEEE802154_ADDR_LONG:
> 		memcpy(buf + pos, &addr->extended_addr,
> IEEE802154_ADDR_LEN); pos += IEEE802154_ADDR_LEN;
> 		break;
> ===
> 
> I don't follow the logic here, but I suspect that it's all wrong
> (just like so many other things in the 802.15.4 stack, sigh), and I
> think that we may need to undo this, however, I'm afraid that this
> would break interoperability with contiki and $DEITY knows how many
> other things in the process.
> 
> (I think the same problem exists with short addresses and PAN IDs.)
> 
> Any thoughts?

Yes, you are wrong. IEEE 802.15.4 §5.2 states:

The frames in the MAC sublayer are described as a sequence of fields in
a specific order. All frame formats in this subclause are depicted in
the order in which they are transmitted by the PHY, from left to right,
where the leftmost bit is transmitted first in time. Bits within each
field are numbered from 0 (leftmost and least significant) to k – 1
(rightmost and most significant), where the length of the field is k
bits. Fields that are longer than a single octet are sent to the PHY in
the order from the octet containing the lowest numbered bits to the
octet containing the highest numbered bits.

The extended addresses are 64 bit *numbers* without endianness, not a
sequence of eight bytes [1]. (Actually, [1] says both. But they
implicitly state that the "string of eight octets" that form an EUI64
is a single big endian number, by explicit example.) Thus, they have to
be transmitted in little endian byte order. Same goes for the short
addresses, those are 16 bit numbers.

[1] http://standards.ieee.org/develop/regauth/tut/eui64.pdf

> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

