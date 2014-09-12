Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:34508 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbaILJe7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Sep 2014 05:34:59 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v2 bluetooth] Fix lowpan_rcv
Date: Fri, 12 Sep 2014 10:34:39 +0100
Message-Id: <1410514480-9070-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1410514480-9070-1-git-send-email-martin.townsend@xsilon.com>
References: <1410514480-9070-1-git-send-email-martin.townsend@xsilon.com>
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

v1 -> v2:
* combined first two patches into one.
* split out renaming of process_data into a new patch
* re-use err in lowpan_process_data and remove err_ret local variable.
* removed third patch as applies to linux-wpan


*** BLURB HERE ***

Martin Townsend (1):
  6lowpan: fix incorrect return values in lowpan_rcv

 include/net/6lowpan.h         |  4 +--
 net/6lowpan/iphc.c            | 73 ++++++++++++++++++-------------------------
 net/bluetooth/6lowpan.c       | 26 +++++++++------
 net/ieee802154/6lowpan_rtnl.c | 44 +++++++++++++++-----------
 4 files changed, 75 insertions(+), 72 deletions(-)

-- 
1.9.1

