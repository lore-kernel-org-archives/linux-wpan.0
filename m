Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41337 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaKLChq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:46 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so3477272wid.4
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:45 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/18] mac820154: rename sdata next to tmp
Date: Wed, 12 Nov 2014 03:36:49 +0100
Message-Id: <1415759825-8309-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch is just a cleanup to name the temporary variable for
protected list for each loop as tmp.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 8d90fba..8b21d20 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -538,9 +538,9 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 
 void ieee802154_remove_interfaces(struct ieee802154_local *local)
 {
-	struct ieee802154_sub_if_data *sdata, *next;
+	struct ieee802154_sub_if_data *sdata, *tmp;
 
-	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
+	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
 		mutex_lock(&sdata->local->iflist_mtx);
 		list_del(&sdata->list);
 		mutex_unlock(&sdata->local->iflist_mtx);
-- 
2.1.3

