Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36135 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbDHIbn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 04:31:43 -0400
Received: by wizk4 with SMTP id k4so45958446wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 01:31:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: add opentask section in developing
Date: Wed,  8 Apr 2015 10:31:34 +0200
Message-Id: <1428481894-19784-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds an open task section in developing. So maybe if somebody
has too much time he/she can pick tasks from it and send patches.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 2f007d5..9cf2ca3 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -122,6 +122,29 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
 For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
 The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
 
+Open Tasks
+~~~~~~~~~~
+
+* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.1.54 standard. Words say more than numbers...
+** channel/page to frequency
+** cca modes/opts
+** no aret mode for max_frame_retires -1
+** etc
+* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
+** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
+** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
+http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
+** Whatever you want and find
+* rework
+** missing features in nl802154, crypto etc.
+** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx] and
+https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c[6LoWPAN]. crypto need to be done at first, otherwise I can't test it.
+** remove cb context from dev_hard_header and introduce generic header generation functions like https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/header_ops.c#L80[header_ops]. Here too, crypto need to be done at first.
+* systemd
+** add basic functionality for nl802154 and 6lowpan setup in systemd-networkd
+* devicetree extended addr setting, draft is here http://www.spinics.net/lists/linux-wpan/msg01503.html[ieee802154: add usual way to get extended address via device tree]
+* RPL? - not our job, need to go through ipv6 netdev community, but we should do something to have a "started" mainline solution.
+
 Rework
 ~~~~~~
 
-- 
2.3.5

