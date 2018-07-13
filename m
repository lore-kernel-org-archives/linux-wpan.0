Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56272 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeGMP7F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Jul 2018 11:59:05 -0400
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
 <CAJiuCceN4uW1zOEwqNXFHgNn=HTHLT3Fy=bv78_dqw8LvRbpMQ@mail.gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <858d58d5-be9c-179e-c74c-3b47dee44993@datenfreihafen.org>
Date: Fri, 13 Jul 2018 11:43:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAJiuCceN4uW1zOEwqNXFHgNn=HTHLT3Fy=bv78_dqw8LvRbpMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Romuald Cari <romuald.cari@devialet.com>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>

Hello.

On 10.07.2018 11:13, Clément Péron wrote:
> Hi Alexander, Stefan,
> 
> Thanks for your feedbacks,
> 
> On Mon, 9 Jul 2018 at 10:49, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
>> Hello Clement.
>>
>> Finally coming to review the patch. Sorry for the delay.
>>
>> On 07.06.2018 16:08, Clément Péron wrote:
>>> From: Romuald CARI <romuald.cari@devialet.com>
>>>
>>> The Link Quality Indication data exposed by drivers could not be accessed from
>>> userspace. Since this data is per-datagram received, it makes sense to make it
>>> available to userspace application through the ancillary data mechanism in
>>> recvmsg rather than through ioctls. This can be activated using the socket
>>> option WPAN_WANTLQI under SOL_IEEE802154 protocol.
>>
>> I can see that it makes the application life a lot easier to have data
>> send out and LQI value synced up by using the socket approach instead of
>> dealing with socket and ioctl's. I am good with this patch in general.
>>
>> So you have some public code that uses this approach? I would be
>> interesting in the userspace part of yours. A demo would be fine. If the
>> network handling part of your application is public anyway that would be
>> even better. :-)
> 
> I'm sorry but the userspace code that use this isn't open.

Fair enough.

> I will check if I can share this part.
> Just the idea is to compute an average LQI and when it reach a
> threshold we allow the remote to control the device.

Yes, I would be happy with a simple example just showing how to use the
socket opt and a very basic algo on how this LQI would be used.

regards
Stefan Schmidt
