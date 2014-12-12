Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51411 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbaLLOVz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:21:55 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so2633918wiw.13
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:21:53 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 1/2] website: fix milestone table name
Date: Fri, 12 Dec 2014 15:21:45 +0100
Message-Id: <1418394106-12799-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index a7ab4bb..5a3252b 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -114,7 +114,7 @@ Currently a rework of 802.15.4 subsystem is in progress.
 
 The rework will contains a new netlink API and a general handling about frame creation and parsing.
 
-.Supported 802.15.4 Hardware
+.Milestones
 [options="header"]
 |=======================================
 |Milestone        | Description | state
-- 
2.1.3

