Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36903 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdHCNoz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Aug 2017 09:44:55 -0400
Received: by mail-io0-f176.google.com with SMTP id c74so7069309iod.4
        for <linux-wpan@vger.kernel.org>; Thu, 03 Aug 2017 06:44:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29a009df-433e-2855-dc44-5e81d1a7a3d6@osg.samsung.com>
References: <1909067.WLLFt4d09f@hella-laptop> <29a009df-433e-2855-dc44-5e81d1a7a3d6@osg.samsung.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Thu, 3 Aug 2017 09:44:53 -0400
Message-ID: <CAB_54W4PfykGKHiGVomduZseC=R-3PiKF0Dsht0Obre_8uRH8Q@mail.gmail.com>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Josef Filzmaier <j.filzmaier@gmx.at>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2017-08-03 2:59 GMT-04:00 Stefan Schmidt <stefan@osg.samsung.com>:
...
>
> To be honest I would first want to verify that your communication between
> the atusb driver and the firmware is actually working correctly.
>
> If you flashed a unmodified rzusb firmware on the device you would have to
> be very lucky that everything would just work out of the box. If this design
> uses the same MCU  it would help a lot (please confirm) but the state
> handling of the rx/tx logic inside the firmware might still be slightly
> different for the 212 compared top the 230/231. The actual 212 kernel driver
> might give some hints about that. I do not know off hand.
>

Please take care of Errata of at86rf212 [0]. The reset doesn't work
you need to change to TRX_OFF after reset... something like that. Not
sure if atusb firmware really does that.
But this is more just like that... set CLKM stuff etc. Simple see
workaround at [0].

- Alex

[0] http://www.atmel.com/images/doc8168.pdf
