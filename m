Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40401 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbbFCJhK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 05:37:10 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] ieee802154: Fix sockaddr_ieee802154 implicit padding information leak.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150603075019.GA26063@wantstofly.org>
Date: Wed, 3 Jun 2015 11:37:07 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <EEB5DBE3-0F8D-4F7A-882F-44B0DF3FAE4A@holtmann.org>
References: <20150603075019.GA26063@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> The AF_IEEE802154 sockaddr looks like this:
> 
> 	struct sockaddr_ieee802154 {
> 		sa_family_t family; /* AF_IEEE802154 */
> 		struct ieee802154_addr_sa addr;
> 	};
> 
> 	struct ieee802154_addr_sa {
> 		int addr_type;
> 		u16 pan_id;
> 		union {
> 			u8 hwaddr[IEEE802154_ADDR_LEN];
> 			u16 short_addr;
> 		};
> 	};
> 
> On most architectures there will be implicit structure padding here,
> in two different places:
> 
> * In struct sockaddr_ieee802154, two bytes of padding between 'family'
>  (unsigned short) and 'addr', so that 'addr' starts on a four byte
>  boundary.
> 
> * In struct ieee802154_addr_sa, two bytes at the end of the structure,
>  to make the structure 16 bytes.
> 
> When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
> ieee802154 stack constructs a struct sockaddr_ieee802154 on the
> kernel stack without clearing these padding fields, and, depending
> on the addr_type, between four and ten bytes of uncleared kernel
> stack will be copied to userspace.
> 
> We can't just insert two 'u16 __pad's in the right places and zero
> those before copying an address to userspace, as not all architectures
> insert this implicit padding -- from a quick test it seems that avr32,
> cris and m68k don't insert this padding, while every other architecture
> that I have cross compilers for does insert this padding.
> 
> The easiest way to plug the leak is to just memset the whole struct
> sockaddr_ieee802154 before filling in the fields we want to fill in,
> and that's what this patch does.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/socket.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

