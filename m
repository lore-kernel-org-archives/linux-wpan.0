Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35868 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935918AbdIZMee (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2017 08:34:34 -0400
Received: by mail-vk0-f68.google.com with SMTP id w23so2700022vkw.3
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2017 05:34:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bb72c12e-1072-9bfd-f76b-0b454bdf6da4@osg.samsung.com>
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw> <fda61128-d27a-8b08-5a31-97e8a57677fe@osg.samsung.com>
 <CAC=mGzja5h1xq66au-CX92oARptFaFGjZcOH5KU0oujBfH4vvw@mail.gmail.com>
 <d463f3a2-e12b-a708-1ade-e9309fa068fa@osg.samsung.com> <CAC=mGzi+wD-Fob6NMviZyZHGpekhAGvuXjB45P71zL6cc2+88g@mail.gmail.com>
 <bb72c12e-1072-9bfd-f76b-0b454bdf6da4@osg.samsung.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Tue, 26 Sep 2017 08:34:33 -0400
Message-ID: <CAOHTApiYtfRaOrsxHMZzZXhsjMDpm3-Nz7o+RD2x7QJfPNTSQQ@mail.gmail.com>
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: StarNight <starnight@g.ncu.edu.tw>, Alexander Aring <alex.aring@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Xue Liu <liuxuenetmail@gmail.com>

Hi,

On Tue, Sep 26, 2017 at 6:16 AM, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> Hello.
>
> [I dropped the device tree list as this is really unrelated to them now]
>
> On 09/24/2017 04:53 PM, StarNight wrote:
>> Hi,
>>
>> I have written a note which is reordered and extracted from LoRaWAN 1.0.2.
>> https://hackmd.io/s/S1kg6Ymo-#
>> Hope this wiil be easier for readers.
>>
>> LoRaWAN defiened by LoRa Alliance is the MAC layer over LoRa PHY.
>> (The relation between LoRaWAN and LoRa PHY)
>
> Thanks a lot for putting thee notes together.
>
> Reading the MAC frame format I see not much in common with IEEE 802.15.4.
> Maybe they really refer to the link layer security parts only.
>
> Given that your driver operates in LoRa and thus will not work with any
> other 802.15.4 device I would not apply it to the ieee802154 subsystem.
>
> The driver is a good start for real LoRa support in the Linux kernel thought.
> I would very much welcome such support and would also be happy to help.
> (Not before November though as my next weeks will be to busy)
>
> Xue (in CC now) also has an interest in LoRa support in the Linux Kernel and
> already started some work if I remember correctly. If you both are interested
> to actively contribute to such a subsystem I would be happy to help getting
> it into the mainline kernel.
>

For security stuff this should be shared between these subsystems
then... Don't know how currently - we need to look.

The only possibility how to put lora in _softmac_ 802.15.4 is for me
to introduce new "lora_register_hw" function who registered a special
"lora" interface type (like node in 802.15.4) and use some of
ieee802154 infrastructure and of course a lora.c which do some frame
parsing on upper layer...

Upper layers need to be some "net/lora" then...

Just an idea how I can imagine how it _could_ work... to put lora in
SoftMAC here.

- Alex
