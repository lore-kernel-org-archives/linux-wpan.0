Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:47137 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdJTKWk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:40 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 0/7] 6LoWPAN userspace support
Date: Fri, 20 Oct 2017 13:22:29 +0300
Message-Id: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces support for 6LoWPAN userspace interface creation along
with IPSP plugin which takes care of L2CAP channel creation.

The bt_6lo instance handles all the details to create the network
interface and also attach channels to it so any io is automatically
forward to the right path. The plugin make use of bt_6lo and create
interfaces for each adapter available using "bt" as prefix followed by
adapter index.

At the current stage only router/central role is supported since
peripheral role may actually need to be enabled via advertisement which
perhaps will require a D-Bus to be triggered on demand.

Since the IPSP plugins does actually register a proper profile driver
Device.Connect can now attempt to connect the IPSP channel and then
proceed to attach the channel to interface, so it is well integrated
with existing D-Bus APIs.

Note that this all depends on TUN/TAP changes proposed here:
http://www.spinics.net/lists/linux-bluetooth/msg72471.html

Luiz Augusto von Dentz (7):
  shared/io: Add io_recv
  shared: Add initial code for 6LoWPAN
  unit: Add initial test for bt_6lo
  uuid: Add IPSP UUID
  build: Add IPSP plugin
  ipsp: Connect to IPSP PSM
  ipsp: Add support for bt_6lo

 Makefile.am             |   8 +-
 Makefile.plugins        |   5 +
 configure.ac            |   4 +
 lib/uuid.h              |   2 +
 profiles/network/ipsp.c | 318 +++++++++++++++++++++++++++++++
 src/shared/6lo.c        | 493 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/6lo.h        |  40 ++++
 src/shared/io-glib.c    |  20 ++
 src/shared/io.h         |   1 +
 unit/test-6lo.c         | 271 ++++++++++++++++++++++++++
 10 files changed, 1161 insertions(+), 1 deletion(-)
 create mode 100644 profiles/network/ipsp.c
 create mode 100644 src/shared/6lo.c
 create mode 100644 src/shared/6lo.h
 create mode 100644 unit/test-6lo.c

-- 
2.13.6

