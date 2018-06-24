Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932073AbeFXPtx (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 24 Jun 2018 11:49:53 -0400
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
 <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org>
 <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <5e6b2d6a-f413-7547-6c03-c41dff21453c@suse.de>
Date: Sun, 24 Jun 2018 17:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jian-Hong Pan,

Am 13.05.2018 um 04:42 schrieb Jian-Hong Pan:
> Hi Jiri and Marcel,
> 
> 2018-05-11 23:39 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
>> Hi Jian-Hong,
>>
>>> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>>> telecommunication wide area network designed to allow long range
>>> communications at a low bit rate among things (connected objects), such
>>> as sensors operated on a battery.  It can be used widely in IoT area.
>>> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>>> access control (MAC) layer protocol for managing communication between
>>> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>>> LoRaWAN™ Specification could be downloaded at:
>>> https://lora-alliance.org/lorawan-for-developers
>>>
>>> However, LoRaWAN is not implemented in Linux kernel right now, so I am
>>> trying to develop it.  Here is my repository:
>>> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
>>>
>>> Because it is a kind of network, the ideal usage in an user space
>>> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>>> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>>> PF_LORAWAN ..., must be listed in the header files of glibc.
>>> For the driver in kernel space, the definitions also must be listed in
>>> the corresponding Linux socket header files.
>>> Especially, both are for the testing programs.
>>>
>>> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
>>> Could or should we add the definitions into corresponding kernel header
>>> files now, if LoRaWAN will be accepted as a subsystem in Linux?
>>
>> when you submit your LoRaWAN subsystem to netdev for review, include a patch that adds these new address family definitions. Just pick the next one available. There will be no pre-allocation of numbers until your work has been accepted upstream. Meaning, that the number might change if other address families get merged before yours. So you have to keep updating. glibc will eventually follow the number assigned by the kernel.
> 
> Thanks for your guidance.  I will follow the steps.

I have been working on a similar thing on and off since proposing it at
FOSDEM 2017:

At https://github.com/afaerber/lora-modules you will find my proof of
concept of PF_LORA with SOCK_DGRAM and stub drivers for various modules.
My idea was to layer LoRaWAN on top of LoRa later.

The way I have developed this was to simply reuse numbers unused in our
distro kernel and built my modules against the distro kernel, to avoid
frequent reboots and full kernel builds.

Not having looked at your code yet, do you think our implementations are
fairly independent at this point, or do you see conflicts apart from
number allocation? Like, I am currently using lora0 as name - are you
planning to use lorawan0 or rather something more generic like lpwan0?
We might place your code in net/lora/lorawan/ and mine in net/lora/?

More problematic would be the actual device drivers, where some devices
would support both modes - some with soft MAC, others with full MAC. Do
you have any ideas how to handle that in a sane way?

Please keep me CC'ed on any follow-ups.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
