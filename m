Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB8C433ED
	for <linux-wpan@archiver.kernel.org>; Sun, 25 Apr 2021 10:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB654613AF
	for <linux-wpan@archiver.kernel.org>; Sun, 25 Apr 2021 10:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhDYKZq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 25 Apr 2021 06:25:46 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50800 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhDYKZq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 25 Apr 2021 06:25:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UWg2IQf_1619346303;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UWg2IQf_1619346303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:25:04 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alex.aring@gmail.com
Cc:     stefan@datenfreihafen.org, davem@davemloft.net, kuba@kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] net/ieee802154: drop unneeded assignment in llsec_iter_devkeys()
Date:   Sun, 25 Apr 2021 18:24:59 +0800
Message-Id: <1619346299-40237-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

In order to keep the code style consistency of the whole file,
redundant return value ‘rc’ and its assignments should be deleted

The clang_analyzer complains as follows:
net/ieee802154/nl-mac.c:1203:12: warning: Although the value stored to
'rc' is used in the enclosing expression, the value is never actually
read from 'rc'

No functional change, only more efficient.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 net/ieee802154/nl-mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 0c1b077..a6a8cf6 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -1184,7 +1184,7 @@ static int llsec_iter_devkeys(struct llsec_dump_data *data)
 {
 	struct ieee802154_llsec_device *dpos;
 	struct ieee802154_llsec_device_key *kpos;
-	int rc = 0, idx = 0, idx2;
+	int idx = 0, idx2;
 
 	list_for_each_entry(dpos, &data->table->devices, list) {
 		if (idx++ < data->s_idx)
@@ -1200,7 +1200,7 @@ static int llsec_iter_devkeys(struct llsec_dump_data *data)
 						      data->nlmsg_seq,
 						      dpos->hwaddr, kpos,
 						      data->dev)) {
-				return rc = -EMSGSIZE;
+				return -EMSGSIZE;
 			}
 
 			data->s_idx2++;
@@ -1209,7 +1209,7 @@ static int llsec_iter_devkeys(struct llsec_dump_data *data)
 		data->s_idx++;
 	}
 
-	return rc;
+	return 0;
 }
 
 int ieee802154_llsec_dump_devkeys(struct sk_buff *skb,
-- 
1.8.3.1

