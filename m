Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56431 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbbFEVlZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 17:41:25 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools] website: adding a list with links to many relevant specifications
Date: Fri,  5 Jun 2015 23:41:17 +0200
Message-Id: <1433540477-18149-1-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <20150605173623.GA3023@thanatos>
References: <20150605173623.GA3023@thanatos>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This does not cover all and some other might be missing and some might not be
to relevant to us but it is a start for people to start digging into it.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 website/index.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 19d1e70..1bec32b 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -173,4 +173,39 @@ The rework will contains a new netlink API and a general handling about frame cr
 
 For the nl802154 framework you will need the wpan-tools, older kernels need lowpan-tools but this is not recommended.
 
+
+Specifications
+~~~~~~~~~~~~~~
+
+* http://www.ieee802.org/15/pub/TG4.html[IEEE]:
+** http://standards.ieee.org/about/get/802/802.15.html
+** 802.15.4-2003
+** 802.15.4-2006
+** 802.15.4a-2007
+** 802.15.4c-2009
+** 802.15.4d-2009
+** 802.15.4-2011
+** 802.15.4e-2012
+** 802.15.4f-2012
+** 802.15.4g-2012
+** 802.15.4j-2013
+** 802.15.4k-2013
+** 802.15.4m-2014
+** 802.15.4p-2014
+
+* https://www.ietf.org/[IETF]:
+** http://tools.ietf.org/html/rfc4919[IPv6 over Low-Power Wireless Personal Area Networks (6LoWPANs): Overview, Assumptions, Problem Statement, and Goals]
+** http://tools.ietf.org/html/rfc4944[Transmission of IPv6 Packets over IEEE 802.15.4 Networks]
+** http://tools.ietf.org/html/rfc6282[Compression Format for IPv6 Datagrams over IEEE 802.15.4-Based Networks]
+** http://tools.ietf.org/html/rfc6550[RPL: IPv6 Routing Protocol for Low-Power and Lossy Networks]
+** http://tools.ietf.org/html/rfc6775[Neighbor Discovery Optimization for IPv6 over Low-Power Wireless Personal Area Networks (6LoWPANs)]
+** http://tools.ietf.org/html/rfc7400[6LoWPAN-GHC: Generic Header Compression for IPv6 over Low-Power Wireless Personal Area Networks (6LoWPANs)]
+
+* IETF working groups:
+** http://datatracker.ietf.org/wg/6lowpan/documents/[IPv6 over Low power WPAN (6lowpan)]
+** http://datatracker.ietf.org/wg/roll/documents/[Routing Over Low power and Lossy networks (roll)]
+** http://datatracker.ietf.org/wg/6tisch/documents/[IPv6 over the TSCH mode of IEEE 802.15.4e (6tisch)]
+** http://datatracker.ietf.org/wg/6lo/documents/[IPv6 over Networks of Resource-constrained Nodes (6lo)]
+** http://datatracker.ietf.org/wg/core/documents/[Constrained RESTful Environments (core)]
+
 // vim: set syntax=asciidoc:
-- 
2.1.0

