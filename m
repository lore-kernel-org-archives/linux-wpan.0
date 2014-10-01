Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:53480 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaJAMKc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 08:10:32 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v4 bluetooth] Fix lowpan_rcv
Date: Wed,  1 Oct 2014 13:10:21 +0100
Message-Id: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

This series aims to fix incorrect return values in lowpan_rcv
To achieve this it also refactors the receive path to
  1) free skb only from lowpan_rcv and not functions that it calls
  2) move skb delivery from IPHC

I have only compile tested the changes for bluetooth as I don't have any HW
available so would be grateful for any testing from the Bluetooth developers.
I have done some minimal testing for IEEE802.15.4

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---

v1 -> v2:
* combined first two patches into one.
* split out renaming of process_data into a new patch
* re-use err in lowpan_process_data and remove err_ret local variable.
* removed third patch as applies to linux-wpan

v2 -> v3: (Updated from Alexander Aring's Review) 
* re-use err hadn't been included in patch.
* fixed some 'goto drop' cases in lowpan_rcv that should be 'goto drop skb'
* handle error codes when returning from lowpan_frag_rcv.
* Refactored lowpan_give_skb_to_devices so it consumes or free's skb and then
  only returns NET_RX status codes.

v3 -> v4: (Updated from Jukka Rissanen and Alexander Aring's Reviews)
* Removed use of double skb pointer in decompress routines in favour of using
  pskb_expand_head to obtain more headroom.  Requires an uncloned skb so the
  calling functions now ensure this.
* prefer consume_skb on non error conditions.
* removed spurious setting of ret in lowpan_rcv

Martin Townsend (1):
  6lowpan: fix incorrect return values in lowpan_rcv

 include/net/6lowpan.h         |  9 +++--
 net/6lowpan/iphc.c            | 92 ++++++++++++++++---------------------------
 net/bluetooth/6lowpan.c       | 52 ++++++++++++++++--------
 net/ieee802154/6lowpan_rtnl.c | 66 ++++++++++++++++++++-----------
 4 files changed, 117 insertions(+), 102 deletions(-)

-- 
1.9.1

