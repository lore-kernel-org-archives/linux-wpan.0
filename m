Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:54813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeHHFUt (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Aug 2018 01:20:49 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net-next] ieee802154: hwsim: fix missing unlock on error in hwsim_add_one()
Date: Wed, 8 Aug 2018 03:10:39 +0000
Message-ID: <1533697839-85602-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Add the missing unlock before return from function hwsim_add_one()
in the error handling case.

Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index f4e9205..44d398c 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -810,8 +810,10 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	mutex_lock(&hwsim_phys_lock);
 	if (init) {
 		err = hwsim_subscribe_all_others(phy);
-		if (err < 0)
+		if (err < 0) {
+			mutex_unlock(&hwsim_phys_lock);
 			goto err_reg;
+		}
 	}
 	list_add_tail(&phy->list, &hwsim_phys);
 	mutex_unlock(&hwsim_phys_lock);

