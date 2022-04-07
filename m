Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92551C433F5
	for <linux-wpan@archiver.kernel.org>; Thu,  7 Apr 2022 10:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiDGKLO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiDGKLM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2022 06:11:12 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C023691E;
        Thu,  7 Apr 2022 03:09:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2B2E760012;
        Thu,  7 Apr 2022 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649326151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35ooHUKkVucweRorUExmNiRHhXXTQ1TtiROdmsJyU30=;
        b=mTl6+5a88hsAgvx857JXpnHOLqvY2g2MDwsuLvdPvqx4JPgrUTA29Ek7fPfTGU5kGlm9yr
        wlg4J/S/rC5lA0e8nQ12LNipZUl6lP+UegOPJp6PsmgEhSFhqK/4fnrba8KXW789HdKdBJ
        OflT6nJCdZqSFfzMiTx5q9P8Ts4LSEEQnHQaB4coPOU/jyhrY5J7fpvL6OKVucGwmr0UXy
        oIlgsyszWVHQhyS+o1bxbzXpOFPCuFFJpFUoClH2rnVkY1mb65PozVqI6kE3eEjNYmNwmx
        STsZscnHsHlIKaLcZkDXm3azSX6lIRpj1XgdG52FDr6uGo2NVNMsossyEED+qA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 04/10] net: mac802154: Create an offloaded transmission error helper
Date:   Thu,  7 Apr 2022 12:08:57 +0200
Message-Id: <20220407100903.1695973-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220407100903.1695973-1-miquel.raynal@bootlin.com>
References: <20220407100903.1695973-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

So far there is only a helper for successful transmissions, which led
device drivers to implement their own handling in case of
error. Unfortunately, we really need all the drivers to give the hand
back to the core once they are done in order to be able to build a
proper synchronous API. So let's create a _xmit_error() helper and take
this opportunity to fill the new device-global field storing Tx
statuses.

Suggested-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/mac802154.h | 10 ++++++++++
 net/mac802154/util.c    | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2c3bbc6645ba..29f289d58720 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -498,4 +498,14 @@ void ieee802154_stop_queue(struct ieee802154_hw *hw);
 void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 			      bool ifs_handling);
 
+/**
+ * ieee802154_xmit_error - offloaded frame transmission failed
+ *
+ * @hw: pointer as obtained from ieee802154_alloc_hw().
+ * @skb: buffer for transmission
+ * @reason: error code
+ */
+void ieee802154_xmit_error(struct ieee802154_hw *hw, struct sk_buff *skb,
+			   int reason);
+
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 0bf46f174de3..ec523335336c 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -91,6 +91,17 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
 
+void ieee802154_xmit_error(struct ieee802154_hw *hw, struct sk_buff *skb,
+			   int reason)
+{
+	struct ieee802154_local *local = hw_to_local(hw);
+
+	local->tx_result = reason;
+	ieee802154_wake_queue(hw);
+	dev_kfree_skb_any(skb);
+}
+EXPORT_SYMBOL(ieee802154_xmit_error);
+
 void ieee802154_stop_device(struct ieee802154_local *local)
 {
 	flush_workqueue(local->workqueue);
-- 
2.27.0

