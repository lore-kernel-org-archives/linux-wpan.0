Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53803 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbbE1OJf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 10:09:35 -0400
Date: Thu, 28 May 2015 17:09:34 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [RFC] the problem of on-the-wire byte order in ieee802154
Message-ID: <20150528140934.GG11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

As far as I can see, the ieee802154 stack is putting extended
addresses into packets in the wrong byte order.

For example, on an interface with address 00:11:22:33:44:55:66:00,
a transmitted 6LoWPAN packet looks like this:

16:08:31.735570 IEEE 802.15.4 Data packet 
	0x0000:  61cc 09ff ff10 6655 4433 2211 0000 6655
	0x0010:  4433 2211 007a 333a 8000 75be 030c 0001
	0x0020:  4f13 6755 0000 0000 ec38 0b00 0000 0000
	0x0030:  1011 1213 1415 1617 1819 1a1b 1c1d 1e1f
	0x0040:  2021 2223 2425 2627 2829 2a2b 2c2d 2e2f
	0x0050:  3031 3233 3435 3637

The breakdown of the header of this packet is as follows:

	Frame control field	61 cc
	Sequence number		09
	Destination PAN ID	ff ff
	Destination address	10 66 55 44 33 22 11 00
	Source address		00 66 55 44 33 22 11 00
	Frame payload		7a 33 3a [...]

The on-the-wire addresses look like they are the wrong way around
in the packet.

As far as I can see, the problems start as soon as extended
addresses enter the 802.15.4 stack from userspace, when
mac802154_wpan_mac_addr does this:

===
static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
{
        struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
        struct sockaddr *addr = p;
        __le64 extended_addr;

        if (netif_running(dev))
                return -EBUSY;

        ieee802154_be64_to_le64(&extended_addr, addr->sa_data);
        if (!ieee802154_is_valid_extended_addr(extended_addr))
                return -EINVAL;

        memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
        sdata->wpan_dev.extended_addr = extended_addr;

        return mac802154_wpan_update_llsec(dev);
}
===

An EUI-64 address is really just a sequence of eight bytes, with none
of the bytes more significant or less significant than the other bytes
as there are no arithmetic operations (addition, multiplication, etc)
defined on EUI-64 addresses that would require disambiguation of the
direction in which arithmetic carry should propagate (which would be
the thing that would settle the question of which of the bytes of the
address is the most significant byte).

But, the 802.15.4 stack has somehow decided that EUI-64 addresses in
their natural order (where the OUI is at the start) are in 'big endian'
order, and has taken it upon itself to convert all addresses entering
the kernel from userland to 'little endian' order, byteswapping them
in the process, and so all addresses are kept in the kernel in the
reverse format, where 00:11:22:33:44:55:66:77 is represented as 77 66
55 44 33 22 11 00 in memory, and when it is time to push a packet out,
it simply memcpys this reverse representation of the address into the
packet (net/ieee802154/header_ops.c):

===
	case IEEE802154_ADDR_LONG:
		memcpy(buf + pos, &addr->extended_addr, IEEE802154_ADDR_LEN);
		pos += IEEE802154_ADDR_LEN;
		break;
===

I don't follow the logic here, but I suspect that it's all wrong
(just like so many other things in the 802.15.4 stack, sigh), and I
think that we may need to undo this, however, I'm afraid that this
would break interoperability with contiki and $DEITY knows how many
other things in the process.

(I think the same problem exists with short addresses and PAN IDs.)

Any thoughts?
