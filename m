Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D56CA0FED
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 17:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbjIARFg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348919AbjIARFd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 13:05:33 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855A1703;
        Fri,  1 Sep 2023 10:05:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDCB3C0002;
        Fri,  1 Sep 2023 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693587927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVSQ/j+75eM1AxTsC1nPd69bH+mn28xqq96mA0ErNic=;
        b=IJOCq9Bge67vJL8vM3hIgzMtw/X1Kkf8K6RcrCV1lYkCb5jj6Ms5QOobBpdUIqoZa+mwZ/
        mbpRcfh1v91vwrfD3gk/sq30L7HfdvZXsZxjU421Ra9GetJAmguB7Vz6KmHSQ7Ga/cnKZR
        xwgCvwv+rNYJZNf1X8h9YCS9gtNXxvewZKuk9OiNarFf7g3Svr9ZTp7jUgvFZGSTJyXM4L
        BVC6s/0A0eEjnJPgXYJj3WC3Se2lnz4MGPfgW0h//hT0Gv2yTx6Y/Z1JTrfSGRLScK0zyY
        Gavxqh7zSVhtHb/mKDYtrY07ViTcfVy+rhS/RvWK6chZoIJNdI3kOo0FOo30ww==
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
Subject: [PATCH wpan-next v2 09/11] mac802154: Follow the number of associated devices
Date:   Fri,  1 Sep 2023 19:04:59 +0200
Message-Id: <20230901170501.1066321-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
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
 net/ieee802154/core.c   |  1 +
 net/mac802154/cfg.c     |  1 +
 net/mac802154/scan.c    | 33 +++++++++++++++++++++++----------
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 442d03b57eb3..966ae5bda31c 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -508,6 +508,7 @@ struct wpan_dev {
 	struct list_head children;
 	unsigned int association_generation;
 	unsigned int max_associations;
+	unsigned int nchildren;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 6ca42f82e63b..435b9a197dac 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -212,6 +212,7 @@ static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
 		kfree(child);
 	}
 
+	wpan_dev->nchildren = 0;
 	wpan_dev->association_generation++;
 
 	mutex_unlock(&wpan_dev->association_lock);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index ff1f4ea019ba..b21e9881a116 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -456,6 +456,7 @@ static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,
 		return ret;
 
 	list_del(&child->node);
+	wpan_dev->nchildren--;
 	wpan_dev->association_generation++;
 	kfree(child);
 
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 9f55b2314fe5..fbbae7586ab1 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -801,20 +801,32 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
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
@@ -838,6 +850,7 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	}
 
 	list_add(&child->node, &wpan_dev->children);
+	wpan_dev->nchildren++;
 	wpan_dev->association_generation++;
 
 unlock:
-- 
2.34.1

