Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:60935 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbAUNey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Jan 2015 08:34:54 -0500
Received: by mail-wi0-f175.google.com with SMTP id fb4so27979147wid.2
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 05:34:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFUtXGwbcBF=90bZtwJ26AWaoSoOvxnxotikjwfNcNfhAjEaOQ@mail.gmail.com>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
	<CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
	<CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
	<54bf9983.07f4440a.7103.0a2e@mx.google.com>
	<CAFUtXGx-naVAhPOM4OEQt9EoJEQ7NiiG7ni3kxd5zzsiNT52iA@mail.gmail.com>
	<54bfa40a.c51e460a.6035.ffff8290@mx.google.com>
	<CAFUtXGwbcBF=90bZtwJ26AWaoSoOvxnxotikjwfNcNfhAjEaOQ@mail.gmail.com>
Date: Wed, 21 Jan 2015 19:04:53 +0530
Message-ID: <CAAkG1NNkzvfGxE=Cx+cAuSwbQ3-JOHXGUJ2J0TazRFHaw6YuNg@mail.gmail.com>
Subject: Re: Device or resource busy
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>, linux-wpan@vger.kernel.org

Argh! My phone doesn't send plain-text emails. Re-adding linux-wpan.

I'm not sure what you mean by modified device tree. In the device
tree, all I did was add my at86rf212b module as an spi device to the
bcm2835-rpi-b-plus.dts.

-Rohit

On Wed, Jan 21, 2015 at 6:39 PM, Maciej Wasilak <wasilak@gmail.com> wrote:
> Aha - that's very similar situation. I also added u-boot and
> bluetooth-next kernel. Are you using modifed device tree?
>
> 3 months ago I used linux-wpan-next kernel also with Raspbian, and old
> userspace tools and everything worked fine.
>
> Maciek
>
> 2015-01-21 14:04 GMT+01:00 Rohit Kulkarni <rmkulkar@gmail.com>:
>> I'm using the raspbian distro that came with noobs (from sometime in
>> December) and just added u-boot and the bluetooth-next kernel.
>>
>> -Rohit
>> ________________________________
>> From: Maciej Wasilak
>> Sent: ‎21-‎01-‎2015 18:13
>> To: Rohit Kulkarni
>>
>> Subject: Re: Device or resource busy
>>
>> Hello,
>>
>> I'm also running bluetooth-next. I replaced normal 3.12 kernel in
>> Raspbian with bluetooth-next. Which distro you are using?
>>
>> Best Regards
>> Maciek
>>
>> 2015-01-21 13:18 GMT+01:00 Rohit Kulkarni <rmkulkar@gmail.com>:
>>> Hi all,
>>>
>>> I'm now on bluetooth-next and still seeing the problem. So, definitely
>>> doesn't look like a raspbian issue.
>>>
>>> -Rohit
>>> ________________________________
>>> From: Maciej Wasilak
>>> Sent: ‎21-‎01-‎2015 17:28
>>> To: Rohit Kulkarni
>>> Cc: Alexander Aring; linux-wpan@vger.kernel.org
>>> Subject: Re: Device or resource busy
>>>
>>> Hello
>>>
>>> 2015-01-21 11:30 GMT+01:00 Rohit Kulkarni <rmkulkar@gmail.com>:
>>>> I tried the "ip link set" command but the wpan interface doesn't go
>>>> down. The wpan1 device is already UP on boot and setting the channel
>>>> works fine but it fails with -EBUSY when trying to set pan_id.
>>>
>>> I wrote the previous email about that problem. I experienced same
>>> issues as Rohit. It seems that problem doesn't occur on all platforms.
>>> Two related questions:
>>>
>>> 1. Is it possible that this issue is somehow related to distro (we
>>> both use Raspbian)?
>>> 2. Is it possible that this issue is caused by improper device tree
>>> information? Maybe something changed in device tree handling in last 3
>>> months?
>>>
>>> Best Regards
>>> Maciek
