Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r-36.net ([78.46.55.227]:36250 "EHLO r-36.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbcBUUbZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 21 Feb 2016 15:31:25 -0500
From: Christoph Lohmann <20h@r-36.net>
Subject: [PATCH] Add a part in the website about how to setup a test network.
Date: Sun, 21 Feb 2016 21:23:08 +0100
Message-Id: <1456086188-15375-1-git-send-email-20h@r-36.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Christoph Lohmann <20h@r-36.net>

---
 website/index.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 3ac44b6..2f5c539 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -85,6 +85,47 @@ Note: we don't support any case of short-addresses right now. This is a complica
 Of course we supporting broadcast frames via short-addresses but nothing more in 802.15.4 6LoWPAN.
 Only extended address handling is supported right now.
 
+
+Setup a 6LowPAN test network
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Let's assume you want to setup a 6lowpan test network of six nodes.
+
+---------------------------------------------------------------------
+# we need some Private Area Network ID
+panid="0xbeef"
+# number of nodes
+numnodes=6
+
+# include the kernel module for a fake node, tell it to create six
+# nodes
+modprobe fakelb numlbs=$numnodes
+
+# initialize all the nodes
+for i in $(seq 0 $numnodes);
+do
+	iwpan dev wpan${i} set pan_id 0xbeef
+	ip link wpan${i} name lowpan${i} type lowpan
+	ip link set wpan${i} up
+	ip link set lowpan${i} up
+done
+---------------------------------------------------------------------
+
+Now let us send some data over our network:
+
+---------------------------------------------------------------------
+wireshark -kSl -i lowpan0 &
+# get the IPv6 address of lowpan1
+lowpan1addr="$(ip addr show lowpan1 | grep inet6 \
+	| sed 's,.*inet6 \([^/]*\).*,\1,')"
+# tell ping6 to ping the IPv6 address of lowpan1 and send it via
+# lowpan0
+ping6 ${lowpan1addr}%lowpan0
+---------------------------------------------------------------------
+
+Now watch wireshark and all the nice ICMP packets there.
+
+
 Sniffing
 ~~~~~~~~
 
-- 
2.7.0

