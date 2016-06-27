Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32910 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751946AbcF0WAq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Jun 2016 18:00:46 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 8/8] fakelb: allow to run as monitor
Date: Tue, 28 Jun 2016 00:00:37 +0200
Message-Id: <20160627220037.10108-9-aar@pengutronix.de>
In-Reply-To: <20160627220037.10108-1-aar@pengutronix.de>
References: <20160627220037.10108-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

For my RIOT-OS in userspace experiments I need to create a fakelb
monitor interface. The fakelb doesn't filter anything on L2 and is a
purely raw interface. Because nl802154 checks on promiscuous mode which
need to supported by creating monitors this patch adds some no-op
promiscuous mode setting and the promiscuous flag.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 drivers/net/ieee802154/fakelb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 860d4ae..0becf0a 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -112,6 +112,12 @@ static void fakelb_hw_stop(struct ieee802154_hw *hw)
 	write_unlock_bh(&fakelb_ifup_phys_lock);
 }
 
+static int
+fakelb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
+{
+	return 0;
+}
+
 static const struct ieee802154_ops fakelb_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = fakelb_hw_xmit,
@@ -119,6 +125,7 @@ static const struct ieee802154_ops fakelb_ops = {
 	.set_channel = fakelb_hw_channel,
 	.start = fakelb_hw_start,
 	.stop = fakelb_hw_stop,
+	.set_promiscuous_mode = fakelb_set_promiscuous_mode,
 };
 
 /* Number of dummy devices to be set up by this module. */
@@ -174,6 +181,7 @@ static int fakelb_add_one(struct device *dev)
 	hw->phy->current_channel = 13;
 	phy->channel = hw->phy->current_channel;
 
+	hw->flags = IEEE802154_HW_PROMISCUOUS;
 	hw->parent = dev;
 
 	err = ieee802154_register_hw(hw);
-- 
2.9.0

