Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37501 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbbFBPoL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 11:44:11 -0400
Received: by wifw1 with SMTP id w1so150071676wif.0
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 08:44:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: remove driver-ops trace opentask entry
Date: Tue,  2 Jun 2015 17:43:57 +0200
Message-Id: <1433259837-13001-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index d8ccbb7..73d4145 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -134,7 +134,6 @@ Open Tasks
 ** no aret mode for max_frame_retires -1
 ** etc
 * Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
-** trace functionality for driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
 ** Whatever you want and find
 * rework
 ** missing features in nl802154, crypto etc.
-- 
2.4.1

