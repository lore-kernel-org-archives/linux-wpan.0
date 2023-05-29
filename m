Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5553C77B7E
	for <linux-wpan@archiver.kernel.org>; Mon, 29 May 2023 08:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjE2IMV (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 29 May 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjE2IMU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 29 May 2023 04:12:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A890;
        Mon, 29 May 2023 01:12:16 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685347935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDcQFJJFfV1Siup4q6p4OZgQniQ046aFw0ogwoYkvUs=;
        b=IJcLwSpdqY/S84uOjPw4mCXhRQWiUo2wiEp6u12X0zgjXdUfl6QFEMfT6iSI4RpjDwgrr6
        zQpruIZUAGkBu8NkfM0mLoEglwlMO5gK4glbPp6jkOBwOpcr36RjULZNtXefw/qrjxZH5J
        d2EEfJUjcGDrcRllXYnasz8rittgSOac7nbyFdkRmDuNN++OPMBP9lJqZAvl+cxQtgKI+Q
        lQeYypHwFMI/3KfRmm1XMlIkRrK+UczFia+7js0ErmgoUGcUJK5t4YB7otsnwYts/X5VX9
        HBrBlL/prkHHBEUvMM4E6kUHaFQddwcRGAp7jsyPMx/9iSFwsQXXOlIPXMxjmw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2184660002;
        Mon, 29 May 2023 08:12:13 +0000 (UTC)
Date:   Mon, 29 May 2023 10:12:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray
 gpiod_unexport() call
Message-ID: <20230529101213.46f4f2b1@xps-13>
In-Reply-To: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
References: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Sun, 28 May 2023 17:09:38
+0300:

> There is no gpiod_export() and gpiod_unexport() looks pretty much stray.
> The gpiod_export() and gpiod_unexport() shouldn't be used in the code,
> GPIO sysfs is deprecated. That said, simply drop the stray call.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Any reason not to consider a backport into stable kernels?
Cc: stable + Fixes would certainly be welcome in this case?

> ---
>  drivers/net/ieee802154/ca8210.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8=
210.c
> index a2d242034220..f9b10e84de06 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2855,7 +2855,6 @@ static int ca8210_interrupt_init(struct spi_device =
*spi)
>  	);
>  	if (ret) {
>  		dev_crit(&spi->dev, "request_irq %d failed\n", pdata->irq_id);
> -		gpiod_unexport(gpio_to_desc(pdata->gpio_irq));
>  		gpio_free(pdata->gpio_irq);
>  	}
> =20


Thanks,
Miqu=C3=A8l
