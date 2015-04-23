Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36317 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596AbbDWKJ3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 06:09:29 -0400
Received: by wizk4 with SMTP id k4so209847657wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 03:09:28 -0700 (PDT)
Date: Thu, 23 Apr 2015 12:09:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: First kernel patch - checkpatch for at86rf230.c, false-positives?
Message-ID: <20150423100918.GA9284@omega>
References: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Apr 23, 2015 at 11:48:07AM +0200, Christoffer Holmstedt wrote:
> Hi
> I've access to a few raspberry pi:s with the openlabs extension board
> and I'm currently configuring my development environment for kernel
> development to help out with the wpan subsystem.
> 
> I just ran checkpatch.pl over at86rf230.c and got 109 errors most of
> them concerning macros not enclosed in parentheses. Are these
> false-positives or should I add parantheses?
> 

definitely false positiv!

what they do there is parameters for functions in a define.

Like:

#define STATIC_VALUES_PARAMETERS 1, 2, 3

void function(void *p, int first, int second, int third, void *foobar)
{
	....
}

and call later;

function(bar, STATIC_VALUES_PARAMETERS, foo);

compiler will replace it with:

function(bar, 1, 2, 3, foo);

and it's wrong to use:

function(bar, (1, 2, 3), foo);

it's not usually kernel programming and historical copy&pasted from
contiki code [0] or maybe contiki copy&pasted it from linux, I don't
know I don't programmed it.


checkpatch warnings about this because it's complicated to use logical
operations define inside another logical operations define. like:
BAR_MASK(FOO_MASK(bar)) - without brackets it's hard to understand
what's going on there.
But this isn't the case here.


btw:

There exists an code styling issue which is not shown by checkpatch.
It's the tab after every define, I have patches for this I will send
them later, it's included for the RFC to add phy capabilities dump.

- Alex

[0] https://github.com/contiki-os/contiki/blob/master/cpu/avr/radio/rf230/at86rf230_registermap.h
