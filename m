Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeHWVOH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 17:14:07 -0400
Subject: Re: [RFC 1/3 net] lorawan: Add LoRaWAN class module
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
 <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
Date: Thu, 23 Aug 2018 10:43:10 -0700
MIME-Version: 1.0
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>

Hi,

On 08/23/2018 10:15 AM, Jian-Hong Pan wrote:
> diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
> new file mode 100644
> index 000000000000..741992b059c6
> --- /dev/null
> +++ b/net/maclorawan/Kconfig
> @@ -0,0 +1,14 @@
> +config LORAWAN
> +	tristate "MAC layer of LoRaWAN Network support"
> +	select CRYPTO
> +	select CRYPTO_CMAC
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	---help---
> +	  LoRaWAN defines a low data rate, low power and long range wireless
> +	  wide area networks. It was designed to organise networks of sensors,
> +	  switches and actuators, etc automation devices.  It could operate as
> +	  multiple kilometers wide.

There are several things that I would change.  How about this instead?


	  LoRaWAN defines low data rate, low power and long range wireless
	  wide area networks. It was designed to organise networks of automation
	  devices, such as sensors, switches and actuators. It can operate
	  multiple kilometers wide.

> +
> +	  Say Y here to compile LoRaWAN support into the kernel or say M to
> +	  compile it as modules.


-- 
~Randy
