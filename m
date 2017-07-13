Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35396 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdGMOmD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Jul 2017 10:42:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id w126so25754837wme.0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Jul 2017 07:42:02 -0700 (PDT)
Date: Thu, 13 Jul 2017 16:41:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: handling multiple MAC instances (multiple address filters)
Message-ID: <20170713144157.uz6euwxbkkn3zqf4@omega>
References: <20170712171051.z35bk6piiqtqypwm@omega>
 <8887.1499889601@dooku.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8887.1499889601@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

On Wed, Jul 12, 2017 at 04:00:01PM -0400, Michael Richardson wrote:
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > Then the discussed stopped after I took a shower and realized we lost
>     > ack handling when going into promiscuous mode... The transceiver will
>     > simple ack every frame which it's received then if we don't stop ack
>     > handling.
> 
> The issue is that with the filters off, we will ack packets aimed at other
> nodes.
> 

ok.

>     > Now, after I looked because RX_SAFE_MODE into af86rf2xx datasheets
>     > again. I think we could try to do the following:
> 
> So don't get too hung up on the limitations of the af86.  It could be that
> it is impossible with that device, but that another device will make it
> possible.
> 

We need to talk about this point, see below.

>     >  - RX done irq comes - Grab buffer information - Doing fast a source
>     > address lookup and check if we have a mac interface currently running
>     > which has the address and ack is requested.  - If so trigger pin to
>     > send ack.  - If not do nothing and drop (because we are not meant)
> 
> This sounds very cool.
> 

ok.

>     > Another question is: Is running multiple interfaces on one PHY the
>     > thing what we "need". I think yes, because the 802.15.4 spec describe
>     > only one source PAN to operate on. Another idea would be to override
> 
> I'd really like to be able to operate on multiple PANs at the same time.
> I think that 6LBRs will need this.
> 

The 802.15.4 SPEC defines "macPANId" where stands:

"The 16-bit identifier of the PAN on which the device is operating. If this value
 is 0xffff, the device is not associated."

So this is for me "we can only have a non-changing _source_ PAN". But
you could run more than one 802.15.4 MAC instances on one 802.15.4 PHY.
Which allows to run multiple wpan interfaces with different source PANs.

Now according to 6LoWPAN interface generation you can specify on which
destination pan you want to operate, or even per sendmsg(2). If not
specified it will use intra-pan communication destination pan == source
pan.

In short: You cannot handle multiple pan support on the same interface,
you need create other interfaces to run on other pans then. Is that what
you are looking for? I know unstrung need to have support to deal with
multiple interfaces then...

- Alex
