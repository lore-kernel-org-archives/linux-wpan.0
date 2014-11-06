Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:48706 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKFJls (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 04:41:48 -0500
Received: by mail-lb0-f175.google.com with SMTP id n15so584198lbi.6
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 01:41:46 -0800 (PST)
Date: Thu, 6 Nov 2014 11:05:54 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 15/18] at86rf230: generate random perm
 extended address
Message-ID: <20141106100552.GB1071@x61s.campuswlan.hs-rm.de>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
 <1415217089-24919-16-git-send-email-alex.aring@gmail.com>
 <CAEUmHyb8VNaXVZKPuP-81ywMG_soVduT69sogD1Qa3DqR1SeiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEUmHyb8VNaXVZKPuP-81ywMG_soVduT69sogD1Qa3DqR1SeiQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, kernel@pengutronix.de

On Thu, Nov 06, 2014 at 11:22:45AM +0530, Varka Bhadram wrote:
> On Thursday 06 November 2014 01:21 AM, Alexander Aring wrote:
> > This patch adds support for a random generated perm extended address for
> > the at86rf230 driver.
> >
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >   drivers/net/ieee802154/at86rf230.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> > index bf47785..a6db768 100644
> > --- a/drivers/net/ieee802154/at86rf230.c
> > +++ b/drivers/net/ieee802154/at86rf230.c
> > @@ -1534,6 +1534,7 @@ static int at86rf230_probe(struct spi_device *spi)
> >   lp->spi = spi;
> >   hw->parent = &spi->dev;
> >   hw->vif_data_size = sizeof(*lp);
> > + ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> >
> >   lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
> >   if (IS_ERR(lp->regmap)) {
> 
> You are getting this extended address here and configuring at the time
> of iface add.
> 
> This change should be there for other drivers ( CC2520 & MRF24J40 ) also ..?
> 

yes, but please refer before if these transceivers supports some eeprom
or serial id where the extended addr could be generated from.

Otherwise we need to generate a random one. This value can also get from
device tree or extended addr, but we are far away to support such
behaviour. If somebody wants to implement this, please send patches to
me and device tree ml.

- Alex
