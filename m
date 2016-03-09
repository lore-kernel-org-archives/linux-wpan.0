Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33609 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587AbcCINxO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Mar 2016 08:53:14 -0500
Received: by mail-wm0-f46.google.com with SMTP id l68so193543317wml.0
        for <linux-wpan@vger.kernel.org>; Wed, 09 Mar 2016 05:53:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <30027.1457531123@obiwan.sandelman.ca>
References: <CAPpUg6OTHiaWvANusmnty0DW0GRonTgX5uOLfR5cOSgbdnYyqQ@mail.gmail.com>
	<30027.1457531123@obiwan.sandelman.ca>
Date: Wed, 9 Mar 2016 14:53:12 +0100
Message-ID: <CAPpUg6MMTrwOiNC5M-e52zZpNkh58AQ7TC7x2p_fY916CvyHpw@mail.gmail.com>
Subject: Re: RPl on Linux
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

2016-03-09 14:45 GMT+01:00 Michael Richardson <mcr@sandelman.ca>:
> Baptiste Clenet <bapclenet@gmail.com> wrote:
>     > Thanks for your work concerning 6lowpan, 802.15.4 and wpan tools,
>     > that's great!  I'm wondering what the status of RPL mesh implementation
>     > on Linux?
>
> There are few implementations, see for instance this article:
>       http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html
>
> 1) Mine, which is at http://unstrung.sandelman.ca/
>    Currently storing only; non-storing requires kernel work
>    that is not yet done.

Thanks for your answer, I see that you suggest to make it work with
Contiki RPL implementation., a serious competitor to Contiki is RIOT,
have you ever tried your RPL implementation with RIOT RPL?


>
> 2) https://github.com/joaopedrotaveira/linux-rpl
>    which lives in the kernel.
>
> 3) https://github.com/tcheneau/simpleRPL
>    I've not looked at this one at all.
>
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
>



-- 
Baptiste
