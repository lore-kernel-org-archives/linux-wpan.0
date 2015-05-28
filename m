Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53778 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbE1Mio (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 08:38:44 -0400
Date: Thu, 28 May 2015 15:38:43 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH,RFC bluetooth-next 2/2] ieee802154: Fix EUI-64 station
 address validation.
Message-ID: <20150528123843.GE11340@wantstofly.org>
References: <53cacc49e75b59f7b6458075b032be16f1133abb.1432816524.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53cacc49e75b59f7b6458075b032be16f1133abb.1432816524.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Refuse to allow setting an EUI-64 group address as an interface
address, as those are not valid station addresses.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 include/linux/ieee802154.h | 10 ++++------
 net/mac802154/iface.c      |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 552210d..1dc1f4e 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -225,15 +225,13 @@ static inline bool ieee802154_is_valid_psdu_len(const u8 len)
  * ieee802154_is_valid_psdu_len - check if extended addr is valid
  * @addr: extended addr to check
  */
-static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
+static inline bool ieee802154_is_valid_extended_unicast_addr(const __le64 addr)
 {
-	/* These EUI-64 addresses are reserved by IEEE. 0xffffffffffffffff
-	 * is used internally as extended to short address broadcast mapping.
-	 * This is currently a workaround because neighbor discovery can't
-	 * deal with short addresses types right now.
+	/* Bail out if the address is all zero, or if the group
+	 * address bit is set.
 	 */
 	return ((addr != cpu_to_le64(0x0000000000000000ULL)) &&
-		(addr != cpu_to_le64(0xffffffffffffffffULL)));
+		!(addr & cpu_to_le64(0x0100000000000000ULL)));
 }
 
 /**
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index b544b5d..6ac0239 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -126,7 +126,7 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 		return -EBUSY;
 
 	ieee802154_be64_to_le64(&extended_addr, addr->sa_data);
-	if (!ieee802154_is_valid_extended_addr(extended_addr))
+	if (!ieee802154_is_valid_extended_unicast_addr(extended_addr))
 		return -EINVAL;
 
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
@@ -539,7 +539,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	switch (type) {
 	case NL802154_IFTYPE_NODE:
 		ndev->type = ARPHRD_IEEE802154;
-		if (ieee802154_is_valid_extended_addr(extended_addr))
+		if (ieee802154_is_valid_extended_unicast_addr(extended_addr))
 			ieee802154_le64_to_be64(ndev->dev_addr, &extended_addr);
 		else
 			memcpy(ndev->dev_addr, ndev->perm_addr,
-- 
2.4.1

