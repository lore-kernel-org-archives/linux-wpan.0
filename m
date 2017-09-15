Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50435
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdIOMRn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Sep 2017 08:17:43 -0400
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw>
 <CAJuUDwtyf_TdGR34oKmLRgRU_jy+JtUSmSt1v_j20e+BwrfA7A@mail.gmail.com>
 <CAOHTApj2tkJ7Xju0LSYrgz_uDsR2L35j+QvXswXgnCRkdqHMKA@mail.gmail.com>
 <CAC=mGziO09oiNcYpYO6kHOcH_D0sypx8RvAML3OvnMUu9af+aQ@mail.gmail.com>
 <CAOHTApizcu5k572sik_Pp9XBOutLb24ZZZfqvr9x1DOdBB5rBA@mail.gmail.com>
 <CAC=mGzg99eG4TBrRdHQMfof2_bE2tbVL-5QX6ny7L_Y4kmv00g@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <6f5281ff-6e37-9703-ef48-b90f5bba47ae@osg.samsung.com>
Date: Fri, 15 Sep 2017 14:17:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAC=mGzg99eG4TBrRdHQMfof2_bE2tbVL-5QX6ny7L_Y4kmv00g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: StarNight <starnight@g.ncu.edu.tw>, Alexander Aring <aring@mojatatu.com>
Cc: Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.

[trimmed the CC list as this goes away from patch review to conceptual 
questions for LoRa integration with 802.15.4 in the kernel]

Jian-Hong, first of all thank you for doing this working and submitting 
your driver for mainline inclusion. We will find a place for it. If it 
will be in ieee802154 or a derived subsystem to handle LoRa support will 
be seen. :)

See my thoughts below on this topic.

On 09/12/2017 06:49 PM, StarNight wrote:
> Hi,
> 
> 2017-09-12 5:13 GMT+08:00 Alexander Aring <aring@mojatatu.com>:
>> Hi,
>>
>> On Mon, Sep 11, 2017 at 11:17 AM, StarNight <starnight@g.ncu.edu.tw> wrote:
>>> Hi,
>>>
>>> 2017-09-11 20:47 GMT+08:00 Alexander Aring <aring@mojatatu.com>:
>>>> Hi,
>>>>
>>>> On Mon, Sep 11, 2017 at 3:50 AM, Xue Liu <liuxuenetmail@gmail.com> wrote:
>>>>> Hello Pan,
>>>>>
>>>>>  From my point of view, it is not a good idea to write sx127x driver
>>>>> for IEEE 802154. Because LoRa is not compatible with IEEE 802.15.4 in
>>>>> PHY and MAC layer.
>>>>>
>>>>
>>>> This isn't true. The security layer is exactly the same and copied
>>>> from IEEE 802.15.4.
>>>> The rest of the mac layer is pretty simple. Simpler than IEEE
>>>> 802.15.4... for now.
>>>
>>> That is the first reason why I write this driver.
>>>
>>> I also found "Transmission of IPv6 Packets over LoRaWAN" on IETF website
>>> https://datatracker.ietf.org/doc/draft-vilajosana-lpwan-lora-hc/
>>> However, it has been expired since 2017-01-09.
>>> It is the second reason why I write this driver.
>>>
>>>>> I think it is better to make individual Phy and MAC layers for LoRa in
>>>>> Linux kernel, where a sx127x driver will make sense.
>>>>
>>>> What about to introduce a new interface type? Then you can do a
>>>> complete different parsing on this interface type and share the code
>>>> what you need from 802.15.4
>>>
>>> So, will the suggestion be a new interface like "6LoWPAN over LoRaWAN"?
>>>
>>
>> You mixing L2 and 6LoWPAN here. L2 layer is 802.15.4, there we have
>> the device nodes "node", "monitor" and "coordinator" (not implemented
>> yet).
>> My idea is to add a Lora L2 interface type there and then you can
>> catch frames and make a "lora.c" file in net/mac802154 for lora frame
>> handling. If you need 802.15.4 stuff just use it then. This makes
>> sense, because Lora use some 802.15.4 stuff which is mostly the same.
> 
> I have found this slide:
> LoRaWAN specification developments     by Nicolas Sornin
> https://www.ietf.org/mail-archive/web/lp-wan/current/pdfbVG486gGVD.pdf
> In the page 5:
> LoRaWAN1.0
> Close ALIGNMENT WITH IEEE 802.15.4 in order to preserve higher layers
> 
> Maybe, I can make a comparison list of IEEE 802.15.4 and LoRaWAN.

This would be very much appreciated. First we really need to understand 
the relationship between LoRa and 802.15.4 here.

The core parts that we all need to understand first are in my opinion:

1) Clean terminology. What do LoRa, LoRaMAC and LoRAWAN stand for? At 
what part the 15.4 compat comes into play? I need to find myself some 
time to read the LoRa spec to understand this better.

2) Is there a mode where a LoRa phy would be run under a standard 
802.15.4(g) MAC as we have right now? If such a mode exists we should 
have support for such transceivers being hooked up with mac802154.

3) If their use of the IEEE802.15.4 MAC is identical in some cases and 
different in others we need to have a full list of these to see if we 
can rework mac802154 to be shared between a ieee802154 and LoRa 
subsystem in this case.

Once these three are clear the rest will most likely be implementation 
details which can be resolved while working on the code.

If you could help in finding out the answers here that would be great 
and helps us forward for getting LoRa support into the mainline kernel.

regards
Stefan Schmidt
