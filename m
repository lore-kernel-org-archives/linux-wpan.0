Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53776 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbE1Mig (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 08:38:36 -0400
Date: Thu, 28 May 2015 15:38:32 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of random
 EUI-64 addresses.
Message-ID: <20150528123832.GD11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Currently, ieee802154_random_extended_addr() has a 50% chance of
generating a group (multicast) address, while this function is used
for generating station addresses (which can't be group addresses)
for interfaces that don't have a hardware-provided address.

Also, in case get_random_bytes() generates the EUI-64 address
00:00:00:00:00:00:00:00 (extremely unlikely), which is an invalid
address, ieee802154_random_extended_addr() reacts by changing it
to 01:00:00:00:00:00:00:00, which is an invalid station address as
well, as it is a group address.

This patch changes the address generation procedure to grab eight
random bytes, treat that as an EUI-64, and then clear the Group
address bit and set the Locally Administered bit, which is in
line with how eth_random_addr() generates random EUI-48s.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 include/linux/ieee802154.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 8872ca1..552210d 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -244,9 +244,9 @@ static inline void ieee802154_random_extended_addr(__le64 *addr)
 {
 	get_random_bytes(addr, IEEE802154_EXTENDED_ADDR_LEN);
 
-	/* toggle some bit if we hit an invalid extended addr */
-	if (!ieee802154_is_valid_extended_addr(*addr))
-		((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] ^= 0x01;
+	/* clear the group bit, and set the locally administered bit */
+	((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] &= ~0x01;
+	((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] |= 0x02;
 }
 
 #endif /* LINUX_IEEE802154_H */
-- 
2.4.1

