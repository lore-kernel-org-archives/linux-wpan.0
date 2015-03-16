Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34641 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbCPDob (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 15 Mar 2015 23:44:31 -0400
Received: by lbbsy1 with SMTP id sy1so23096588lbb.1
        for <linux-wpan@vger.kernel.org>; Sun, 15 Mar 2015 20:44:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426372323-33695-1-git-send-email-bradjc5@gmail.com>
References: <1426372323-33695-1-git-send-email-bradjc5@gmail.com>
Date: Mon, 16 Mar 2015 09:14:28 +0530
Message-ID: <CAEUmHyZ=F0vbnfuP=SMjyG_TzaKxHsyQOp7X3M0hajvYQ-p2=w@mail.gmail.com>
Subject: Re: [PATCH] cc2520: Add support for CC2591 amplifier.
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>

Hi Brad Campbell,

On 03/15/2015 04:02 AM, Brad Campbell wrote:

> The TI CC2521 is an RF power amplifier that is designed to interface
> with the CC2520. Conveniently, it directly interfaces with the CC2520
> and does not require any pins to be connected to a
> microcontroller/processor. Adding a CC2591 increases the CC2520's range,
> which is useful for border router and other wall-powered applications.
>
> Using the CC2591 with the CC2520 requires configuring the CC2520 GPIOs
> that are connected to the CC2591 to correctly set the CC2591 into TX and
> RX modes. Further, TI recommends that the CC2520_TXPOWER and
> CC2520_AGCCTRL1 registers are set differently to maximize the CC2591's
> performance. These settings are covered in TI Application Note AN065.

Please provide the link to Application note..

> This patch adds an optional `amplified` field to the cc2520 entry in the
> device tree. If present and set to `1` the CC2520 will be configured to
> operate with a CC2591.
>
> The expected pin mapping is:
> CC2520 GPIO0 --> CC2591 EN
> CC2520 GPIO5 --> CC2591 PAEN
> ---
>   .../devicetree/bindings/net/ieee802154/cc2520.txt  |  4 ++
>   drivers/net/ieee802154/cc2520.c                    | 53 ++++++++++++++++++----
>   include/linux/spi/cc2520.h                         |  1 +
>   3 files changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> index 0071883..c6682f9 100644
> --- a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> +++ b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> @@ -13,11 +13,15 @@ Required properties:
>   - cca-gpio: GPIO spec for the CCA pin
>   - vreg-gpio: GPIO spec for the VREG pin
>   - reset-gpio: GPIO spec for the RESET pin
> +Optional properties:
> + - amplified: set to 1 if the CC2520 is connected to a CC2591 amplifier
> +
>   Example:
>   cc2520@0 {
>   compatible = "ti,cc2520";
>   reg = <0>;
>   spi-max-frequency = <4000000>;
> + amplified = <1>;
>   pinctrl-names = "default";
>   pinctrl-0 = <&cc2520_cape_pins>;
>   fifo-gpio = <&gpio1 18 0>;
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 181b349..37c7e00 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -719,6 +719,7 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>   u8 status = 0, state = 0xff;
>   int ret;
>   int timeout = 100;
> + struct cc2520_platform_data *pdata = priv->spi->dev.platform_data;
>
>   ret = cc2520_read_register(priv, CC2520_FSMSTAT1, &state);
>   if (ret)
> @@ -741,11 +742,46 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>
>   dev_vdbg(&priv->spi->dev, "oscillator brought up\n");
>
> - /* Registers default value: section 28.1 in Datasheet */
> - ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
> - if (ret)
> - goto err_ret;
> + /* If the CC2520 is connected to a CC2591 amplifier, we must both
> + * configure GPIOs on the CC2520 to correctly configure the CC2591
> + * and change a couple settings of the CC2520 to work with the
> + * amplifier. See section 8 page 17 of TI application note AN065.
> + */
> + if (pdata->amplified == 1) {
> + ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF9);
> + if (ret)
> + goto err_ret;
> +
> + ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x16);
> + if (ret)
> + goto err_ret;
> +
> + ret = cc2520_write_register(priv, CC2520_GPIOCTRL0, 0x46);
> + if (ret)
> + goto err_ret;
> +
> + ret = cc2520_write_register(priv, CC2520_GPIOCTRL5, 0x47);
> + if (ret)
> + goto err_ret;
> +
> + ret = cc2520_write_register(priv, CC2520_GPIOPOLARITY, 0x1e);
> + if (ret)
> + goto err_ret;
>
> + ret = cc2520_write_register(priv, CC2520_TXCTRL, 0xc1);
> + if (ret)
> + goto err_ret;
> + } else {
> + ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
> + if (ret)
> + goto err_ret;
> +
> + ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x11);
> + if (ret)
> + goto err_ret;
> + }
> +
> + /* Registers default value: section 28.1 in Datasheet */
>   ret = cc2520_write_register(priv, CC2520_CCACTRL0, 0x1A);
>   if (ret)
>   goto err_ret;
> @@ -770,10 +806,6 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>   if (ret)
>   goto err_ret;
>
> - ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x11);
> - if (ret)
> - goto err_ret;
> -
>   ret = cc2520_write_register(priv, CC2520_ADCTEST0, 0x10);
>   if (ret)
>   goto err_ret;
> @@ -814,6 +846,7 @@ cc2520_get_platform_data(struct spi_device *spi)
>   struct cc2520_platform_data *pdata;
>   struct device_node *np = spi->dev.of_node;
>   struct cc2520_private *priv = spi_get_drvdata(spi);
> + int ret;
>
>   if (!np)
>   return spi->dev.platform_data;
> @@ -832,6 +865,10 @@ cc2520_get_platform_data(struct spi_device *spi)
>   pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
>   pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
>
> + ret = of_property_read_s32(np, "amplified", &pdata->amplified);
> + if (ret < 0)
> + pdata->amplified = 0;
> +
>   spi->dev.platform_data = pdata;
>
>   done:
> diff --git a/include/linux/spi/cc2520.h b/include/linux/spi/cc2520.h
> index 85b8ee6..1810cd0 100644
> --- a/include/linux/spi/cc2520.h
> +++ b/include/linux/spi/cc2520.h
> @@ -21,6 +21,7 @@ struct cc2520_platform_data {
>   int sfd;
>   int reset;
>   int vreg;
> + int amplified;

This is just a flag ... So why don't we use bool instead of int.

>   };
>
>   #endif

Have you tested these changes along with cc2591..? Because i don't
have cc2591 to test these changes.

-- 
Varka Bhadram
