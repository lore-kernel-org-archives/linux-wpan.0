Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47092 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbcKUUeh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:37 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/8] examples: add README with details to the various examples
Date: Mon, 21 Nov 2016 21:34:14 +0100
Message-Id: <1479760461-18947-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Describe the current set of example to give some background what they intend
to show case.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 Makefile.am              |  3 ++-
 configure.ac             |  1 +
 examples/Makefile.am     |  1 +
 examples/README.examples | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 examples/Makefile.am
 create mode 100644 examples/README.examples

diff --git a/Makefile.am b/Makefile.am
index 2261603..37f18b6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -20,4 +20,5 @@ AM_LDFLAGS = \
 
 SUBDIRS = \
 	src \
-	wpan-ping
+	wpan-ping \
+	examples
diff --git a/configure.ac b/configure.ac
index 6d438c4..289fd7f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,6 +56,7 @@ AC_CONFIG_FILES([
         Makefile
 	src/Makefile
 	wpan-ping/Makefile
+	examples/Makefile
 ])
 
 AC_OUTPUT
diff --git a/examples/Makefile.am b/examples/Makefile.am
new file mode 100644
index 0000000..1b6a35e
--- /dev/null
+++ b/examples/Makefile.am
@@ -0,0 +1 @@
+EXTRA_DIST = README.examples
diff --git a/examples/README.examples b/examples/README.examples
new file mode 100644
index 0000000..11e9424
--- /dev/null
+++ b/examples/README.examples
@@ -0,0 +1,34 @@
+This folder contains various examples on how the Linux-wpan stack can be used
+from userspace, using the Linux socket interface.
+
+These examples do not cover all socket programming functionality nor do they
+give a real introduction to it. Their aim is to provide some quick examples for
+using the Linux-wpan stack for developers familiar with socket programming.
+
+Keep in mind that the socket interface is used for the data plane. For the
+configuration plane you would use netlink, which is heavily demonstrated in
+iwpan itself.
+
+Examples:
+---------
+Address family AF_IEEE802154 with type SOCK_DGRAM:
+  * Direct usage of IEEE 802.15.4 frames, no 6LoWPAN involved
+  * Short and extended address usage is demonstrated
+  * af_ieee802154_rx loops and prints each received IEEE 802.15.4 frame on stdout
+  * af_ieee802154_tx sends a IEEE 802.15.4 frame
+
+Address family AF_INET6 with type SOCK_DGRAM:
+  * 6LoWPAN examples, IPv6 over IEEE 802.15.4
+  * af_inet6_rx binds on any IPv6 address on UDP port
+  * af_inet6_tx sends an UDP packet to the IPv6 all nodes address
+
+Address family AF_PACKET with type SOCK_RAW:
+  * Raw access to IEEE 8021.5.4 frames for rx and tx
+  * Useful for sniffer, packet generators, network stack in userspace, etc
+  * af_packet_rx loops and prints each frame as hexdump
+  * af_packet_tx constructs the raw packet payload manually and sends it
+
+Some of the example need special privileges to run. If you get a error like:
+socket: Operation not permitted
+
+Make sure your user that the needed privileges or run the example with sudo.
-- 
2.5.5

