Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDSpv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 14:45:51 -0400
Date: Fri, 4 May 2018 20:45:39 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 2/2] net: mac808211: mac802154: use
 lockdep_assert_in_softirq() instead own warning
Message-ID: <20180504184538.gavk7e2vtm73e32w@linutronix.de>
References: <20180504175144.12179-1-bigeasy@linutronix.de>
 <20180504175144.12179-3-bigeasy@linutronix.de>
 <20180504183249.GU12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504183249.GU12217@hirez.programming.kicks-ass.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>

On 2018-05-04 20:32:49 [+0200], Peter Zijlstra wrote:
> On Fri, May 04, 2018 at 07:51:44PM +0200, Sebastian Andrzej Siewior wrote:
> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > 
> > The warning in ieee802154_rx() and ieee80211_rx_napi() is there to ensure
> > the softirq context for the subsequent netif_receive_skb() call. 
> 
> That's not in fact what it does though; so while that might indeed be
> the intent that's not what it does.

It was introduced in commit d20ef63d3246 ("mac80211: document
ieee80211_rx() context requirement"):

    mac80211: document ieee80211_rx() context requirement
    
    ieee80211_rx() must be called with softirqs disabled
    since the networking stack requires this for netif_rx()
    and some code in mac80211 can assume that it can not
    be processing its own tasklet and this call at the same
    time.
    
    It may be possible to remove this requirement after a
    careful audit of mac80211 and doing any needed locking
    improvements in it along with disabling softirqs around
    netif_rx(). An alternative might be to push all packet
    processing to process context in mac80211, instead of
    to the tasklet, and add other synchronisation.

Sebastian
