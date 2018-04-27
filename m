Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:45126 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759114AbeD0VWG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Apr 2018 17:22:06 -0400
Received: by mail-io0-f193.google.com with SMTP id r22-v6so4008659ioc.12
        for <linux-wpan@vger.kernel.org>; Fri, 27 Apr 2018 14:22:06 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [RFC PATCH wpan-next 2/2] ieee802154: fakelb: add deprecated msg while probe
Date: Fri, 27 Apr 2018 17:21:54 -0400
Message-Id: <20180427212154.29582-3-aring@mojatatu.com>
In-Reply-To: <20180427212154.29582-1-aring@mojatatu.com>
References: <20180427212154.29582-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

Since mac802154_hwsim the fakelb driver will get deprecated. This patch will
notifier all users of fakelb to switch to the new mac802154_hwsim driver.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 drivers/net/ieee802154/fakelb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0d673f7682ee..d44cc27a13c7 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -254,6 +254,9 @@ static __init int fakelb_init_module(void)
 {
 	ieee802154fake_dev = platform_device_register_simple(
 			     "ieee802154fakelb", -1, NULL, 0);
+
+	pr_warn("fakelb driver is marked as deprecated, please use mac802154_hwsim!");
+
 	return platform_driver_register(&ieee802154fake_driver);
 }
 
-- 
2.11.0

