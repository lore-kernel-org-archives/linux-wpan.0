Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:39965 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeFZQCm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Jun 2018 12:02:42 -0400
Received: by mail-ot0-f178.google.com with SMTP id f17-v6so3018405otl.7
        for <linux-wpan@vger.kernel.org>; Tue, 26 Jun 2018 09:02:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e6b2d6a-f413-7547-6c03-c41dff21453c@suse.de>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
 <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org> <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
 <5e6b2d6a-f413-7547-6c03-c41dff21453c@suse.de>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Wed, 27 Jun 2018 00:02:38 +0800
Message-ID: <CAC=mGzhs-YVDWePHKJcJt7Ea8ercVjGc-ZUzY4C=VkRS-4xEHw@mail.gmail.com>
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andreas,

2018-06-24 23:49 GMT+08:00 Andreas F=C3=A4rber <afaerber@suse.de>:
> Hi Jian-Hong Pan,
>
> Am 13.05.2018 um 04:42 schrieb Jian-Hong Pan:
>> Hi Jiri and Marcel,
>>
>> 2018-05-11 23:39 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
>>> Hi Jian-Hong,
>>>
>>>> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>>>> telecommunication wide area network designed to allow long range
>>>> communications at a low bit rate among things (connected objects), suc=
h
>>>> as sensors operated on a battery.  It can be used widely in IoT area.
>>>> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>>>> access control (MAC) layer protocol for managing communication between
>>>> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>>>> LoRaWAN=E2=84=A2 Specification could be downloaded at:
>>>> https://lora-alliance.org/lorawan-for-developers
>>>>
>>>> However, LoRaWAN is not implemented in Linux kernel right now, so I am
>>>> trying to develop it.  Here is my repository:
>>>> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
>>>>
>>>> Because it is a kind of network, the ideal usage in an user space
>>>> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>>>> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>>>> PF_LORAWAN ..., must be listed in the header files of glibc.
>>>> For the driver in kernel space, the definitions also must be listed in
>>>> the corresponding Linux socket header files.
>>>> Especially, both are for the testing programs.
>>>>
>>>> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now"=
.
>>>> Could or should we add the definitions into corresponding kernel heade=
r
>>>> files now, if LoRaWAN will be accepted as a subsystem in Linux?
>>>
>>> when you submit your LoRaWAN subsystem to netdev for review, include a =
patch that adds these new address family definitions. Just pick the next on=
e available. There will be no pre-allocation of numbers until your work has=
 been accepted upstream. Meaning, that the number might change if other add=
ress families get merged before yours. So you have to keep updating. glibc =
will eventually follow the number assigned by the kernel.
>>
>> Thanks for your guidance.  I will follow the steps.
>
> I have been working on a similar thing on and off since proposing it at
> FOSDEM 2017:

Wow!  Great!  I get new friends :)

> At https://github.com/afaerber/lora-modules you will find my proof of
> concept of PF_LORA with SOCK_DGRAM and stub drivers for various modules.
> My idea was to layer LoRaWAN on top of LoRa later.

We have the same idea here.

> The way I have developed this was to simply reuse numbers unused in our
> distro kernel and built my modules against the distro kernel, to avoid
> frequent reboots and full kernel builds.

I use the the AF_MAX number as AF_LORAWAN and the new AF_MAX will be
the old AF_MAX + 1
And so on ...

> Not having looked at your code yet, do you think our implementations are
> fairly independent at this point, or do you see conflicts apart from
> number allocation? Like, I am currently using lora0 as name - are you
> planning to use lorawan0 or rather something more generic like lpwan0?

The interface name I created is loraX, X will be 0, 1, 2 ...

4: lora0: <NOARP,UP,LOWER_UP> mtu 20 qdisc noqueue state UNKNOWN group
default qlen 1000
    link/[830] 01:02:03:04 brd ff:ff:ff:ff

> We might place your code in net/lora/lorawan/ and mine in net/lora/?

My implementation is:
LoRaWAN class module: net/lorawan/
LoRa device drivers: drivers/net/lorawan/sx127X ...

> More problematic would be the actual device drivers, where some devices
> would support both modes - some with soft MAC, others with full MAC. Do
> you have any ideas how to handle that in a sane way?

Let me guess!  You have the LoRa "chips" and "modules", am I correct?

If I am right, here is my opinion:
Most of the LoRa chips go with the SPI interface.  These are okay.

However, the LoRa modules go with their own protocols (like AT
commands) over the serial port.
The modules also are the combination of an MCU and a LoRa chip. Users
can flash the firmware of the MCU on their own directly.  I prefer having u=
ser
space applications deal with these modules, until there is a formal spec fo=
r
these kind of modules.

Regards,
Jian-Hong Pan

> Please keep me CC'ed on any follow-ups.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
