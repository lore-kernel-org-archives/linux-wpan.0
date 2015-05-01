Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34006 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964771AbbEAQE4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 1 May 2015 12:04:56 -0400
Received: by wicmx19 with SMTP id mx19so34435620wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 01 May 2015 09:04:55 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 1/2] website: remove finished opentasks
Date: Fri,  1 May 2015 18:04:47 +0200
Message-Id: <1430496288-17239-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/website/index.txt b/website/index.txt
index 2dfa962..e6e2427 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -134,9 +134,7 @@ Open Tasks
 ** no aret mode for max_frame_retires -1
 ** etc
 * Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
-** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
-** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
-http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
+** trace functionality for driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
 ** Whatever you want and find
 * rework
 ** missing features in nl802154, crypto etc.
-- 
2.3.6

