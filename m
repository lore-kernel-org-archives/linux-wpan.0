Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeL2G3A (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 29 Dec 2018 01:29:00 -0500
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
 <20181224153205.ycr2zdrjbyklulfh@x220t>
 <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
 <20181228154316.2x2tyfzidnb4emqo@x220t>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <5c3c9f71-73f3-6010-04c3-75ac91a35b05@suse.de>
Date: Sat, 29 Dec 2018 07:28:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181228154316.2x2tyfzidnb4emqo@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: Xue Liu <liuxuenetmail@gmail.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Stefan Schmidt <stefan@datenfreihafen.org>

Am 28.12.18 um 16:43 schrieb Alexander Aring:
> On Fri, Dec 28, 2018 at 05:57:53AM +0100, Andreas Färber wrote:
>> Am 24.12.18 um 16:32 schrieb Alexander Aring:
>>> On Tue, Dec 18, 2018 at 02:50:58PM +0100, Xue Liu wrote:
>>>> On Mon, 17 Dec 2018 at 15:19, Andreas Färber <afaerber@suse.de> wrote:
>>>>> Am 17.12.18 um 09:50 schrieb Xue Liu:
>>>>>> I have a question about the architecture of your module. AFAIK LoRaWAN
>>>>>> is already the MAC Layer above the LoRa technology. Why do you want to
>>>>>> make a new layer called "maclorawan" ?
>>>>>
>>>>> I had asked Jian-Hong to separate between his soft-MAC implementation
>>>>> and the common bits needed to drive hard-MAC implementations found on
>>>>> several of the hardware modules made available to me.
>>>>>
>>>> As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
>>>> We may also use the name “cfglora” for hard-MAC implementation.
>>>
>>> There exists also a cfg802154. :-)
>>>
>>> Note that cfg80211 is also for providing a backwardscompatibility to the
>>> wireless ioctl() interface.
>>>
>>> In theory it's simple:
>>>
>>> netlink API -> SoftMAC (macFOOBAR layer) -> cfgFOOBAR implementation -> driver layer
>>>             \-> HardMAC (driver layer) -> cfgFOOBAR implementation
>>
>> So how does cfgFOOBAR relate to nlFOOBAR now? Given that we were told to
>> use netlink and pointed to some nl802whatever, I am confused about two
>> people now calling for cfg. We have an nllora stubbed in linux-lora.git,
>> and I was expecting to see an nllorawan¹ either in this series or on
> 
> Why there is a different between two lora technologies? This sounds you
> driving into two lora subsystems without one userspace api to access them,
> this getting worse.

This had just been explained to Jiri: LoRa PHY vs. LoRaWAN MAC. Similar
splits exist for other technologies; and how the LoRaWAN soft-MAC can
reuse underlying LoRa facilities is the very subject of this sub-thread!

It entirely depends on what the user wants to do - connect to a LoRaWAN
network as client, forward LoRaWAN packets as a gateway, communicate
peer-to-peer, implement alternative MACs in userspace, ...

So if a user is working on LoRaWAN MAC layer I expect him to deal with
PF_LORAWAN and nllorawan and not need direct access to nllora, as that
would be an implementation detail specific to the soft-MAC; a hard-MAC
should not need to implement nllora, as it may not have that control.

>> top. If you're suggesting to rename them technology-neutral, then please
> 
> I am sorry, I actually meant that... People tell me that I can't explain
> things all the time.
> 
>> say so clearly - otherwise it sounds to me like you didn't actually look
>> at the staged code yet or didn't read our previous discussions and lead
>> our contributors to reinvent things we already have...
> 
> As example for 802.15.4:
> 
> nl802154 (which is one netlink interface for doesn't matter what
> kind 802.15.4 device is behind) -> callback structure of cfg802154 which
> goes to a somehow 802.15.4 device as SoftMAC layer or HardMAC driver.

Okay, I took a shortcut there for LoRa and assume we always have a LoRa
netdev (i.e., no theoretical SDR netdev), so that I could postpone
figuring out how to register extra per-netdev cfg structs for quicker
PoC of the netlink interface. :) My get_freq callback will need to be
moved out from struct lora_dev_priv (lora/netdev.h) into its own struct.

>> We really need to complete the layers from the ground up before we get
>> lost in more nice-to-have upper layers: For LoRaWAN that means we need
>> to have TX and RX working for LoRa _and_ FSK. sx1276 still has lots of
>> hardcoded stuff from my own testing that needs to hook into nllora, and
>> FSK exists only as ETH_P_FSK constant so far, with no concept for
>> switching modes yet (which as mentioned in my presentation¹ needs to go
>> via sleep mode, losing most register settings) nor any netlink support.
>> Not all drivers need to be at the same implementation level, of course,
>> but we need at least one that's far enough to validate such patches.
> 
> Your register behaviour sounds for me like a feature for regmap. Or
> either a feature to handle in your subsystem.

We don't have regmap caching enabled. sx1276 has no paging implemented,
as it's slightly more complicated than sx1301 (and the "youngest" of 3).

I assume instead of just writing from netlink/cfg callbacks to regmap
we'll need to also save the values in the driver for writing them back
after a mode switch or suspend.

However it's also a question of who initiates the mode switch and how,
presumably via netlink.

>> And seeing that I just found a major bug in sx1276 driver's TX path,
>> apparently no one apart from me is testing that driver - sx128x and
>> sx1301 were not yet complete enough to transmit, and due to the open
>> socket address/protocol discussions none can receive yet, so as Jiri
>> hinted, this LoRaWAN soft-MAC patch series can't have been
>> runtime-tested against any staged driver at all!  => [RFC lora-next v5 6/6]
> 
> aha. When I started working on ieee802154 many times I thought nobody
> had really tested it. That's somehow the process of upstream
> programming, it's growing over the time. The first implementation is
> always somehow crappy, but people working on it and get experience over
> the time, you cannot have perfect code.

This is not about iterative development, it's about discussing about a
high-level cfg interface on top of nl on top of a PHY that didn't work;
not just some optional offload feature being broken. ;) We may never
have perfect code, but we can't merge a driver that doesn't work at all,
and as long as I know it's not working sufficiently I am holding back on
sending out a v2, in favor of queuing more fixes and cleanups that'll
make it worth people's time to review.

Having the soft-MAC be further implemented and actually using the
functions it implements may avoid some of the declarations Jiri disliked
by just making them static locally where they're needed.

Earlier reviewers were already getting deep into coding style reviews,
but it seems this is not yet a "PATCH" ready for merging after all and
should therefore by its author be labeled "RFC" or at least "RFT" if it
couldn't be tested yet. If it's a "PATCH", I expect to be able to queue
it on my tree if I spot no major design problems or nits the author
could help fix upfront. Compare below.

>> Therefore I thought in our case some hard-MAC may be easier to validate
>> LoRaWAN sockets (patch 1/6), to avoid a dependency on completing the MAC
>> implementation first. For example, iM880, RF1276TS and 32001353 are pure
>> LoRaWAN modules without raw LoRa support. (Whereas many others support
>> both and I'm still looking for input on how to best deal with that -
>> currently exposing them as LoRa devices for maximal flexibility.)
> 
> So that means you ignore SoftMAC because HardMAC is easier?

No, I don't ignore it, I'm missing infrastructure to evaluate it!

As Jiri has pointed out earlier, this series is doing two things, 1)
introduce LoRaWAN sockets (that's great, needs review/discussion) and 2)
prepare a soft-MAC implementation with a number of functions that are
not yet called from anywhere. Plus the series omits to extend my
lower-level netlink interfaces and driver(s) with the facilities it'll
need to actually work. The default Sync Word on sx1276 is 0x12, for
instance.

Basically Jian-Hong and I are at odds in which direction the layers
should plug together, with me vehemently against coding LoRaWAN stuff in
LoRa drivers (layering violation!) and instead wanting that centrally in
an optional LoRaWAN soft-MAC module (=maclorawan) on top. Compare 2/6
still reading "driver should implement some of them according to the
usage" - for me that should be a cfg struct at the nllorawan layer,
which he should implement in maclorawan and I only for hard-MAC drivers,
instead of exporting an ABI that's not called by anyone and would
seemingly need to be reimplemented in each and every of my LoRa drivers!
Note that duplicate copies and forks of LoRaWAN soft-MAC userspace
implementations on GitHub were one of the reasons for me to start this
kernel project, so I really, really don't want that here. And 5/6 main.c
appears to still be based around the idea that he gets his own loraX
netdevs, seemingly conflicting by name with mine if they would actually
get created by the functions getting called anywhere...

Maybe you can now grasp my annoyance with this non-RFC v5 making only
cosmetic changes since v2? (and completely lacking any changelog in 0/6)

> We actually
> go the opposite way to say SoftMAC introduce the most infrastructure and
> then say that we will bind HardMAC to it.

The very definition of a hard-MAC is that it does not need a soft-MAC.

So that doesn't make much sense to me. The netlink interfaces for LoRa
(e.g., Join operations for authentication) will be constrained by what
ops the hard-MACs need, whereas we have much more freedoms with our own
soft-MAC. LoRaWAN provides a meta set of operations compared to LoRa+FSK
(e.g., setting the data rate on MAC layer would involve regional
awareness and translates to setting frequency+bandwidth+SF on PHY layer,
and a LoRa transmission/reception will need to set a Sync Word of 0x34);
therefore my saying that for the soft-MAC we need interfaces and
implementations on my LoRa PHY layer that are still incomplete today.

Once the PHY layer is working, the soft-MAC would just need to properly
dispatch - and ideally I would have it provide packets in an ETH_P_LORA
format, so that I don't need duplicate (ETH_P_LORA + ETH_P_LORAWAN)
implementations in each soft-MAC capable LoRa driver. Thus, if the PHY
doesn't transmit (yet), LoRaWAN can't send either.

And that brings us back to the big question circling since months of how
to design these socket layers: Currently I'm using a PF_LORA and was
hoping to extend its sock_addr to cope with the Sync Word, frequency,
etc. and set that via skb for each TX (which raised problems for RX). At
ELCE 2018 it was suggested that we should rather take the easy route of
not defining a PF_LORA and just use PF_PACKET with htons(ETH_P_LORA) and
apply every global setting via netlink; that however appears to obsolete
my lora/dgram.c code dealing with private ifindex field then, so that we
could no longer pass any LoRa-specific per-packet metadata from LoRaWAN
layer down to LoRa either. And since I'm unfamiliar with PF_PACKET, I'm
focusing on making the basics work first before diving into refactorings
that give us no functional benefits.

Anyway, I assume we'll need to translate from LoRaWAN to LoRa skbs
somewhere in this patch series to add the necessary LoRaWAN headers for
SOCK_DGRAM or SOCK_SEQPACKET packets - it's neither in 1/6 nor in 5/6.
Additionally, operations such as Join that the user would request via
netlink command will need to create LoRa skbs in the soft-MAC directly.
So in that way LoRaWAN may be comparable to Wifi connecting to an AP,
whereas LoRa is more like shoveling packets into/out an Ethernet cable.

Hope that explains better from my side as well.
Most of it had been brought up in replies to the cover letter of my
original RFC on netdev list: https://patchwork.ozlabs.org/cover/937545/

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
