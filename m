Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDSdE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 14:33:04 -0400
Date: Fri, 4 May 2018 20:32:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/2] net: mac808211: mac802154: use
 lockdep_assert_in_softirq() instead own warning
Message-ID: <20180504183249.GU12217@hirez.programming.kicks-ass.net>
References: <20180504175144.12179-1-bigeasy@linutronix.de>
 <20180504175144.12179-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504175144.12179-3-bigeasy@linutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>

On Fri, May 04, 2018 at 07:51:44PM +0200, Sebastian Andrzej Siewior wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> The warning in ieee802154_rx() and ieee80211_rx_napi() is there to ensure
> the softirq context for the subsequent netif_receive_skb() call. 

That's not in fact what it does though; so while that might indeed be
the intent that's not what it does.
