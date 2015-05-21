Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48565 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbbEUOkS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 21 May 2015 10:40:18 -0400
Message-ID: <555DEE4E.4020307@osg.samsung.com>
Date: Thu, 21 May 2015 16:40:14 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH atubs-fw 0/4] ATUSB firmware changes towards a 0.2 release
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org> <555C8A77.3070203@datenfreihafen.org>
In-Reply-To: <555C8A77.3070203@datenfreihafen.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net

Hello.

On 20/05/15 15:21, Stefan Schmidt wrote:
> Hello.
>
> On 20/05/15 15:18, Stefan Schmidt wrote:
>> Hello.
>>
>> Nothing to be appliad to the kernel but rather the atusb firmware repo. Just
>> sending it here as it is releated to the mainline driver and the device users
>> are reading here.
>>
>> These are the four patches I consider we need to have a working 0.2 release.
>> The revert might be only needed for my qemu setup with USB passthrough, but
>> without it I'm not able to get the device to show up in qemu. Thoughts
>> appreciated.
>>
>> Using RX_AACK_ON sounds like a good idea as we loose nothing but work also work
>> well with nodes using ARET.
>>
>> Bumping to version 0.2 and adding the need magic to add a valid DFU suffix to
>> the firmware file. I will followup with a mail attaching the binary I'm using
>> right now and I consider the final 0.2 if everyone agrees with these patches.
>>
> Binary firmware image attached. Alexander, if you could give that a test
> it would be appreciated.
>
> Everyone else with a atusb please test as well if you have the time.

The pending patches have been pushed and I tagged the atusb firmware 0.2 
release in git:
http://projects.qi-hardware.com/index.php/p/ben-wpan/source/changes/v0.2-atusb-fw/

The firmware binary should be available from the website soon. If you 
are eager you can get it here:
http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/web/releases/atusb-0.2.dfu

If anyone has patches for the firmware pending or upcoming please CC me. 
I should be able help reviewing, testing and pushing them.

regards
Stefan Schmidt
