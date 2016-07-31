Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34485 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcGaWeg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 31 Jul 2016 18:34:36 -0400
Received: by mail-qk0-f196.google.com with SMTP id s186so4669146qkb.1
        for <linux-wpan@vger.kernel.org>; Sun, 31 Jul 2016 15:34:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e65bd287-bfba-c92b-ac64-0e1c758a3e03@datenfreihafen.org>
References: <20160728174051.GB75405@redhat.com> <e65bd287-bfba-c92b-ac64-0e1c758a3e03@datenfreihafen.org>
From: Marcin K Szczodrak <mszczodrak@gmail.com>
Date: Sun, 31 Jul 2016 15:34:35 -0700
Message-ID: <CAP3K90dJt7cbo54dhwXKfTGSJpXt=24S2bRa1NL57uhp1dx8Hg@mail.gmail.com>
Subject: Re: Looking for boards with an 802.15.4 chip
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Don Zickus <dzickus@redhat.com>, "aar@pengutronix.de" <aar@pengutronix.de>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linville@redhat.com" <linville@redhat.com>

To just get a feeling of how the technology works, OpenThread is one
way of discovering 15.4 and it's Thread standard. One can use various
dev boards to run OpenThread, such as Zolertia's RE-Mote or TI's
CC2538 dev kit. Alternatively, there are also very good kits from
SiLabs, NXP (Freescale) and Dialog (check OpenThread Sandbox
Development Platform).

 From a Linux perspective, it might be worth playing with OpenThread
and wpantund, a user-space 15.4 driver that talks to 15.4 radio chip
over UART or SPI. In this setup, one could flash 15.4 with OpenThread
and run wpantund on a Linux host to create a Thread network gateway,
which typically is used by low-power 15.4 only devices to get outside
of the Thread network.

Best,
Marcin

On Sat, Jul 30, 2016 at 3:02 PM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> Hello.
>
> On 28.07.2016 19:40, Don Zickus wrote:
>> Hi Alexander,
>>
>> I was wondering what boards/chips folks like yourself use to develop/test
>> the 802.15.4 work?  I noticed the website  http://wpan.cakelab.org/ mentions
>> a bunch of boards.  Some of those pointers don't work and the ones that do,
>> show standalone boards that need to be wired up to a SPI bus.
>>
>> I assume the SPI bus is easily found on a rPI-like board.  Is it difficult to
>> hook one of them up to an x86 desktop?
>
> You might be able to do this with some USB dongle exposing some GPIOs to
> to the kernel but I never used anything like that. Most of my
> transceivers are connected to Pi's. So it goes down to embedded.
>
> I'm in the lucky position though to have two ATUSB dongles which are
> simple USB dongles and get connected to your x86 systems with ease.
> They work out of the box in mainline since 4.1 and the firmware is open
> source as well. The problem right now is that it is now longer being sold.
>
> We are working on changing this though. See my mail from a few minutes
> ago to this list about interest for a new ATUSB production batch.
> Right now we would estimate them being on sale again sometime in October
> (the smaller fabs we are using for SMT is on holiday and we also need to
> prepare things in our spare time).
>
> If this is to far away, fair enough. If it does not really matter to you
> and you would have an interest to use them please let me know so I can
> better estimate the needed number of devices for the batch.
>
> regards
> Stefan Schmidt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
