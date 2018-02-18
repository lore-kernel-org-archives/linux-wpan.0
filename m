Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:51470 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeBRXDS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 18 Feb 2018 18:03:18 -0500
Date: Mon, 19 Feb 2018 00:03:16 +0100
From: anton@picapica.im
Subject: [PATCH] website: Add troubleshooting section in how-tos
Message-ID: <20180218230316.GA8719@picapica.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org


Some hints about issues related to SPI bus.

Signed-off-by: Anton Sviridenko <anton@picapica.im>
---
 website/index.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 9fd149e..6d9fe88 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -135,6 +135,21 @@ ip netns exec wpan0 ping6 ff02::1%lowpan0
 Now watch wireshark and all the nice ICMP packets there.
 
 
+Troubleshooting
+~~~~~~~~~~~~~~~
+If you have issues with transceiver connected to SPI bus, check first
+if wiring is correct and SPI controller is properly configured. Try to
+decrease SPI clock frequency. Messages like these ones in dmesg output
+could indicate problems with SPI connection:
+
+---------------------------------------------------------------------
+at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state:
+0x01
+WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
+received tx trac status 4
+---------------------------------------------------------------------
+
+
 Sniffing
 ~~~~~~~~
 
-- 
2.3.6


