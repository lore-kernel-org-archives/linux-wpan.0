Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53417 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbFRIht (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 04:37:49 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/3] wpan-ping: switch server indicator variable to bool
Date: Thu, 18 Jun 2015 10:37:36 +0200
Message-Id: <1434616656-16209-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
References: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This is really only true or false so use bool as we do for extended.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 4a159ae..c83a0ad 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -92,7 +92,7 @@ struct config {
 	uint8_t dst_extended[IEEE802154_ADDR_LEN];
 	uint8_t src_extended[IEEE802154_ADDR_LEN];
 	bool extended;
-	char server;
+	bool server;
 	char *interface;
 	struct nl_sock *nl_sock;
 	int nl802154_id;
@@ -467,7 +467,7 @@ int main(int argc, char *argv[]) {
 			conf->extended = true;
 			break;
 		case 'd':
-			conf->server = 1;
+			conf->server = true;
 			address = optarg;
 			break;
 		case 'c':
-- 
2.4.3

