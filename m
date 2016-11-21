Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47109 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754857AbcKUUeq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:46 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 8/8] examples: add .gitignore file for examples directory
Date: Mon, 21 Nov 2016 21:34:21 +0100
Message-Id: <1479760461-18947-9-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 examples/.gitignore | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 examples/.gitignore

diff --git a/examples/.gitignore b/examples/.gitignore
new file mode 100644
index 0000000..845e803
--- /dev/null
+++ b/examples/.gitignore
@@ -0,0 +1,7 @@
+/.deps
+/af_ieee802154_rx
+/af_ieee802154_tx
+/af_packet_rx
+/af_packet_tx
+/af_inet6_rx
+/af_inet6_tx
-- 
2.5.5

