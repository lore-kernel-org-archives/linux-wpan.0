Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:61764 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeBUQOO (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 11:14:14 -0500
Subject: Re: [PATCH] website: Add troubleshooting section in how-tos
References: <20180218230316.GA8719@picapica.im>
 <1dd13aca-fc2d-82fb-821e-3b1994f26930@osg.samsung.com>
 <CAB_54W6KG-np16p6v1-jbmjFZMRP60i3pzpkwexNr_1OBr6bLw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <ed00a201-dee8-0636-da03-8892c340e7cd@osg.samsung.com>
Date: Wed, 21 Feb 2018 17:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAB_54W6KG-np16p6v1-jbmjFZMRP60i3pzpkwexNr_1OBr6bLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: anton@picapica.im, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.


On 02/21/2018 04:46 PM, Alexander Aring wrote:
> Hi,
>
> 2018-02-21 9:08 GMT-05:00 Stefan Schmidt <stefan@osg.samsung.com>:
>> Hello.
>>
>>
>> On 02/19/2018 12:03 AM, anton@picapica.im wrote:
>>> Some hints about issues related to SPI bus.
>>>
>>> Signed-off-by: Anton Sviridenko <anton@picapica.im>
>>> ---
>>>  website/index.txt | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/website/index.txt b/website/index.txt
>>> index 9fd149e..6d9fe88 100644
>>> --- a/website/index.txt
>>> +++ b/website/index.txt
>>> @@ -135,6 +135,21 @@ ip netns exec wpan0 ping6 ff02::1%lowpan0
>>>  Now watch wireshark and all the nice ICMP packets there.
>>>
>>>
>>> +Troubleshooting
>>> +~~~~~~~~~~~~~~~
>>> +If you have issues with transceiver connected to SPI bus, check first
>>> +if wiring is correct and SPI controller is properly configured. Try to
>>> +decrease SPI clock frequency. Messages like these ones in dmesg output
>>> +could indicate problems with SPI connection:
>>> +
>>> +---------------------------------------------------------------------
>>> +at86rf230 spi32765.0: unexcept state change from 0x01 to 0x08. Actual state:
>>> +0x01
>>> +WARNING: CPU: 0 PID: 61 at drivers/net/ieee802154/at86rf230.c:696 0xc0442644
>>> +received tx trac status 4
>>> +---------------------------------------------------------------------
>>> +
>>> +
>>>  Sniffing
>>>  ~~~~~~~~
>>>
>> Thanks for the patch I applied and pushed it to the repo now.
>> While doing this I toke the freedom to replace your email with name and email in the from line to ahve your name show up correctly in git.
>>
>> Alex, could you re-generate the website to get this included?
>>
> Can I do that at weekend? I need to search my login data again. :-)

Sure, no rush. Just make yourself a note to to remember it :)

>
> Also I will prepare patches to add some license to the website. I just
> want to put it in some license which makes clear "you can share/modify
> etc. what you want without warranty foo" Creative Commons is enough
> for me..., but I am not a expert into that... just want to make it
> clear: you can do what you want and if you submit patches you are
> under this license.
>
> What I don't want is to mention authors etc, that's too much and I
> really don't care about that.
>

It sounds what you are thinking about is Creative commons share alike (sa)
https://creativecommons.org/share-your-work/licensing-types-examples/

A word on the website though. My feeling is that this is not working to well for us. You are the only one having access and being able to
update the site.

That is already the reason why I moved the wpan-tools release tarballs to github.

Maybe it is time think about moving it somewhere where we both (and maybe others in the future) can access it easily?
I was thinking about using github pages for it as we already use the github account for our userspace tools.
I also reserved linux-wpan.org top be used as the primary URL for the project home page. I just never came to getting it all put together to
show you.

That is unrelated to get this patch updated to the web site and also a license selected. Just wanted to mention my plan here.

regards
Stefan Schmidt
