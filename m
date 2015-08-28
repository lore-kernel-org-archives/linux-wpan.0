Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36839 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbH1HvD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Aug 2015 03:51:03 -0400
Received: by wicfv10 with SMTP id fv10so1130829wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2015 00:51:02 -0700 (PDT)
Date: Fri, 28 Aug 2015 09:50:55 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 04/21] mrf24j40: remove spi settings
 overwrite
Message-ID: <20150828075052.GA6297@omega>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-5-git-send-email-alex.aring@gmail.com>
 <55DF0D37.4080508@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55DF0D37.4080508@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hi,

On Thu, Aug 27, 2015 at 03:14:31PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 13/08/15 14:22, Alexander Aring wrote:
> >This patch removes spi settings while mrf24j40 probing. These settings
> >cannot be overwrite while device probing where spi controller should be
> >already configured. These settings need to be setup by device tree or
> >platform data.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/mrf24j40.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> >diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> >index de63cba..d16bef3 100644
> >--- a/drivers/net/ieee802154/mrf24j40.c
> >+++ b/drivers/net/ieee802154/mrf24j40.c
> >@@ -746,10 +746,6 @@ static int mrf24j40_probe(struct spi_device *spi)
> >  	if (!devrec->buf)
> >  		goto err_register_device;
> >-	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
> >-	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
> >-		spi->max_speed_hz = MAX_SPI_SPEED_HZ;
> >-
> >  	mutex_init(&devrec->buffer_mutex);
> >  	init_completion(&devrec->tx_complete);
> 
> So far I only have been setting the SPI speed but never the mode via
> devicetree. Digging for it I found that we can set the various modes easily
> via devicetree.
> Documentation/devicetree/bindings/spi/spi-bus.txt
> 
> - spi-cpol        - (optional) Empty property indicating device requires
>     		inverse clock polarity (CPOL) mode
> - spi-cpha        - (optional) Empty property indicating device requires
>     		shifted clock phase (CPHA) mode
> - spi-cs-high     - (optional) Empty property indicating device requires
>     		chip select active high
> - spi-3wire       - (optional) Empty property indicating device requires
>     		    3-wire mode.
> - spi-lsb-first   - (optional) Empty property indicating device requires
> 		LSB first mode.
> 
> 
> Platform data could always do that anyway so we are good here.
> 

I think, that changing the attribute only, will not change the spi bus
controller. This setup was before any spi device will be probed.

One reason is here because we already access the spi device inside
probing of mrf24j40 -> spi need to be setup correctly. It can't be
changed again in any device probing, or we need to call some other
function that we can tell the spi controller these spi attributes
was changed, if possible.

For the SPI_MODE think, it's mostly SPI_MODE_0 which sets non of these
flags. They call it "original MicroWire".

#define SPI_MODE_0      (0|0)                   /* (original MicroWire) */

What we could do is to make some
"WARN_ON(spi->max_speed_hz > MAX_SPI_SPEED_HZ, "foobar\n");

if the SPI clock is above maximum.

- Alex
