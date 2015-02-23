Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:40726 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbBWPlO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 10:41:14 -0500
Received: by wesx3 with SMTP id x3so19243217wes.7
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 07:41:12 -0800 (PST)
Date: Mon, 23 Feb 2015 16:41:05 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] at86rf230: add support for setting
 external xtal
Message-ID: <20150223154104.GA15550@omega>
References: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>
 <54EB4302.9090006@pengutronix.de>
 <20150223151329.GC704@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150223151329.GC704@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Marc,

On Mon, Feb 23, 2015 at 04:13:29PM +0100, Alexander Aring wrote:
> On Mon, Feb 23, 2015 at 04:10:58PM +0100, Marc Kleine-Budde wrote:
> > On 02/23/2015 04:05 PM, Alexander Aring wrote:
> > > This patch adds support for setting external xtal. This is recommended
...
> > >  	rc = at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
> > >  	if (rc)
> > >  		return rc;
> > > @@ -1392,6 +1403,16 @@ at86rf230_get_pdata(struct spi_device *spi)
> > >  	pdata->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
> > >  	pdata->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
> > >  
> > > +	pdata->xtal = of_property_read_bool(spi->dev.of_node, "external-xtal");
> > 
> > The platform data should be considered read only by the driver. Better
> > put the information into your per-driver private data struct.
> > 
> 
> ah, yes you are completely right here. Sorry :)
> 

I am not sure if this is okay here in that case. For non devicetree this
code will never touched and I grab this code from some i2c driver like
[0].

They also use the platform-data for setting the devicetree properties.

The only thing which I can see now is the check if (xtal > 0xF) which is
not available on non devicetree settings... but I can also remove this
check, somebody should make something complete wrong if this value is
above 0xF and regmap should mask this value.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/media/i2c/adv7343.c#L404
