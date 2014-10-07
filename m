Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61580 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbaJGTwi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 15:52:38 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v2 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC decompression.
Date: Tue,  7 Oct 2014 20:52:28 +0100
Message-Id: <1412711549-24653-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

This patch aims to reduce the amount of copying in the receive path when
decompressing by checking for headroom and calling pskb_expand_head if required.
Another benefit of this is that the skb pointer passed to the decompression
routine will be the same skb after decompression.  This will be a step towards
freeing the skb within the receive function and not within all the error paths
of the decompression routine.

Bluetooth and 802.15.4 have been changed to ensure that only one reference
to the skb exists before calling the decompression routine as this is a
requirement of pskb_expand_head.

v1 -> v2
Use const int for new headroom size.
Remove blank line.
Use skb_unshare instead of skb_copy_expand. 

Martin Townsend (1):
  6lowpan: Use pskb_expand_head in IPHC decompression.

 net/6lowpan/iphc.c            | 53 ++++++++++++++++++++++---------------------
 net/bluetooth/6lowpan.c       | 19 ++++++++++++----
 net/ieee802154/6lowpan_rtnl.c | 13 +++++++++++
 3 files changed, 55 insertions(+), 30 deletions(-)

-- 
1.9.1

