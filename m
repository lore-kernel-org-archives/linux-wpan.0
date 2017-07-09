Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from postout1.mail.lrz.de ([129.187.255.137]:47956 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdGIQW3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Jul 2017 12:22:29 -0400
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega>
 <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega>
From: Balz <s.balz@hm.edu>
Message-ID: <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
Date: Sun, 9 Jul 2017 18:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170708181410.64zhqqyfvgp22b6c@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,
I do not use the SPIDEV fragment, so I've deleted it out of the Overlay.
The data sheet of the ATREB233 says that the SPI cut get up to 7.5 MHZ 
but decreasing it does have no positive effects.
My SPI Configuration is specified for the BBB.

I do think that released the RX_Save_MODE means, that the frame buffer 
is not any more protected, so that the hardware can override the 
FrameBuffer.
I've checked the value of register 0x0c periodically but it does not 
change its value while operating.  But i have no idea how to make the 
regmap volatile.

Best Regards
Sebastian Balz


Am 08.07.2017 um 20:14 schrieb Alexander Aring:
> Hi,
>
> On Sat, Jul 08, 2017 at 08:11:13PM +0200, Alexander Aring wrote:
>> Hi,
>>
>> On Sat, Jul 08, 2017 at 08:06:48PM +0200, Alexander Aring wrote:
>> ...
>>>> The Registers a configured as:
>>>>
>>>> cat /sys/kernel/debug/regmap/spi1.0/registers
>>>>
>>>> 01: 16
>>>> 02: 16
>>>> 03: 00
>>>> 04: 20
>>>> 05: 00
>>>> 06: 20
>>>> 07: ff
>>>> 08: 1a
>>>> 09: 00
>>>> 0a: 00
>>>> 0b: 00
>>>> 0c: a0
>>> RX_SAFE_MODE is 1 here, good.
>>>
>> It could be that I misunderstood the datasheet, and the RX_SAFE_MODE is
>> "released" on loosing CS. Which means we need to reenable the bit after
>> each received frame.
>>
>> maybe you could check that? :-/
>>
> one small note here, for that you need to make the register for
> RX_SAFE_MODE volatile - don't trust regmap for now, because it's using
> shadow register - with volatile it will not use shadow registering!
>
> - Alex

