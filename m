Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47723 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHKXCG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Aug 2018 19:02:06 -0400
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e703bd38-f45d-6dda-b0e3-404598fd4bab@datenfreihafen.org>
Date: Sat, 11 Aug 2018 20:30:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180810165711.59bf26f7@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Andreas Faerber <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, mkubecek@suse.cz, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, pieter.robyns@uhasselt.be, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>

Hello.

On 08/10/2018 05:57 PM, Alan Cox wrote:
> 
> Long term yes I think Alexander is right the inevitable fate of all
> networks is to become a link layer in order to transmit IP frames 8)

There should be a niche for both at the same time. LoRaWAN is relevant
right now and we should aim for making it possible to run a native Linux
gateway for it.

As for IP for long range low power there is the static context header
compression draft to adapt IPv6 to the characteristics for some use
cases of such networks. Implementing it within the existing 6lwopan
subsystem should be possible.

https://tools.ietf.org/html/draft-ietf-lpwan-ipv6-static-context-hc-16

regards
Stefan Schmidt
