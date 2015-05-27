Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33407 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbE0MMu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 08:12:50 -0400
Received: by pdbqa5 with SMTP id qa5so12493376pdb.0
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 05:12:50 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCHv2 wpan-tools] phy: convert tx power value
Date: Wed, 27 May 2015 17:41:42 +0530
Message-Id: <1432728702-3458-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

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

