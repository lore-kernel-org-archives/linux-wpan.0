Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:40010 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbK3LVd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Nov 2015 06:21:33 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 4/4] wpan-ping: make sure we do not leak conf during wrong options exit
Date: Mon, 30 Nov 2015 12:21:22 +0100
Message-Id: <1448882482-20784-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
References: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

When we hit a wrong option and we are goignt o exit wpan-ping we might have
leaked conf. Not a real problem as we are goign to exit anyway at this point.
Still fix this. Thanks to the smatch tool for pointing this out.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index edba8dd..92f4cf8 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -481,6 +481,7 @@ int main(int argc, char *argv[]) {
 			if (conf->packet_len >= MAX_PAYLOAD_LEN || conf->packet_len < MIN_PAYLOAD_LEN) {
 				printf("Packet size must be between %i and %i.\n",
 				       MIN_PAYLOAD_LEN, MAX_PAYLOAD_LEN - 1);
+				free(conf);
 				return 1;
 			}
 			break;
@@ -489,12 +490,15 @@ int main(int argc, char *argv[]) {
 			break;
 		case 'v':
 			fprintf(stdout, "wpan-ping " PACKAGE_VERSION "\n");
+			free(conf);
 			return 1;
 		case 'h':
 			usage(argv[0]);
+			free(conf);
 			return 1;
 		default:
 			usage(argv[0]);
+			free(conf);
 			return 1;
 		}
 	}
-- 
2.4.3

