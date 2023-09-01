Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A29CA0FEC
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 17:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbjIARFg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348602AbjIARFf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 13:05:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6610F2;
        Fri,  1 Sep 2023 10:05:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06D70C0004;
        Fri,  1 Sep 2023 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693587929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAusTqww3GKCKagYGgVq6mCykn/a4tiagbOZZTORQcs=;
        b=dQjtuecKH2IJCluJriNSIe14g8n1fGaukb9lQ4HmKNbvLGTKptzM1jeBYEbFRpKI+5fGSn
        aC8BK4Z1Ac83CLhosTXVBfQXoq9r1ITvpuaRaSV/h1GW5p7PcsRnvDua+JSoA+QLXwehd/
        pSmYNVNiCow6XNR6IxSrulJ26yBCnFwN55ZMRfz1EJsiYLaEDeE+xHEtTOexF1W+wC1QJ3
        KsXJtQhgAimf0U1mBWjO6p0C3FtXQ5qhD0DbXJXOZy8Sg/wVaTOb2rg6OdvgRKggAkpQyl
        GgtVA0Sh1SaWUrwUYCXZYEgp0WLZSBNsZVl0Q6Pix1vjEWzGS2FJDI7ksxkjVg==
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
Subject: [PATCH wpan-next v2 10/11] mac802154: Handle disassociation notifications from peers
Date:   Fri,  1 Sep 2023 19:05:00 +0200
Message-Id: <20230901170501.1066321-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Peers may decided to disassociate from us, their coordinator, in this
case they will send a disassociation notification which we must
acknowledge. If we don't, the peer device considers itself disassociated
anyway. We also need to drop the reference to this child from our
internal structures.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/ieee802154_i.h |  2 ++
 net/mac802154/rx.c           |  8 ++++++
 net/mac802154/scan.c         | 53 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 432bfa87249e..08dd521a51a5 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -318,6 +318,8 @@ static inline bool mac802154_is_associating(struct ieee802154_local *local)
 int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
 					struct ieee802154_pan_device *target,
 					u8 reason);
+int mac802154_process_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					   struct sk_buff *skb);
 int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 				      struct sk_buff *skb);
 
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 96040b63a4fc..0024341ef9c5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -110,6 +110,14 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
 		mac802154_process_association_req(mac_pkt->sdata, mac_pkt->skb);
 		break;
 
+	case IEEE802154_CMD_DISASSOCIATION_NOTIFY:
+		dev_dbg(&mac_pkt->sdata->dev->dev, "processing DISASSOC NOTIF\n");
+		if (mac_pkt->sdata->wpan_dev.iftype != NL802154_IFTYPE_COORD)
+			break;
+
+		mac802154_process_disassociation_notif(mac_pkt->sdata, mac_pkt->skb);
+		break;
+
 	default:
 		break;
 	}
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index fbbae7586ab1..ffd793c22ad3 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -857,3 +857,56 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 	mutex_unlock(&wpan_dev->association_lock);
 	return ret;
 }
+
+int mac802154_process_disassociation_notif(struct ieee802154_sub_if_data *sdata,
+					   struct sk_buff *skb)
+{
+	struct ieee802154_addr *src = &mac_cb(skb)->source;
+	struct ieee802154_addr *dest = &mac_cb(skb)->dest;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_pan_device *child;
+	struct ieee802154_addr target;
+	bool parent;
+	u64 teaddr;
+
+	if (skb->len != sizeof(u8))
+		return -EINVAL;
+
+	if (unlikely(src->mode != IEEE802154_EXTENDED_ADDRESSING))
+		return -EINVAL;
+
+	if (dest->mode == IEEE802154_EXTENDED_ADDRESSING &&
+	    unlikely(dest->extended_addr != wpan_dev->extended_addr))
+		return -ENODEV;
+	else if (dest->mode == IEEE802154_SHORT_ADDRESSING &&
+		 unlikely(dest->short_addr != wpan_dev->short_addr))
+		return -ENODEV;
+
+	target.mode = IEEE802154_EXTENDED_ADDRESSING;
+	target.extended_addr = src->extended_addr;
+	teaddr = swab64((__force u64)target.extended_addr);
+	dev_dbg(&skb->dev->dev, "Processing DISASSOC NOTIF from %8phC\n", &teaddr);
+
+	mutex_lock(&wpan_dev->association_lock);
+	parent = cfg802154_device_is_parent(wpan_dev, &target);
+	if (!parent)
+		child = cfg802154_device_is_child(wpan_dev, &target);
+	if (!parent && !child) {
+		mutex_unlock(&wpan_dev->association_lock);
+		return -EINVAL;
+	}
+
+	if (parent) {
+		kfree(wpan_dev->parent);
+		wpan_dev->parent = NULL;
+	} else {
+		list_del(&child->node);
+		kfree(child);
+		wpan_dev->nchildren--;
+	}
+	wpan_dev->association_generation++;
+
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return 0;
+}
-- 
2.34.1

