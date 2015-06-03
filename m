Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:48124 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbFCHuW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 03:50:22 -0400
Date: Wed, 3 Jun 2015 10:50:19 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] ieee802154: Fix sockaddr_ieee802154 implicit padding
 information leak.
Message-ID: <20150603075019.GA26063@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org

The AF_IEEE802154 sockaddr looks like this:

	struct sockaddr_ieee802154 {
		sa_family_t family; /* AF_IEEE802154 */
		struct ieee802154_addr_sa addr;
	};

	struct ieee802154_addr_sa {
		int addr_type;
		u16 pan_id;
		union {
			u8 hwaddr[IEEE802154_ADDR_LEN];
			u16 short_addr;
		};
	};

On most architectures there will be implicit structure padding here,
in two different places:

* In struct sockaddr_ieee802154, two bytes of padding between 'family'
  (unsigned short) and 'addr', so that 'addr' starts on a four byte
  boundary.

* In struct ieee802154_addr_sa, two bytes at the end of the structure,
  to make the structure 16 bytes.

When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
ieee802154 stack constructs a struct sockaddr_ieee802154 on the
kernel stack without clearing these padding fields, and, depending
on the addr_type, between four and ten bytes of uncleared kernel
stack will be copied to userspace.

We can't just insert two 'u16 __pad's in the right places and zero
those before copying an address to userspace, as not all architectures
insert this implicit padding -- from a quick test it seems that avr32,
cris and m68k don't insert this padding, while every other architecture
that I have cross compilers for does insert this padding.

The easiest way to plug the leak is to just memset the whole struct
sockaddr_ieee802154 before filling in the fields we want to fill in,
and that's what this patch does.

Cc: stable@vger.kernel.org
Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Acked-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 02abef2..b6eacf3 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -731,6 +731,12 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	sock_recv_ts_and_drops(msg, sk, skb);
 
 	if (saddr) {
+		/* Clear the implicit padding in struct sockaddr_ieee802154
+		 * (16 bits between 'family' and 'addr') and in struct
+		 * ieee802154_addr_sa (16 bits at the end of the structure).
+		 */
+		memset(saddr, 0, sizeof(*saddr));
+
 		saddr->family = AF_IEEE802154;
 		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
 		*addr_len = sizeof(*saddr);
-- 
2.4.1
