Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42533 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBWPNg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 10:13:36 -0500
Received: by mail-wi0-f182.google.com with SMTP id l15so17857705wiw.3
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 07:13:35 -0800 (PST)
Date: Mon, 23 Feb 2015 16:13:32 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] at86rf230: add support for setting
 external xtal
Message-ID: <20150223151329.GC704@omega>
References: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>
 <54EB4302.9090006@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54EB4302.9090006@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Mon, Feb 23, 2015 at 04:10:58PM +0100, Marc Kleine-Budde wrote:
> On 02/23/2015 04:05 PM, Alexander Aring wrote:
> > This patch adds support for setting external xtal. This is recommended
> > by the at86rf230 transceivers to reduce power consuming and for a better
> > clock source.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  .../bindings/net/ieee802154/at86rf230.txt          |  6 ++++++
> >  drivers/net/ieee802154/at86rf230.c                 | 25 ++++++++++++++++++++--
> >  include/linux/spi/at86rf230.h                      |  2 ++
> >  3 files changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> > index d3bbdded..4d47c2e 100644
> > --- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> > +++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> > @@ -11,6 +11,10 @@ Required properties:
> >  Optional properties:
> >    - reset-gpio:		GPIO spec for the rstn pin
> >    - sleep-gpio:		GPIO spec for the slp_tr pin
> > +  - external-xtal:	boolean to use external xtal if present
> > +  - xtal-trim:		u8 value to fine tuning the internal capacitance
> > +			arrays of xtal pins. This value should not above 0x0F
> > +			and only present when external-xtal is enabled
> >  
> >  Example:
> >  
> > @@ -20,4 +24,6 @@ Example:
> >  		reg = <0>;
> >  		interrupts = <19 1>;
> >  		interrupt-parent = <&gpio3>;
> > +		external-xtal;
> > +		xtal-trim = /bits/ 8 <0x06>;
> >  	};
> > diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> > index cbfc8c5..1a95520 100644
> > --- a/drivers/net/ieee802154/at86rf230.c
> > +++ b/drivers/net/ieee802154/at86rf230.c
> > @@ -1315,7 +1315,8 @@ static struct at86rf2xx_chip_data at86rf212_data = {
> >  	.get_desense_steps = at86rf212_get_desens_steps
> >  };
> >  
> > -static int at86rf230_hw_init(struct at86rf230_local *lp)
> > +static int at86rf230_hw_init(struct at86rf230_local *lp,
> > +			     const struct at86rf230_platform_data *pdata)
> >  {
> >  	int rc, irq_type, irq_pol = IRQ_ACTIVE_HIGH;
> >  	unsigned int dvdd;
> > @@ -1362,6 +1363,16 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
> >  	usleep_range(lp->data->t_sleep_cycle,
> >  		     lp->data->t_sleep_cycle + 100);
> >  
> > +	if (pdata->xtal) {
> > +		rc = at86rf230_write_subreg(lp, SR_XTAL_TRIM, pdata->xtal_trim);
> > +		if (rc)
> > +			return rc;
> > +
> > +		rc = at86rf230_write_subreg(lp, SR_XTAL_MODE, 0x5);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> >  	rc = at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
> >  	if (rc)
> >  		return rc;
> > @@ -1392,6 +1403,16 @@ at86rf230_get_pdata(struct spi_device *spi)
> >  	pdata->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
> >  	pdata->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
> >  
> > +	pdata->xtal = of_property_read_bool(spi->dev.of_node, "external-xtal");
> 
> The platform data should be considered read only by the driver. Better
> put the information into your per-driver private data struct.
> 

ah, yes you are completely right here. Sorry :)

- Alex
