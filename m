Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:42974 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934081AbeBUPqn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Feb 2018 10:46:43 -0500
Received: by mail-io0-f174.google.com with SMTP id u84so2571637iod.9
        for <linux-wpan@vger.kernel.org>; Wed, 21 Feb 2018 07:46:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1dd13aca-fc2d-82fb-821e-3b1994f26930@osg.samsung.com>
References: <20180218230316.GA8719@picapica.im> <1dd13aca-fc2d-82fb-821e-3b1994f26930@osg.samsung.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 21 Feb 2018 10:46:41 -0500
Message-ID: <CAB_54W6KG-np16p6v1-jbmjFZMRP60i3pzpkwexNr_1OBr6bLw@mail.gmail.com>
Subject: Re: [PATCH] website: Add troubleshooting section in how-tos
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: anton@picapica.im, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-21 9:08 GMT-05:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
>
> On 02/19/2018 12:03 AM, anton@picapica.im wrote:
>> Some hints about issues related to SPI bus.
>>
>> Signed-off-by: Anton Sviridenko <anton@picapica.im>
>> ---
>>  website/index.txt | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/website/index.txt b/website/index.txt
>> index 9fd149e..6d9fe88 100644
>> --- a/website/index.txt
>> +++ b/website/index.txt
>> @@ -135,6 +135,21 @@ ip netns exec wpan0 ping6 ff02::1%lowpan0
>>  Now watch wireshark and all the nice ICMP packets there.
>>
>>
>> +Troubleshooting
>> +~~~~~~~~~~~~~~~
>> +If you have issues with transceiver connected to SPI bus, check first
>> +if wiring is correct and SPI controller is properly configured. Try to
>> +decrease SPI clock frequency. Messages like these ones in dmesg output
>> +could indicate problems with SPI connection:
>> +
>> +---------------------------------------------------------------------
>> +at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state:
>> +0x01
>> +WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
>> +received tx trac status 4
>> +---------------------------------------------------------------------
>> +
>> +
>>  Sniffing
>>  ~~~~~~~~
>>
>
> Thanks for the patch I applied and pushed it to the repo now.
> While doing this I toke the freedom to replace your email with name and email in the from line to ahve your name show up correctly in git.
>
> Alex, could you re-generate the website to get this included?
>

Can I do that at weekend? I need to search my login data again. :-)

Also I will prepare patches to add some license to the website. I just
want to put it in some license which makes clear "you can share/modify
etc. what you want without warranty foo" Creative Commons is enough
for me..., but I am not a expert into that... just want to make it
clear: you can do what you want and if you submit patches you are
under this license.

What I don't want is to mention authors etc, that's too much and I
really don't care about that.

Everybody agrees to put it into some license? What I found in the
internet is [0], but so far I know CC has some subtypes which depends
exactly of mention author or not...

- Alex

[0] https://creativecommons.org/choose/results-one?license_code=by&amp;jurisdiction=&amp;version=4.0&amp;lang=en
