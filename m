Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34212 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788AbbEAQE5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 1 May 2015 12:04:57 -0400
Received: by wgso17 with SMTP id o17so94562170wgs.1
        for <linux-wpan@vger.kernel.org>; Fri, 01 May 2015 09:04:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 2/2] website: add new opentask entries
Date: Fri,  1 May 2015 18:04:48 +0200
Message-Id: <1430496288-17239-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430496288-17239-1-git-send-email-alex.aring@gmail.com>
References: <1430496288-17239-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index e6e2427..7cede5d 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -147,6 +147,8 @@ https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee80215
 * devicetree extended addr setting, draft is here http://www.spinics.net/lists/linux-wpan/msg01503.html[ieee802154: add usual way to get extended address via device tree]
 * RPL? - not our job, need to go through ipv6 netdev community, but we should do something to have a "started" mainline solution.
 * cleanup/fix 802.15.4 af raw/dgram socket code. We should use bluetooth socket code as example.
+* In wireless exists a "station dump", we need something similar "node dump" with all neighbour nodes and their last LQI value, addresses, etc. information.
+* A wpan-phy is an own device class, we need pm suspend handling like in wireless http://lxr.free-electrons.com/source/net/wireless/sysfs.c#L154[callbacks which are in #ifdef CONFIG_PM].
 
 Rework
 ~~~~~~
-- 
2.3.6

