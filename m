Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:39141 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeBQTEF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Feb 2018 14:04:05 -0500
Received: by mail-io0-f177.google.com with SMTP id b34so4603979ioj.6
        for <linux-wpan@vger.kernel.org>; Sat, 17 Feb 2018 11:04:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217184113.GA7717@picapica.im>
References: <20180217184113.GA7717@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat, 17 Feb 2018 14:04:04 -0500
Message-ID: <CAB_54W7WdNDYgKN4gADN-bTRDoDz_TjYw2Bq8-=CLgF_CON-9w@mail.gmail.com>
Subject: Re: issues with at86rf212b transceiver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-17 13:41 GMT-05:00  <anton@picapica.im>:
> Hi
>
> I have a transceiver at86rf212b connected to Atmel's SAMA5D2-XULT devboard.
> It runs kernel from Atmel, based on Linux release 4.9. Maybe it's not a latest one,
> but I checked that there are no significant changes to at86rf230 driver since then.
>
> So I have some issues with transceiver and at86rf230 driver module.
> Is this driver considered production-ready, was it tested with at86rf212b?
>

So far I know somebody already use the driver with an at86rf212b -
there was patches related to that.

What do you mean with "production-ready"? GPL gives you no warranty
and we do it as "hobby"...

According your problem, show me "cat /proc/interrupts" I will see if
the interrupt is fired (more than one time), otherwise I see a board
setup problem...

- Alex
