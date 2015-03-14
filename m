Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34842 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbCNSc2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 14:32:28 -0400
Received: by wibdy8 with SMTP id dy8so9945961wib.0
        for <linux-wpan@vger.kernel.org>; Sat, 14 Mar 2015 11:32:27 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: correct default phy indentifier
Date: Sat, 14 Mar 2015 19:32:14 +0100
Message-Id: <1426357934-11016-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch corrects the phy indentifier name. Since we changed the UAPI
that we use "phy%d" instead "wpan-phy%d" all calls need to be changed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 7556cfc..2f007d5 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -95,7 +95,7 @@ iwpan dev $IFNAME del
 Finally create a monitor interface:
 
 ---------------------------------------------------------------------
-iwpan phy wpan-phy0 interface add monitor%d type monitor
+iwpan phy phy0 interface add monitor%d type monitor
 ---------------------------------------------------------------------
 
 Then bring this interface up and run wireshark, tcpdump, etc... on it.
-- 
2.3.2

