Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35666 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbCQIDL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 04:03:11 -0400
Received: by wgdm6 with SMTP id m6so1621826wgd.2
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 01:03:10 -0700 (PDT)
Date: Tue, 17 Mar 2015 09:03:04 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 2/2] cc2520: Add support for CC2591 amplifier.
Message-ID: <20150317080301.GA1303@omega>
References: <1426544203-60585-1-git-send-email-bradjc5@gmail.com>
 <1426544203-60585-3-git-send-email-bradjc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426544203-60585-3-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Mar 16, 2015 at 06:16:43PM -0400, Brad Campbell wrote:
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
> 
> This patch adds an optional `amplified` field to the cc2520 entry in the
> device tree. If present, the CC2520 will be configured to operate with a
> CC2591.
> 
> The expected pin mapping is:
> CC2520 GPIO0 --> CC2591 EN
> CC2520 GPIO5 --> CC2591 PAEN
> 
> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> ---
>  .../devicetree/bindings/net/ieee802154/cc2520.txt  |  4 ++
>  drivers/net/ieee802154/cc2520.c                    | 55 ++++++++++++++++++----
>  include/linux/spi/cc2520.h                         |  1 +
>  3 files changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> index 0071883..fb6d49f 100644
> --- a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> +++ b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> @@ -13,11 +13,15 @@ Required properties:
>  	- cca-gpio:		GPIO spec for the CCA pin
>  	- vreg-gpio:		GPIO spec for the VREG pin
>  	- reset-gpio:		GPIO spec for the RESET pin
> +Optional properties:
> +	- amplified:		include if the CC2520 is connected to a CC2591 amplifier
> +
>  Example:
>  	cc2520@0 {
>  		compatible = "ti,cc2520";
>  		reg = <0>;
>  		spi-max-frequency = <4000000>;
> +		amplified;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cc2520_cape_pins>;
>  		fifo-gpio = <&gpio1 18 0>;
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 275e6fb..0639af6 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -736,6 +736,8 @@ static int cc2520_get_platform_data(struct spi_device *spi,
>  	pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
>  	pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
>  
> +	pdata->amplified = of_property_read_bool(np, "amplified");
> +
>  	return 0;
>  }
>  
> @@ -744,6 +746,11 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  	u8 status = 0, state = 0xff;
>  	int ret;
>  	int timeout = 100;
> +	struct cc2520_platform_data pdata;
> +
> +	ret = cc2520_get_platform_data(priv->spi, &pdata);
> +	if (ret)
> +		goto err_ret;
>  
>  	ret = cc2520_read_register(priv, CC2520_FSMSTAT1, &state);
>  	if (ret)
> @@ -766,11 +773,47 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  
>  	dev_vdbg(&priv->spi->dev, "oscillator brought up\n");
>  
> -	/* Registers default value: section 28.1 in Datasheet */
> -	ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
> -	if (ret)
> -		goto err_ret;
> +	/* If the CC2520 is connected to a CC2591 amplifier, we must both
> +	 * configure GPIOs on the CC2520 to correctly configure the CC2591
> +	 * and change a couple settings of the CC2520 to work with the
> +	 * amplifier. See section 8 page 17 of TI application note AN065.
> +	 * http://www.ti.com/lit/an/swra229a/swra229a.pdf
> +	 */
> +	if (pdata.amplified == 1) {

just if (pdata.amplified) here.

- Alex
