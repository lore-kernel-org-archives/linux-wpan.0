Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46047 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaLELx0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 06:53:26 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so561315pab.30
        for <linux-wpan@vger.kernel.org>; Fri, 05 Dec 2014 03:53:26 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/2] mac802154: use goto label on failure
Date: Fri,  5 Dec 2014 17:19:09 +0530
Message-Id: <1417780150-4033-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/rx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 041dbd5..c0d67b2 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -85,8 +85,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 	default:
 		spin_unlock_bh(&sdata->mib_lock);
 		pr_debug("invalid dest mode\n");
-		kfree_skb(skb);
-		return NET_RX_DROP;
+		goto fail;
 	}
 
 	spin_unlock_bh(&sdata->mib_lock);
-- 
1.7.9.5

