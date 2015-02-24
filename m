Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:34520 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbBXKsB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 05:48:01 -0500
Received: by wesq59 with SMTP id q59so24395597wes.1
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 02:48:00 -0800 (PST)
Date: Tue, 24 Feb 2015 11:47:57 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/2] at86rf230: add support for external
 xtal trim
Message-ID: <20150224104757.GC748@omega>
References: <1424772665-25857-1-git-send-email-alex.aring@gmail.com>
 <1424772665-25857-3-git-send-email-alex.aring@gmail.com>
 <54EC50B7.4040105@pengutronix.de>
 <20150224102832.GA748@omega>
 <54EC53A9.8070004@pengutronix.de>
 <20150224104236.GB748@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150224104236.GB748@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Feb 24, 2015 at 11:42:36AM +0100, Alexander Aring wrote:
> On Tue, Feb 24, 2015 at 11:34:17AM +0100, Marc Kleine-Budde wrote:
> > On 02/24/2015 11:28 AM, Alexander Aring wrote:
> > > Hi Marc,
> > > 
> > > On Tue, Feb 24, 2015 at 11:21:43AM +0100, Marc Kleine-Budde wrote:
> > >> On 02/24/2015 11:11 AM, Alexander Aring wrote:
> > >>> This patch adds support for setting the xtal trim register. Some at86rf2xx
> > >>> transceiver boards needs fine tuning the xtal capacitor.
> > >>>
> > >>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > >>> ---
> > >>>  .../devicetree/bindings/net/ieee802154/at86rf230.txt         |  3 +++
> > >>>  drivers/net/ieee802154/at86rf230.c                           | 12 ++++++++++++
> > >>>  include/linux/spi/at86rf230.h                                |  1 +
> > >>>  3 files changed, 16 insertions(+)
> > >>>
> > > ...
> > >>> @@ -1390,6 +1397,10 @@ static int at86rf230_get_pdata(struct spi_device *spi,
> > >>>  
> > >>>  	cfg->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
> > >>>  	cfg->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
> > >>> +	ret = of_property_read_u8(spi->dev.of_node, "xtal-trim",
> > >>> +				  &cfg->xtal_trim);
> > >>> +	if (ret < 0 && ret != -EINVAL)
> > >>> +		return ret;
> > >>>  
> > >>>  	return 0;
> > >>>  }
> > >>> @@ -1545,6 +1556,7 @@ static int at86rf230_probe(struct spi_device *spi)
> > >>>  	lp = hw->priv;
> > >>>  	lp->hw = hw;
> > >>>  	lp->spi = spi;
> > >>> +	lp->cfg = cfg;
> > >>
> > >> This doesn't look correct.
> > > 
> > > You mean the line:
> > > 
> > > "lp->cfg = cfg;" or everything?
> > 
> > Just that line, it's in the wrong patch.
> > 
> 
> yes, but in the other patch it makes no sense. I only use the platform
> data in probe function and can't access the platform data over lp->cfg
> there, because lp isn't allocated. So I can add it in patch 1/2 but then
> I will never access the lp->cfg then.
> 
> devm_request_gpio thing will remember which gpio was requested. I never
> read the platform_data again.
> 
> 
> Now in this patch (2/2) I will access the platform data in hw_init and the lp
> is allocated already in this function and can access xtal_trim over
> lp->cfg->xtal_trim.
> 
> We don't really need after probe the platform data again. Further when
> we will add support for the slp_tr pin we need that. This pin is used
> after probing. This means copying platform data in at86rf230_local is a
> good thing to prepare for future.
> 
> Nevertheless I will move it to 1/2.
> 

Okay, I simple move the ieee802154_alloc_hw call a little bit earlier.
Since we have devm_request_... thing the error handling will not more
complex when doing this step.

- Alex
