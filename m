Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43225 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbaKLChv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:51 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so3483272wiv.2
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:50 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/18] ieee802154: cleanup cfg802154 intendation
Date: Wed, 12 Nov 2014 03:36:54 +0100
Message-Id: <1415759825-8309-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This is patch is cleanup to have a similar indentation like cfg80211
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 3695152..8a3edc5 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -35,8 +35,8 @@ struct cfg802154_ops {
 	struct net_device * (*add_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
 							   const char *name,
 							   int type);
-	void (*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
-					    struct net_device *dev);
+	void	(*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
+					       struct net_device *dev);
 };
 
 struct wpan_phy {
-- 
2.1.3

