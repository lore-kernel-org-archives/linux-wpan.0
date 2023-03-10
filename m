Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05501C6FA99
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Mar 2023 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjCJPBk (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjCJPBO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Mar 2023 10:01:14 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCA1A7
        for <linux-wpan@vger.kernel.org>; Fri, 10 Mar 2023 06:54:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27C24FF80D;
        Fri, 10 Mar 2023 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678460031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxxv6wqlJLEdwcZVpqHJDYnLSR3neGVOWI7v1Gm9Gb0=;
        b=MqFlADSnsEHgaDT9f/Oy7FJNEmjZxl/T2t6DEkXkBON3bt8pO/UMN8bu7p9Dsh8198rAWc
        hbUxSk33e5g66nBm0nG5RVkO3DTYyfsIIK+N+joO7dPNXRUc76S8V9CWL3PrOT+801r1z1
        XX+2IjzOywYD5LmY4aTZc4zOs6wJXPq5HnpYo3ZxL+Vz1npilwdVKEiAIfSXb0g26i+7S4
        B3bsj0Dzd2jya2Nzkpn7D4GwP4lX3ucaNzBxB2dfxwHzQ/2BAsOF9uhpkXMLw33gmebbva
        Ww6c4m83YAOvlI82vGTdkr0WdopOG7gN6dASSalyfWqTv3WNSVXp+cUmGg99jA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v2 2/4] mac802154: Handle active scanning
Date:   Fri, 10 Mar 2023 15:53:44 +0100
Message-Id: <20230310145346.1397068-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Active scan support is based on the current passive scan support,
cheered up with beacon requests sent after every channel change.

Co-developed-by: David Girault <david.girault@qorvo.com>
Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/ieee802154_netdev.h | 18 ++++++++++-
 net/ieee802154/header_ops.c     | 23 ++++++++++++++
 net/mac802154/ieee802154_i.h    |  1 +
 net/mac802154/scan.c            | 53 +++++++++++++++++++++++++++++++--
 4 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index da8a3e648c7a..257c9b2e9c9a 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -74,6 +74,10 @@ struct ieee802154_beacon_hdr {
 #endif
 } __packed;
 
+struct ieee802154_mac_cmd_pl {
+	u8  cmd_id;
+} __packed;
+
 struct ieee802154_sechdr {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	u8 level:3,
@@ -149,6 +153,16 @@ struct ieee802154_beacon_frame {
 	struct ieee802154_beacon_hdr mac_pl;
 };
 
+struct ieee802154_mac_cmd_frame {
+	struct ieee802154_hdr mhr;
+	struct ieee802154_mac_cmd_pl mac_pl;
+};
+
+struct ieee802154_beacon_req_frame {
+	struct ieee802154_hdr mhr;
+	struct ieee802154_mac_cmd_pl mac_pl;
+};
+
 /* pushes hdr onto the skb. fields of hdr->fc that can be calculated from
  * the contents of hdr will be, and the actual value of those bits in
  * hdr->fc will be ignored. this includes the INTRA_PAN bit and the frame
@@ -174,9 +188,11 @@ int ieee802154_hdr_peek_addrs(const struct sk_buff *skb,
  */
 int ieee802154_hdr_peek(const struct sk_buff *skb, struct ieee802154_hdr *hdr);
 
-/* pushes a beacon frame into an skb */
+/* pushes/pulls various frame types into/from an skb */
 int ieee802154_beacon_push(struct sk_buff *skb,
 			   struct ieee802154_beacon_frame *beacon);
+int ieee802154_mac_cmd_push(struct sk_buff *skb, void *frame,
+			    const void *pl, unsigned int pl_len);
 
 int ieee802154_max_payload(const struct ieee802154_hdr *hdr);
 
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index 35d384dfe29d..a5ff1017a4b2 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -120,6 +120,29 @@ ieee802154_hdr_push(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 }
 EXPORT_SYMBOL_GPL(ieee802154_hdr_push);
 
+int ieee802154_mac_cmd_push(struct sk_buff *skb, void *f,
+			    const void *pl, unsigned int pl_len)
+{
+	struct ieee802154_mac_cmd_frame *frame = f;
+	struct ieee802154_mac_cmd_pl *mac_pl = &frame->mac_pl;
+	struct ieee802154_hdr *mhr = &frame->mhr;
+	int ret;
+
+	skb_reserve(skb, sizeof(*mhr));
+	ret = ieee802154_hdr_push(skb, mhr);
+	if (ret < 0)
+		return ret;
+
+	skb_reset_mac_header(skb);
+	skb->mac_len = ret;
+
+	skb_put_data(skb, mac_pl, sizeof(*mac_pl));
+	skb_put_data(skb, pl, pl_len);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ieee802154_mac_cmd_push);
+
 int ieee802154_beacon_push(struct sk_buff *skb,
 			   struct ieee802154_beacon_frame *beacon)
 {
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 63bab99ed368..7bfd5411a164 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -58,6 +58,7 @@ struct ieee802154_local {
 	/* Scanning */
 	u8 scan_page;
 	u8 scan_channel;
+	struct ieee802154_beacon_req_frame scan_beacon_req;
 	struct cfg802154_scan_request __rcu *scan_req;
 	struct delayed_work scan_work;
 
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 9b0933a185eb..201bfc567a43 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -18,8 +18,12 @@
 
 #define IEEE802154_BEACON_MHR_SZ 13
 #define IEEE802154_BEACON_PL_SZ 4
+#define IEEE802154_MAC_CMD_MHR_SZ 23
+#define IEEE802154_MAC_CMD_PL_SZ 1
 #define IEEE802154_BEACON_SKB_SZ (IEEE802154_BEACON_MHR_SZ + \
 				  IEEE802154_BEACON_PL_SZ)
+#define IEEE802154_MAC_CMD_SKB_SZ (IEEE802154_MAC_CMD_MHR_SZ + \
+				   IEEE802154_MAC_CMD_PL_SZ)
 
 /* mac802154_scan_cleanup_locked() must be called upon scan completion or abort.
  * - Completions are asynchronous, not locked by the rtnl and decided by the
@@ -131,6 +135,42 @@ static int mac802154_scan_find_next_chan(struct ieee802154_local *local,
 	return 0;
 }
 
+static int mac802154_scan_prepare_beacon_req(struct ieee802154_local *local)
+{
+	memset(&local->scan_beacon_req, 0, sizeof(local->scan_beacon_req));
+	local->scan_beacon_req.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
+	local->scan_beacon_req.mhr.fc.dest_addr_mode = IEEE802154_SHORT_ADDRESSING;
+	local->scan_beacon_req.mhr.fc.version = IEEE802154_2003_STD;
+	local->scan_beacon_req.mhr.fc.source_addr_mode = IEEE802154_NO_ADDRESSING;
+	local->scan_beacon_req.mhr.dest.mode = IEEE802154_ADDR_SHORT;
+	local->scan_beacon_req.mhr.dest.pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
+	local->scan_beacon_req.mhr.dest.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+	local->scan_beacon_req.mac_pl.cmd_id = IEEE802154_CMD_BEACON_REQ;
+
+	return 0;
+}
+
+static int mac802154_transmit_beacon_req(struct ieee802154_local *local,
+					 struct ieee802154_sub_if_data *sdata)
+{
+	struct sk_buff *skb;
+	int ret;
+
+	skb = alloc_skb(IEEE802154_MAC_CMD_SKB_SZ, GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	skb->dev = sdata->dev;
+
+	ret = ieee802154_mac_cmd_push(skb, &local->scan_beacon_req, NULL, 0);
+	if (ret) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	return ieee802154_mlme_tx(local, sdata, skb);
+}
+
 void mac802154_scan_worker(struct work_struct *work)
 {
 	struct ieee802154_local *local =
@@ -206,6 +246,13 @@ void mac802154_scan_worker(struct work_struct *work)
 		goto end_scan;
 	}
 
+	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+		ret = mac802154_transmit_beacon_req(local, sdata);
+		if (ret)
+			dev_err(&sdata->dev->dev,
+				"Error when transmitting beacon request (%d)\n", ret);
+	}
+
 	ieee802154_configure_durations(wpan_phy, page, channel);
 	scan_duration = mac802154_scan_get_channel_time(scan_req_duration,
 							wpan_phy->symbol_duration);
@@ -231,8 +278,8 @@ int mac802154_trigger_scan_locked(struct ieee802154_sub_if_data *sdata,
 	if (mac802154_is_scanning(local))
 		return -EBUSY;
 
-	/* TODO: support other scanning type */
-	if (request->type != NL802154_SCAN_PASSIVE)
+	if (request->type != NL802154_SCAN_PASSIVE &&
+	    request->type != NL802154_SCAN_ACTIVE)
 		return -EOPNOTSUPP;
 
 	/* Store scanning parameters */
@@ -247,6 +294,8 @@ int mac802154_trigger_scan_locked(struct ieee802154_sub_if_data *sdata,
 	local->scan_page = request->page;
 	local->scan_channel = -1;
 	set_bit(IEEE802154_IS_SCANNING, &local->ongoing);
+	if (request->type == NL802154_SCAN_ACTIVE)
+		mac802154_scan_prepare_beacon_req(local);
 
 	nl802154_scan_started(request->wpan_phy, request->wpan_dev);
 
-- 
2.34.1

