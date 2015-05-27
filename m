Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35503 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbbE0KZX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 06:25:23 -0400
Received: by wicmx19 with SMTP id mx19so105968746wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 03:25:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/3] phy: fix cca ed level parameter parsing
Date: Wed, 27 May 2015 12:25:03 +0200
Message-Id: <1432722305-22460-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the parsing of cca ed level parameter which is now an
floating point dbm value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/phy.c b/src/phy.c
index 285801c..8adffcc 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -121,14 +121,14 @@ static int handle_cca_ed_level(struct nl802154_state *state,
 			       int argc, char **argv,
 			       enum id_input id)
 {
-	long level;
+	float level;
 	char *end;
 
 	if (argc < 1)
 		return 1;
 
 	/* CCA_ED_LEVEL */
-	level = strtol(argv[0], &end, 10);
+	level = strtof(argv[0], &end);
 	if (*end != '\0')
 		return 1;
 
-- 
2.4.1

