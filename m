Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62544 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbaKFKek (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Nov 2014 05:34:40 -0500
Message-ID: <1415270051.2918.49.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 06 Nov 2014 12:34:11 +0200
In-Reply-To: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
References: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alex.aring@gmail.com, marcel@holtmann.org

Hi Martin,

On ti, 2014-11-04 at 21:36 +0000, Martin Townsend wrote:
> Currently we ensure that the skb is freed on every error path in IPHC
> decompression which makes it easy to introduce skb leaks.  By centralising
> the skb_free into the receive function it makes future decompression routines
> easier to maintain.  It does come at the expense of ensuring that the skb
> passed into the decompression routine must not be copied.

Tested this with real bluetooth hw and no issues were found. Just rebase
the patch with latest upstream (conflict had a very simple fix) so ack
with actions to v2.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


