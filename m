Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57308 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbbHNPcw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 14 Aug 2015 11:32:52 -0400
Subject: Re: ADF7242 driver ready for mainline inclusion?
References: <55CC5CF3.5030701@sostec.de>
 <78F369B105E123488216BDB7B6C397DAA4DA4FD8@NWD2MBX7.ad.analog.com>
 <55CD9513.8020508@datenfreihafen.org> <55CDFECD.80907@analog.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <55CE0A21.3050700@datenfreihafen.org>
Date: Fri, 14 Aug 2015 17:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <55CDFECD.80907@analog.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: michael.hennerich@analog.com
Cc: Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 14/08/15 16:44, Michael Hennerich wrote:
> On 08/14/2015 09:13 AM, Stefan Schmidt wrote:
>> Hello.
>>
>> On 13/08/15 20:50, Hennerich, Michael wrote:
>>> Hi All,
>>>
>>> I did tis driver a long time ago, when the Linux 802.15.4 support in
>>> general was at its beginning and pretty broken as well.
>>>  From time to time I update this driver - and actually it's pretty
>>> mature - and should apply to mainline without problems.
>>>
>>> There is currently only one minor thing that I wanted to investigate
>>> (some ifdef in the ISR) before submitting the driver mainline.
>> This is great to hear! Looking forward to it. :)
>>> Are you using the ADF7242 in a design already?
>> No. The reason I wrote this is that I have an interest in the linux-wpan
>> subsystem in general and thought the driver would be a good candidate
>> for mainline.
>>
>> I actually searched for some simple ADF7242which I could hook up to SPI
>> + IRQ and maybe some more control lines. So far I only found the
>> official evaluation board which is to expensive for some hobbyist
>> testing.
>
> Well there is the EVAL-ADF7242-PMOD [1] which uses a PMOD [2] interface
> basically a cheap 100mil spaced header, with SPI, IRQ and supply.
>
I see. I have seen that one but was under the impression one needed the
mother board for this one as well. As it seems it should be easy to just
hookup the PMOD interface to all kind of boards via SPI, IRQ and some
more GPIOs.

> If you are really interested testing the driver I can provide you one
> FOC.
>

That is an interesting offer. Alex and myself try to keep a transceiver
around for every driver we have in tree, if possible. This helps during
review to test the patches as well as testing our own changes which
might touch all drivers. Given that Alex does the most work on this
right now I would propose to provide him with this board.

Alex, does that sound good to you?

>>> Do you have feedback already?
>> The driver interface for ieee802154 has advanced since the it got merged
>> initially. Some of the new things you might want to look into and add
>> support are:
>>
>> o Async transmit (xmit_async)
>> o LBT support (set_lbt)
>> o Set CC mode and ed level (set_cc_mode, set_cca_ed_level)
>> o Support for monitor mode (set_promiscuous_mode)
>>
>> These I found missing when having a brief look over the driver.
>
> Thanks for the summary!
>

These are not really a must to get the driver merged mainline. But if
you find some time working on it before submitting some of these might
be easy to add.

regards
Stefan Schmidt
