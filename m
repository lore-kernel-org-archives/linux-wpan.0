Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34030 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaJIHqm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Oct 2014 03:46:42 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC decompression.
Date: Thu,  9 Oct 2014 08:46:33 +0100
Message-Id: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com>
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

Bluetooth and 802.15.4 have been changed to ensure that the skb isn't shared
before calling the decompression routine as this is a requirement of
pskb_expand_head.

v1 -> v2
Use const int for new headroom size.
Remove blank line.
Use skb_unshare instead of skb_copy_expand. 
Use consume_skb.

v2 -> v3 
Remove cases where we are trying to free a NULL skb.

v3 -> v4
Now uses skb_share_check to ensure the skb isn't shared before decompressing

v4 -> v5
Remove skb_share_check from 802.15.4 lowpan_rcv as it's already done at the
top of the function.

Martin Townsend (1):
  6lowpan: Use pskb_expand_head in IPHC decompression.

 net/6lowpan/iphc.c      | 51 ++++++++++++++++++++++++-------------------------
 net/bluetooth/6lowpan.c |  7 +++++++
 2 files changed, 32 insertions(+), 26 deletions(-)

-- 
1.9.1

