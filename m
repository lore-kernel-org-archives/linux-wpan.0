Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36847 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbeHIRex (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Aug 2018 13:34:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so10414280oig.3
        for <linux-wpan@vger.kernel.org>; Thu, 09 Aug 2018 08:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180701110804.32415-1-afaerber@suse.de> <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de> <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de> <20180809125939.39ac2cc9@alans-desktop>
In-Reply-To: <20180809125939.39ac2cc9@alans-desktop>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Thu, 9 Aug 2018 23:02:45 +0800
Message-ID: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "linux-kernel@vger.kernel.org>," <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, pieter.robyns@uhasselt.be, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>

Alan Cox <gnomes@lxorguk.ukuu.org.uk> =E6=96=BC 2018=E5=B9=B48=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > Yes, and we are talking about that concrete sx1276 driver here, whose
> > chipset has a state machine that only allows either rx or tx and also
> > has standby and sleep modes with differing levels of data retention.
>
> It's a hardware limit, it should never influence the protocol stack
> itself just the driver. Linux always tries to design to optimize the
> non-crappy case. In the long term that works out best because hardware
> improves and you don't want to be tied to an old limit.
>
> > > (Some ancient ethernet cards do this btw.. they can't listen and tran=
smit
> > > at the same time)
> >
> > So when do they start receiving?
>
> When they are not transmitting. The transmit path switches modes and when
> the frame send is done it goes back to receiving. As old ethernet was
> also half duplex that worked.
>
> > The issue here was that my original description, which you appear to
> > have cut, suggested a continuous listen mode, interrupted by transmit.
>
> I don't think I cut it but if so I didn't mean to and your approach is
> the one I agree with.
>
> > Jian-Hong didn't like that, with reference to the LoRaWAN spec that
> > supposedly asks for only being in receive mode when expecting a message=
,
> > likely to save on battery. So the question is, could we cleanly
> > implement receiving only when the user asks us to, or is that a no-go?
>
> Why would you do so ? You can't run Linux on a tiny little
> micro-controller where that would matter. Sure it makes sense for some
> tiny spec of embedded silicon buried in a sensor - but not a Linux box.
>
> Now you might power it down when the interface is down, or when there is
> nobody using that interface but that's really more about long term idle
> power.

Except saving power, mitigating the wireless signal conflict on the
air is one of the reasons.

According to the LoRaWAN spec. defined by LoRa Alliance, all LoRaWAN
end devices must implement class A features, which is also the most
general and simplest.
1. The transmission slot scheduled by the end-device is based on its
own communication needs with a small variation based on a random time
basis (ALOHA-type of protocol).
2. Only require downlink communication from the server shortly after
the end-device has sent an uplink transmission. Downlink
communications from the server at any other time will have to wait
until the next scheduled uplink.
3. Each end-device=E2=80=98s uplink transmission is followed by two short
downlink receive windows.

End device transmits an uplink message finished
   ->
End device goes to sleep/idle/stop
   ->
End device opens RX1 window.  This is the time for the downlink message.
   ->
End device goes to sleep/idle/stop
   ->
End device opens RX2 window.  This is another time for the downlink message=
.
   ->
End device goes to sleep/idle/stop

The time between end device transmit an uplink message finished and
end device opens RX1 window is RX delay #1.
The time between end device transmit an uplink message finished and
end device opens RX2 window is RX delay #2.
If end device gets the meaningful downlink message in RX1 window, it
will not open RX2 window.
The time of RX delay #1 and 2 are defined in LoRaWAN Regional Parameters.

The sleep/idle/stop mitigate the unconcerned RF signals or messages.

> > bands and 2.) duty-cycle limits for some of those bands. No maintainer
> > commented on that so far. Thus I am working in tiny steps on providing
> > netlink-layer commands in nllora that can dispatch the individual radio
> > settings to drivers, which then upper layers can instrument as needed.
>
> Sounds right to me.
> >
> > And making my very first steps with netlink here, it appeared as if eac=
h
> > technology has its own enums of commands and attributes, so I don't see
> > how to reuse anything from Wifi here apart from some design inspiration=
.
>
> That seems reasonable - you aren't likely to want to manage them with the
> same tool.
>
> > > That's a hardware question. Imagine a software defined radio. If your
> > > limitation wouldn't exist in a pure software defined radio then it's
> > > almost certainly a device level detal.
> >
> > An SDR would not be using this sx1276 device driver, I imagine.
> >
> > In fact I would expect an SDR device not to be in drivers/net/lora/ at
> > all but to live in drivers/net/sdr/ and to consume ETH_P_LORA etc. skbs
> > and just do the right thing for them depending on their type...
>
> The point I was trying to make was that if you want to decide whether
> something is driver level or protocol level ask 'is this something you
> can't do even with an SDR'. Some things are protocol properties that no
> fancy hardware will change. Others are hardware limits, in which case you
> want them driver level - because at some point the hardware will get
> better.
>
> > > If you've got something listening to data but without the structure
> > > needed to identify multiple listeners and split out the data meaningf=
ully
> > > to those listeners according to parts of the packet then you've got n=
o
> > > reason to make it a protocol just use SOCK_PACKET and if need be BPF.
> >
> > Sorry, that doesn't parse for me. SOCK_PACKET must be a protocol on som=
e
> > PF_ protocol family, no? Are you suggesting I use SOCK_PACKET instead o=
f
> > SOCK_DGRAM in what is now net/lora/dgram.c? Or are you saying there's
> > some generic implementation that we can reuse and scratch mine?
>
> There is a heirarchy. Let me us IP for an example
>
> (historically it was SOCK_PACKET nowdays PF_PACKET - the layering got
> sorted better)
>
> PF_PACKET SOCK_RAW ETH_P_ALL
>
> Everything on that device minus some things like hardware pre-ambles
>
> PF_PACKET SOCK_RAW ETH_P_SOMETHING
>
> Everything on that device that has the underlying protocol (and the
> protocol might not be in the packet but a property of the interface
> because it only does that format - simple example SLIP is IP packets over
> a serial link a SLIP interface is IP, not because there is anything
> saying it is but because that is *all* it can be)
>
> You get the two above for free. PF_PACKET is built into the stack so
> providing you label packets with the ETH_P_xxx you have for Lora, you can
> use PF_PACKET interfaces to dump them and write raw packets at the kernel
> layer.
>
> PF_INET SOCK_RAW
>
> Split the messages by protocol number in IP between multiple
> listeners/writers
>
> PF_INET SOCK_UDP / TCP etc
>
> Split the messages by port numbers in the higher level protocol
>
>
> For PF_LORA these would map to whatever goes on at the LORA protocol
> level and divide LORA messages up between multiple processes on the
> Linux system that are interested in some of the messages.
>
>
> > > The reason we have a socket layer not /dev/ethernet0 is that it's
> > > meaningful to divide messages up into flows, and to partition those f=
lows
> > > securely amongst multiple consumers/generators.
> >
> > For me the distinction is that a /dev/whatever0 would seem more suited
> > for a stream of data to read/write, whereas sockets give us a bounded
> > skb for packets at device driver level.
>
> You could equally do that in a simple character device *if* you didn't
> need to split messages up and share between users. Some protocol stacks
> actually do that and then sort it out in user space, either because they
> are really obscure or they are incredibly complicated and broken so want
> to be out of kernel 8)
>
> > These PHYs all broadcast something over the antenna when sending, with
> > any addressing of listeners or senders being optional and MAC-specific,
> > apart from the LoRa/FSK SyncWord as well as the various frequency etc.
> > settings that determine what the receiver listens for.
> >
> > None of these PHYs define any mechanism like EtherType through which to
> > identify upper-layer protocols.
> >
> > So in a way, listening is always in a promiscuous mode, and I guess we
> > would need to try to parse each incoming packet as e.g. a LoRaWAN packe=
t
> > and just give up if it's too short or checksums don't match. Only at th=
e
> > layer of LoRaWAN and competing proprietary or custom protocols can we
> > split received packets out to individual listeners.
>
> My vote would be in that case that you either
>
> 1. Set the protocol type on the interface assuming you don't mix and
> match (and if it's relying on random bits not looking like other packets
> then it sounds a complete mess at the moment - but yeah its new tech)
>
> 2. You pass everything up to some magical agent which somehow splits them
> up and labels them ETH_P_LORA / ETH_P_FOO etc
>
> 3. You do what ethernet does (which admittedly is *way* simpler for
> ethernet) and you have a library routine you can pass an skbuff in the
> driver itself which figures out wtf to label the packet. Look how
> eth_type_trans() is used. Drivers then just do
>
>            skb->protocol =3D xxx_type_trans(skb, dev);
>
> and the basic labelling gets done and any header pulls (you probably won'=
t
> have any given you don't have anything wrapping LORA), and
> multicast/broadcast labelling - again meaningless I suspect.
>
> #3 Is probably the nicest because you update it all in one place as
> standards change and the market hopefully conslidates and develops some
> kind of sane packet formats. It's also effectively covering #1 and it's
> easy to start with because an initial implementation can just do 'return
> htons(ETH_P_LORA)'.
>
> >
> > Does that give us any further clues for the design discussion here?
> >
> I think so yes
>
> How do you plan to deal with routing if you've got multiple devices ?

For LoRaWAN, it is a star topology.

One end device and one LoRaWAN gateway:
An end device sends a uplink message to the LoRaWAN gateway directly.
A LoRaWAN gateway receives the uplink message, then transfers to the
LoRaWAN network server.
The network server sends a downlink message to the end device via the
transfer of the LoRaWAN gateway.

Multiple end devices and multiple LoRaWAN gateway:
Multiple end devices can send uplink messages to multiple LoRaWAN
gateways directly.  Gateways receive the the uplink messages, then
transfer to the LoRaWAN network server.
The LoRaWAN network server compares the uplink messages' content to
filter out the duplicated messages.
The LoRaWAN network server sends a downlink message to the end device
via the transfer of only one chosen LoRaWAN gateway.

So, an end device does not talk to other end devices directly.
And, of course, the links between LoRaWAN gateway and the network
server could be any network technology, only if they can communicate
with each other fast enough.

Regards,
Jian-Hong Pan
