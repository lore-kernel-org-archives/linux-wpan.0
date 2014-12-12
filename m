Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45824 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbaLLO4Z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:56:25 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so9294291wgh.22
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:56:24 -0800 (PST)
Date: Fri, 12 Dec 2014 15:56:20 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 15/18] at86rf230: generate random perm
 extended address
Message-ID: <20141212145619.GE381@omega>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
 <1415217089-24919-16-git-send-email-alex.aring@gmail.com>
 <CAEUmHyb8VNaXVZKPuP-81ywMG_soVduT69sogD1Qa3DqR1SeiQ@mail.gmail.com>
 <20141106100552.GB1071@x61s.campuswlan.hs-rm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141106100552.GB1071@x61s.campuswlan.hs-rm.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, kernel@pengutronix.de

Varka,

On Thu, Nov 06, 2014 at 11:05:52AM +0100, Alexander Aring wrote:
> On Thu, Nov 06, 2014 at 11:22:45AM +0530, Varka Bhadram wrote:
> > On Thursday 06 November 2014 01:21 AM, Alexander Aring wrote:
> > > This patch adds support for a random generated perm extended address for
> > > the at86rf230 driver.
> > >
> > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > ---
> > >   drivers/net/ieee802154/at86rf230.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> > > index bf47785..a6db768 100644
> > > --- a/drivers/net/ieee802154/at86rf230.c
> > > +++ b/drivers/net/ieee802154/at86rf230.c
> > > @@ -1534,6 +1534,7 @@ static int at86rf230_probe(struct spi_device *spi)
> > >   lp->spi = spi;
> > >   hw->parent = &spi->dev;
> > >   hw->vif_data_size = sizeof(*lp);
> > > + ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
> > >
> > >   lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
> > >   if (IS_ERR(lp->regmap)) {
> > 
> > You are getting this extended address here and configuring at the time
> > of iface add.
> > 
> > This change should be there for other drivers ( CC2520 & MRF24J40 ) also ..?
> > 
> 
> yes, but please refer before if these transceivers supports some eeprom
> or serial id where the extended addr could be generated from.
> 
> Otherwise we need to generate a random one. This value can also get from
> device tree or extended addr, but we are far away to support such
> behaviour. If somebody wants to implement this, please send patches to
> me and device tree ml.
> 

what's about this, to having a zero address perm_extended_addr address
is defintly a bug in your driver.

My respone here was more a (this is not really c, but mention what I
meant here):

switch (CC2520_supports)
case EEPROM_FOR_EUI64:
	perm_extended_addr = readout_eeprom;
	break;
case SERIAL_ID_REGISTERS_FOR_EUI64:
	perm_extended_addr = readout_registers;
	break;
default:
	perm_extended_addr = generate_random_one;
}

So if you don't have case 1 and 2, then generate a random one.

Also please check for reset values for phy settings like
current_channel, current_page...

Maybe wait some time when cca handling patches are in then you can
changes also the cca mode to the default value after reset.

- Alex
