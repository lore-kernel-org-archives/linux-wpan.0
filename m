Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880BCD37B0
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 15:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIRPhe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIRPhe (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 11:37:34 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89CCE9;
        Mon, 18 Sep 2023 08:35:48 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 565AAD1930;
        Mon, 18 Sep 2023 15:08:46 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77D261C0003;
        Mon, 18 Sep 2023 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695049725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqQ9PFkNZ7FlEQrNIrUxQJAcjr3CAMWwJylbar1PE9U=;
        b=NgVB9OohHI7TrKaGB2tVQZOXpUGkXiI3Ui1LrOwfgWhv+dGwDedI5puTMD2/LuBPnRsx7F
        ImO2z3rwis15vg5bMPSMZt3rHaXm7DG1L+hewYXkErk998YrqRlCDjG3in1vYNkJVQMnE1
        3LDuohyIoYHVfTRc1crfOPLpSztuKvgNZ/pQk9hMJfqFEpe2cBY2kDt/uX+2QaASNGbl5m
        0qkGAB+R9DrgMtb1kbrs6ut0DRXvx0LU0JKEVBGyVoaHkqkzegUfXF00iGM/VPeQWNFRKU
        4jx1FQbcQ5Iu8TP4MT+2h6z2EV7lGvfnQbiJMIdz6/kz9SSKkpSpVFUahUcCLw==
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
Subject: [PATCH wpan-next v3 10/11] mac802154: Handle disassociation notifications from peers
Date:   Mon, 18 Sep 2023 17:08:08 +0200
Message-Id: <20230918150809.275058-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150809.275058-1-miquel.raynal@bootlin.com>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
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
 net/mac802154/scan.c         | 52 ++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

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
index 9ba45984e9de..78d29edaa2b6 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -855,3 +855,55 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
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
+
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return 0;
+}
-- 
2.34.1

