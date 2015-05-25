Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52614 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbEYMiw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:38:52 -0400
Date: Mon, 25 May 2015 15:38:51 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCHv2 bluetooth-next 6/6] mac802154: mac802154_mlme_start_req()
 optimisation.
Message-ID: <20150525123851.GO11340@wantstofly.org>
References: <cover.1432535597.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432535597.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

mac802154_mlme_start_req() calls
ieee802154_mlme_ops(dev)->llsec->set_params() on the net_device
passed into it, however, this net_device will always be a mac802154
net_device, so just call mac802154_set_params() directly instead.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 net/mac802154/mac_cmd.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 5220c2b2..8606da4 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -36,8 +36,8 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 				    u8 pan_coord, u8 blx,
 				    u8 coord_realign)
 {
-	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
-	int rc = 0;
+	struct ieee802154_llsec_params params;
+	int changed = 0;
 
 	ASSERT_RTNL();
 
@@ -47,26 +47,19 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 	dev->ieee802154_ptr->short_addr = addr->short_addr;
 	mac802154_dev_set_page_channel(dev, page, channel);
 
-	if (ops->llsec) {
-		struct ieee802154_llsec_params params;
-		int changed = 0;
+	params.pan_id = addr->pan_id;
+	changed |= IEEE802154_LLSEC_PARAM_PAN_ID;
 
-		params.coord_shortaddr = addr->short_addr;
-		changed |= IEEE802154_LLSEC_PARAM_COORD_SHORTADDR;
+	params.hwaddr = ieee802154_devaddr_from_raw(dev->dev_addr);
+	changed |= IEEE802154_LLSEC_PARAM_HWADDR;
 
-		params.pan_id = addr->pan_id;
-		changed |= IEEE802154_LLSEC_PARAM_PAN_ID;
+	params.coord_hwaddr = params.hwaddr;
+	changed |= IEEE802154_LLSEC_PARAM_COORD_HWADDR;
 
-		params.hwaddr = ieee802154_devaddr_from_raw(dev->dev_addr);
-		changed |= IEEE802154_LLSEC_PARAM_HWADDR;
+	params.coord_shortaddr = addr->short_addr;
+	changed |= IEEE802154_LLSEC_PARAM_COORD_SHORTADDR;
 
-		params.coord_hwaddr = params.hwaddr;
-		changed |= IEEE802154_LLSEC_PARAM_COORD_HWADDR;
-
-		rc = ops->llsec->set_params(dev, &params, changed);
-	}
-
-	return rc;
+	return mac802154_set_params(dev, &params, changed);
 }
 
 static int mac802154_set_mac_params(struct net_device *dev,
-- 
2.1.0

