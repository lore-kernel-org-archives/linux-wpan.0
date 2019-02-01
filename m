Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:39450 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfBAA61 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 31 Jan 2019 19:58:27 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so4383965iob.6
        for <linux-wpan@vger.kernel.org>; Thu, 31 Jan 2019 16:58:26 -0800 (PST)
Date: Thu, 31 Jan 2019 19:58:14 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC net-next 1/4] net: Reserve protocol identifiers for EnOcean
Message-ID: <20190201005613.2qt2sneva3eaxj2t@x220t>
References: <20190129050130.10932-1-afaerber@suse.de>
 <20190129050130.10932-2-afaerber@suse.de>
 <20190129125708.plsbgcpcwhtezgo5@x220t>
 <6a220f80-1c75-12e6-1f8c-53b76412257a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a220f80-1c75-12e6-1f8c-53b76412257a@suse.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, support@enocean.com, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>

Hi,

On Wed, Jan 30, 2019 at 02:42:29AM +0100, Andreas Färber wrote:
> Hi Alex,
> 
> Am 29.01.19 um 13:57 schrieb Alexander Aring:
> > On Tue, Jan 29, 2019 at 06:01:27AM +0100, Andreas Färber wrote:
> >> EnOcean wireless technology is based on ASK (ERP1) and FSK (ERP2) modulations
> >> for sub-GHz and on IEEE 802.15.4 for 2.4 GHz.
> >>
> > 
> > I am not sure what you try to do here. If I see that correctly you
> > want to add for some special protocol vendor specific transceiver which
> > is underneath an 802.15.4 transceiver a new ARPHRD type and even more
> > for each modulation what it supports?
> 
> No. EnOcean uses a 4-byte node ID across PHY layers, which I am using a
> single ARPHRD_ENOCEAN for (which you conveniently cut off above).
> 
> As indicated above, the 868 MHz transceiver is _not_ using 802.15.4 PHY
> or MAC to my knowledge. It does sound like you spotted "IEEE 802.15.4"
> and literally blended out all the rest...
> 

Ah okay, I am curious about that. As far I undetstood now this has
nothing to do with LoRa? I was not getting that point.

Is the PHY layer open? Do they actually refer to 802.15.4 in their
specs, but the PHY layer is changed by... preamble, phy header, MTU?

> > 
> > If it's a 802.15.4 transceiver why not using the 802.15.4 subsystem?
> > 
> > For me it sounds more like a HardMAC transceiver driver for doing the
> > vendor protocol. The different modulations is part of a 802.15.4 phy
> > device class. Similar like in wireless.
> 
> I've tried to design this exactly so that one _could_ implement it based
> on 802.15.4 PHY framework for 2.4 GHz or based on an FSK PHY for sub-GHz
> as a soft-MAC, layered similarly to LoRaWAN vs. LoRa, alongside the ESP
> serdev driver in this series.
> 
> In ESP3 the only 802.15.4 specific operations are getting/setting the
> channel (COMMAND_2_4 packet type), and there's a CO_GET_FREQUENCY_INFO
> command to discover frequency and protocol, with 802.15.4 having a
> different ID than ERP2 (and I spot a value 0x30 for "Long Range" :-)).
> So in theory it might be possible to instantiate an 802.15.4 PHY after
> discovering that ESP3 value, but neither is this a generic 802.15.4 PHY
> nor a generic FSK PHY, and none of that relates to above ARPHRD really.
> 

I keep it in mind, thanks.

> PF_PACKET with SOCK_DGRAM for ETH_P_ERP2 gives me the subtelegram
> contents to transmit via ESP, whereas SOCK_RAW would give the full frame
> to transmit via FSK PHY. By avoiding a custom PF_ENOCEAN we seem to lose
> the ability to prepend any protocol headers on the skb for SOCK_DGRAM.
> 

I am not quite following here. SOCK_RAW full frame and SOCK_DGRAM
payload sounds like what I suppose it should work.

A switch of protocol will do a switch from ESP to FSK which is a phy layer
behaviour?

> Did you actually read my P.S. in the cover letter? I was glad to avoid
> much PF_ socket boilerplate code here (as a playground for LoRa), and
> now you're complaining about a single ARPHRD constant! :-/
> By that standard we could stop implementing anything new... If you're
> worried about number space, why has no one commented on the values added
> for LoRa and other previous wireless technologies? No one had any such
> comments on my LoRa RFC, nor on Jian-Hong's LoRaWAN patches, so I've
> been reserving new ARPHRD_ constants for each technology I work on. If
> ARPHRD_NONE would be a better value to use for PHY layers, no one
> bothered to point it out so far! Nor did anyone suggest to Jian-Hong to
> reuse ARPHRD_EUI64! And yet I spot nothing more suitable for EnOcean
> addresses than a custom value. Fact is, the net_device wants some value.
> Note that you have two ARPHRD constants assigned for 802.15.4 alone, so
> please be fair to others.
> 

Indeed we only need one. :-)

> An 802.15.4 PHY won't help me for 868 MHz FSK - by my reading 802.15.4
> is PSK (BPSK/OQPSK), thus incompatible with ASK/OOK and FSK/MSK.
> 
> As noted in the cover letter, Semtech chips have FSK and OOK support
> alongside LoRa modulation; so I am looking into FSK PHY support, both
> for those chips as well as for some pure FSK/OOK transceivers posted to
> linux-lpwan list (and potentially more, given time):
> https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000116.html
> https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000117.html
> https://en.opensuse.org/User:A_faerber/LoRa_interop
> 
> Therefore an FSK PHY's netlink interface will need to be able to handle
> the requirements of upper-layer protocols, such as:
> * Wireless M-Bus (which I could not yet find a suitable 868MHz hard-MAC
> for to test against, only 169MHz; Si4432 has an Application Note AN451),
> * KNX RF (which I have not come across a hard-MAC for either),
> * Sigfox downstream (cf. mm002 LoRa driver as hard-MAC; no public docs),
> * Z-Wave (not enough docs to implement much more for now), and here
> * EnOcean Radio Protocol 2.
> 
> In general I want to make sure my implementations can work with both
> soft- and hard-MAC hardware out there, as demonstrated for LoRaWAN.
> Pointing a user with hard-MAC device to a theoretical generic subsystem
> of your preference doesn't help them, nor does it help to split the
> community into separate hard-MAC vs. soft-MAC implementation camps that
> make it hard for users to switch.

agree.

> * For example, when looking for how to actually use the Pine64 Z-Wave
> adapter, back in the day I merely found an OpenHAB Raspbian(?) image
> that as an openSUSE contributor I would surely not block my board with;
> no explanations, no instructions, nothing. And when you have a pure Java
> application on the one hand and a C/Python/whatever application on the
> other, chances are that the kernel is the only common point of reuse. I
> surely mentioned that I hate any userspace applications that attempt to
> detect hardware on spidev/i2c-dev/tty without using the kernel-provided
> facilities such as DT; finally, serdev allows to move any such
> hardware-dependent tty code into the kernel - we just need to figure out
> how to best expose functionality there (and ideally grow some more
> helpers). Just note how patch 3/4 reuses the kernel's crc8
> implementation instead of re-implementing it from scratch. Similarly I'd
> love for my AT based LoRa drivers to share more serdev code, despite
> line ending and response styles differing greatly (think
> serdev_device_readline w/args?); binary protocols like ESP here are
> luckily not affected as much. It could also use some more/better
> documentation, some of the return values are wrong.
> * As another example, we seem to be lacking a generic SDR subsystem:
> People with SDR hardware seem to use either downstream kernel modules,
> possibly application-generated, or closed-source userspace libraries?
> Neither seems able to currently reuse the net subsystem for protocols.
> And yet I've been asked repeatedly to design drivers in a way they could
> be used with SDR, too, but without any way to actually test that today.
> Has anyone talked to the SDR chipset/equipment vendors to remedy that?
> The one I was in contact with simply chose not to reply again to date...
> 
> For ETH_P_ we seem to be far away from 0xffff, so I don't see a problem
> there? Not just was it the easiest thing to implement & test short-term,
> but as outlined in the cover letter I saw no way here to turn that into
> a non-net-subsystem because the data transmitted is not self-describing
> (mostly battery-less sensors/actuators with ca. 4 byte data payload).
> You must know that your device with id 0x12345678 conforms to profile X.
> 
> Is describing remote devices in DT an option? (CC'ing Rob and Jonathan)
> 
> /.../uart@foo {
> 	enocean {
> 		compatible = "enocean,esp3";
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		window-handle@41424344 {
> 			compatible = "manufacturer1,handle";
> 			reg = <0x41424344>;
> 			enocean,equipment-profile = <1 2 3>;

What are these profiles? For declaring you actually can support some
"window-handle"? Can this be changed during runtime?

Is this some kind of device class specification by EnOcean which need to
be set into their transceiver that a management layer handle it which is
running by firmware?

> 			#io-channel-cells = <1>;
> 		};
> 
> 		light-switch@41424348 {
> 			compatible = "manufacturer2,rocker";
> 			reg = <0x41424348>;
> 			enocean,equipment-profile = <4 5 6>;
> 			#io-channel-cells = <2>;
> 		};
> 	};
> };
> 
> Pro: This would allow to abstract sensors (iio?) and actuators (gpio?).
>      Cf. https://patchwork.ozlabs.org/patch/1028209/ for comparison.
> Con: How to deal with it on ACPI or on DT platforms without Overlays?
>      How would the kernel preserve remote device state across reboots?
> 
> So no, I don't think we can or should shoehorn non-802.15.4 PHYs into
> your ieee802154 PHY layer. If you see ways to share code between the
> various wireless PHYs, that would be great, but at present it seems like
> mostly boilerplate code with nothing in your phy struct applying to FSK
> or LoRa. Compare my cfglora series pointed to and Xue Liu's recent sysfs
> patch under discussion. If no more comments turn up on my cfglora series
> I'll copy it into a cfgfsk, so that I can integrate both into sx127x as
> a base for further discussions at Netdevconf. Thanks.
> 

Share code always sounds like a good idea.

Thanks.

- Alex
