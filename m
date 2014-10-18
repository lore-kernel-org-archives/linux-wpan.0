Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39169 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaJRHJ1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 18 Oct 2014 03:09:27 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next 0/5] Move skb delivery out of IPHC.
Date: Sat, 18 Oct 2014 08:09:08 +0100
Message-Id: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>

This series moves skb delivery out of IPHC and into the receive routines of
both bluetooth and 802.15.4.  The reason is that we need to support more
(de)compression schemes in the future.  It also means that calling 
lowpan_process_data now only returns error codes or 0 for success so 
this has been cleaned up.  The final patch then renames occurences of
lowpan_process_data and process_data to something more meaningful.

Martin Townsend (5):
  Remove skb_deliver from IPHC.
  Fix process_data return values
  Use consume_skb when packet processed successfully.
  Remove unused skb_delivery_cb typedef.
  Rename process_data and lowpan_process_data.

 include/net/6lowpan.h         | 12 ++++++------
 net/6lowpan/iphc.c            | 42 ++++++++++++------------------------------
 net/bluetooth/6lowpan.c       | 29 ++++++++++++++++++++---------
 net/ieee802154/6lowpan_rtnl.c | 34 +++++++++++++++-------------------
 4 files changed, 53 insertions(+), 64 deletions(-)

-- 
1.9.1

