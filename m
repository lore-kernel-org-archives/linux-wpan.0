Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36785 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbCPN5a (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 16 Mar 2015 09:57:30 -0400
Received: by wgra20 with SMTP id a20so40652403wgr.3
        for <linux-wpan@vger.kernel.org>; Mon, 16 Mar 2015 06:57:29 -0700 (PDT)
Date: Mon, 16 Mar 2015 14:57:26 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] cc2520: Add support for CC2591 amplifier.
Message-ID: <20150316135722.GB918@omega>
References: <1426372323-33695-1-git-send-email-bradjc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426372323-33695-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

I want to note something here, if it's technical correct according the
CC2520 - Varka Bhadram needs to decide that.

On Sat, Mar 14, 2015 at 06:32:03PM -0400, Brad Campbell wrote:
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
> device tree. If present and set to `1` the CC2520 will be configured to
> operate with a CC2591.
> 
> The expected pin mapping is:
> CC2520 GPIO0 --> CC2591 EN
> CC2520 GPIO5 --> CC2591 PAEN

Signed-off-by is missing here. Create your patches with "fomat-patch -s"
or add a signed-off bt adding "-s" add your "git commit" commands.

> ---
>  .../devicetree/bindings/net/ieee802154/cc2520.txt  |  4 ++
>  drivers/net/ieee802154/cc2520.c                    | 53 ++++++++++++++++++----
>  include/linux/spi/cc2520.h                         |  1 +
>  3 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> index 0071883..c6682f9 100644
> --- a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> +++ b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> @@ -13,11 +13,15 @@ Required properties:
>  	- cca-gpio:		GPIO spec for the CCA pin
>  	- vreg-gpio:		GPIO spec for the VREG pin
>  	- reset-gpio:		GPIO spec for the RESET pin
> +Optional properties:
> +	- amplified:		set to 1 if the CC2520 is connected to a CC2591 amplifier
> +

Which Varka already mentioned this should be a bool.

>  Example:
>  	cc2520@0 {
>  		compatible = "ti,cc2520";
>  		reg = <0>;
>  		spi-max-frequency = <4000000>;
> +		amplified = <1>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cc2520_cape_pins>;
>  		fifo-gpio = <&gpio1 18 0>;
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 181b349..37c7e00 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -719,6 +719,7 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  	u8 status = 0, state = 0xff;
>  	int ret;
>  	int timeout = 100;
> +	struct cc2520_platform_data *pdata = priv->spi->dev.platform_data;
>

Normal processing now is to have "read only" access on platform_data.
Look for commit:

aaa1c4d226e4cd730075d3dac99a6d599a0190c7 ("at86rf230: copy pdata to
driver allocated space")

for a similar issue and solution.

>  	ret = cc2520_read_register(priv, CC2520_FSMSTAT1, &state);
>  	if (ret)
> @@ -741,11 +742,46 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  
>  	dev_vdbg(&priv->spi->dev, "oscillator brought up\n");
>  
...
>  
> +	ret = of_property_read_s32(np, "amplified", &pdata->amplified);
> +	if (ret < 0)

note: if you using "of_property_read_bool" then checking on failure isn't
required here.

I mentioned here because checking (ret < 0) is wrong for an optional
attribute. Correct would be if (ret < 0 && ret != -EINVAL). See [0].
"... -EINVAL if the property does not exist".

- Alex

[0] http://lxr.free-electrons.com/source/drivers/of/base.c#L1231
