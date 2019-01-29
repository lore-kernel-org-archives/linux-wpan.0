Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfA2P0J (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 29 Jan 2019 10:26:09 -0500
Subject: Re: [PATCH 1/1] net: lora: add sysfs entry for LoRa system
References: <20190128220930.23366-1-liuxuenetmail@gmail.com>
 <20190128220930.23366-2-liuxuenetmail@gmail.com>
 <43477075-3df1-0437-dc57-51715271a323@suse.de>
 <CAJuUDws-Ob_W4U83jnR3hH0Q=R45qRAQbyht11EbbPfL5CrD3A@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <e81ff92f-1093-557d-e780-0541410696b3@suse.de>
Date: Tue, 29 Jan 2019 16:26:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDws-Ob_W4U83jnR3hH0Q=R45qRAQbyht11EbbPfL5CrD3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-lpwan@lists.infradead.org, linux-wpan - ML <linux-wpan@vger.kernel.org>, Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@datenfreihafen.org>

Hello,

Am 29.01.19 um 13:58 schrieb Xue Liu:
> On Tue, 29 Jan 2019 at 06:53, Andreas Färber <afaerber@suse.de> wrote:
>> Am 28.01.19 um 23:09 schrieb Xue Liu:
>>> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
>>> ---
>>>  net/lora/Makefile |  1 +
>>>  net/lora/cfg.c    | 45 +++++++++++++++++++++++++++-
>>>  net/lora/cfg.h    |  4 +++
>>>  net/lora/sysfs.c  | 76 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  net/lora/sysfs.h  | 10 +++++++
>>>  5 files changed, 135 insertions(+), 1 deletion(-)
>>>  create mode 100644 net/lora/sysfs.c
>>>  create mode 100644 net/lora/sysfs.h
[...]
>> Please don't copy code from 802.15.4 (including its "ugh" comments!) to
>> lora, I tried to do a minimal sane implementation here. Why does it need
>> to be a device?
> which device do you mean ? struct device ?

Yes, you're doing a device_initialize() and lora_class dance there,
without mentioning it in your commit message or cover letter!

>> I also didn't understand why a single 802.15.4 PHY would
>> be associated with multiple net_devices; when we don't allow that here,
> AFAIK net_deivce (wpan_dev) is acting as a virtual interface.
> Multi interfaces can share a single PHY. The advantage is that you can use
> only one PHY to simulate many virtual devices with different parameters,
> e.g. address. Not only 802.15.4 but also 802.11 are using this strategy.

We don't have any address at the PHY layer, neither for LoRa nor FSK.
The only things we have at the PHY layer are freq/SF/bw and Sync Word.
And I have not found any LoRa or FSK PHY so far that could listen to
multiple Sync Words in parallel. Therefore it'll need to be configured
via netlink for the one PHY, with no obvious use case for multiple
net_devices.

>> that also simplifies our reference counting, as it is then bound to the
>> lifetime of the parent device.
>>
>> Note also how I added a net_device pointer to the phy, whereas 802.15.4
>> has a pointer in net_device (which would rule out me testing this on our
>> distro kernels).
>>
> I did not touch net_device.
>> In case of SX1276 our sx127x SPI driver would have three different PHYs.
>> Still not sure whether we would want ten PHYs for SX1301 or just two -
>> the former would rule out going by ifindex and require a netlink
>> interface to enumerate PHYs to obtain an identifier for reference,
>> unless we restart the old "joke" of how many netdevs we need for sx130x.
>>
> Why do you want three different PHYs ?. Can SX1276 working in three
> different channel at the same time ? I think multiple PHYs for one chip is
> reasonable for the chip which can transmitting and receiving packets from
> different channels at the same time, such as SX1301 and MCR20A.

It's not about different channels, it's about different modulation modes
and therefore different configuration and driver frameworks. Just like a
Wifi driver won't use the ieee802154 or whatever other PHY struct.

We can't tie FSK into a LoRa PHY, as I have demonstrated with nrf24l01p
and si443x drivers that there are FSK transceivers unrelated to LoRa. So
we'll end up with drivers/net/lora/ using LoRa, FSK and ASK/OOK PHYs,
drivers/fsk/ using FSK and ASK/OOK PHYs. Plus LoRaWAN MAC layer. Yes,
it's a mess, and it gets worse if you consider modules with BLE/Sigfox
in addition. I see no sane way to use mfd framework there.

My original LoRa RFC received zero feedback on this topic so far, so I
am planning for a single lora0 net_device with three alternative PHYs,
switched via netlink or something; the alternative would've been three
net_devices with one PHY each, of which only one can be up at a time.

Hoping we can discuss that at Netdevconf 0x13 in Stefan's IoT workshop.

>> Finally, why do we need a sysfs entry when we already have netlink? Not
>> saying we can't have sysfs, you just haven't explained your motivation.
>> Reasons (benefits) convince me more than precedence.
>>
> Not every programing language has support for netlink, such as Bash.
> A good example is the script used in OpenWRT[1].
[...]
> [1] https://github.com/openwrt/openwrt/blob/master/package/kernel/mac80211/files/lib/wifi/mac80211.sh

Exposing something in sysfs could also be done via the main driver
though, like I've done for debugfs in sx127x driver.

What's your use case of using a bash script with the LoRa PHY? I'm not
convinced that OpenWRT scripts are the best design example here...

As long as a struct is internal to our drivers, we can refactor it as
much as we want. Once we expose things to userspace like you do here,
changes become much more problematic. Therefore it needs to be a
conscious decision and not hidden in a larger patch.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
