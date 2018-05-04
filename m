Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35086 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEDUKG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 May 2018 16:10:06 -0400
Date: Fri, 4 May 2018 22:09:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/2] net: mac808211: mac802154: use
 lockdep_assert_in_softirq() instead own warning
Message-ID: <20180504200953.GW12217@hirez.programming.kicks-ass.net>
References: <20180504175144.12179-1-bigeasy@linutronix.de>
 <20180504175144.12179-3-bigeasy@linutronix.de>
 <20180504183249.GU12217@hirez.programming.kicks-ass.net>
 <20180504184538.gavk7e2vtm73e32w@linutronix.de>
 <20180504185132.GV12217@hirez.programming.kicks-ass.net>
 <20180504190735.izmzibhb66gjb5wr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504190735.izmzibhb66gjb5wr@linutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes@sipsolutions.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>

On Fri, May 04, 2018 at 09:07:35PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-04 20:51:32 [+0200], Peter Zijlstra wrote:

> > softirqs disabled, ack that is exactly what it checks.
> > 
> > But afaict the assertion you introduced tests that we are _in_ softirq
> > context, which is not the same.
> 
> indeed, now it clicked. Given what I wrote in the cover letter would you
> be in favour of (a proper) lockdep_assert_BH_disabled() or the cheaper
> local_bh_enable() (assuming the network folks don't mind the cheaper
> version)?

Depends a bit on what the code wants I suppose. If the code is in fact
fine with the stronger in-softirq assertion, that'd be best. Otherwise I
don't object to a lockdep_assert_bh_disabled() to accompany the
lockdep_assert_irq_disabled() we already have either.
