Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52322 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965115AbcBQJOU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 17 Feb 2016 04:14:20 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC radvd 0/2] 6lowpan: pending radvd patches
Date: Wed, 17 Feb 2016 10:14:13 +0100
Message-Id: <1455700455-5319-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, reubenhwk@gmail.com, s@mlng.net, Alexander Aring <aar@pengutronix.de>

Hi all,

this patch series are my latest version for support 6CO in radvd.
Somebody wants to bring these patches into radvd upstream, see [0].

Nevertheless, I don't have any time to working on this currently so I want
to broadcast somehow my latest state. If there are no issues for radvd
maintainer, then this is great. :-)

Maybe somebody can also work on the ToDo's like C=0 handling at first and
then have some "mechanism" to switch to C=1.

How to setup:

Nodes which sends RA messages need to setup 6CO before.
This is the "lowpanco" field in the configuration.

All others nodes need to run radvd as well, but processing RA messages only.
To setup their 6CO fields, when receiving RA messages.

This can be done by a simple configuration with one entry for 6lowpan
interfaces with "AdvSendAdvert off;".

IMPORTANT NOTE:

This requires the patch which is not mainline yet, to set 6CO option fields
as userspace option. Otherwise the kernel will filter it. See [1]. As well,
you need the pending patches on the list for stateful compression, see [2].

- Alex

[0] https://github.com/reubenhwk/radvd/issues/50#issuecomment-183329181
[1] http://www.spinics.net/lists/linux-wpan/msg03364.html
[2] http://www.spinics.net/lists/linux-wpan/msg03453.html

Alexander Aring (2):
  device-linux: replace ARPHRD_IEEE802154 to ARPHRD_6LOWPAN
  radvd: rework 6CO handling

 defaults.h      |   3 ++
 device-bsd44.c  |  24 ++++++++++
 device-linux.c  |  43 +++++++++++++++--
 gram.y          |  72 ++++++++++++++++++++++------
 pathnames.h     |   4 ++
 privsep-linux.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 process.c       |  44 ++++++++++++++++++
 radvd.h         |  18 ++++++-
 scanner.l       |   2 +-
 send.c          |  32 ++++++++-----
 10 files changed, 352 insertions(+), 32 deletions(-)

-- 
2.7.1

