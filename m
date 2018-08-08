Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:39929 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbeHHExx (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Aug 2018 00:53:53 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net-next] ieee802154: hwsim: fix copy-paste error in hwsim_set_edge_lqi()
Date: Wed, 8 Aug 2018 02:43:46 +0000
Message-ID: <1533696226-26445-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

The return value from kzalloc() is not checked correctly. The
test is done against a wrong variable. This patch fix it.

Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1982308..04f4100 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -564,7 +564,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	}
 
 	einfo = kzalloc(sizeof(*einfo), GFP_KERNEL);
-	if (!info) {
+	if (!einfo) {
 		mutex_unlock(&hwsim_phys_lock);
 		return -ENOMEM;
 	}

