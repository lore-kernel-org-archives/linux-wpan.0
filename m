Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:32831 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEMCmZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 12 May 2018 22:42:25 -0400
Received: by mail-ot0-f179.google.com with SMTP id l22-v6so10608681otj.0
        for <linux-wpan@vger.kernel.org>; Sat, 12 May 2018 19:42:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
 <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sun, 13 May 2018 10:42:23 +0800
Message-ID: <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri and Marcel,

2018-05-11 23:39 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Jian-Hong,
>
>> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>> telecommunication wide area network designed to allow long range
>> communications at a low bit rate among things (connected objects), such
>> as sensors operated on a battery.  It can be used widely in IoT area.
>> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>> access control (MAC) layer protocol for managing communication between
>> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>> LoRaWAN=E2=84=A2 Specification could be downloaded at:
>> https://lora-alliance.org/lorawan-for-developers
>>
>> However, LoRaWAN is not implemented in Linux kernel right now, so I am
>> trying to develop it.  Here is my repository:
>> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
>>
>> Because it is a kind of network, the ideal usage in an user space
>> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>> PF_LORAWAN ..., must be listed in the header files of glibc.
>> For the driver in kernel space, the definitions also must be listed in
>> the corresponding Linux socket header files.
>> Especially, both are for the testing programs.
>>
>> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
>> Could or should we add the definitions into corresponding kernel header
>> files now, if LoRaWAN will be accepted as a subsystem in Linux?
>
> when you submit your LoRaWAN subsystem to netdev for review, include a pa=
tch that adds these new address family definitions. Just pick the next one =
available. There will be no pre-allocation of numbers until your work has b=
een accepted upstream. Meaning, that the number might change if other addre=
ss families get merged before yours. So you have to keep updating. glibc wi=
ll eventually follow the number assigned by the kernel.

Thanks for your guidance.  I will follow the steps.

Thanks a lot,

Jian-Hong Pan

> Regards
>
> Marcel
>
