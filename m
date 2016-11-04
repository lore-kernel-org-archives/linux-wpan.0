Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37792 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbcKDU6g (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Nov 2016 16:58:36 -0400
Received: by mail-wm0-f42.google.com with SMTP id t79so72706436wmt.0
        for <linux-wpan@vger.kernel.org>; Fri, 04 Nov 2016 13:58:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f4f8a2d3-5233-0ccf-5808-02126cf9d514@osg.samsung.com>
References: <CAJuUDwsJvZ0gjcSP02vjAkR4PX6BQq=jTEtMoHtcXheY1kvS7Q@mail.gmail.com>
 <f4f8a2d3-5233-0ccf-5808-02126cf9d514@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Fri, 4 Nov 2016 21:58:34 +0100
Message-ID: <CAJuUDwsU1wb+XXEgrN8abeQNWwzV_kcFU9ch2VT9fdxRpps_Kw@mail.gmail.com>
Subject: Re: How to use wpan-ping
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hello,

2016-11-04 15:28 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> On 04/11/16 14:19, Xue Liu wrote:
>>
>> Hello everyone,
>>
>> I would like to use latest wpan-ping in RPi3 4.4.28 with ATUSB stick
>> (latest firmware).
>
>
> Interesting combination to use a USB dongle on the Pi :)

I have bought two ATUSB for almost 3 years. But have no time to play with.

>
>  I follow the README.wpan-ping as =E2=80=9C./wpan-ping -d
>>
>> 0x0001=E2=80=9D or "wpan-ping -a 0x0003 -c 5 -s 114", but I got en error
>> message:
>>
>> bind: No such device
>
>
> It can't find the device it should bind to. Did you setup a short address
> for the interface?
>
> iwpan dev will tell us.
>

Yes, you are right. Now it is running. But there is still a error message:

Packet size must be between 5 and 104.

change 114 to another one will solve this problem.

>> even with parameter =E2=80=9C-i wpan0=E2=80=9D.
>
>
> This interface is only used to get the address over netlink. It needs to =
be
> set before with iwpan though.
>
> This interface is not used on the server side to bind to the device becau=
se
> this would need extra permissions I wanted to avoid for this small utilit=
y.
>
>> Does wpan-ping require latest kernel like bluetooth-next ? Or did I
>> miss something ?
>
>
> It should not depend on anything new.

I have another ATUSB on my Linux PC (Ubuntu 16.04, 4.4.0-45). It gives
me another error:

socket: Address family not supported by protocol

Any idea about it ? Thanks

>
> regards
> Stefan Schmidt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
