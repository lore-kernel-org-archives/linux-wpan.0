Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729732AbeHIDND (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Aug 2018 23:13:03 -0400
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
Message-ID: <f1967750-0a42-0e76-2d7d-da293bc351af@suse.de>
Date: Thu, 9 Aug 2018 02:50:39 +0200
MIME-Version: 1.0
In-Reply-To: <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter Robyns <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-wpan <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, Xue Liu <liuxuenetmail@gmail.com>, =?UTF-8?Q?Sebastian_He=c3=9f?= <shess@hessware.de>

Am 05.08.2018 um 02:11 schrieb Andreas Färber:
> Am 03.07.2018 um 17:11 schrieb Jian-Hong Pan:
>> 2018-07-01 19:07 GMT+08:00 Andreas Färber <afaerber@suse.de>:
>>> 5) Many of the modules support multiple modes, such as LoRa, LoRaWAN and FSK.
>>>    Lacking a LoRaWAN implementation, I am currently switching them into LoRa
>>>    mode at probe time wherever possible. How do we deal with that properly?
[...]
> Independently of what LoRaWAN does, the
> user needs to be able to send on the physical layer from a selection of
> LoRa, GFSK, FSK, OOK, GMSK and MSK.
> Supposedly Wireless M-Bus and IEEE 802.15.4 can be implemented via those
> according to the SX1276 datasheet.
> 
> This opens a can of worms...
> 
> SX127x has a single channel, so I don't think there should be six
> network interfaces lora0, gfsk0, fsk0, ook0, gmsk0 and msk0 exposed to
> the user.
> Having a lora0 interface speak non-LoRa modulations may be confusing,
> but since the chip is sold as LoRa transceiver it might be acceptable.
> 
> SX130x has 8+2 channels, with IF9 dedicated to GFSK/FSK. It appears to
> use one FIFO for receiving (up to 16 packets) and can only transmit one
> packet at a time. So I think this should be one lora0 interface, too.
> 
> With a view to supporting non-LoRa RF chipsets such as Si4xxx (GFSK,
> FSK, OOK) or nRF905 and nRF24L01+ (both GFSK) at a later date, I don't
> think those modulations should be some netlink option on a PF_LORA
> interface but cleanly distinguished as ETH_P_GFSK or something.
> For example, the Chistera Pi HAT has both an RFM95W and an RFM22 module.

Answering myself here: MSK is a special case of FSK, and GMSK a special
case of GFSK. SX1276 allows to switch between LoRa and FSK/OOK modes,
and in FSK/OOK mode between FSK and OOK modulation types and for FSK
modulation allows to set Gaussian filter values. I assume (G)MSK is
selected indirectly through BitRate and Fdev settings or something.

So we would just need ETH_P_FSK and ETH_P_OOK plus some skb fields for
ETH_P_FSK.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
