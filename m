Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C358C5479D
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjAFLSx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjAFLSt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:49 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3E65AC5
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:46 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D353240009;
        Fri,  6 Jan 2023 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkCgC2+vIP/TIDZlwCYhjc5qyOT835idDBUgPb0RERI=;
        b=lqbOVU+FdmxNcCjyJY/igrgf2j6eeRFhc6bOB7YtmacqEBGqUWRuGwAcB+Kd7qeh7Vi9nX
        z3Q2ymDYnANBOCzua6Q5y32uK51bKWV/s0lZZSF1yu7bS//KlbONOhOVIe0C5rCli8EUaR
        4AmgR+08LrhM2YQh2Fo/Mt76SXpOAJSxMsrH1bvcdh/NQgzq5q2en4FFxn304629p9SSr4
        hkq+0D3uideydV9NhwK5pNJ/ukhQuvyjqgL1lI7zuILmfkjkHzeBcZKIkErtgZrXJcdAQD
        DjONEeTeJ4JQ6dEwQTpdmuv2u+A+Jdp6gvh6wT0bC60XLIxNK9AiFuI30v8Wuw==
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
Subject: [PATCH wpan-tools v2 6/8] iwpan: Synchronize nl802154.h with the latest scan changes
Date:   Fri,  6 Jan 2023 12:18:29 +0100
Message-Id: <20230106111831.692202-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The content of this file has evolved, reflect the changes accepted in the
mainline Linux kernel here with the additional scan definitions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/nl802154.h | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/src/nl802154.h b/src/nl802154.h
index eb8ad48..648fc93 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -70,6 +70,11 @@ enum nl802154_commands {
 	NL802154_CMD_NEW_SEC_LEVEL,
 	NL802154_CMD_DEL_SEC_LEVEL,
 
+	NL802154_CMD_SCAN_EVENT,
+	NL802154_CMD_TRIGGER_SCAN,
+	NL802154_CMD_ABORT_SCAN,
+	NL802154_CMD_SCAN_DONE,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -129,6 +134,15 @@ enum nl802154_attrs {
 	NL802154_ATTR_PID,
 	NL802154_ATTR_NETNS_FD,
 
+	NL802154_ATTR_COORDINATOR,
+	NL802154_ATTR_SCAN_TYPE,
+	NL802154_ATTR_SCAN_FLAGS,
+	NL802154_ATTR_SCAN_CHANNELS,
+	NL802154_ATTR_SCAN_PREAMBLE_CODES,
+	NL802154_ATTR_SCAN_MEAN_PRF,
+	NL802154_ATTR_SCAN_DURATION,
+	NL802154_ATTR_SCAN_DONE_REASON,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
@@ -215,6 +229,93 @@ enum nl802154_wpan_phy_capability_attr {
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
+ * enum nl802154_scan_done_reasons - End of scan reasons
+ *
+ * @__NL802154_SCAN_DONE_REASON_INVALID: scan done reason number 0 is reserved.
+ * @NL802154_SCAN_DONE_REASON_FINISHED: The scan just finished naturally after
+ *      going through all the requested and possible (complex) channels.
+ * @NL802154_SCAN_DONE_REASON_ABORTED: The scan was aborted upon user request.
+ *      a Beacon Request command
+ * @NL802154_SCAN_DONE_REASON_MAX: Maximum scan done reason attribute number.
+ */
+enum nl802154_scan_done_reasons {
+        __NL802154_SCAN_DONE_REASON_INVALID,
+        NL802154_SCAN_DONE_REASON_FINISHED,
+        NL802154_SCAN_DONE_REASON_ABORTED,
+
+        /* keep last */
+        NL802154_SCAN_DONE_REASON_MAX,
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

