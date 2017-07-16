Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37089 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdGPRJP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Jul 2017 13:09:15 -0400
Received: by mail-wm0-f46.google.com with SMTP id b134so27581145wma.0
        for <linux-wpan@vger.kernel.org>; Sun, 16 Jul 2017 10:09:14 -0700 (PDT)
Date: Sun, 16 Jul 2017 19:09:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: handling multiple MAC instances (multiple address filters)
Message-ID: <20170716170905.dwauxdblssthonsn@omega>
References: <20170712171051.z35bk6piiqtqypwm@omega>
 <8887.1499889601@dooku.sandelman.ca>
 <20170713144157.uz6euwxbkkn3zqf4@omega>
 <28086.1500027712@dooku.sandelman.ca>
 <20170716090806.oy6a6aoibtrsovas@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170716090806.oy6a6aoibtrsovas@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi,

took a shower again and detected issues.

On Sun, Jul 16, 2017 at 11:08:06AM +0200, Alexander Aring wrote:
> On Fri, Jul 14, 2017 at 12:21:52PM +0200, Michael Richardson wrote:
> > 
> > Alexander Aring <alex.aring@gmail.com> wrote:
> >     > So this is for me "we can only have a non-changing _source_ PAN". But
> >     > you could run more than one 802.15.4 MAC instances on one 802.15.4 PHY.
> >     > Which allows to run multiple wpan interfaces with different source PANs.
> > 
> > I'm not parsing the difference.
> > 
> 
> ok.
> 
> >     > In short: You cannot handle multiple pan support on the same interface,
> >     > you need create other interfaces to run on other pans then. Is that what
> >     > you are looking for? I know unstrung need to have support to deal with
> >     > multiple interfaces then...
> > 
> > What does "same interface" mean here?
> > Differrent hardware is needed, or just different lowpanX interfaces?
> > 
> 
> just different lowpanX interfaces.
> 
>       ____PHY0____
>       |   ...   |
>     wpan0 ... wpanX   <---- can have different source pan settings,
>       |         |           destination can also be different over
>       |         |           af802154 socket communication.
>       |         |           (it's for setting the source pan)
>       |   ,,,   |
>   lowpan0 ... lowpanX <---- can have different destination pan as
>                             ``default destination pan''. _Maybe_ you
> 			    could change overwrite default destination
> 			    pan by CMSG attribute.

I think we cannot change the destination pan while interface running, so
handle only one different destination pan per interface and while it's
up.

The reason is simple: There is no address option for the destination pan
per neighbor cache - there is only one for short address and for this
reason we need always need to know on which pan the neighbor operates.
When doing ifdown on ipv6 capable interface - neighbor cache will be
flushed so we can change destination pan then.

Maybe 6lo working group will write something about handle destination
pan right. Don't know - maybe extract the info from received mac header?
But this sounds weird - because we don't do that for short address,
maybe there will be some PAN address option field come for ndisc
handling.

I mean we cannot handle anyway multiple destination pans on one
interface, because we save the short address only per neighbor and it's
not unique without the right pan. I don't see right now that this can
be working. :-/

So forget to change destination pan per CMSG attribute or per runtime
(interface is up).

> 			    At least we need CMSG attribute I think,
> 			    because 0xffff pan which is broadcast pan.
> 			    We should only allow "unicast" pans in
> 			    lowpanX generation as destination.

yea, forget to handle 0xffff ever - I don't know how this can be useful, see
above.

- Alex
