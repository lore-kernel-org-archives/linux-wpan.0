Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34545 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755681AbcK3KuO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 05:50:14 -0500
Received: by mail-io0-f179.google.com with SMTP id c21so323170001ioj.1
        for <linux-wpan@vger.kernel.org>; Wed, 30 Nov 2016 02:50:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <967ea223-c8b1-bd2b-f5e4-bd842eeca9d5@osg.samsung.com>
References: <CAJuUDwsJvZ0gjcSP02vjAkR4PX6BQq=jTEtMoHtcXheY1kvS7Q@mail.gmail.com>
 <f4f8a2d3-5233-0ccf-5808-02126cf9d514@osg.samsung.com> <CAJuUDwsU1wb+XXEgrN8abeQNWwzV_kcFU9ch2VT9fdxRpps_Kw@mail.gmail.com>
 <967ea223-c8b1-bd2b-f5e4-bd842eeca9d5@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Wed, 30 Nov 2016 11:50:12 +0100
Message-ID: <CAJuUDwtF_uZUraF+4d3_GBz=4CO_f3EfSjtxCgNU_Y5CmgtGqw@mail.gmail.com>
Subject: Re: How to use wpan-ping
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Sorry for delay.

2016-11-07 17:16 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> On 04/11/16 21:58, Xue Liu wrote:
>>
>> Hello,
>>
>> 2016-11-04 15:28 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
>>>
>>> Hello.
>>>
>>> On 04/11/16 14:19, Xue Liu wrote:
>>>>
>>>>
>>>> Hello everyone,
>>>>
>>>> I would like to use latest wpan-ping in RPi3 4.4.28 with ATUSB stick
>>>> (latest firmware).
>>>
>>>
>>>
>>> Interesting combination to use a USB dongle on the Pi :)
>>
>>
>> I have bought two ATUSB for almost 3 years. But have no time to play wit=
h.
>
>
> Glad you finally have the time. :)
>
>>>
>>>  I follow the README.wpan-ping as =E2=80=9C./wpan-ping -d
>>>>
>>>>
>>>> 0x0001=E2=80=9D or "wpan-ping -a 0x0003 -c 5 -s 114", but I got en err=
or
>>>> message:
>>>>
>>>> bind: No such device
>>>
>>>
>>>
>>> It can't find the device it should bind to. Did you setup a short addre=
ss
>>> for the interface?
>>>
>>> iwpan dev will tell us.
>>>
>>
>> Yes, you are right. Now it is running. But there is still a error messag=
e:
>>
>> Packet size must be between 5 and 104.
>>
>> change 114 to another one will solve this problem.
>
>
>
> I'm a bit conservative here on the payload size. With short addressing yo=
u
> should be able to have a bigger payload. Wpan-ping should detect this bas=
ed
> on the commandline (use short or extended address) and adjust the limit
> accordingly.
>
>>
>>>> even with parameter =E2=80=9C-i wpan0=E2=80=9D.
>>>
>>>
>>>
>>> This interface is only used to get the address over netlink. It needs t=
o
>>> be
>>> set before with iwpan though.
>>>
>>> This interface is not used on the server side to bind to the device
>>> because
>>> this would need extra permissions I wanted to avoid for this small
>>> utility.
>>>
>>>> Does wpan-ping require latest kernel like bluetooth-next ? Or did I
>>>> miss something ?
>>>
>>>
>>>
>>> It should not depend on anything new.
>>
>>
>> I have another ATUSB on my Linux PC (Ubuntu 16.04, 4.4.0-45). It gives
>> me another error:
>>
>> socket: Address family not supported by protocol
>>
>> Any idea about it ? Thanks
>
>
> This really sounds as if the kernel on your Linux pc does not have
> ieee802154 socket support enabled.
>
> Any chance you could paste the relevant parts of the .config for this
> kernel? Is it self build or from a distro? Which version?

I use default Linux kernel from Ubuntu 16.04. Now It is 4.4.0-47-generic.

This problem is solved by modprobe ieee802154_socket.

Now my RPi 3 and PC can wpan-ping each other via two atusb. :)

Thanks.

>
> regards
> Stefan Schmidt
