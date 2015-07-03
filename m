Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:55757 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754079AbbGCNXm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Jul 2015 09:23:42 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC 0/2] Adding stateful compression to IPHC
Date: Fri, 3 Jul 2015 15:23:36 +0200
Message-ID: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi all,

The following patches introduce support for stateful compression in IPHC.
 
Patch #1: Adding stateful compression to 6lowpan module.
Patch #2: Enabling use of stateful compression in bluetooth_6lowpan module.
 
Usage of stateful compression is described in Patch #1.
 
Limitations
===========
 
- Temporarly use of debugfs to be able to add context table entries.
- Current module does not support context time-outs.
- No support for multicast addresses stateful compression.
 
Discussion: Idea on how to make the 6lowpan context tables out of debug mode
============================================================================
 
The patch provided here is just a temporary solution where the contexts are
manually added. The proper way of adding/removing contexts would be to make
ndisc.c parse 6CO options and act upon it. Generated Router Advertisement
packets with 6CO option (for example from RADVD) will be handled in the
ndisc_router_discovery function.
 
Also, other flags like ARO, ABRO etc. which are specified in RFC6775 need to
be handled in the ipv6 module in order to do it in a neat way.
Potentially the RFC6775 extensions could potentially also be used by other
protocols than BLE and 802.15.4.
 
There is a need for parsing the 6CO option in ndisc.c which parses Router
Advertisement messages. Today the function calls to IPHC (6lowpan module) are
quite hard to implement in ndisc.c, as there is no guarantee that the 6lowpan
module will be loaded or not. It would make sense to build 6lowpan module
as in-build part of IPv6. The features could be compiled in by using #defines.
 
What do you think about moving 6lowpan as a component of IPv6 and modify ndisc.c
to handled 6LoWPAN specific options? Do you see any other solution to make sure
that 6CO is parsed and acted upon and still keep 6lowpan as a stand-alone module?

Best regards,
Lukasz Duda

Lukasz Duda (2):
  6lowpan: Add stateful compression for IPHC
  Bluetooth: 6lowpan: Enable stateful compression for bluetooth_6lowpan
    module

 include/net/6lowpan.h   |  37 ++++
 net/6lowpan/Makefile    |   2 +-
 net/6lowpan/context.c   | 523 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/context.h   |  13 ++
 net/6lowpan/iphc.c      | 259 ++++++++++++++++++++----
 net/bluetooth/6lowpan.c |   4 +
 6 files changed, 795 insertions(+), 43 deletions(-)
 create mode 100644 net/6lowpan/context.c
 create mode 100644 net/6lowpan/context.h

-- 
2.1.4

