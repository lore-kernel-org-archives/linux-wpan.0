Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C18C54EAA
	for <linux-wpan@archiver.kernel.org>; Mon, 30 Jan 2023 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjA3Puy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjA3Pul (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Jan 2023 10:50:41 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC16A54
        for <linux-wpan@vger.kernel.org>; Mon, 30 Jan 2023 07:50:29 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 651A6E0002;
        Mon, 30 Jan 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675093828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lk5BhyUXCk0wAHnoa2lzAXjGYSpRRgr9FFxs99Fc6Q=;
        b=Fvmde/eFxEbEG8SBAh1d2KNQDKD7v96tlpKePxqCiMXaI0tvan5JQ/qikIYkRfxiezA4Lz
        /ZHwSc/Rlf2lPBuDqji3tUgRzruLJHIusXcP7nVaQO2BONeq0NduF98TJknDN03TCU49+Y
        XgKN+uog8/iGG04aKBzp5VnMW+G+xug4X+xTsZ977Vt0d+ytHMc+MKuz4EIBcBl+irvlYg
        Dp6fXhWMZxvxUSRYT9nffSyrTZ5BpD1T9jn/t2sKQOk+zO6tr8awxT/SuwUOFJ8lQanw+B
        aKLiCrDjNLvdWVajNVWdoCHDYpYc8EJacR1khvMU+AfFPT8Wpziq0xcNNwZ5aQ==
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
Subject: [wpan-tools 2/2] iwpan: Add beaconing support
Date:   Mon, 30 Jan 2023 16:50:22 +0100
Message-Id: <20230130155022.115117-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130155022.115117-1-miquel.raynal@bootlin.com>
References: <20230130155022.115117-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: David Girault <david.girault@qorvo.com>

Support interacting with the kernel to request beacons to be sent or
stopped on a particular interface.

Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/scan.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 63a5e24..e92702d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -546,3 +546,46 @@ COMMAND(scan, trigger,
 	NL802154_CMD_TRIGGER_SCAN, 0, CIB_NETDEV, scan_trigger_handler,
 	"Launch scanning on this virtual interface with the given configuration.\n"
 	SCAN_TYPES);
+
+SECTION(beacons);
+
+static int send_beacons_handler(struct nl802154_state *state, struct nl_cb *cb,
+				struct nl_msg *msg, int argc, char **argv,
+				enum id_input id)
+{
+	unsigned long interval;
+	bool valid_interval;
+	int tpset;
+
+	tpset = get_option_value(&argc, &argv, "interval", &interval, &valid_interval);
+	if (tpset)
+		return tpset;
+	if (valid_interval && interval > UINT8_MAX)
+		return 1;
+
+	if (argc)
+		return 1;
+
+	/* Optional arguments */
+	if (valid_interval)
+		NLA_PUT_U8(msg, NL802154_ATTR_BEACON_INTERVAL, interval);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
+static int stop_beacons_handler(struct nl802154_state *state, struct nl_cb *cb,
+				struct nl_msg *msg, int argc, char **argv,
+				enum id_input id)
+{
+	return 0;
+}
+
+COMMAND(beacons, stop, NULL,
+	NL802154_CMD_STOP_BEACONS, 0, CIB_NETDEV, stop_beacons_handler,
+	"Stop sending beacons on this interface.");
+COMMAND(beacons, send, "[interval <interval-order>]",
+	NL802154_CMD_SEND_BEACONS, 0, CIB_NETDEV, send_beacons_handler,
+	"Send beacons on this virtual interface at a regular pace.");
-- 
2.34.1

