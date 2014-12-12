Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35093 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967904AbaLLNrh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 08:47:37 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so9148933wgg.35
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 05:47:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: inital commit
Date: Fri, 12 Dec 2014 14:47:29 +0100
Message-Id: <1418392049-11101-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418392049-11101-1-git-send-email-alex.aring@gmail.com>
References: <1418392049-11101-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This is the initial commit for the website asciidoc framework of:

http://wpan.cakelab.org/

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/.gitingore |   1 +
 website/Makefile   |   5 +++
 website/index.txt  | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 website/.gitingore
 create mode 100644 website/Makefile
 create mode 100644 website/index.txt

diff --git a/website/.gitingore b/website/.gitingore
new file mode 100644
index 0000000..dcaf716
--- /dev/null
+++ b/website/.gitingore
@@ -0,0 +1 @@
+index.html
diff --git a/website/Makefile b/website/Makefile
new file mode 100644
index 0000000..cc090bc
--- /dev/null
+++ b/website/Makefile
@@ -0,0 +1,5 @@
+all:
+	asciidoc -b html5 -a icons -a toc2 -a theme=flask index.txt
+
+clean:
+	rm index.html
diff --git a/website/index.txt b/website/index.txt
new file mode 100644
index 0000000..a7ab4bb
--- /dev/null
+++ b/website/index.txt
@@ -0,0 +1,128 @@
+linux-wpan
+==========
+Mailinglist <linux-wpan@vger.kernel.org>
+
+wpan-tools
+----------
+
+To access the nl802154 netlink inteface you will need the wpan-tools.
+
+Dependencies:
+
+- netlink library http://www.infradead.org/~tgr/libnl/[libnl].
+
+These tools contains:
+
+[horizontal]
+*iwpan*:: based on the wireless http://wireless.kernel.org/en/users/Documentation/iw[iw] tool.
+
+Download
+~~~~~~~~
+For the last release check out http://wpan.cakelab.org/releases/[releases] page:
+
+http://wpan.cakelab.org/releases/
+
+Supported Hardware
+------------------
+
+.Supported 802.15.4 Hardware
+[cols="3,4,2,^2,12",options="header"]
+|=============================================================
+|Transceiver |Supported        |Driver     | Bus |Where to buy
+|at86rf230   |no               |at86rf230? | SPI |
+|at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
+|at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
+|at86rf212   |yes              |at86rf230  | SPI |
+|atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
+|=============================================================
+
+How-To's
+--------
+
+This section describes various How-To's.
+Per default you should have already a node type wpan interface.
+
+////////
+af802154
+~~~~~~~
+
+////////
+6LoWPAN
+~~~~~~~
+
+Set some valid pan_id, 802.15.4 default is 0xffff which means not assigned:
+
+---------------------------------------------------------------------
+iwpan dev wpan0 set pan_id 0xbeef
+---------------------------------------------------------------------
+
+Currently you need to setup the 6LoWPAN interface manually:
+
+---------------------------------------------------------------------
+ip link add link wpan0 name lowpan0 type lowpan
+---------------------------------------------------------------------
+
+That's it! Now you have some lowpan0 interface with a 6LoWPAN 1280 MTU which runs on top the wpan interface.
+As default you have a default link-local address based on the MAC (extended address).
+
+Note: we don't support any case of short-addresses right now. This is a complicated issue with the IPv6 neighbour discovery cache.
+Of course we supporting broadcast frames via short-addresses but nothing more in 802.15.4 6LoWPAN.
+Only extended address handling is supported right now.
+
+Sniffing
+~~~~~~~~
+
+To sniff first remove all wpan interface which sits on top of the wpan phy.
+You will get a list of all current running phy interface with:
+
+---------------------------------------------------------------------
+iwpan dev
+---------------------------------------------------------------------
+
+then delete all interfaces with:
+
+---------------------------------------------------------------------
+iwpan dev $IFNAME del
+---------------------------------------------------------------------
+
+Finally create a monitor interface:
+
+---------------------------------------------------------------------
+iwpan phy wpan-phy0 interface add monitor%d type monitor
+---------------------------------------------------------------------
+
+Then bring this interface up and run wireshark, tcpdump, etc... on it.
+
+//////
+Foren6
+^^^^^^
+
+//////
+Developing
+----------
+
+Current developing repository is http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git[bluetooth-next].
+All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetooth-next.
+
+For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
+The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
+
+Rework
+~~~~~~
+
+Currently a rework of 802.15.4 subsystem is in progress.
+
+The rework will contains a new netlink API and a general handling about frame creation and parsing.
+
+.Supported 802.15.4 Hardware
+[options="header"]
+|=======================================
+|Milestone        | Description | state
+|1. nl802154      | new netlink framework              | [green]#mostly done#
+|2. crypto-layer  | accessable over nl802154 and tools | [red]#TODO#
+|3. frame parsing | remove bugs, more generical        | [red]#TODO#
+|=======================================
+
+For the nl802154 framework you will need the wpan-tools, older kernels need lowpan-tools but this is not recommended.
+
+// vim: set syntax=asciidoc:
-- 
2.1.3

