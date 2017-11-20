Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33403 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdKTP1G (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2017 10:27:06 -0500
Received: by mail-yw0-f194.google.com with SMTP id z125so2970352ywb.0
        for <linux-wpan@vger.kernel.org>; Mon, 20 Nov 2017 07:27:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOHTApiBh8VzMTm4FwjguPCQtNQMwefeDMptKDL1Vzh0TgewgA@mail.gmail.com>
References: <20171118155501.14148-1-starnight@g.ncu.edu.tw> <CAOHTApiBh8VzMTm4FwjguPCQtNQMwefeDMptKDL1Vzh0TgewgA@mail.gmail.com>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Mon, 20 Nov 2017 23:27:03 +0800
Message-ID: <CAC=mGzjagf4mM2Mf1ELDovRYjxOxGBq6i6_jskX1f6u2Uz9=7w@mail.gmail.com>
Subject: Re: [PATCH] doc: linux-wpan: Fulfill the description of missed
 802.15.4 APIs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-wpan - ML <linux-wpan@vger.kernel.org>, linux-doc@vger.kernel.org

Hi,

2017-11-20 0:19 GMT+08:00 Alexander Aring <aring@mojatatu.com>:
> Hi,
>
> On Sat, Nov 18, 2017 at 10:55 AM, Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:
>> There are more functions and operations which must be used or implemented
>> in each IEEE 802.15.4 device driver, but are not mentioned in the Device
>> drivers API section of Documentation/networking/ieee802154.txt.  Therefore,
>> I want to fulfill the missed part into the documentation with this patch.
>>
>> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>
> Acked-by: Alexander Aring <aring@mojatatu.com>
>
> Thanks for doing this kind of job and blame for me that I didn't
> update documentation...
>
> xmit_complete is more a signal to say "frame transmission done", means
> you can fill the hardware side frame buffer with new frames again.
> It works together mit xmit_async, as xmit_sync (the old method) waits
> until framebuffer fill is complete. It queues the work into workqueue
> and people do "spi_sync" handling... but the ndo_xmit callback of
> netdev works differently. It means "fill the frame into framebuffer
> and start transmit" (in context of this callback) what "xmit_async" is
> made for - not queue into workqueue (what xmit_sync) does.

Thanks for Alex's sharing.
And, Yes!  I was stuck here a while when I was developing the device driver.
I figured out what you mentioned after traced the code and the dumped error
message.

Jian-Hong, Pan

> Anyway I see problems when using subsystems e.g. traffic control which
> assumes that at this time the frame is being to transmitted and not
> queued somewhere else (in a software queue, e.g. workqueue).
> People say to me, "spi_sync" "spi_async" - doesn't matter the spi
> subsystem will do the same "things" afterwards, but then this is a bug
> inside the spi subsystem to handle softirq context correctly.
>
> - Alex
