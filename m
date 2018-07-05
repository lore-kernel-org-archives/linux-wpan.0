Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:49733 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeGEJ5y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Jul 2018 05:57:54 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] ieee802154: mcr20a: add missing includes
References: <20180530214732.1021121-1-arnd@arndb.de>
Message-ID: <f05de56e-eb0c-a821-b623-90571c4551de@datenfreihafen.org>
Date: Thu, 5 Jul 2018 11:57:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180530214732.1021121-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S. Miller" <davem@davemloft.net>
Cc: Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

[Sorry for the delay here, I was on a few weeks on leave]

On 30.05.2018 23:47, Arnd Bergmann wrote:
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
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
