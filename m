Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbeLRStK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 18 Dec 2018 13:49:10 -0500
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
Date: Tue, 18 Dec 2018 19:49:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Jiri Pirko <jiri@resnulli.us>, Ben Whitten <ben.whitten@lairdtech.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Am 18.12.18 um 15:27 schrieb Jian-Hong Pan:
>> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
>>> LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
>>>
>>> This patch implements part of Class A end-devices SoftMAC defined in
>>> LoRaWAN(TM) Specification Ver. 1.0.2:
>>> 1. End-device receive slot timing
>>> 2. Only single channel and single data rate for now
>>> 3. Unconfirmed data up/down message types
>>>
>>> On the other side, it defines the basic interface and operation
>>> functions for compatible LoRa device drivers.
>>>
>>> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
[...]
>>> net/maclorawan/Kconfig  |  14 +
>>> net/maclorawan/Makefile |   2 +
>>> net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
>>> net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 1177 insertions(+)
>>> create mode 100644 net/maclorawan/Kconfig
>>> create mode 100644 net/maclorawan/Makefile
>>> create mode 100644 net/maclorawan/mac.c
>>> create mode 100644 net/maclorawan/main.c
>>
>> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
>> you add headers for "API" and here you implement functions. That is just
>> weird. Does it mean you can have other implementations?
> 
> LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> This part is soft-MAC as Andreas mentioned
> http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html
> 
>> Also, you don't really have any user of this API in the set. Please
>> introduce at least 1 driver, preferably more (I see that Andreas has
>> multiple ones in his patchset). You cannot push kernel infrastructure
>> without kernel user.
> 
> The soft-MAC is suitable for the LoRa chips' device drivers, like
> sx1276/77/78/79, RFM95/96/97/98W ...
> Still waiting for Andreas' sx1276 version 2 patch and more discussion.

sx1276 regmap conversion was pushed to my staging tree together with
Ben's sx1301 final conversion last night, lightly tested.

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/log/?h=lora-next

TBD: rename to sx127x, implement regmap fields, only auto-detect reset
when no OF node available (all low priority atm, patches welcome)

(and for sx1301 I still need to update my DT overlays with the new clk)

> For example, how to make PF_LORA and PF_LORAWAN like Ethernet, PF_INET
> and PF_INET6 don't need separate devices either, both use eth0.
> https://lkml.org/lkml/2018/8/3/266

Jiri, I am expecting the maclorawan driver to lower packets from
ETH_P_LORAWAN to ETH_P_LORA in a generic way, so that any of the LoRa
device drivers can benefit of it, with maclorawan using the LoRa netlink
commands that the individual drivers implement.
Not sure what if anything is missing for that in the current revision?
Still dealing with the lower-level infrastructure and my test setup ...
progressing slowly.

I'll probably need to queue the remaining generic LoRaWAN part 1/6 in my
tree to resolve this circular dependency between Jian-Hong and me, so
that only the soft-MAC implementation remains a separate patch series.
The hard-MAC implementations will be on my plate mostly, as both SX1276
and SX1301 need the soft-MAC.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
