Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33586 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbaLDK6Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Dec 2014 05:58:16 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 5/5] net/mac802154: No need for an extra space when casting
Date: Thu,  4 Dec 2014 11:52:01 +0100
Message-Id: <1417690321-19450-5-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
References: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Coding style cleanup.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 net/mac802154/llsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 4a661f7..dcf7395 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -298,12 +298,12 @@ static bool llsec_dev_use_shortaddr(__le16 short_addr)
 
 static u32 llsec_dev_hash_short(__le16 short_addr, __le16 pan_id)
 {
-	return ((__force u16) short_addr) << 16 | (__force u16) pan_id;
+	return ((__force u16)short_addr) << 16 | (__force u16)pan_id;
 }
 
 static u64 llsec_dev_hash_long(__le64 hwaddr)
 {
-	return (__force u64) hwaddr;
+	return (__force u64)hwaddr;
 }
 
 static struct mac802154_llsec_device*
-- 
1.9.3

