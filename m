Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:54222 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeHIRrF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Aug 2018 13:47:05 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so754161itw.3
        for <linux-wpan@vger.kernel.org>; Thu, 09 Aug 2018 08:21:42 -0700 (PDT)
Date: Thu, 9 Aug 2018 11:21:34 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Message-ID: <20180809152134.gcql2lsh4sigx3hg@x220t>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, Michael =?utf-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, Konstantin =?utf-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "linux-kernel@vger.kernel.org>," <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, pieter.robyns@uhasselt.be, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>

Hi,

On Thu, Aug 09, 2018 at 11:02:45PM +0800, Jian-Hong Pan wrote:
...
> 
> For LoRaWAN, it is a star topology.
> 

In sense of 6LoWPAN that means "border router" in the middle which runs
radvd on it and sending RA messages. Then doing a route (or even allow nd
proxy) between capable $IPv6 (ethernet?) and LoRa 6LoWPAN interface.

All others listen for RA messages with PIO and doing autoconfiguration.
(In 6LoWPAN you would also pass a 6CO option to compress the PIO
prefix, which would make sense to fully elide all IP addresses in the
header).

- Alex
