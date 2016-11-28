Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50996 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbcK1RWm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 28 Nov 2016 12:22:42 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next] docs: ieee802154: update main documentation file
Date: Mon, 28 Nov 2016 18:22:33 +0100
Message-Id: <1480353753-28365-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

This updates some out of date documentation and fixes some wrong assumptions as
well as pure grammar fixes. This file needs to move towards the new kernel doc
system and getting an overhaul during this work.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 Documentation/networking/ieee802154.txt | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
index aa69ccc..c411434 100644
--- a/Documentation/networking/ieee802154.txt
+++ b/Documentation/networking/ieee802154.txt
@@ -4,20 +4,20 @@
 
 Introduction
 ============
-The IEEE 802.15.4 working group focuses on standardization of bottom
-two layers: Medium Access Control (MAC) and Physical (PHY). And there
+The IEEE 802.15.4 working group focuses on standardization of the bottom
+two layers: Medium Access Control (MAC) and Physical access (PHY). And there
 are mainly two options available for upper layers:
  - ZigBee - proprietary protocol from the ZigBee Alliance
  - 6LoWPAN - IPv6 networking over low rate personal area networks
 
-The linux-wpan project goal is to provide a complete implementation
+The goal of the Linux-wpan is to provide a complete implementation
 of the IEEE 802.15.4 and 6LoWPAN protocols. IEEE 802.15.4 is a stack
 of protocols for organizing Low-Rate Wireless Personal Area Networks.
 
 The stack is composed of three main parts:
  - IEEE 802.15.4 layer;  We have chosen to use plain Berkeley socket API,
-   the generic Linux networking stack to transfer IEEE 802.15.4 messages
-   and a special protocol over genetlink for configuration/management
+   the generic Linux networking stack to transfer IEEE 802.15.4 data
+   messages and a special protocol over netlink for configuration/management
  - MAC - provides access to shared channel and reliable data delivery
  - PHY - represents device drivers
 
@@ -33,15 +33,13 @@ include/net/af_ieee802154.h header or in the special header
 in the userspace package (see either http://wpan.cakelab.org/ or the
 git tree at https://github.com/linux-wpan/wpan-tools).
 
-One can use SOCK_RAW for passing raw data towards device xmit function. YMMV.
-
 
 Kernel side
 =============
 
 Like with WiFi, there are several types of devices implementing IEEE 802.15.4.
 1) 'HardMAC'. The MAC layer is implemented in the device itself, the device
-   exports MLME and data API.
+   exports a management (e.g. MLME) and data API.
 2) 'SoftMAC' or just radio. These types of devices are just radio transceivers
    possibly with some kinds of acceleration like automatic CRC computation and
    comparation, automagic ACK handling, address matching, etc.
@@ -106,7 +104,7 @@ Fake drivers
 
 In addition there is a driver available which simulates a real device with
 SoftMAC (fakelb - IEEE 802.15.4 loopback driver) interface. This option
-provides possibility to test and debug stack without usage of real hardware.
+provides a possibility to test and debug the stack without usage of real hardware.
 
 See sources in drivers/net/ieee802154 folder for more details.
 
@@ -125,17 +123,15 @@ to support the IPv6 minimum MTU requirement [RFC2460], and stateless header
 compression for IPv6 datagrams (LOWPAN_HC1 and LOWPAN_HC2) to reduce the
 relatively large IPv6 and UDP headers down to (in the best case) several bytes.
 
-In Semptember 2011 the standard update was published - [RFC6282].
+In September 2011 the standard update was published - [RFC6282].
 It deprecates HC1 and HC2 compression and defines IPHC encoding format which is
 used in this Linux implementation.
 
 All the code related to 6lowpan you may find in files: net/6lowpan/*
 and net/ieee802154/6lowpan/*
 
-To setup 6lowpan interface you need (busybox release > 1.17.0):
-1. Add IEEE802.15.4 interface and initialize PANid;
+To setup a 6LoWPAN interface you need:
+1. Add IEEE802.15.4 interface and set channel and PAN ID;
 2. Add 6lowpan interface by command like:
    # ip link add link wpan0 name lowpan0 type lowpan
-3. Set MAC (if needs):
-   # ip link set lowpan0 address de:ad:be:ef:ca:fe:ba:be
-4. Bring up 'lowpan0' interface
+3. Bring up 'lowpan0' interface
-- 
2.5.5

