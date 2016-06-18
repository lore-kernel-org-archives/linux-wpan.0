Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46468 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbcFRJXI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 18 Jun 2016 05:23:08 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: linux-wpan radvd upstream
Message-ID: <22574127-79b0-9877-769d-1489eb3162e5@pengutronix.de>
Date: Sat, 18 Jun 2016 11:23:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, Jukka Rissanen <jukka.rissanen@linux.intel.com>, reubenhwk@gmail.com

Hi wpan and bluetooth people,

Please review dev branch [0]. The important commit is the rework of the 6CO
support which is used by Bluetooth and 802.15.4 6LoWPAN.

Jukka, tell me if support for a common userspace application to sending
RA frames is okay for you.

I like to send a push request the next days to radvd repository.

btw:

We have now the layer for ndisc stuff and could think about to handle
6CO in userspace.

NOT the sending transmit of RA + 6CO, this isn't kernel job, but processing
RA frames with 6CO could be moved to kernel. The kernel take care for
context table only (overwrites by administration should always possible).

Anyway, I think we can still change it later if we want to move the
handling into kernelspace.

- Alex

[0] https://github.com/linux-wpan/radvd/commits/6lowpan
