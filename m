Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:55893 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJ0O6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 10:58:11 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v5 bluetooth-next 0/4] 6lowpan: Move skb delivery out of IPHC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
Date: Mon, 27 Oct 2014 07:58:03 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <9557671F-92C7-4A29-940B-5D6FDE64A4A2@holtmann.org>
References: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

> This series moves skb delivery out of IPHC and into the receive routines of
> both bluetooth and 802.15.4.  The reason is that we need to support more
> (de)compression schemes in the future.  It also means that calling 
> lowpan_process_data now only returns error codes or 0 for success so 
> this has been cleaned up.  The final patch then renames occurences of
> lowpan_process_data and process_data to something more meaningful.
> 
> v1 -> v2
> 
> * Handle freeing of skb in lowpan_give_skb_to_devices for 802.15.14
> * Added another skb_consume in bluetooth code for uncompressed IPv6 headers
> * Added missing skb_consume for local_skb for bluetooth in compreesed IPv6 header
>  path
> * Combine patch 4 into 1.
> 
> v2 -> v3
> 
> * Ensure error codes aren't returned in the bluetooth skb delivery function.
> * In lowpan_give_skb_to_devices return NET_RX_DROP when the first call to
>  netif_rx fails.
> 
> v3 -> v4
> 
> * Fixed incorrect frag return handling due to refactoring skb_deliver.
> 
> v4 -> v5
> 
> * Removed unnecessary break statements in lowpan_rcv
> 
> Martin Townsend (4):
>  6lowpan: remove skb_deliver from IPHC
>  6lowpan: fix process_data return values
>  bluetooth:6lowpan: use consume_skb when packet processed successfully
>  ieee802154: 6lowpan: rename process_data and lowpan_process_data
> 
> include/net/6lowpan.h         | 12 ++++-----
> net/6lowpan/iphc.c            | 42 +++++++++---------------------
> net/bluetooth/6lowpan.c       | 36 +++++++++++++++++---------
> net/ieee802154/6lowpan_rtnl.c | 60 ++++++++++++++++++++++++++-----------------
> 4 files changed, 78 insertions(+), 72 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

