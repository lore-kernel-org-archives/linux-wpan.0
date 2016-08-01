Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:51750 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbcHAUpW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2016 16:45:22 -0400
Subject: Re: Looking for boards with an 802.15.4 chip
References: <20160728174051.GB75405@redhat.com>
 <e65bd287-bfba-c92b-ac64-0e1c758a3e03@datenfreihafen.org>
 <20160801181053.GV181121@redhat.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <ac095e9a-e604-e91c-e820-871e0f194d5c@datenfreihafen.org>
Date: Mon, 1 Aug 2016 22:45:17 +0200
MIME-Version: 1.0
In-Reply-To: <20160801181053.GV181121@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: "aar@pengutronix.de" <aar@pengutronix.de>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linville@redhat.com" <linville@redhat.com>

Hello.

On 01.08.2016 20:10, Don Zickus wrote:
> On Sun, Jul 31, 2016 at 12:02:29AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 28.07.2016 19:40, Don Zickus wrote:
>>> Hi Alexander,
>>>
>>> I was wondering what boards/chips folks like yourself use to develop/test
>>> the 802.15.4 work?  I noticed the website  http://wpan.cakelab.org/ mentions
>>> a bunch of boards.  Some of those pointers don't work and the ones that do,
>>> show standalone boards that need to be wired up to a SPI bus.
>>>
>>> I assume the SPI bus is easily found on a rPI-like board.  Is it difficult to
>>> hook one of them up to an x86 desktop?
>>
>> You might be able to do this with some USB dongle exposing some GPIOs to
>> to the kernel but I never used anything like that. Most of my
>> transceivers are connected to Pi's. So it goes down to embedded.
>>
>> I'm in the lucky position though to have two ATUSB dongles which are
>> simple USB dongles and get connected to your x86 systems with ease.
>> They work out of the box in mainline since 4.1 and the firmware is open
>> source as well. The problem right now is that it is now longer being sold.
> 
> This sounds like a simple way to get started...

That is the idea. Breaking down some of the barriers. Still not as easy
as BT or WiFi but at least a good step forward to use it on a normal
development machine.

>>
>> We are working on changing this though. See my mail from a few minutes
>> ago to this list about interest for a new ATUSB production batch.
>> Right now we would estimate them being on sale again sometime in October
>> (the smaller fabs we are using for SMT is on holiday and we also need to
>> prepare things in our spare time).
>>
>> If this is to far away, fair enough. If it does not really matter to you
>> and you would have an interest to use them please let me know so I can
>> better estimate the needed number of devices for the batch.
> 
> I don't see an archives for this mailing list, so I can't see your previous
> email.  How much would this cost? I might be up for buying 5 or so.


One archive is on spinics.net. Here is a link to my mail about this
topic: http://www.spinics.net/lists/linux-wpan/msg04084.html

As you can see we are estimating how big the production batch needs to
be. The price point would be 50 EUR with a little hope to cut it down a
bit. We can't make promises on the later one though. I will keep the
list informed.

regards
Stefan Schmidt
