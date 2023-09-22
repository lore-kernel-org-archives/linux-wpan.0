Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373AE6FE52
	for <linux-wpan@archiver.kernel.org>; Fri, 22 Sep 2023 15:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjIVPu4 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIVPuz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2023 11:50:55 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB8122;
        Fri, 22 Sep 2023 08:50:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A1F160003;
        Fri, 22 Sep 2023 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695397846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OxrcaWjW3sTUa6UJSQzcptgX3Fr1ugD71QaKu8KFjBY=;
        b=IEpkzFJQf/VNIZkif3JVyc4XmrTn0mbKC/0Hd40Ppt1LBsVwn/7TjSViiOjGvndjwY13+2
        2mRvweYlUpGO4jx+TiXI0YXlEdtogd0qOYW5/NY7aONZeQC7/LQZ4im1MfOxAQZ3W2A2Ir
        4RSsxaRW65TvdSpNIMDryLKwOPVSFZyHRvdguj/DUEooFf+a+dEsfwbnrgmdAITFMAShZP
        nzcZ//xEUolLtj4gaWnIbsvlbPbmk3wDMQ/6RBLiM5HNZMqOT0aXovNTPPC4YU+eQ6uNww
        VZx0r+FRXkz6kZkmNyZJnwUA6M3bEpeYpPjH+KpfbxNd3H/Hr5bULVb5RGZzYA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v4 09/11] mac802154: Follow the number of associated devices
Date:   Fri, 22 Sep 2023 17:50:27 +0200
Message-Id: <20230922155029.592018-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922155029.592018-1-miquel.raynal@bootlin.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Track the count of associated devices. Limit the number of associations
using the value provided by the user if any. If we reach the maximum
number of associations, we tell the device we are at capacity. If the
user do not want to accept any more associations, it may specify the
value 0 to the maximum number of associations, which will lead to an
access denied error status returned to the peers trying to associate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h |  1 +
 net/ieee802154/core.c   |  2 ++
 net/mac802154/cfg.c     |  1 +
 net/mac802154/scan.c    | 33 +++++++++++++++++++++++----------
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 0d3e9af00198..a64bbcd71f10 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -507,6 +507,7 @@ struct wpan_dev {
 	struct ieee802154_pan_device *parent;
 	struct list_head children;
 	unsigned int max_associations;
+	unsigned int nchildren;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 2d6fe45efa05..60e8fff1347e 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -212,6 +212,8 @@ static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
 		kfree(child);
 	}
 
+	wpan_dev->nchildren = 0;
+
 	mutex_unlock(&wpan_dev->association_lock);
 }
 
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 0d0aed788f57..4a85fa674f66 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -454,6 +454,7 @@ static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,
 		return ret;
 
 	list_del(&child->node);
+	wpan_dev->nchildren--;
 	kfree(child);
 
 	return 0;
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d5f66c204bc5..81d2c2bb1f09 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -800,20 +800,32 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	child->mode = IEEE802154_EXTENDED_ADDRESSING;
 	ceaddr = swab64((__force u64)child->extended_addr);
 
-	assoc_resp_pl.status = IEEE802154_ASSOCIATION_SUCCESSFUL;
-	if (assoc_req_pl.alloc_addr) {
-		assoc_resp_pl.short_addr = cfg802154_get_free_short_addr(wpan_dev);
-		child->mode = IEEE802154_SHORT_ADDRESSING;
+	if (wpan_dev->nchildren >= wpan_dev->max_associations) {
+		if (!wpan_dev->max_associations)
+			assoc_resp_pl.status = IEEE802154_PAN_ACCESS_DENIED;
+		else
+			assoc_resp_pl.status = IEEE802154_PAN_AT_CAPACITY;
+		assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
+		dev_dbg(&sdata->dev->dev,
+			"Refusing ASSOC REQ from child %8phC, %s\n", &ceaddr,
+			assoc_resp_pl.status == IEEE802154_PAN_ACCESS_DENIED ?
+			"access denied" : "too many children");
 	} else {
-		assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+		assoc_resp_pl.status = IEEE802154_ASSOCIATION_SUCCESSFUL;
+		if (assoc_req_pl.alloc_addr) {
+			assoc_resp_pl.short_addr = cfg802154_get_free_short_addr(wpan_dev);
+			child->mode = IEEE802154_SHORT_ADDRESSING;
+		} else {
+			assoc_resp_pl.short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+		}
+		child->short_addr = assoc_resp_pl.short_addr;
+		dev_dbg(&sdata->dev->dev,
+			"Accepting ASSOC REQ from child %8phC, providing short address 0x%04x\n",
+			&ceaddr, le16_to_cpu(child->short_addr));
 	}
-	child->short_addr = assoc_resp_pl.short_addr;
-	dev_dbg(&sdata->dev->dev,
-		"Accepting ASSOC REQ from child %8phC, providing short address 0x%04x\n",
-		&ceaddr, le16_to_cpu(child->short_addr));
 
 	ret = mac802154_send_association_resp_locked(sdata, child, &assoc_resp_pl);
-	if (ret) {
+	if (ret || assoc_resp_pl.status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
 		kfree(child);
 		goto unlock;
 	}
@@ -834,6 +846,7 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	}
 
 	list_add(&child->node, &wpan_dev->children);
+	wpan_dev->nchildren++;
 
 unlock:
 	mutex_unlock(&wpan_dev->association_lock);
-- 
2.34.1

