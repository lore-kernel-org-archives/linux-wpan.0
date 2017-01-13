Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50338
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751526AbdAMMr5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Jan 2017 07:47:57 -0500
Subject: Re: [PATCH v7 2/3] ieee802154: Add device tree documentation for
 CA8210
References: <20170110154122.6724-1-h.morris@cascoda.com>
 <20170110154122.6724-3-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <4124e6b8-1eca-aee5-0f41-f56226ec9dae@osg.samsung.com>
Date: Fri, 13 Jan 2017 13:47:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170110154122.6724-3-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi Harry.

Alex pointed out that we might want to run the addition to 
vendor-prefixes.txt through the devicetree list and maintainers.

Should really not be a problem but that way they are at least aware. I 
added them in CC for this patch.

On 10/01/17 16:41, Harry Morris wrote:
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  .../devicetree/bindings/net/ieee802154/ca8210.txt  | 28 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
>
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> new file mode 100644
> index 0000000..a1046e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> @@ -0,0 +1,28 @@
> +* CA8210 IEEE 802.15.4 *
> +
> +Required properties:
> +	- compatible:           Should be "cascoda,ca8210"
> +	- reg:                  Controlling chip select
> +	- spi-max-frequency:    Maximum clock speed, should be *less than*
> +	                        4000000
> +	- spi-cpol:             Requires inverted clock polarity
> +	- reset-gpio:           GPIO attached to reset
> +	- irq-gpio:             GPIO attached to IRQ
> +Optional properties:
> +	- extclock-enable:      Include for the ca8210 to route its 16MHz clock
> +	                        to an output
> +	- extclock-freq:        Frequency in Hz of the external clock
> +	- extclock-gpio:        GPIO of the ca8210 to output the clock on
> +
> +Example:
> +	ca8210@0 {
> +		compatible = "cascoda,ca8210";
> +		reg = <0>;
> +		spi-max-frequency = <3000000>;
> +		spi-cpol;
> +		reset-gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +		irq-gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		extclock-enable;
> +		extclock-freq = 16000000;
> +		extclock-gpio = 2;
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 24c6f65..6c5609f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -47,6 +47,7 @@ brcm	Broadcom Corporation
>  buffalo	Buffalo, Inc.
>  calxeda	Calxeda
>  capella	Capella Microsystems, Inc
> +cascoda	Cascoda, Ltd.
>  cavium	Cavium, Inc.
>  cdns	Cadence Design Systems Inc.
>  ceva	Ceva, Inc.
>

regards
Stefan Schmidt
