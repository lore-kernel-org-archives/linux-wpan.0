Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40505 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbbCBKaT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 05:30:19 -0500
Received: by wiwl15 with SMTP id l15so13667891wiw.5
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 02:30:17 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: add frame parsing/generation dependency
Date: Mon,  2 Mar 2015 11:30:04 +0100
Message-Id: <1425292204-21235-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 3eb455b..7556cfc 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -138,6 +138,8 @@ The rework will contains a new netlink API and a general handling about frame cr
 |3. frame parsing | remove bugs, more generical        | [red]#TODO#
 |=======================================
 
+*NOTE* we need to finish rework state 2. before we can start 3 or anything else which touch the frame parsing/generation.
+
 For the nl802154 framework you will need the wpan-tools, older kernels need lowpan-tools but this is not recommended.
 
 // vim: set syntax=asciidoc:
-- 
2.3.0

