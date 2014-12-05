Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43055 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaLERz6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 12:55:58 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH wpan-tools 2/3] build: add header files to SOURCES
Date: Fri,  5 Dec 2014 18:55:43 +0100
Message-Id: <1417802144-3012-3-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
References: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

We need to specify them here or they will not end up in the tarball and thus
distcheck would fail.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 src/Makefile.am | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 26f73b8..2d54576 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -3,11 +3,14 @@ bin_PROGRAMS = \
 
 iwpan_SOURCES = \
 	iwpan.c \
+	iwpan.h \
 	sections.c \
 	info.c \
 	interface.c \
 	phy.c \
-	mac.c
+	mac.c \
+	nl_extras.h \
+	nl802154.h
 
 iwpan_CFLAGS = $(AM_CFLAGS) $(LIBNL3_CFLAGS)
 iwpan_LDADD = $(LIBNL3_LIBS)
-- 
1.9.3

