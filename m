Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53965 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbbE2ER1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 00:17:27 -0400
Date: Fri, 29 May 2015 07:17:23 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150529041723.GN11340@wantstofly.org>
References: <20150528140934.GG11340@wantstofly.org>
 <20150528162702.785e1f1c@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150528162702.785e1f1c@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 04:27:02PM +0200, Phoebe Buckheister wrote:

> > As far as I can see, the ieee802154 stack is putting extended
> > addresses into packets in the wrong byte order.
> > 
> > For example, on an interface with address 00:11:22:33:44:55:66:00,
> > a transmitted 6LoWPAN packet looks like this:
> > 
> > 16:08:31.735570 IEEE 802.15.4 Data packet 
> > 	0x0000:  61cc 09ff ff10 6655 4433 2211 0000 6655
> > 	0x0010:  4433 2211 007a 333a 8000 75be 030c 0001
> > 	0x0020:  4f13 6755 0000 0000 ec38 0b00 0000 0000
> > 	0x0030:  1011 1213 1415 1617 1819 1a1b 1c1d 1e1f
> > 	0x0040:  2021 2223 2425 2627 2829 2a2b 2c2d 2e2f
> > 	0x0050:  3031 3233 3435 3637
> > 
> > The breakdown of the header of this packet is as follows:
> > 
> > 	Frame control field	61 cc
> > 	Sequence number		09
> > 	Destination PAN ID	ff ff
> > 	Destination address	10 66 55 44 33 22 11 00
> > 	Source address		00 66 55 44 33 22 11 00
> > 	Frame payload		7a 33 3a [...]
> > 
> > The on-the-wire addresses look like they are the wrong way around
> > in the packet.
> > 
> > As far as I can see, the problems start as soon as extended
> > addresses enter the 802.15.4 stack from userspace, when
> > mac802154_wpan_mac_addr does this:
> > 
> > ===
> > static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
> > {
> >         struct ieee802154_sub_if_data *sdata =
> > IEEE802154_DEV_TO_SUB_IF(dev); struct sockaddr *addr = p;
> >         __le64 extended_addr;
> > 
> >         if (netif_running(dev))
> >                 return -EBUSY;
> > 
> >         ieee802154_be64_to_le64(&extended_addr, addr->sa_data);
> >         if (!ieee802154_is_valid_extended_addr(extended_addr))
> >                 return -EINVAL;
> > 
> >         memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
> >         sdata->wpan_dev.extended_addr = extended_addr;
> > 
> >         return mac802154_wpan_update_llsec(dev);
> > }
> > ===
> > 
> > An EUI-64 address is really just a sequence of eight bytes
> 
> No.
> 
> > , with none
> > of the bytes more significant or less significant than the other bytes
> > as there are no arithmetic operations (addition, multiplication, etc)
> > defined on EUI-64 addresses that would require disambiguation of the
> > direction in which arithmetic carry should propagate (which would be
> > the thing that would settle the question of which of the bytes of the
> > address is the most significant byte).
> > 
> > But, the 802.15.4 stack has somehow decided that EUI-64 addresses in
> > their natural order (where the OUI is at the start) are in 'big
> > endian' order
> 
> That's because they are. EUIs (48 and 64) are intered by the user as
> big endian numbers in the form of :-separated byte strings.
> 
> > , and has taken it upon itself to convert all addresses
> > entering the kernel from userland to 'little endian' order,
> > byteswapping them in the process, and so all addresses are kept in
> > the kernel in the reverse format, where 00:11:22:33:44:55:66:77 is
> > represented as 77 66 55 44 33 22 11 00 in memory, and when it is time
> > to push a packet out, it simply memcpys this reverse representation
> > of the address into the packet (net/ieee802154/header_ops.c):
> > 
> > ===
> > 	case IEEE802154_ADDR_LONG:
> > 		memcpy(buf + pos, &addr->extended_addr,
> > IEEE802154_ADDR_LEN); pos += IEEE802154_ADDR_LEN;
> > 		break;
> > ===
> > 
> > I don't follow the logic here, but I suspect that it's all wrong
> > (just like so many other things in the 802.15.4 stack, sigh), and I
> > think that we may need to undo this, however, I'm afraid that this
> > would break interoperability with contiki and $DEITY knows how many
> > other things in the process.
> > 
> > (I think the same problem exists with short addresses and PAN IDs.)
> > 
> > Any thoughts?
> 
> Yes, you are wrong. IEEE 802.15.4 §5.2 states:
> 
> The frames in the MAC sublayer are described as a sequence of fields in
> a specific order. All frame formats in this subclause are depicted in
> the order in which they are transmitted by the PHY, from left to right,
> where the leftmost bit is transmitted first in time. Bits within each
> field are numbered from 0 (leftmost and least significant) to k – 1
> (rightmost and most significant), where the length of the field is k
> bits. Fields that are longer than a single octet are sent to the PHY in
> the order from the octet containing the lowest numbered bits to the
> octet containing the highest numbered bits.
> 
> The extended addresses are 64 bit *numbers* without endianness, not a
> sequence of eight bytes [1]. (Actually, [1] says both. But they
> implicitly state that the "string of eight octets" that form an EUI64
> is a single big endian number, by explicit example.) Thus, they have to
> be transmitted in little endian byte order. Same goes for the short
> addresses, those are 16 bit numbers.
> 
> [1] http://standards.ieee.org/develop/regauth/tut/eui64.pdf

OK, as this document equates AC-DE-48-23-45-67-AB-CD with the
64 bit number ACDE48234567ABCD, I'll concede that EUIs are big
endian numbers.

However, I still disagree with writing out packet headers with
these numbers (as well as PAN IDs and short addresses) in little
endian order -- and I don't see how the paragraph you quoted from
802.15.4 supports this point of view (I actually think that it
supports the point of view that they should be transmitted in big
endian byte order).

The paragraph you quoted says the following:

| The frames in the MAC sublayer are described as a sequence of fields in
| a specific order. All frame formats in this subclause are depicted in
| the order in which they are transmitted by the PHY, from left to right,
| where the leftmost bit is transmitted first in time.

This suggests to me that the EUI-64 address 00:11:22:33:44:55:66:77,
(where 00:11:22 would be an MA-L OUI) should be transmitted as the
byte sequence 00 11 22 33 44 55 66 77 -- after all, the leftmost byte
is 00, and therefore it should be transmitted first?


| Bits within each field are numbered from 0 (leftmost and least
| significant) to k – 1 (rightmost and most significant), where the
| length of the field is k bits.

This explains why the bit numbering in fields such as the Frame
Control field is the way it is:

	http://i.imgur.com/TT4Wwdn.png

(But even the IEEE seems to acknowledge that the way they do bit
numbering is confusing, and I think that this is the reason why the
Frame Type field in the next paragraph is documented in b2 b1 b0
bit order even though the bit transmission order is b0 b1 b2.)


| Fields that are longer than a single octet are sent to the PHY in
| the order from the octet containing the lowest numbered bits to the
| octet containing the highest numbered bits.

As the leftmost octet contains bit 0, this reaffirms that the
leftmost octet should be transmitted first.


Also, https://standards.ieee.org/develop/regauth/tut/eui64.pdf
contains this example:

|         OUI(24)          |            extension identifier            | field
|                          |                                            |
| eui[0] | eui[1] | eui[2] | eui[3] | eui[4] | eui[5] | eui[6] | eui[7] | order
|        |        |        |        |        |        |        |        |
|   AC   |   DE   |   48   |   23   |   45   |   67   |   AB   |   CD   |

10101100 11011110 01001000 00100011 01000101 01100111 10101011 11001101 binary

This also seems to suggest that the bytes containing the OUI are the
lowest numbered bytes and should therefore be transmitted first.
(And on the wire, the transmitted bits would be 0 0 1 1 0 1 0 1 |
0 1 1 1 1 0 1 1 | etc., as bit 0 is the least significant bit of
eui[0] -- the 'binary' representation in the example is not in
transmission order.)

Also, every other 802 link layer I know of transmits the OUI bytes
of the EUI first, and at least for 802.3 ("Ethernet"), the point of
transmitting the least significant bit first is so that the first
transmitted header bit is the group address bit of the destination
ethernet address, see e.g. this section from 802.3-2012 3.2.3:

	http://i.imgur.com/YfaWVwT.png

(And note how the I/G and U/L bits are on the very left, even though
when we write out an EUI-48, the I/G bit is 01:00:00:00:00:00, and
the U/L bit is 02:00:00:00:00:00.)

I don't know of any EUI-{48,64} users that transmit the OUI bytes
including the I/G bit and the U/L bit as the very last bytes of the
address, but this is what you are arguing for, and I'm really not
sure why you think it should be like this -- the references you
quoted all seem to contradict the conclusion you're drawing from
them, in my humble opinion.
