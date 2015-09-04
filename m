Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35645 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530AbbIDJRw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Sep 2015 05:17:52 -0400
Received: by wicge5 with SMTP id ge5so10892841wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 04 Sep 2015 02:17:51 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 2/3] website: update open tasks
Date: Fri,  4 Sep 2015 11:17:10 +0200
Message-Id: <1441358231-22349-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441358231-22349-1-git-send-email-alex.aring@gmail.com>
References: <1441358231-22349-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/website/index.txt b/website/index.txt
index 9a4794f..b7b5311 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -136,14 +136,12 @@ Open Tasks
 * There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.15.4 standard. Words say more than numbers...
 ** channel/page to frequency
 ** cca modes/opts
-** no aret mode for max_frame_retires -1
 ** etc
 * Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
 ** Whatever you want and find
 * rework
 ** missing features in nl802154, crypto etc.
-** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx] and
-https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c[6LoWPAN]. Crypto need to be done at first, otherwise I can't test it.
+** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx]. Crypto need to be done at first, otherwise I can't test it.
 ** remove cb context from dev_hard_header and introduce generic header generation functions like https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/header_ops.c#L80[header_ops]. Here too, crypto need to be done at first.
 * systemd
 ** add basic functionality for nl802154 and 6lowpan setup in systemd-networkd
@@ -152,7 +150,6 @@ https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee80215
 * RPL? - not our job, need to go through ipv6 netdev community, but we should do something to have a "started" mainline solution.
 * cleanup/fix 802.15.4 af raw/dgram socket code. We should use bluetooth socket code as example.
 * In wireless exists a "station dump", we need something similar "node dump" with all neighbour nodes and their last LQI value, addresses, etc. information.
-* A wpan-phy is an own device class, we need pm suspend handling like in wireless http://lxr.free-electrons.com/source/net/wireless/sysfs.c#L154[callbacks which are in #ifdef CONFIG_PM].
 
 Rework
 ~~~~~~
-- 
2.5.1

