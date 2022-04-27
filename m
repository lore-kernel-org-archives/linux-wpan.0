Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF93C433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 27 Apr 2022 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbiD0Qum (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243570AbiD0Quk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2022 12:50:40 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8BB3BBF48;
        Wed, 27 Apr 2022 09:47:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B45F8100012;
        Wed, 27 Apr 2022 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651078037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uprKRxpPNS2FwGoP4geeX0dLZY5C2SdqPpJ1poentmI=;
        b=ncSTJKYAJdxGXm12AahQLu5RgQ3rsaNYgLy+h+2j4aZnFgsZ026IEouBm6Oo68XLxyl8e7
        wRbGKJP1WcVdYiqy4QP+bU8yKdFau3ZKbpc+3of1UIParc3hrPeXJfpTY/qhKQCxDjsG7Y
        EIyQFRpi5i9bhNFL/DWtcek2wWo3r2tDjBcucZKKZKHlYRoho54dLB46vibifm9tXUYVDi
        1ZY9ylT0jQkk3M4QMrxinBy6JYyAnuJqg6HPNb1UlikX05T20yJwaBkLZhSNh0x5eLmCPM
        9w2rVtfbDu5Sh+pQRQukpceGiYVBjzYsOK245qYLQb5J6pwsDsuME4eFXYpxLw==
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
Subject: [PATCH wpan-next 09/11] net: mac802154: Introduce a helper to disable the queue
Date:   Wed, 27 Apr 2022 18:46:57 +0200
Message-Id: <20220427164659.106447-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427164659.106447-1-miquel.raynal@bootlin.com>
References: <20220427164659.106447-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Sometimes calling the stop queue helper is not enough because it does
not hold any lock. In order to be safe and avoid racy situations when
trying to (soon) sync the Tx queue, for instance before sending an MLME
frame, let's now introduce an helper which actually hold the necessary
locks when doing so.

Suggested-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/ieee802154_i.h | 12 ++++++++++++
 net/mac802154/util.c         | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index cb61a4abaf37..c686a027555a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -186,6 +186,18 @@ void ieee802154_stop_queue(struct ieee802154_local *local);
  */
 bool ieee802154_queue_is_stopped(struct ieee802154_local *local);
 
+/**
+ * ieee802154_disable_queue - disable ieee802154 queue
+ * @local: main mac object
+ *
+ * When trying to sync the Tx queue, we cannot just stop the queue
+ * (which is basically a bit being set without proper lock handling)
+ * because it would be racy. We actually need to call netif_tx_disable()
+ * instead, which is done by this helper. Restarting the queue can
+ * however still be done with a regular wake call.
+ */
+void ieee802154_disable_queue(struct ieee802154_local *local);
+
 /* MIB callbacks */
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
 
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index cfd17a7db532..3e2b157b34b1 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -62,6 +62,21 @@ bool ieee802154_queue_is_stopped(struct ieee802154_local *local)
 	return stopped;
 }
 
+void ieee802154_disable_queue(struct ieee802154_local *local)
+{
+        struct ieee802154_sub_if_data *sdata;
+
+        rcu_read_lock();
+        list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+                if (!sdata->dev)
+                        continue;
+
+		netif_tx_disable(sdata->dev);
+        }
+        rcu_read_unlock();
+}
+EXPORT_SYMBOL(ieee802154_disable_queue);
+
 enum hrtimer_restart ieee802154_xmit_ifs_timer(struct hrtimer *timer)
 {
 	struct ieee802154_local *local =
-- 
2.27.0

