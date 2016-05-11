Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38677 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348AbcEKJrL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 05:47:11 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH wpan-misc] website: update testing scripts for netns
Date: Wed, 11 May 2016 11:46:55 +0200
Message-Id: <1462960015-6833-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 website/index.txt | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/website/index.txt b/website/index.txt
index 65c6b9c..fde4d7d 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -90,8 +90,13 @@ Setup a 6LowPAN test network
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Let's assume you want to setup a 6lowpan test network of six nodes.
+Each of them will be created in their own net namespace to avoid
+local IPv6 optimizations. Each netns is named according to the wpan
+interface which available in the net namespace.
 
 ---------------------------------------------------------------------
+#!/bin/sh
+
 # we need some Private Area Network ID
 panid="0xbeef"
 # number of nodes
@@ -102,25 +107,26 @@ numnodes=6
 modprobe fakelb numlbs=$numnodes
 
 # initialize all the nodes
-for i in $(seq 0 $numnodes);
+for i in $(seq 0 `expr $numnodes - 1`);
 do
-	iwpan dev wpan${i} set pan_id 0xbeef
-	ip link wpan${i} name lowpan${i} type lowpan
-	ip link set wpan${i} up
-	ip link set lowpan${i} up
+	ip netns delete wpan${i}
+	ip netns add wpan${i}
+	PHYNUM=`iwpan dev | grep -B 1 wpan${i} | sed -ne '1 s/phy#\([0-9]\)/\1/p'`
+	iwpan phy${PHYNUM} set netns name wpan${i}
+
+	ip netns exec wpan${i} iwpan dev wpan${i} set pan_id 0xbeef
+	ip netns exec wpan${i} ip link add link wpan${i} name lowpan${i} type lowpan
+	ip netns exec wpan${i} ip link set wpan${i} up
+	ip netns exec wpan${i} ip link set lowpan${i} up
 done
 ---------------------------------------------------------------------
 
 Now let us send some data over our network:
 
 ---------------------------------------------------------------------
-wireshark -kSl -i lowpan0 &
-# get the IPv6 address of lowpan1
-lowpan1addr="$(ip addr show lowpan1 | grep inet6 \
-	| sed 's,.*inet6 \([^/]*\).*,\1,')"
-# tell ping6 to ping the IPv6 address of lowpan1 and send it via
-# lowpan0
-ping6 ${lowpan1addr}%lowpan0
+ip netns exec wpan0 wireshark -kSl -i lowpan0 &
+# ping all nodes
+ip netns exec wpan0 ping6 ff02::1%lowpan0
 ---------------------------------------------------------------------
 
 Now watch wireshark and all the nice ICMP packets there.
-- 
2.8.2

