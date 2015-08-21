Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60902 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbHUIju (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Aug 2015 04:39:50 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 1/2] ieee802154: docs: fix project name to linux-wpan as well as some typos
Date: Fri, 21 Aug 2015 10:39:39 +0200
Message-Id: <1440146380-12066-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 Documentation/networking/ieee802154.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
index 1700756..aa69ccc 100644
--- a/Documentation/networking/ieee802154.txt
+++ b/Documentation/networking/ieee802154.txt
@@ -7,11 +7,11 @@ Introduction
 The IEEE 802.15.4 working group focuses on standardization of bottom
 two layers: Medium Access Control (MAC) and Physical (PHY). And there
 are mainly two options available for upper layers:
- - ZigBee - proprietary protocol from ZigBee Alliance
- - 6LowPAN - IPv6 networking over low rate personal area networks
+ - ZigBee - proprietary protocol from the ZigBee Alliance
+ - 6LoWPAN - IPv6 networking over low rate personal area networks
 
-The Linux-ZigBee project goal is to provide complete implementation
-of IEEE 802.15.4 and 6LoWPAN protocols. IEEE 802.15.4 is a stack
+The linux-wpan project goal is to provide a complete implementation
+of the IEEE 802.15.4 and 6LoWPAN protocols. IEEE 802.15.4 is a stack
 of protocols for organizing Low-Rate Wireless Personal Area Networks.
 
 The stack is composed of three main parts:
-- 
2.4.3

