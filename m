Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB7C54EED
	for <linux-wpan@archiver.kernel.org>; Mon, 30 Jan 2023 15:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjA3Puv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbjA3Pui (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Jan 2023 10:50:38 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67842DE4
        for <linux-wpan@vger.kernel.org>; Mon, 30 Jan 2023 07:50:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6AAFAE0008;
        Mon, 30 Jan 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675093826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMceWOT0lwlbGZo+3g5/yUzadG2Ncnd3KE3++qy+xy8=;
        b=O0obdhLBCwSWzDnHQAWzMDslz3oiHEWbzdTFnq5m99HTYiV0U/cCpVnMlsy1tZYj8Gz2yY
        oNAIL9T3WDdYx6W3OjJBlqj268+8Qgvsj9o3PuNhbKF9EUPFJEjyJSvqJ+7xTB1f14ytdF
        jh6q4gNcmq6ShGRkbQ4e2aVSz1cdpjdf3o93oYifx/FFk8CCcuajTwoEgoisttZr9BJxcN
        8hRALn+n9sS2YzCRjn1D/f9KU05wA/Mt+ieUdB7iLb4b3EG1sFnesq0lhXZL/qWhakzEcN
        Qatlt6AfZ7Iot+OgNhK53CjYtZ2LvtOiRsfAuFLU+JjhbzmJGW8Vb38NIRU+bw==
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
Subject: [wpan-tools 1/2] iwpan: Synchronize nl802154.h with the latest beaconing changes
Date:   Mon, 30 Jan 2023 16:50:21 +0100
Message-Id: <20230130155022.115117-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130155022.115117-1-miquel.raynal@bootlin.com>
References: <20230130155022.115117-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The content of this file has evolved, reflect the changes accepted in the
mainline Linux kernel here with the additional beaconing definitions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/nl802154.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/nl802154.h b/src/nl802154.h
index 648fc93..dbad1c9 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -74,6 +74,8 @@ enum nl802154_commands {
 	NL802154_CMD_TRIGGER_SCAN,
 	NL802154_CMD_ABORT_SCAN,
 	NL802154_CMD_SCAN_DONE,
+	NL802154_CMD_SEND_BEACONS,
+	NL802154_CMD_STOP_BEACONS,
 
 	/* add new commands above here */
 
@@ -142,6 +144,7 @@ enum nl802154_attrs {
 	NL802154_ATTR_SCAN_MEAN_PRF,
 	NL802154_ATTR_SCAN_DURATION,
 	NL802154_ATTR_SCAN_DONE_REASON,
+	NL802154_ATTR_BEACON_INTERVAL,
 
 	/* add attributes here, update the policy in nl802154.c */
 
-- 
2.34.1

