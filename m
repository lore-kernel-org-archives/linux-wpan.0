Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx139-tc.baidu.com ([61.135.168.139]:58944 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbfBSFR2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 19 Feb 2019 00:17:28 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 148B211C0060
        for <linux-wpan@vger.kernel.org>; Tue, 19 Feb 2019 13:10:29 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ieee802154:: propagate genlmsg_reply return code
Date: Tue, 19 Feb 2019 13:10:29 +0800
Message-Id: <1550553029-1480-1-git-send-email-lirongqing@baidu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

genlmsg_reply can fail, so propagate its return code

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index b6743f03dce0..3b88846de31b 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -324,7 +324,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			goto out_err;
 		}
 
-		genlmsg_reply(skb, info);
+		res = genlmsg_reply(skb, info);
 		break;
 	}
 
-- 
2.16.2
