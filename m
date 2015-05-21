Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48951 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582AbbEUQjK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 21 May 2015 12:39:10 -0400
Message-ID: <555E0A2A.1070903@osg.samsung.com>
Date: Thu, 21 May 2015 18:39:06 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH atubs-fw 0/4] ATUSB firmware changes towards a 0.2 release
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org> <555C8A77.3070203@datenfreihafen.org> <555DEE4E.4020307@osg.samsung.com> <20150521153910.GB901@omega>
In-Reply-To: <20150521153910.GB901@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, werner@almesberger.net

Hello.

On 21/05/15 17:39, Alexander Aring wrote:
> On Thu, May 21, 2015 at 04:40:14PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 20/05/15 15:21, Stefan Schmidt wrote:
>>> Hello.
>>>
>>> On 20/05/15 15:18, Stefan Schmidt wrote:
>>>> Hello.
>>>>
>>>> Nothing to be appliad to the kernel but rather the atusb firmware repo. Just
>>>> sending it here as it is releated to the mainline driver and the device users
>>>> are reading here.
>>>>
>>>> These are the four patches I consider we need to have a working 0.2 release.
>>>> The revert might be only needed for my qemu setup with USB passthrough, but
>>>> without it I'm not able to get the device to show up in qemu. Thoughts
>>>> appreciated.
>>>>
>>>> Using RX_AACK_ON sounds like a good idea as we loose nothing but work also work
>>>> well with nodes using ARET.
>>>>
>>>> Bumping to version 0.2 and adding the need magic to add a valid DFU suffix to
>>>> the firmware file. I will followup with a mail attaching the binary I'm using
>>>> right now and I consider the final 0.2 if everyone agrees with these patches.
>>>>
>>> Binary firmware image attached. Alexander, if you could give that a test
>>> it would be appreciated.
>>>
>>> Everyone else with a atusb please test as well if you have the time.
>> The pending patches have been pushed and I tagged the atusb firmware 0.2
>> release in git:
>> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/changes/v0.2-atusb-fw/
>>
>> The firmware binary should be available from the website soon. If you are
>> eager you can get it here:
>> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/web/releases/atusb-0.2.dfu
>>
>> If anyone has patches for the firmware pending or upcoming please CC me. I
>> should be able help reviewing, testing and pushing them.
>>
> Maybe send patches to be maintainer of atusb driver?
Guess I can do that if you want. I have some more patches coming but 
they are not ready yet. Mostly catch up with what the stack learned in 
the last months. Adding the hooks inside the driver. Things like 
.set_promiscuous_mode, .set_frame_retries, .set_txpower, etc.

I will add a maintainer patch at the end of this and will send it 
together with that series when ready.

> I could review
> also some firmware things when it's related to talk the with the
> at86rf231 transceiver.

Yeah, there are quite some bits from the at86rf231 driver which will be 
useful in the  firmware. Need to pick them up piece by piece.

regards
Stefan Schmidt
