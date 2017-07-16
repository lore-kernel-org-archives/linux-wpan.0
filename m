Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35312 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdGPJIO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Jul 2017 05:08:14 -0400
Received: by mail-wm0-f41.google.com with SMTP id w126so52399959wme.0
        for <linux-wpan@vger.kernel.org>; Sun, 16 Jul 2017 02:08:13 -0700 (PDT)
Date: Sun, 16 Jul 2017 11:08:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: handling multiple MAC instances (multiple address filters)
Message-ID: <20170716090806.oy6a6aoibtrsovas@omega>
References: <20170712171051.z35bk6piiqtqypwm@omega>
 <8887.1499889601@dooku.sandelman.ca>
 <20170713144157.uz6euwxbkkn3zqf4@omega>
 <28086.1500027712@dooku.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28086.1500027712@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

On Fri, Jul 14, 2017 at 12:21:52PM +0200, Michael Richardson wrote:
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > So this is for me "we can only have a non-changing _source_ PAN". But
>     > you could run more than one 802.15.4 MAC instances on one 802.15.4 PHY.
>     > Which allows to run multiple wpan interfaces with different source PANs.
> 
> I'm not parsing the difference.
> 

ok.

>     > In short: You cannot handle multiple pan support on the same interface,
>     > you need create other interfaces to run on other pans then. Is that what
>     > you are looking for? I know unstrung need to have support to deal with
>     > multiple interfaces then...
> 
> What does "same interface" mean here?
> Differrent hardware is needed, or just different lowpanX interfaces?
> 

just different lowpanX interfaces.

      ____PHY0____
      |   ...   |
    wpan0 ... wpanX   <---- can have different source pan settings,
      |         |           destination can also be different over
      |         |           af802154 socket communication.
      |         |           (it's for setting the source pan)
      |   ,,,   |
  lowpan0 ... lowpanX <---- can have different destination pan as
                            ``default destination pan''. _Maybe_ you
			    could change overwrite default destination
			    pan by CMSG attribute.
			    At least we need CMSG attribute I think,
			    because 0xffff pan which is broadcast pan.
			    We should only allow "unicast" pans in
			    lowpanX generation as destination.
			    (it's for setting the destination pan)
			    You could insert some routes to route over
			    different pans via internal lowpanX
			    interfaces, if you want that.

What doesn't work and what I don't want to plan is one wpan interfaces
and different lowpan interfaces on top of it, which operates on different
source pans (on lowpan interface layer). The reason is that IEEE 802.15.4
can have only one source PAN for one MAC instance (which is part of wpan
interface and not lowpan).

If somebody has another idea to deal with different pan settings I would
like to hear that, then I can think about it.

- Alex
