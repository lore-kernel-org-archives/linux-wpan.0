Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36325 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbIITKE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 15:10:04 -0400
Received: by wicgb1 with SMTP id gb1so128246867wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2015 12:10:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] mac802154: llsec: fix device deletion from list
Date: Wed,  9 Sep 2015 21:09:39 +0200
Message-Id: <1441825780-6461-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

This patch adds a missing list_del when a device description will be
deleted.

Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/llsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 985e939..7799d3c 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -401,6 +401,7 @@ int mac802154_llsec_dev_del(struct mac802154_llsec *sec, __le64 device_addr)
 
 	hash_del_rcu(&pos->bucket_s);
 	hash_del_rcu(&pos->bucket_hw);
+	list_del_rcu(&pos->dev.list);
 	call_rcu(&pos->rcu, llsec_dev_free_rcu);
 
 	return 0;
-- 
2.5.1

