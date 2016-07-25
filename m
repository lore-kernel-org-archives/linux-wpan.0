Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcGYNPc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 09:15:32 -0400
Date: Mon, 25 Jul 2016 09:15:30 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: Re: [PATCH 1/3] mac802154: don't warn on unsupported frames
Message-ID: <20160725131530.GE30145@redhat.com>
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
 <78726941-7d65-1ece-e203-f1507597978a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78726941-7d65-1ece-e203-f1507597978a@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi Alexander,
On Sat, Jul 23, 2016 at 02:46:28PM +0200, Alexander Aring wrote:
> agree, but this patch introduce a different stats handling right now. :-)

sorry, should have split both parts in different patches.

> This should be moved into ieee802154_deliver_skb, right before calling
> netif_rx(...);
> 
> The reason is because we have for "stats.rx_bytes" and
> "stats.rx_packets" a very clean definition what it means. It means, the
> frames hit a state where it is ready to put it into the packet-layer,
> this is what netif_rx is doing.
> 
> It's okay for me to add support for rx_frame_errors and also rx_dropped
> stuff. But with a very big warning that the meaning of such stats will
> be touched again later if we found some strategie where we we define
> what each stats attribute means. Also there exists subsystems which
> simple ignore these stats, because at userspace side you need always to
> lookup what the definition means and when we run such stats counters and
> when not and some subsystems don't care about that.

Fair enough, I'll redo the patch just removing the warning.
Thanks!

-- 
Aristeu

