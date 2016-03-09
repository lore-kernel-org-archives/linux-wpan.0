Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33529 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbcCIU1i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Mar 2016 15:27:38 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so2123064wml.0
        for <linux-wpan@vger.kernel.org>; Wed, 09 Mar 2016 12:27:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3583.1457550990@obiwan.sandelman.ca>
References: <CAPpUg6OTHiaWvANusmnty0DW0GRonTgX5uOLfR5cOSgbdnYyqQ@mail.gmail.com>
	<30027.1457531123@obiwan.sandelman.ca>
	<CAPpUg6MMTrwOiNC5M-e52zZpNkh58AQ7TC7x2p_fY916CvyHpw@mail.gmail.com>
	<3583.1457550990@obiwan.sandelman.ca>
Date: Wed, 9 Mar 2016 21:27:37 +0100
Message-ID: <CAPpUg6OYkm6watgsSaLgE-_2hKsEGCnR5BjCRkLV-CHpHf7GRg@mail.gmail.com>
Subject: Re: RPl on Linux
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Nice, I may have a try in the coming months,thank for your reply.

2016-03-09 20:16 GMT+01:00 Michael Richardson <mcr@sandelman.ca>:
>
> Baptiste Clenet <bapclenet@gmail.com> wrote:
>     >> Baptiste Clenet <bapclenet@gmail.com> wrote: > Thanks for your work
>     >> concerning 6lowpan, 802.15.4 and wpan tools, > that's great!  I'm
>     >> wondering what the status of RPL mesh implementation > on Linux?
>     >>
>     >> There are few implementations, see for instance this article:
>     >> http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html
>     >>
>     >> 1) Mine, which is at http://unstrung.sandelman.ca/ Currently storing
>     >> only; non-storing requires kernel work that is not yet done.
>
>     > Thanks for your answer, I see that you suggest to make it work with
>     > Contiki RPL implementation., a serious competitor to Contiki is RIOT,
>     > have you ever tried your RPL implementation with RIOT RPL?
>
> We interoperated with RIOT-OS RPL back at the 6lo interop in November.
> I haven't yet successfully flashed my own openmote with RIOT-OS (or OpenWSN).
> [It's a JTAG/bootloader issue that I haven't had time to resolve...]
>
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
>



-- 
Baptiste
