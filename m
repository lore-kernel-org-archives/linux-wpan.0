Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:50180 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBXK25 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 05:28:57 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so24262385wiw.3
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 02:28:56 -0800 (PST)
Date: Tue, 24 Feb 2015 11:28:48 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/2] at86rf230: add support for external
 xtal trim
Message-ID: <20150224102832.GA748@omega>
References: <1424772665-25857-1-git-send-email-alex.aring@gmail.com>
 <1424772665-25857-3-git-send-email-alex.aring@gmail.com>
 <54EC50B7.4040105@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54EC50B7.4040105@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Marc,

On Tue, Feb 24, 2015 at 11:21:43AM +0100, Marc Kleine-Budde wrote:
> On 02/24/2015 11:11 AM, Alexander Aring wrote:
> > This patch adds support for setting the xtal trim register. Some at86rf2xx
> > transceiver boards needs fine tuning the xtal capacitor.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  .../devicetree/bindings/net/ieee802154/at86rf230.txt         |  3 +++
> >  drivers/net/ieee802154/at86rf230.c                           | 12 ++++++++++++
> >  include/linux/spi/at86rf230.h                                |  1 +
> >  3 files changed, 16 insertions(+)
> > 
...
> > @@ -1390,6 +1397,10 @@ static int at86rf230_get_pdata(struct spi_device *spi,
> >  
> >  	cfg->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
> >  	cfg->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
> > +	ret = of_property_read_u8(spi->dev.of_node, "xtal-trim",
> > +				  &cfg->xtal_trim);
> > +	if (ret < 0 && ret != -EINVAL)
> > +		return ret;
> >  
> >  	return 0;
> >  }
> > @@ -1545,6 +1556,7 @@ static int at86rf230_probe(struct spi_device *spi)
> >  	lp = hw->priv;
> >  	lp->hw = hw;
> >  	lp->spi = spi;
> > +	lp->cfg = cfg;
> 
> This doesn't look correct.

You mean the line:

"lp->cfg = cfg;" or everything?

I copy there the "temporary on stack" allocated platform data to
at86rf230_local cfg, which is the platform data allocated on the heap in
the at86rf230_local struct.

The "temporary on stack" platform data is to not use the "real
platform_data" for requesting several pins. Afterwards I copy the
platform_data from stack to the at86rf230_local. I can't do this
directly because we allocate space for at86rf230_local after requesting
pins and do reset, etc..

- Alex
