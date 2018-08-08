Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729884AbeHIBEx (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Aug 2018 21:04:53 -0400
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
Date: Thu, 9 Aug 2018 00:42:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180808213640.10a1d76f@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter Robyns <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, =?UTF-8?Q?Sebastian_He=c3=9f?= <shess@hessware.de>, Xue Liu <liuxuenetmail@gmail.com>

Am 08.08.2018 um 22:36 schrieb Alan Cox:
> On Sun, 5 Aug 2018 02:11:25 +0200
> Andreas Färber <afaerber@suse.de> wrote:
>> Am 03.07.2018 um 17:11 schrieb Jian-Hong Pan:
>>> 2018-07-01 19:07 GMT+08:00 Andreas Färber <afaerber@suse.de>:  
>> LoRa radio channels being half-duplex, we'd need to stop receiving in
>> ndo_start_xmit and re-start receiving in the TX interrupt handler AFAIU.
>> Yes, it's ugly - one reason I haven't implemented RX in sx1276 yet.
> 
> Why - the signal is still floating around in the air, you can't unhear it
> at the antenna.

Why what? :)

> If a given piece of hardware needs to flip between RX
> and TX mode then it should be handled by that driver.

Yes, and we are talking about that concrete sx1276 driver here, whose
chipset has a state machine that only allows either rx or tx and also
has standby and sleep modes with differing levels of data retention.

The sx1301 is a different beast (and driver) and may allow both.

In any case, the ndo_start_xmit hook is in each device driver. But the
recvmsg hook I mentioned is at protocol layer, which exactly is the
layering problem I see.

> (Some ancient ethernet cards do this btw.. they can't listen and transmit
> at the same time)

So when do they start receiving?

The issue here was that my original description, which you appear to
have cut, suggested a continuous listen mode, interrupted by transmit.
Jian-Hong didn't like that, with reference to the LoRaWAN spec that
supposedly asks for only being in receive mode when expecting a message,
likely to save on battery. So the question is, could we cleanly
implement receiving only when the user asks us to, or is that a no-go?

>>> - We can have a pre-defined table according to LoRaWAN Regional Parameters.
>>> - Device driver declares the hardware's capability, for example
>>> frequency, TX power.  And then registers as a LoRaWAN compatible
>>> device.  
>>
>> That sounds like a layering violation. We rather need to expose all
>> these tunable parameters individually at the LoRa layer, allowing the
>> LoRaWAN layer to configure them as it pleases. Not the other direction.
>> That still leaves my above question 4) open of how to implement each.
> 
> Wifi already has the general policy database for the various existing
> protocols. Please take a look at the CRDA agent and how it hooks into
> wireless.It might need to some tweaking but it would be odd to have
> different configuration schemes for different wifi protocols.

CRDA/wireless-regdb had been brought up and I've been pointed to nl80211
and nl802154, which I've tried to make sense of for my initial nllora.
Admittedly with limited success, as that code is slightly complex.

We also seemed to have consensus here that we _should_ be reusing
wireless-regdb but would need to extend it 1.) with sub-GHz frequency
bands and 2.) duty-cycle limits for some of those bands. No maintainer
commented on that so far. Thus I am working in tiny steps on providing
netlink-layer commands in nllora that can dispatch the individual radio
settings to drivers, which then upper layers can instrument as needed.

And making my very first steps with netlink here, it appeared as if each
technology has its own enums of commands and attributes, so I don't see
how to reuse anything from Wifi here apart from some design inspiration.

>> The use case I have in mind is this: User A opens a LoRaWAN socket and
>> using maclorawan sends a packet P1. Here the LoRaWAN Regional Parameters
>> and LoRaWAN Sync Word need to be applied.
>> User B then opens a pure LoRa socket and transmits a packet P1' with
>> different Sync Word, SF, BW, CR, etc.
>> Afterwards user A wants to send another packet P2 via LoRaWAN - this
>> needs to use the same LoRaWAN settings as before, not those used for
>> LoRa in between. Therefore I was thinking about socket-level options, as
>> netlink operations would be device-wide, with undesired side-effects.
> 
> Agreed
> 
>> Obviously in that scenario not both users can receive at the same time.
> 
> That's a hardware question. Imagine a software defined radio. If your
> limitation wouldn't exist in a pure software defined radio then it's
> almost certainly a device level detal.

An SDR would not be using this sx1276 device driver, I imagine.

In fact I would expect an SDR device not to be in drivers/net/lora/ at
all but to live in drivers/net/sdr/ and to consume ETH_P_LORA etc. skbs
and just do the right thing for them depending on their type...

>> interface but cleanly distinguished as ETH_P_GFSK or something.
>> For example, the Chistera Pi HAT has both an RFM95W and an RFM22 module.
> 
> Agreed if you can flip per packet.

The SX127x can - it might involve delays of course.

The SX130x doesn't even need to flip for sending AFAICT, it's just
metadata after the payload in the FIFO.

>> The next question arising is how the user would create such an skb. Just
>> like I was hesitant about PF_LORAWAN originally, I'd like to avoid
>> polluting the PF_ number space for each of these. Maybe have one PF_FSK
>> as equivalent to PF_LORA and then have either a socket option or
>> sockaddr field to select the modulation variants? Not sure how exactly
>> those others differ from each other, that's why I tried to postpone the
>> FSK topic and to focus on LoRa first - b) below.
>>
>> At this point we could also argue whether we need a PF_LORA at all or
>> rather just some generic PF_RADIO with lots of options stored in its
>> sockaddr.
> 
> What matters most is mux/demux.
> 
> If you've got something listening to data but without the structure
> needed to identify multiple listeners and split out the data meaningfully
> to those listeners according to parts of the packet then you've got no
> reason to make it a protocol just use SOCK_PACKET and if need be BPF.

Sorry, that doesn't parse for me. SOCK_PACKET must be a protocol on some
PF_ protocol family, no? Are you suggesting I use SOCK_PACKET instead of
SOCK_DGRAM in what is now net/lora/dgram.c? Or are you saying there's
some generic implementation that we can reuse and scratch mine?

> The reason we have a socket layer not /dev/ethernet0 is that it's
> meaningful to divide messages up into flows, and to partition those flows
> securely amongst multiple consumers/generators.

For me the distinction is that a /dev/whatever0 would seem more suited
for a stream of data to read/write, whereas sockets give us a bounded
skb for packets at device driver level.

These PHYs all broadcast something over the antenna when sending, with
any addressing of listeners or senders being optional and MAC-specific,
apart from the LoRa/FSK SyncWord as well as the various frequency etc.
settings that determine what the receiver listens for.

None of these PHYs define any mechanism like EtherType through which to
identify upper-layer protocols.

So in a way, listening is always in a promiscuous mode, and I guess we
would need to try to parse each incoming packet as e.g. a LoRaWAN packet
and just give up if it's too short or checksums don't match. Only at the
layer of LoRaWAN and competing proprietary or custom protocols can we
split received packets out to individual listeners.

Does that give us any further clues for the design discussion here?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
