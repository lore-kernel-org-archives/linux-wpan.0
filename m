Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36163 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdKSQTu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 19 Nov 2017 11:19:50 -0500
Received: by mail-ua0-f193.google.com with SMTP id w47so4439614uah.3
        for <linux-wpan@vger.kernel.org>; Sun, 19 Nov 2017 08:19:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171118155501.14148-1-starnight@g.ncu.edu.tw>
References: <20171118155501.14148-1-starnight@g.ncu.edu.tw>
From: Alexander Aring <aring@mojatatu.com>
Date: Sun, 19 Nov 2017 11:19:48 -0500
Message-ID: <CAOHTApiBh8VzMTm4FwjguPCQtNQMwefeDMptKDL1Vzh0TgewgA@mail.gmail.com>
Subject: Re: [PATCH] doc: linux-wpan: Fulfill the description of missed
 802.15.4 APIs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Jonathan Corbet <corbet@lwn.net>, linux-wpan - ML <linux-wpan@vger.kernel.org>, linux-doc@vger.kernel.org

Hi,

On Sat, Nov 18, 2017 at 10:55 AM, Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:
> There are more functions and operations which must be used or implemented
> in each IEEE 802.15.4 device driver, but are not mentioned in the Device
> drivers API section of Documentation/networking/ieee802154.txt.  Therefore,
> I want to fulfill the missed part into the documentation with this patch.
>
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>

Acked-by: Alexander Aring <aring@mojatatu.com>

Thanks for doing this kind of job and blame for me that I didn't
update documentation...

xmit_complete is more a signal to say "frame transmission done", means
you can fill the hardware side frame buffer with new frames again.
It works together mit xmit_async, as xmit_sync (the old method) waits
until framebuffer fill is complete. It queues the work into workqueue
and people do "spi_sync" handling... but the ndo_xmit callback of
netdev works differently. It means "fill the frame into framebuffer
and start transmit" (in context of this callback) what "xmit_async" is
made for - not queue into workqueue (what xmit_sync) does.
Anyway I see problems when using subsystems e.g. traffic control which
assumes that at this time the frame is being to transmitted and not
queued somewhere else (in a software queue, e.g. workqueue).
People say to me, "spi_sync" "spi_async" - doesn't matter the spi
subsystem will do the same "things" afterwards, but then this is a bug
inside the spi subsystem to handle softirq context correctly.

- Alex
