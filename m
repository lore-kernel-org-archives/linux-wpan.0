Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeLQIuw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Dec 2018 03:50:52 -0500
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
In-Reply-To: <20181216101858.9585-7-starnight@g.ncu.edu.tw>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Mon, 17 Dec 2018 09:50:13 +0100
Message-ID: <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello Jian-Hong,

Thanks for your work in LoRaWAN.
I have a question about the architecture of your module. AFAIK LoRaWAN
is already the MAC Layer above the LoRa technology. Why do you want to
make a new layer called "maclorawan" ?

Regards,

Xue Liu


On Sun, 16 Dec 2018 at 11:20, Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:
>
> List LORAWAN and MACLORAWAN in menuconfig and make they can be built.
>
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
> V2:
> - Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>   LoRaWAN Soft MAC modules
>
>  net/Kconfig  | 2 ++
>  net/Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index cf2e651ee31d..03b3ff306778 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
>  source "net/ieee802154/Kconfig"
>  source "net/mac802154/Kconfig"
>  source "net/lora/Kconfig"
> +source "net/lorawan/Kconfig"
> +source "net/maclorawan/Kconfig"
>  source "net/sched/Kconfig"
>  source "net/dcb/Kconfig"
>  source "net/dns_resolver/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index e80b84313851..9d5515965a8f 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)         += 6lowpan/
>  obj-$(CONFIG_IEEE802154)       += ieee802154/
>  obj-$(CONFIG_MAC802154)                += mac802154/
>  obj-$(CONFIG_LORA)             += lora/
> +obj-$(CONFIG_LORAWAN)          += lorawan/
> +obj-$(CONFIG_MACLORAWAN)       += maclorawan/
>
>  ifeq ($(CONFIG_NET),y)
>  obj-$(CONFIG_SYSCTL)           += sysctl_net.o
> --
> 2.20.0
>


--
