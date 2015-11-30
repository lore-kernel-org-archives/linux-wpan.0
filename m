Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:40004 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbbK3LVb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Nov 2015 06:21:31 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/4] iwpan/wpan-ping: add some missing static attributes
Date: Mon, 30 Nov 2015 12:21:20 +0100
Message-Id: <1448882482-20784-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
References: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Sparse pointed these out to me.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/info.c            | 6 +++---
 src/iwpan.c           | 2 +-
 wpan-ping/wpan-ping.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/info.c b/src/info.c
index e00ed3e..7c033ec 100644
--- a/src/info.c
+++ b/src/info.c
@@ -148,8 +148,8 @@ static void print_freq_handler(int channel_page, int channel)
 
 static char cca_mode_buf[100];
 
-const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
-				   enum nl802154_cca_opts cca_opt)
+static const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
+					  enum nl802154_cca_opts cca_opt)
 {
 	switch (cca_mode) {
 	case NL802154_CCA_ENERGY:
@@ -217,7 +217,7 @@ static const char *commands[NL802154_CMD_MAX + 1] = {
 
 static char cmdbuf[100];
 
-const char *command_name(enum nl802154_commands cmd)
+static const char *command_name(enum nl802154_commands cmd)
 {
 	if (cmd <= NL802154_CMD_MAX && commands[cmd])
 		return commands[cmd];
diff --git a/src/iwpan.c b/src/iwpan.c
index e988703..e7781fd 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -21,7 +21,7 @@
 
 /* TODO libnl 1.x compatibility code */
 
-int iwpan_debug = 0;
+static int iwpan_debug = 0;
 
 static int nl802154_init(struct nl802154_state *state)
 {
diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 08211c3..665ed93 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -99,7 +99,7 @@ struct config {
 
 extern char *optarg;
 
-void usage(const char *name) {
+static void usage(const char *name) {
 	printf("Usage: %s OPTIONS\n"
 	"OPTIONS:\n"
 	"--daemon |-d\n"
-- 
2.4.3

