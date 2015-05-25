Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52606 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbbEYMia (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:38:30 -0400
Date: Mon, 25 May 2015 15:38:29 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCHv2 bluetooth-next 2/6]
 Documentation/networking/ieee802154.txt: fix various inaccuracies.
Message-ID: <20150525123829.GK11340@wantstofly.org>
References: <cover.1432535597.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432535597.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

* Update the linux-zigbee git:// repository URL.

* Remove the MLME section as the current kernel does not provide a
  full 802.15.4 MLME implementation.

* The hardmac example driver 'fakehard' was removed some time ago.

* The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
  not in drivers/ieee802154/.

* The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.

* Some of the 6LoWPAN code lives in net/6lowpan/.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 Documentation/networking/ieee802154.txt | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
index 22bbc72..1700756 100644
--- a/Documentation/networking/ieee802154.txt
+++ b/Documentation/networking/ieee802154.txt
@@ -30,8 +30,8 @@ int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
 
 The address family, socket addresses etc. are defined in the
 include/net/af_ieee802154.h header or in the special header
-in our userspace package (see either linux-zigbee sourceforge download page
-or git tree at git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee).
+in the userspace package (see either http://wpan.cakelab.org/ or the
+git tree at https://github.com/linux-wpan/wpan-tools).
 
 One can use SOCK_RAW for passing raw data towards device xmit function. YMMV.
 
@@ -49,15 +49,6 @@ Like with WiFi, there are several types of devices implementing IEEE 802.15.4.
 Those types of devices require different approach to be hooked into Linux kernel.
 
 
-MLME - MAC Level Management
-============================
-
-Most of IEEE 802.15.4 MLME interfaces are directly mapped on netlink commands.
-See the include/net/nl802154.h header. Our userspace tools package
-(see above) provides CLI configuration utility for radio interfaces and simple
-coordinator for IEEE 802.15.4 networks as an example users of MLME protocol.
-
-
 HardMAC
 =======
 
@@ -75,8 +66,6 @@ net_device with a pointer to struct ieee802154_mlme_ops instance. The fields
 assoc_req, assoc_resp, disassoc_req, start_req, and scan_req are optional.
 All other fields are required.
 
-We provide an example of simple HardMAC driver at drivers/ieee802154/fakehard.c
-
 
 SoftMAC
 =======
@@ -89,7 +78,8 @@ stack interface for network sniffers (e.g. WireShark).
 
 This layer is going to be extended soon.
 
-See header include/net/mac802154.h and several drivers in drivers/ieee802154/.
+See header include/net/mac802154.h and several drivers in
+drivers/net/ieee802154/.
 
 
 Device drivers API
@@ -114,18 +104,17 @@ Moreover IEEE 802.15.4 device operations structure should be filled.
 Fake drivers
 ============
 
-In addition there are two drivers available which simulate real devices with
-HardMAC (fakehard) and SoftMAC (fakelb - IEEE 802.15.4 loopback driver)
-interfaces. This option provides possibility to test and debug stack without
-usage of real hardware.
+In addition there is a driver available which simulates a real device with
+SoftMAC (fakelb - IEEE 802.15.4 loopback driver) interface. This option
+provides possibility to test and debug stack without usage of real hardware.
 
-See sources in drivers/ieee802154 folder for more details.
+See sources in drivers/net/ieee802154 folder for more details.
 
 
 6LoWPAN Linux implementation
 ============================
 
-The IEEE 802.15.4 standard specifies an MTU of 128 bytes, yielding about 80
+The IEEE 802.15.4 standard specifies an MTU of 127 bytes, yielding about 80
 octets of actual MAC payload once security is turned on, on a wireless link
 with a link throughput of 250 kbps or less.  The 6LoWPAN adaptation format
 [RFC4944] was specified to carry IPv6 datagrams over such constrained links,
@@ -140,7 +129,8 @@ In Semptember 2011 the standard update was published - [RFC6282].
 It deprecates HC1 and HC2 compression and defines IPHC encoding format which is
 used in this Linux implementation.
 
-All the code related to 6lowpan you may find in files: net/ieee802154/6lowpan.*
+All the code related to 6lowpan you may find in files: net/6lowpan/*
+and net/ieee802154/6lowpan/*
 
 To setup 6lowpan interface you need (busybox release > 1.17.0):
 1. Add IEEE802.15.4 interface and initialize PANid;
-- 
2.1.0

