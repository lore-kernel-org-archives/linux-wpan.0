Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:42082 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGNQww (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Jul 2018 12:52:52 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so611906ioq.9
        for <linux-wpan@vger.kernel.org>; Sat, 14 Jul 2018 09:33:16 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCHv2 wpan-next 2/2] ieee802154: fakelb: add deprecated msg while probe
Date: Sat, 14 Jul 2018 12:33:06 -0400
Message-Id: <20180714163306.5629-3-aring@mojatatu.com>
In-Reply-To: <20180714163306.5629-1-aring@mojatatu.com>
References: <20180714163306.5629-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aring@mojatatu.com>

Since mac802154_hwsim the fakelb driver will get deprecated. This patch will
notifier all users of fakelb to switch to the new mac802154_hwsim driver.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 drivers/net/ieee802154/fakelb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0d673f7682ee..3136278b10be 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -254,6 +254,9 @@ static __init int fakelb_init_module(void)
 {
 	ieee802154fake_dev = platform_device_register_simple(
 			     "ieee802154fakelb", -1, NULL, 0);
+
+	pr_warn("fakelb driver is marked as deprecated, please use mac802154_hwsim!\n");
+
 	return platform_driver_register(&ieee802154fake_driver);
 }
 
-- 
2.11.0

