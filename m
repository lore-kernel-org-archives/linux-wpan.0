Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37382 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaKFVL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 16:11:29 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCHv2 bluetooth-next] 6lowpan: move skb_free from error paths in decompression
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415301313-32290-1-git-send-email-mtownsend1973@gmail.com>
Date: Thu, 6 Nov 2014 13:11:23 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <930045C7-036D-41C9-B877-3BB126AB55E5@holtmann.org>
References: <1415301313-32290-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com

Hi Martin,

> Currently we ensure that the skb is freed on every error path in IPHC
> decompression which makes it easy to introduce skb leaks.  By centralising
> the skb_free into the receive function it makes future decompression routines
> easier to maintain.  It does come at the expense of ensuring that the skb
> passed into the decompression routine must not be copied.
> 
> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
> ---
> net/6lowpan/iphc.c            | 31 ++++++++++++-------------------
> net/bluetooth/6lowpan.c       | 15 +++++++--------
> net/ieee802154/6lowpan_rtnl.c | 16 ++++++----------
> 3 files changed, 25 insertions(+), 37 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

