Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39123
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759301AbcJYPy2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Oct 2016 11:54:28 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH 2/3] ieee802154: Add device tree documentation for CA8210
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-3-h.morris@cascoda.com>
Message-ID: <ff139ca6-38c3-bd73-2ecc-41a4b6d32388@osg.samsung.com>
Date: Tue, 25 Oct 2016 17:54:23 +0200
MIME-Version: 1.0
In-Reply-To: <20161024150449.11132-3-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Harry Morris <h.morris@cascoda.com>

Hello.

On 24/10/16 17:04, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> ---
>  .../devicetree/bindings/net/ieee802154/ca8210.txt  | 28 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
>
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> new file mode 100644
> index 0000000..0297ce8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> @@ -0,0 +1,28 @@
> +* CA8210 IEEE 802.15.4 *
> +
> +Required properties:
> +	- compatible:           should be "cascoda,ca8210"


Start should with a capital S here as you do on all other lines. Total 
nitpick. :)

> +	- reg:                  Controlling chip select
> +	- spi-max-frequency:    Maximum clock speed, should be *less than*
> +	                        4000000
> +	- spi-cpol:             Invert clock polarity

Is this a mandatory field for the bindings? I would expect one being the 
default and used while the other one being an optional property and only 
used when the hardware setup needs this. Does this make sense?


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
> index d415b38..725a996 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -26,6 +26,7 @@ brcm	Broadcom Corporation
>  buffalo	Buffalo, Inc.
>  calxeda	Calxeda
>  capella	Capella Microsystems, Inc
> +cascoda	Cascoda Ltd.
>  cavium	Cavium, Inc.
>  cdns	Cadence Design Systems Inc.
>  chrp	Common Hardware Reference Platform
>

The rest looks good.

regards
Stefan Schmidt
