Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35686 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdIKPRT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Sep 2017 11:17:19 -0400
Received: by mail-yw0-f179.google.com with SMTP id q80so22198056ywg.2
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 08:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOHTApj2tkJ7Xju0LSYrgz_uDsR2L35j+QvXswXgnCRkdqHMKA@mail.gmail.com>
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw> <CAJuUDwtyf_TdGR34oKmLRgRU_jy+JtUSmSt1v_j20e+BwrfA7A@mail.gmail.com>
 <CAOHTApj2tkJ7Xju0LSYrgz_uDsR2L35j+QvXswXgnCRkdqHMKA@mail.gmail.com>
From: StarNight <starnight@g.ncu.edu.tw>
Date: Mon, 11 Sep 2017 23:17:14 +0800
Message-ID: <CAC=mGziO09oiNcYpYO6kHOcH_D0sypx8RvAML3OvnMUu9af+aQ@mail.gmail.com>
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, devicetree@vger.kernel.org

Hi,

2017-09-11 20:47 GMT+08:00 Alexander Aring <aring@mojatatu.com>:
> Hi,
>
> On Mon, Sep 11, 2017 at 3:50 AM, Xue Liu <liuxuenetmail@gmail.com> wrote:
>> Hello Pan,
>>
>> From my point of view, it is not a good idea to write sx127x driver
>> for IEEE 802154. Because LoRa is not compatible with IEEE 802.15.4 in
>> PHY and MAC layer.
>>
>
> This isn't true. The security layer is exactly the same and copied
> from IEEE 802.15.4.
> The rest of the mac layer is pretty simple. Simpler than IEEE
> 802.15.4... for now.

That is the first reason why I write this driver.

I also found "Transmission of IPv6 Packets over LoRaWAN" on IETF website
https://datatracker.ietf.org/doc/draft-vilajosana-lpwan-lora-hc/
However, it has been expired since 2017-01-09.
It is the second reason why I write this driver.

>> I think it is better to make individual Phy and MAC layers for LoRa in
>> Linux kernel, where a sx127x driver will make sense.
>
> What about to introduce a new interface type? Then you can do a
> complete different parsing on this interface type and share the code
> what you need from 802.15.4

So, will the suggestion be a new interface like "6LoWPAN over LoRaWAN"?

Thanks,

Jian-Hong Pan
