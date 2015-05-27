Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36360 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbbE0IWM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 04:22:12 -0400
Received: by pdfh10 with SMTP id h10so4542090pdf.3
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 01:22:12 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-tools] wpan-tools: convert tx power value
Date: Wed, 27 May 2015 13:51:38 +0530
Message-Id: <1432714898-23276-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch convert the tx power value from long to float to
support the IEEE-802.15.4 radio power setting values.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 src/phy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/phy.c b/src/phy.c
index ee0e7ad..285801c 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -53,14 +53,14 @@ static int handle_tx_power_set(struct nl802154_state *state,
 			       int argc, char **argv,
 			       enum id_input id)
 {
-	long dbm;
+	float dbm;
 	char *end;
 
 	if (argc < 1)
 		return 1;
 
 	/* TX_POWER */
-	dbm = strtol(argv[0], &end, 10);
+	dbm = strtof(argv[0], &end);
 	if (*end != '\0')
 		return 1;
 
-- 
1.7.9.5

