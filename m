Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35636 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbIRJay (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 05:30:54 -0400
Received: by wicge5 with SMTP id ge5so24499475wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2015 02:30:53 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/5] mac802154: llsec: fix device deletion from list
Date: Fri, 18 Sep 2015 11:30:40 +0200
Message-Id: <1442568644-2158-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
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
2.5.2

