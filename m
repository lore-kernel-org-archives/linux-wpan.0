Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4CCCCA479
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiGAOiW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AE3DA5F
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 368D6200002;
        Fri,  1 Jul 2022 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd4fIq1C5Slakhrfguk5LkXAVZkjq9iPJkmRSdO29xE=;
        b=GmPpq1UC/SqaOkR41MepPdUUKhVAFfydZOujA3EmW8R12HnsvfOJHxUCdIetxygx5ya+2H
        aPm7X/cZMj3kZmAcBDLROSj01PJ47YnewSoTfm1v0HY2TdXYAZJF7UvmWQzR/t1i00hjt5
        0lnHWgTf7k0RLMCXUTy+MDLWbCJWqdHFaUJQ2C7CWWKlV68+1dkFxtVabupDVDhLT5Eu2G
        ZNddhwiO68BmKTEKPa3rwVyFpPkq/mqQdY6BdnIeW0UxHdz0kdP0OsSzJhpWgHZhQEaBj8
        ZQLSnRgMhLK1NGw8mYEFCSmDE4YcKj2q2vqsBnzxpT9MNZOkYUGN6xiEc7C8SQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 5/7] iwpan: Synchronize nl802154 header with the Linux kernel
Date:   Fri,  1 Jul 2022 16:34:32 +0200
Message-Id: <20220701143434.1267864-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The content of this file as evolved, reflect the changes accepted in the
mainline Linux kernel here.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/nl802154.h | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/src/nl802154.h b/src/nl802154.h
index ddcee12..a9c06f3 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -56,6 +56,13 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_WPAN_PHY_NETNS,
 
+	NL802154_CMD_NEW_COORDINATOR,
+	NL802154_CMD_TRIGGER_SCAN,
+	NL802154_CMD_ABORT_SCAN,
+	NL802154_CMD_SCAN_DONE,
+	NL802154_CMD_SEND_BEACONS,
+	NL802154_CMD_STOP_BEACONS,
+
 	/* add new commands above here */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
@@ -131,6 +138,13 @@ enum nl802154_attrs {
 	NL802154_ATTR_PID,
 	NL802154_ATTR_NETNS_FD,
 
+	NL802154_ATTR_COORDINATOR,
+	NL802154_ATTR_SCAN_TYPE,
+	NL802154_ATTR_SCAN_FLAGS,
+	NL802154_ATTR_SCAN_CHANNELS,
+	NL802154_ATTR_SCAN_DURATION,
+	NL802154_ATTR_BEACON_INTERVAL,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
@@ -217,6 +231,85 @@ enum nl802154_wpan_phy_capability_attr {
 	NL802154_CAP_ATTR_MAX = __NL802154_CAP_ATTR_AFTER_LAST - 1
 };
 
+/**
+ * enum nl802154_scan_types - Scan types
+ *
+ * @__NL802154_SCAN_INVALID: scan type number 0 is reserved
+ * @NL802154_SCAN_ED: An ED scan allows a device to obtain a measure of the peak
+ *	energy in each requested channel
+ * @NL802154_SCAN_ACTIVE: Locate any coordinator transmitting Beacon frames using
+ *	a Beacon Request command
+ * @NL802154_SCAN_PASSIVE: Locate any coordinator transmitting Beacon frames
+ * @NL802154_SCAN_ORPHAN: Relocate coordinator following a loss of synchronisation
+ * @NL802154_SCAN_ENHANCED_ACTIVE: Same as Active using Enhanced Beacon Request
+ *	command instead of Beacon Request command
+ * @NL802154_SCAN_RIT_PASSIVE: Passive scan for RIT Data Request command frames
+ *	instead of Beacon frames
+ * @NL802154_SCAN_ATTR_MAX: Maximum SCAN attribute number
+ */
+enum nl802154_scan_types {
+	__NL802154_SCAN_INVALID,
+	NL802154_SCAN_ED,
+	NL802154_SCAN_ACTIVE,
+	NL802154_SCAN_PASSIVE,
+	NL802154_SCAN_ORPHAN,
+	NL802154_SCAN_ENHANCED_ACTIVE,
+	NL802154_SCAN_RIT_PASSIVE,
+
+	/* keep last */
+	NL802154_SCAN_ATTR_MAX,
+};
+
+/**
+ * enum nl802154_scan_flags - Scan request control flags
+ *
+ * @NL802154_SCAN_FLAG_RANDOM_ADDR: use a random MAC address for this scan (ie.
+ *	a different one for every scan iteration). When the flag is set, full
+ *	randomisation is assumed.
+ */
+enum nl802154_scan_flags {
+	NL802154_SCAN_FLAG_RANDOM_ADDR = 1 << 0,
+};
+
+/**
+ * enum nl802154_coord - Netlink attributes for a coordinator
+ *
+ * @__NL802154_COORD_INVALID: invalid
+ * @NL802154_COORD_PANID: PANID of the coordinator (2 bytes)
+ * @NL802154_COORD_ADDR: Coordinator address, (8 bytes or 2 bytes)
+ * @NL802154_COORD_CHANNEL: channel number, related to @NL802154_COORD_PAGE (u8)
+ * @NL802154_COORD_PAGE: channel page, related to @NL802154_COORD_CHANNEL (u8)
+ * @NL802154_COORD_PREAMBLE_CODE: Preamble code used when the beacon was received,
+ *     this is PHY dependent and optional (u8)
+ * @NL802154_COORD_MEAN_PRF: Mean PRF used when the beacon was received,
+ *     this is PHY dependent and optional (u8)
+ * @NL802154_COORD_SUPERFRAME_SPEC: superframe specification of the PAN (u16)
+ * @NL802154_COORD_LINK_QUALITY: signal quality of beacon in unspecified units,
+ *	scaled to 0..255 (u8)
+ * @NL802154_COORD_GTS_PERMIT: set to true if GTS is permitted on this PAN
+ * @NL802154_COORD_PAYLOAD_DATA: binary data containing the raw data from the
+ *	frame payload, (only if beacon or probe response had data)
+ * @NL802154_COORD_PAD: attribute used for padding for 64-bit alignment
+ * @NL802154_COORD_MAX: highest coordinator attribute
+ */
+enum nl802154_coord {
+	__NL802154_COORD_INVALID,
+	NL802154_COORD_PANID,
+	NL802154_COORD_ADDR,
+	NL802154_COORD_CHANNEL,
+	NL802154_COORD_PAGE,
+	NL802154_COORD_PREAMBLE_CODE,
+	NL802154_COORD_MEAN_PRF,
+	NL802154_COORD_SUPERFRAME_SPEC,
+	NL802154_COORD_LINK_QUALITY,
+	NL802154_COORD_GTS_PERMIT,
+	NL802154_COORD_PAYLOAD_DATA,
+	NL802154_COORD_PAD,
+
+	/* keep last */
+	NL802154_COORD_MAX,
+};
+
 /**
  * enum nl802154_cca_modes - cca modes
  *
-- 
2.34.1

