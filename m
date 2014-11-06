Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:59431 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFT0q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 14:26:46 -0500
Date: Thu, 6 Nov 2014 20:26:42 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression
Message-ID: <20141106192639.GC2321@omega>
References: <1415301313-32290-1-git-send-email-mtownsend1973@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1415301313-32290-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Martin,

On Thu, Nov 06, 2014 at 07:15:13PM +0000, Martin Townsend wrote:
> Currently we ensure that the skb is freed on every error path in IPHC
> decompression which makes it easy to introduce skb leaks.  By centralising
> the skb_free into the receive function it makes future decompression routines
> easier to maintain.  It does come at the expense of ensuring that the skb
> passed into the decompression routine must not be copied.
> 
> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>

so far I understand is that Jukka already acked this patch. So you
could also add Acked-by: Jukka ... before sending this patch.

Nevertheless you will have also an ack from me now:

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
