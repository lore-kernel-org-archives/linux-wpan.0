Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BCDC636CC
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Feb 2023 17:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBMRrN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Feb 2023 12:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMRrM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Feb 2023 12:47:12 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1151E5F8
        for <linux-wpan@vger.kernel.org>; Mon, 13 Feb 2023 09:47:11 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7B7DC0007;
        Mon, 13 Feb 2023 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676310430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aopsgh0IqI3mmqnTKLmHIhbdTbMTkYMNafS0zqL+DtI=;
        b=kYbMyIVF93AfKpvr2b4xoQYC1z376dZ0y3DFttVQUb3ujy2k7i/zsyC01+H2wyjCmAtGzo
        4jho9w6a8YRPSGabaKXSdP9IxnaKmV2FULsOAxSPNQcGKc+/G2GJzzOEZzeUi5iUNSCIIc
        4dqHqqRacaC4Ms5HlinesiVVfVY5OTY7yi+E8cU0pVf6t+pFoa4bzZeVdM2V2Lqlk6/Ju7
        uJSWk5DOsw7BPE22ciuKydob/ZyrX+oOa3psh0hshNwULEVNd8sHNJqZ/EWiN64WuEyhuO
        HF/fV1DlktFWgawUvZA7d+yjdGce3AOwE6KDJ9gbS+pOiSax/vZahQ7Atdu4lQ==
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
Subject: [PATCH wpan-tools] iwpan: Allow the phy shortcut for scanning commands
Date:   Mon, 13 Feb 2023 18:47:03 +0100
Message-Id: <20230213174703.1172423-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Allow running:
iwpan phy <phy> scan trigger ...
iwpan phy <phy> scan abort ...

Aside with the existing:
iwpan dev <dev> scan trigger ...
iwpan dev <dev> scan abort ...

This change does not apply easily to the TOPLEVEL(scan) command, so we
keep this one more constrained for simplicity.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index e92702d..8bc21ca 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -541,11 +541,15 @@ TOPLEVEL(scan, "type <type> [page <page>] [channels <bitfield>] [duration <durat
 	SCAN_TYPES);
 COMMAND(scan, abort, NULL, NL802154_CMD_ABORT_SCAN, 0, CIB_NETDEV, scan_abort_handler,
 	"Abort ongoing scanning on this virtual interface");
+COMMAND(scan, abort, NULL, NL802154_CMD_ABORT_SCAN, 0, CIB_PHY, scan_abort_handler, NULL);
 COMMAND(scan, trigger,
 	"type <type> [page <page>] [channels <bitfield>] [duration <duration-order>]",
 	NL802154_CMD_TRIGGER_SCAN, 0, CIB_NETDEV, scan_trigger_handler,
 	"Launch scanning on this virtual interface with the given configuration.\n"
 	SCAN_TYPES);
+COMMAND(scan, trigger,
+	"type <type> [page <page>] [channels <bitfield>] [duration <duration-order>]",
+	NL802154_CMD_TRIGGER_SCAN, 0, CIB_PHY, scan_trigger_handler, NULL);
 
 SECTION(beacons);
 
-- 
2.34.1

