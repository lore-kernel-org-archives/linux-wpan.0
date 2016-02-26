Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51133 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462AbcBZIG3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.Org>);
	Fri, 26 Feb 2016 03:06:29 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next] 6lowpan: iphc: fix invalid case handling
Date: Fri, 26 Feb 2016 09:06:07 +0100
Message-Id: <1456473967-26721-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, dan.carpenter@oracle.com, Alexander Aring <aar@pengutronix.de>

This patch fixes the return value in a case which should never occur.
Instead returning "-EINVAL" we return LOWPAN_IPHC_DAM_00 which is
invalid on context based addresses. Also change the WARN_ON_ONCE to
WARN_ONCE which was suggested by Dan Carpenter.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 06287ac..7217251 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -811,8 +811,8 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct in6_addr *ipaddr,
 		goto out;
 	}
 
-	WARN_ON_ONCE("context found but no address mode matched\n");
-	return -EINVAL;
+	WARN_ONCE(1, "context found but no address mode matched\n");
+	return LOWPAN_IPHC_DAM_00;
 out:
 
 	if (sam)
-- 
2.7.1

