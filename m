Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43058 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaLERz7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 12:55:59 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH wpan-tools 3/3] configure: do not use check-news for now
Date: Fri,  5 Dec 2014 18:55:44 +0100
Message-Id: <1417802144-3012-4-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
References: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

We do not use a NEWS file right now and without it distcheck will fail
with this option. We can bring it back when we are going to use a NEWS
file for keeping track.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6ad60f5..9aa6330 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,7 +5,6 @@ AC_INIT([Userspace tools for Linux IEEE 802.15.4 stack],
 AC_CONFIG_SRCDIR([src/iwpan.c])
 AC_CONFIG_AUX_DIR([build-aux])
 AM_INIT_AUTOMAKE([
-	check-news
 	foreign
 	1.11
 	-Wall
-- 
1.9.3

