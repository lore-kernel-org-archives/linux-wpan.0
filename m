Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:54650 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbaJ2FxK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 01:53:10 -0400
Received: by mail-lb0-f181.google.com with SMTP id w7so1834952lbi.26
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 22:53:08 -0700 (PDT)
Date: Wed, 29 Oct 2014 06:53:06 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 07/17] mac802154: remove might_sleep from
 driver layer
Message-ID: <20141029055303.GC4709@omega>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
 <1414516892-4107-8-git-send-email-alex.aring@gmail.com>
 <5450601D.8040608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5450601D.8040608@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Varka,

On Wed, Oct 29, 2014 at 09:03:49AM +0530, Varka Bhadram wrote:
> On 10/28/2014 10:51 PM, Alexander Aring wrote:
> >This patch removes all might_sleep calls from driver layer. This
> >handling is already done by mac802154 layer.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/at86rf230.c | 3 ---
> >  drivers/net/ieee802154/cc2520.c    | 1 -
> >  drivers/net/ieee802154/fakelb.c    | 4 ----
> >  3 files changed, 8 deletions(-)
> >
> For CC2520 driver
> 

I would Cc you here if you stand in the MAINTAINERS file for cc2520
driver. I asked you some months ago if you like to be there. I didn't
saw any patches for that. I thought it's out of interest by you that you
want to be maintainer for this driver.  When these changes are very trivial
like this one, it's okay for you when Marcel simple apply these patches
without any ack? I already told him that we don't need to wait of Alan's
ack for the mrf24j40 driver.

Nevertheless if you want to add really a Acked here and we need to wait
then please insert you in the MAINTAINERS file. When I run
get_maintainers it's currently me who is maintainer for the cc2520 driver.

If you want to take care of this driver, please see my improvements and
fixes for the at86rf230. I am sure you could also take some code for the
cc2520 from it. Also I would be very happy for async xmit handling or
regmap support. Most of the cc2520 code is lowlevel spi api calls.

- Alex
