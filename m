Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47898 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbFDNZh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 09:25:37 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/3] wpan-ping: Add README for some basic usage descriptions.
Date: Thu,  4 Jun 2015 15:25:22 +0200
Message-Id: <1433424323-24099-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433424323-24099-1-git-send-email-stefan@osg.samsung.com>
References: <1433424323-24099-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/Makefile.am      |  2 ++
 wpan-ping/README.wpan-ping | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 wpan-ping/README.wpan-ping

diff --git a/wpan-ping/Makefile.am b/wpan-ping/Makefile.am
index 6b511a9..6021c95 100644
--- a/wpan-ping/Makefile.am
+++ b/wpan-ping/Makefile.am
@@ -4,3 +4,5 @@ wpan_ping_SOURCES = wpan-ping.c
 
 wpan_ping_CFLAGS = $(AM_CFLAGS) $(LIBNL3_CFLAGS)
 wpan_ping_LDADD = $(LIBNL3_LIBS)
+
+EXTRA_DIST = README.wpan-ping
diff --git a/wpan-ping/README.wpan-ping b/wpan-ping/README.wpan-ping
new file mode 100644
index 0000000..4827e21
--- /dev/null
+++ b/wpan-ping/README.wpan-ping
@@ -0,0 +1,26 @@
+wpan-ping aims to offer ping/ping6 like functionality on a IEEE 802.15.4 level.
+
+No control message protocol is defined so we will simply use DGRAM's over a
+plain socket with a server component to emulate the behaviour.
+
+One can specify packet count (-c) as well as size (-s) and the interface to be
+used.
+
+Example usage server side:
+--------------------------
+./wpan-ping -d 0x0001 #0x0001 is the client short address
+Server mode. Waiting for packets...
+
+Example usage client side:
+--------------------------
+./wpan-ping -a 0x0003 -c 5 -s 114 #0x0003 is the server short address
+PING 0x0003 (PAN ID 0xbeef) 114 data bytes
+114 bytes from 0x0003 seq=0 time=22.0 ms
+114 bytes from 0x0003 seq=1 time=27.9 ms
+114 bytes from 0x0003 seq=2 time=21.3 ms
+114 bytes from 0x0003 seq=3 time=21.3 ms
+114 bytes from 0x0003 seq=4 time=20.3 ms
+
+--- 0x0003 ping statistics ---
+5 packets transmitted, 5 received, 0% packet loss
+rtt min/avg/max = 20.261/22.539/27.895 ms
-- 
2.1.0

