Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44031 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFAVxA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jun 2018 17:53:00 -0400
MIME-Version: 1.0
References: <20180530214732.1021121-1-arnd@arndb.de>
In-Reply-To: <20180530214732.1021121-1-arnd@arndb.de>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Fri, 1 Jun 2018 23:52:23 +0200
Message-ID: <CAJuUDwtZ7tK3=WP_O0UMe2SaD+B9L-BdAvK3qyBJB=L+yqiSuQ@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: mcr20a: add missing includes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: arnd@arndb.de
Cc: "alex. aring" <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S. Miller" <davem@davemloft.net>, colin.king@canonical.com, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Arnd,

Thanks for the fix.

Acked-by: Xue Liu <liuxuenetmail@gmail.com>

On Wed, 30 May 2018 at 23:47, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without CONFIG_GPIOLIB, some headers are not included implicitly,
> leading to a build failure:
>
> drivers/net/ieee802154/mcr20a.c: In function 'mcr20a_probe':
> drivers/net/ieee802154/mcr20a.c:1347:13: error: implicit declaration of function 'irq_get_trigger_type'; did you mean 'irq_get_irqchip_state'? [-Werror=implicit-function-declaration]
>
> This includes gpio/consumer.h and irq.h directly rather through the
> gpiolib header.
>
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ieee802154/mcr20a.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index de0d7f28a181..e428277781ac 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -15,10 +15,11 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/workqueue.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/skbuff.h>
>  #include <linux/of_gpio.h>
>  #include <linux/regmap.h>
> --
> 2.9.0
>


--
