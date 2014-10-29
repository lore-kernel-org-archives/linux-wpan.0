Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61239 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaJ2HXi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 03:23:38 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so1973905lbi.3
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 00:23:37 -0700 (PDT)
Date: Wed, 29 Oct 2014 08:23:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 07/17] mac802154: remove might_sleep from
 driver layer
Message-ID: <20141029072333.GF4709@omega>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
 <1414516892-4107-8-git-send-email-alex.aring@gmail.com>
 <5450601D.8040608@gmail.com>
 <20141029055303.GC4709@omega>
 <545081E1.8000508@gmail.com>
 <20141029061306.GE4709@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141029061306.GE4709@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Varka,

it's too early in the morning, apologize my english here.

On Wed, Oct 29, 2014 at 07:13:06AM +0100, Alexander Aring wrote:
> Hi Varka,
> 
> On Wed, Oct 29, 2014 at 11:27:53AM +0530, Varka Bhadram wrote:
> > On 10/29/2014 11:23 AM, Alexander Aring wrote:
> > >Hi Varka,
> > >
> > >On Wed, Oct 29, 2014 at 09:03:49AM +0530, Varka Bhadram wrote:
> > >>On 10/28/2014 10:51 PM, Alexander Aring wrote:
> > >>>This patch removes all might_sleep calls from driver layer. This
> > >>>handling is already done by mac802154 layer.
> > >>>
> > >>>Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > >>>---
> > >>>  drivers/net/ieee802154/at86rf230.c | 3 ---
> > >>>  drivers/net/ieee802154/cc2520.c    | 1 -
> > >>>  drivers/net/ieee802154/fakelb.c    | 4 ----
> > >>>  3 files changed, 8 deletions(-)
> > >>>
> > >>For CC2520 driver
> > >>
> > >I would Cc you here if you stand in the MAINTAINERS file for cc2520
> > >driver. I asked you some months ago if you like to be there. I didn't
> > >saw any patches for that. I thought it's out of interest by you that you
> > >want to be maintainer for this driver.  When these changes are very trivial
> > >like this one, it's okay for you when Marcel simple apply these patches
> > >without any ack? I already told him that we don't need to wait of Alan's
> > >ack for the mrf24j40 driver.
> > >
> > >Nevertheless if you want to add really a Acked here and we need to wait
> > >then please insert you in the MAINTAINERS file. When I run
> > >get_maintainers it's currently me who is maintainer for the cc2520 driver.
> > >
> > >If you want to take care of this driver, please see my improvements and
> > >fixes for the at86rf230. I am sure you could also take some code for the
> > >cc2520 from it. Also I would be very happy for async xmit handling or
> > >regmap support. Most of the cc2520 code is lowlevel spi api calls.
> > >
> > >- Alex
> > 
> > I think i clarified you that i want to be the CC2520 driver maintainer.
> > 
> > I asked you to submit the patche for MAINTAINER file, you told that its
> > not required.
> > 
> 
> I looked up the conversion:
> 

s/conversion/conversation/

> You:
> 
> "You mean to say that i need to add an entry in MAINTAINER file or ..?"
> 
> Me:
> 
> "not need, only if you like. I have no idea about the cc2520 driver."
> 
> need != required. For me this sentence is more... you really don't need
> that do be maintainer of this if you don't like that. But if you like to

s/do/to


well, I think I cherry-pick some commits now to generate the next
series.

- Alex
