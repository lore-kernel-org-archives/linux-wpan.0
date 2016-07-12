Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35712 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912AbcGLVp7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 Jul 2016 17:45:59 -0400
Subject: Re: [PATCH] net: ieee802154: mrf24j40: avoid uninitialized byte in
 SPI transfer to radio.
References: <20160712032051.F2D441C012F@csi-office.componentsw.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <cf98c898-b58e-4583-38ff-53becfda52e8@pengutronix.de>
Date: Tue, 12 Jul 2016 23:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <20160712032051.F2D441C012F@csi-office.componentsw.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On 07/12/2016 05:02 AM, Walter Mack wrote:
> isr function issues SPI read command to mrf to obtain INTSTAT.
> SPI transfer is 2 bytes, but value of 2nd byte is not defined.
> This had the effect that only the first ISR worked as intended. The
> second ISR read incorrect INTSTAT values. Observed on Raspberry PI B+.
> Signed-off-by: Walter Mack <wmack@componentsw.com>
> ---
>  drivers/net/ieee802154/mrf24j40.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index f446db8..7b131f8 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -1054,6 +1054,8 @@ static irqreturn_t mrf24j40_isr(int irq, void *data)
>  	disable_irq_nosync(irq);
>  
>  	devrec->irq_buf[0] = MRF24J40_READSHORT(REG_INTSTAT);
> +	devrec->irq_buf[1] = 0;
> +

thanks.

I think it would be better to not use global resources for hard irq
here. We should change that code to similar stuff in at86rf230 driver,
see [0].

So each irq as their own resource data. Note you still need to disable
irq stuff because LEVEL triggered irq's and irqline will be cleared
until INSTAT is readed out.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L828
