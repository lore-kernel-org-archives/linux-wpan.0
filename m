Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37035 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbbDWKZf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 06:25:35 -0400
Received: by widdi4 with SMTP id di4so87177344wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 03:25:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150423100918.GA9284@omega>
References: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
	<20150423100918.GA9284@omega>
Date: Thu, 23 Apr 2015 12:25:34 +0200
Message-ID: <CAG9Fz+usxJ-9ME2VoODfO1W2usMophATuYD5Nxer_w9TXj9Rag@mail.gmail.com>
Subject: Re: First kernel patch - checkpatch for at86rf230.c, false-positives?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-04-23 12:09 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Thu, Apr 23, 2015 at 11:48:07AM +0200, Christoffer Holmstedt wrote:
>> Hi
>> I've access to a few raspberry pi:s with the openlabs extension board
>> and I'm currently configuring my development environment for kernel
>> development to help out with the wpan subsystem.
>>
>> I just ran checkpatch.pl over at86rf230.c and got 109 errors most of
>> them concerning macros not enclosed in parentheses. Are these
>> false-positives or should I add parantheses?
>>
>
> definitely false positiv!
>
> what they do there is parameters for functions in a define.
>
> Like:
>
> #define STATIC_VALUES_PARAMETERS 1, 2, 3
>
> void function(void *p, int first, int second, int third, void *foobar)
> {
>         ....
> }
>
> and call later;
>
> function(bar, STATIC_VALUES_PARAMETERS, foo);
>
> compiler will replace it with:
>
> function(bar, 1, 2, 3, foo);
>
> and it's wrong to use:
>
> function(bar, (1, 2, 3), foo);
>
> it's not usually kernel programming and historical copy&pasted from
> contiki code [0] or maybe contiki copy&pasted it from linux, I don't
> know I don't programmed it.
>
>
> checkpatch warnings about this because it's complicated to use logical
> operations define inside another logical operations define. like:
> BAR_MASK(FOO_MASK(bar)) - without brackets it's hard to understand
> what's going on there.
> But this isn't the case here.
>
>
> btw:
>
> There exists an code styling issue which is not shown by checkpatch.
> It's the tab after every define, I have patches for this I will send
> them later, it's included for the RFC to add phy capabilities dump.
>
> - Alex
>
> [0] https://github.com/contiki-os/contiki/blob/master/cpu/avr/radio/rf230/at86rf230_registermap.h

Thank you Alexander for your fast and thorough response, I expected
something like that as other defines did have parantheses.

--
Christoffer Holmstedt
