Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44325 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeDLMi6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Apr 2018 08:38:58 -0400
Received: by mail-pl0-f67.google.com with SMTP id b6-v6so3819777pla.11
        for <linux-wpan@vger.kernel.org>; Thu, 12 Apr 2018 05:38:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412122849.15329-1-stefan@osg.samsung.com>
References: <20180412122849.15329-1-stefan@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Thu, 12 Apr 2018 14:38:17 +0200
Message-ID: <CAJuUDwsKu50Dk+rgbuXLdSkZWNufXuA8LZGnEXiM1oVV9Q=6rA@mail.gmail.com>
Subject: Re: [PATCH] net: ieee802154: mcr20a: do not leak resources on error path
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, Alexander Aring <alex.aring@gmail.com>

ACK-by: Xue Liu <liuxuenetmail@gmail.com>

On 12 April 2018 at 14:28, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> We already allocated the device and platform  data at this
> point. Instead of simply return from the probe function we
> need to cleanup the resources first.
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 944470d69ba9..de0d7f28a181 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -1309,8 +1309,10 @@ mcr20a_probe(struct spi_device *spi)
>         /* init buf */
>         lp->buf = devm_kzalloc(&spi->dev, SPI_COMMAND_BUFFER, GFP_KERNEL);
>
> -       if (!lp->buf)
> -               return -ENOMEM;
> +       if (!lp->buf) {
> +               ret = -ENOMEM;
> +               goto free_dev;
> +       }
>
>         mcr20a_setup_tx_spi_messages(lp);
>         mcr20a_setup_rx_spi_messages(lp);
> --
> 2.14.3
>
