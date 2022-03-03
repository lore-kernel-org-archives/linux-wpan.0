Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C5C433FE
	for <linux-wpan@archiver.kernel.org>; Thu,  3 Mar 2022 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiCCS0L (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiCCS0J (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Mar 2022 13:26:09 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E821A41EB;
        Thu,  3 Mar 2022 10:25:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35F2F2000B;
        Thu,  3 Mar 2022 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646331915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gc9GvEmcqPdgjbsstrsAlcUKY3OGmYysVOqtCmZ0Ffc=;
        b=G2C2kWpZ8MCW9Vi1ORpk0GsXh2KYOqsRaIyJiL/DajnjKR/C5Tvsg+2EmFiUfjadFIFtpT
        LtjtrC5Tic8FPTxQY6gJRhc/d4KJp5qJM3YqdLtuqOK6M4vn9huphze2YwxBTC3QFCqQ37
        RX1u2SAe957HegMx736MrUpfszjwQ3efn+Hw8LxK2C8v1RLUTstG1yPFh0LHiIRor4rlCV
        srrn7Q0K1k+xXekfibTSvvQqFOxjgu9DJbgJcjLhbbcw6NCZESVwG3QDQpOTipOgnErcYx
        H7/hD9ztHz4l6Rb7cL1sFUVydE0UBuE02BGivt4HOYRZ2E0uGAAZn+W0LlYBSw==
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
Subject: [PATCH wpan-next v3 03/11] net: mac802154: Create a transmit error helper
Date:   Thu,  3 Mar 2022 19:25:00 +0100
Message-Id: <20220303182508.288136-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303182508.288136-1-miquel.raynal@bootlin.com>
References: <20220303182508.288136-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

So far there is only a helper for successful transmission, which led
device drivers to implement their own handling in case of
error. Unfortunately, we really need all the drivers to give the hand
back to the core once they are done in order to be able to build a
proper synchronous API. So let's create a _xmit_error() helper and take
this opportunity to fill the new device-global field storing Tx
statuses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/mac802154.h | 10 ++++++++++
 net/mac802154/util.c    | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2c3bbc6645ba..abbe88dc9df5 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -498,4 +498,14 @@ void ieee802154_stop_queue(struct ieee802154_hw *hw);
 void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 			      bool ifs_handling);
 
+/**
+ * ieee802154_xmit_error - frame transmission failed
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
index f2078238718b..37d2520804e3 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -88,6 +88,17 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
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

