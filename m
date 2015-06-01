Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:46076 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbFANpz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 09:45:55 -0400
Date: Mon, 1 Jun 2015 16:45:51 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: information leak in struct sockaddr_ieee802154 processing
Message-ID: <20150601134551.GD1897@wantstofly.org>
References: <20150525131712.GP11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150525131712.GP11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Mon, May 25, 2015 at 04:17:12PM +0300, Lennert Buytenhek wrote:

> There is a kernel stack information leak in net/ieee802154/socket.c,
> in the dgram_recvmsg() handling of socket addresses.
> 
> The AF_IEEE802154 sockaddr looks as follows:
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
> 	struct sockaddr_ieee802154 {
> 		sa_family_t family; /* AF_IEEE802154 */
> 		struct ieee802154_addr_sa addr;
> 	};
> 
> On most architectures that Linux runs on, there will be implicit
> structure padding here, in two different places:
> 
> * In struct sockaddr_ieee802154, two bytes of padding between 'family'
>   (unsigned short) and 'addr', so that 'addr' starts on a four byte
>   boundary.
> 
> * In struct ieee802154_addr_sa, two bytes at the end of the structure,
>   to make the structure 16 bytes.
> 
> When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
> ieee802154 stack constructs a sockaddr_ieee802154 on the kernel stack
> (stack space allocated in net/socket.c, SYSCALL_DEFINE6(recvfrom, [..])
> and/or __sys_recvmsg()) without clearing these padding fields, and
> between four and ten bytes (depending on the addr_type) of uncleared
> kernel stack will be copied to userspace.
> 
> A suggested fix is below, however, this unconditionally inserts
> explicit padding even on architectures that didn't insert implicit
> padding in the first place.
> 
> I tested with cross-compilers for aarch64, alpha, arm, avr32, bfin,
> c6x, cris, frv, h8300, hppa, hppa64, ia64, m32r, m68k, microblaze,
> mips64, mn10300, nios2, powerpc64, ppc64, s390x, sh, sh64, sparc64,
> tile, x86_64 and xtensa (every architecture that my Fedora box has
> cross-compilers for), and out of these, avr32/cris/h8300/m68k don't
> insert any implicit padding, while all the other architectures do
> insert 2 bytes of padding in each of the two places described above.
> 
> As far as I can tell, the Linux kernel doesn't run on h8300, so
> that means that we either unconditionally insert the padding as per
> the patch below and break the userland ABI on avr32/cris/m68k in the
> process, which doesn't seem like a very attractive option, or
> conditionalise the padding on the architecture we're running on
> which will get rather messy.
> 
> Any thoughts?

How about this way of solving it instead -- any thoughts on this?


 From 8e8aef6d7badb33f50ca04c03a7c884b95733f16 Mon Sep 17 00:00:00 2001
From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Sun, 17 May 2015 09:24:06 +0300
Subject: [PATCH] ieee802154: Fix sockaddr_ieee802154 implicit padding
 information leak.

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

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
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
