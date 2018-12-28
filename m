Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbeL1E57 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 27 Dec 2018 23:57:59 -0500
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
 <20181224153205.ycr2zdrjbyklulfh@x220t>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
Date: Fri, 28 Dec 2018 05:57:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181224153205.ycr2zdrjbyklulfh@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>

Hi Alexander and Xue Liu,

Am 24.12.18 um 16:32 schrieb Alexander Aring:
> On Tue, Dec 18, 2018 at 02:50:58PM +0100, Xue Liu wrote:
>> On Mon, 17 Dec 2018 at 15:19, Andreas Färber <afaerber@suse.de> wrote:
>>> Am 17.12.18 um 09:50 schrieb Xue Liu:
>>>> I have a question about the architecture of your module. AFAIK LoRaWAN
>>>> is already the MAC Layer above the LoRa technology. Why do you want to
>>>> make a new layer called "maclorawan" ?
>>>
>>> I had asked Jian-Hong to separate between his soft-MAC implementation
>>> and the common bits needed to drive hard-MAC implementations found on
>>> several of the hardware modules made available to me.
>>>
>> As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
>> We may also use the name “cfglora” for hard-MAC implementation.
> 
> There exists also a cfg802154. :-)
> 
> Note that cfg80211 is also for providing a backwardscompatibility to the
> wireless ioctl() interface.
> 
> In theory it's simple:
> 
> netlink API -> SoftMAC (macFOOBAR layer) -> cfgFOOBAR implementation -> driver layer
>             \-> HardMAC (driver layer) -> cfgFOOBAR implementation

So how does cfgFOOBAR relate to nlFOOBAR now? Given that we were told to
use netlink and pointed to some nl802whatever, I am confused about two
people now calling for cfg. We have an nllora stubbed in linux-lora.git,
and I was expecting to see an nllorawan¹ either in this series or on
top. If you're suggesting to rename them technology-neutral, then please
say so clearly - otherwise it sounds to me like you didn't actually look
at the staged code yet or didn't read our previous discussions and lead
our contributors to reinvent things we already have...

We really need to complete the layers from the ground up before we get
lost in more nice-to-have upper layers: For LoRaWAN that means we need
to have TX and RX working for LoRa _and_ FSK. sx1276 still has lots of
hardcoded stuff from my own testing that needs to hook into nllora, and
FSK exists only as ETH_P_FSK constant so far, with no concept for
switching modes yet (which as mentioned in my presentation¹ needs to go
via sleep mode, losing most register settings) nor any netlink support.
Not all drivers need to be at the same implementation level, of course,
but we need at least one that's far enough to validate such patches.

And seeing that I just found a major bug in sx1276 driver's TX path,
apparently no one apart from me is testing that driver - sx128x and
sx1301 were not yet complete enough to transmit, and due to the open
socket address/protocol discussions none can receive yet, so as Jiri
hinted, this LoRaWAN soft-MAC patch series can't have been
runtime-tested against any staged driver at all!  => [RFC lora-next v5 6/6]

Therefore I thought in our case some hard-MAC may be easier to validate
LoRaWAN sockets (patch 1/6), to avoid a dependency on completing the MAC
implementation first. For example, iM880, RF1276TS and 32001353 are pure
LoRaWAN modules without raw LoRa support. (Whereas many others support
both and I'm still looking for input on how to best deal with that -
currently exposing them as LoRa devices for maximal flexibility.)

Regards,
Andreas

¹
https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf
https://www.youtube.com/watch?v=Jjel65sZO9M

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
