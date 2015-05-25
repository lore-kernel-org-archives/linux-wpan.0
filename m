Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52623 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbEYNRQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 09:17:16 -0400
Date: Mon, 25 May 2015 16:17:12 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: information leak in struct sockaddr_ieee802154 processing
Message-ID: <20150525131712.GP11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi!

There is a kernel stack information leak in net/ieee802154/socket.c,
in the dgram_recvmsg() handling of socket addresses.

The AF_IEEE802154 sockaddr looks as follows:

	struct ieee802154_addr_sa {
		int addr_type;
		u16 pan_id;
		union {
			u8 hwaddr[IEEE802154_ADDR_LEN];
			u16 short_addr;
		};
	};

	struct sockaddr_ieee802154 {
		sa_family_t family; /* AF_IEEE802154 */
		struct ieee802154_addr_sa addr;
	};

On most architectures that Linux runs on, there will be implicit
structure padding here, in two different places:

* In struct sockaddr_ieee802154, two bytes of padding between 'family'
  (unsigned short) and 'addr', so that 'addr' starts on a four byte
  boundary.

* In struct ieee802154_addr_sa, two bytes at the end of the structure,
  to make the structure 16 bytes.

When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
ieee802154 stack constructs a sockaddr_ieee802154 on the kernel stack
(stack space allocated in net/socket.c, SYSCALL_DEFINE6(recvfrom, [..])
and/or __sys_recvmsg()) without clearing these padding fields, and
between four and ten bytes (depending on the addr_type) of uncleared
kernel stack will be copied to userspace.

A suggested fix is below, however, this unconditionally inserts
explicit padding even on architectures that didn't insert implicit
padding in the first place.

I tested with cross-compilers for aarch64, alpha, arm, avr32, bfin,
c6x, cris, frv, h8300, hppa, hppa64, ia64, m32r, m68k, microblaze,
mips64, mn10300, nios2, powerpc64, ppc64, s390x, sh, sh64, sparc64,
tile, x86_64 and xtensa (every architecture that my Fedora box has
cross-compilers for), and out of these, avr32/cris/h8300/m68k don't
insert any implicit padding, while all the other architectures do
insert 2 bytes of padding in each of the two places described above.

As far as I can tell, the Linux kernel doesn't run on h8300, so
that means that we either unconditionally insert the padding as per
the patch below and break the userland ABI on avr32/cris/m68k in the
process, which doesn't seem like a very attractive option, or
conditionalise the padding on the architecture we're running on
which will get rather messy.

Any thoughts?


thanks,
Lennert



commit b973b3b4098d40f5e9608edd39d80697f246a99f
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Sun May 17 09:24:06 2015 +0300

    ieee802154: Fix sockaddr_ieee802154 implicit padding information leak.
    
    Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index 7d38e2f..fe3c221 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -39,6 +39,7 @@ struct ieee802154_addr_sa {
 		u8 hwaddr[IEEE802154_ADDR_LEN];
 		u16 short_addr;
 	};
+	u16 __pad;
 };
 
 #define IEEE802154_PANID_BROADCAST	0xffff
@@ -47,6 +48,7 @@ struct ieee802154_addr_sa {
 
 struct sockaddr_ieee802154 {
 	sa_family_t family; /* AF_IEEE802154 */
+	u16 __pad;
 	struct ieee802154_addr_sa addr;
 };
 
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 94a2970..69452fc 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -207,11 +207,14 @@ static inline void ieee802154_addr_to_sa(struct ieee802154_addr_sa *sa,
 	switch (a->mode) {
 	case IEEE802154_ADDR_SHORT:
 		sa->short_addr = le16_to_cpu(a->short_addr);
+		memset(sa->hwaddr + 2, 0, IEEE802154_ADDR_LEN - 2);
 		break;
 	case IEEE802154_ADDR_LONG:
 		ieee802154_devaddr_to_raw(sa->hwaddr, a->extended_addr);
 		break;
 	}
+
+	sa->__pad = 0;
 }
 
 /*
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index b60c65f..22f85bc 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -740,6 +740,7 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	if (saddr) {
 		saddr->family = AF_IEEE802154;
+		saddr->__pad = 0;
 		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
 		*addr_len = sizeof(*saddr);
 	}
