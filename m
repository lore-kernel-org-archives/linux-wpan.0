Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:57247 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbcBVJJn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Feb 2016 04:09:43 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: extending driver mrf24j40
From: smlng <s@mlng.net>
In-Reply-To: <56C9B125.2030409@bergzand.net>
Date: Mon, 22 Feb 2016 10:09:35 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <3C6ECFF9-7B13-42A3-8A4B-1258CA1926C5@mlng.net>
References: <1A88240A-AAAD-4243-A31C-61CBC7E8949F@mlng.net> <56C9ADBB.1040608@pengutronix.de> <56C9B125.2030409@bergzand.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen <koen@bergzand.net>
Cc: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org, Alan Ott <alan@signal11.us>

Hi all,

thanks for the replies and input. I'm happy to contribute on the enhancing the mrf24j40 driver and I've some time to spare on that. 

@Koen: briefly said my plan is to _port_ some of the functionality (i.e., reset) from the at86rf230 driver - I know it's a different device but the driver seems to be well written and implements/uses reset, sleep and so on. I think it is a good starting point, or not? Currently I've 1 (maybe 2) mrf24j40ma transceiver(s) at my disposal, and use them with a Raspberry Pi via SPI for testing.

I'll report back, as soon as I got some of the planned _enhancements_ running, maybe you (@Koen) can review and test them as well?

Best
 Sebastian

> Am 21.02.2016 um 13:44 schrieb Koen <koen@bergzand.net>:
> 
> On 02/21/2016 01:29 PM, Alexander Aring wrote:
>> Hi,
>> 
>> Am 02/20/2016 um 10:20 PM schrieb smlng:
>>> Hi all,
>>> 
>>> I'm using 2 lowpan transceivers on a Raspberry Pi namely openlabs at86rf233 and microchip mrf24j40ma. I found that the latter one seams to be somewhat _incomplete_, that is it doesn't support handles for _reset_ and _wake/sleep_ gpio-pin configuration. Further, this makes connecting the mrf24j40ma to the RasPi pinout inconvenient (IMHO). On the other hand the atmel driver (at86rf230)[1] does support these functions, so I'd like to _port_ the reset and sleep functionality into the mrf24j40 driver[2]. 
>> Yes, hard-reset functionality would be nice.
>> 
>> Remember the wake/sleep functionalty is limited only, if the subsystem doesn't use the
>> transceiver then it will go into sleep mode. Nothing more is supported for powersaving
>> currently.
>> 
>>> Is anybody working on this, and if not: do you think it is useful/worth while doing so? I'm willing to work on that and implement these extension, maybe also restructure/clean up the driver code a little bit in this process.
>> ok. Great!
>> 
>> If I remember correctly Koen Zandberg (I cc him here) said something about the
>> hard-reset functionality @irc, that he plans to implement it.
>> 
>> Koen, do you already working on this or still try to bring mac802154 led-trigger
>> functionality mainline? :-)
> Real life gave me a kick in the nuts, but I haven't forgotten the led
> triggers.
>> 
>> Also I cc "Alan Ott" the maintainer of mrf24j40 driver.
>> 
>> - Alex
> Hello,
> 
> I'm using multiple mrf24j40ma radio's in my setup. I've had some plans
> too to extend the driver. Maybe we could collaborate with this since we
> seem to have the same ideas. As Alexander said, I've got the reset
> functionality on my to-do list, but haven't found time to implement it
> yet. I also had the idea to implement some sanity checks in the
> interrupt code. Furthermore it might be nice to have some kind of check
> in the hw_init code to probe the device somehow and error if the radio
> does not respond (correctly).
> 
> It would be great if you have time to implement some of these functions.
> When I find the time to start working on these things I'll notify you so
> we don't do the same work twice :)
> 
> Koen

