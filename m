Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49924 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaJBI5K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 04:57:10 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH linux-wpan 0/3] Fix handling of skbs of type PACKET_OTHERHOST
Date: Thu,  2 Oct 2014 09:56:43 +0100
Message-Id: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: varkabhadram@gmail.com, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Simon Vincent <simon.vincent@xsilon.com>

This series of patches fix the cases where the pkt_type is overriden 
resulting in skbs of type PACKET_OTHERHOST getting set to PACKET_HOST.
Also it drops packets of PACKET_OTHERHOST type in the 6lowpan layer
as there is not point processing them as they are dropped at the next
layer.

Simon Vincent (3):
  6lowpan: Ensure pkt_type is not lost
  ieee802154: 6lowpan: Ensure pkt_type is not lost
  ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan

 net/6lowpan/iphc.c            | 1 -
 net/ieee802154/6lowpan_rtnl.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.9.1

