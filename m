Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1bon0099.outbound.protection.outlook.com ([157.56.111.99]:18505
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932837AbbLHIOK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 8 Dec 2015 03:14:10 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com> <56657561.70305@osg.samsung.com>
 <56657926.5070604@analog.com> <20151207132506.GA20826@omega>
 <56658AE5.9010209@analog.com> <20151207141239.GC20826@omega>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <56668FCF.3070206@analog.com>
Date: Tue, 8 Dec 2015 09:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <20151207141239.GC20826@omega>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, marcel@holtmann.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, chrisfriedt@gmail.com

On 12/07/2015 03:12 PM, Alexander Aring wrote:
> On Mon, Dec 07, 2015 at 02:34:29PM +0100, Michael Hennerich wrote:
> ...
>>> Stefan, maybe you testing with the ATUSB firmware which going _not_
>>> into RX_AACK_ON. This was one of my lastest changes according to the
>>> ATUSB firmware. Please check that, otherwise the atusb doesn't send
>>> ack frames if ackrequest bit is set after receiving.
>>
>> I was wondering where can I buy the ATUSB?
>> On the pulster page I can't find it.
>>
>
> They are all out of stock, everywhere. I cc Werner maybe he will bring
> back the atusb again. He do his stuff all open source and a possible
> solution would be a Kickstarter project.
>
> Another option would be:
>
>   - Produce your own atusb
>   - I know that "Christopher Friedt" produced some, maybe he will give/sell
>     some. :-) I cc'ed him here.
>   - use the experimental firmware [1] on RZUSBStick [0] support. Basics
>     functionality only and not stable such atusb. I ported the firmware
>     to this stick, it can be used by atusb driver. The transceiver is a
>     different -> at86rf230... and this transceiver we also doesn't
>     support by the at86rf230 because it's too different and a huge
>     errata.

Would be nice to have a USB MAC8021511.
Guess I need to wait for the next lot being produced.


>
>> In general why is the framework not requesting ACKs on all non broadcast
>> DATA frames?
>>
>> There is an option if turned on - it'll also request ACks on broadcasts...
>
> I suppose you use the af802154 socket family. I didn't touched the code
> and this socket family is full of bugs. We need a replacement for that.
>
> The socket code which I was working is AF_PACKET.
>
> In case of AF_PACKET:
>
>   dgram sockets: extended address and intra_pan communciaton only. The
>                  AF_PACKET UAPI doesn't offer more address information.
> 		We do a mapping to this currently, other option would be
> 		to disable DGRAM on AF_PACKET. It's not possible to send
> 		broadcast frames with that.
> 		If you need that, something similar like af802154 should
> 		be available, but it's currently broken.
>
>   raw sockets:   You can build the mac frame inside userspace with
>                  complete control fc and address settings. We don't check
> 		this frame if it's valid. This is not a bug.
>
>
> and 6LoWPAN:
>
> 6LoWPAN doesn't do that, the check should be at [2]. If it's currently
> broken at your side?

Maybe - I still use the lowpan-tools.
And it locks like ACKs must be enabled via 
NL802154_CMD_SET_ACKREQ_DEFAULT, which lowpan-tools doesn't do.
Wondering why it's not by default enabled...
So I patched my kernel, probably in the wrong place.



>
> - Alex
>
> [0] http://www.atmel.com/tools/RZUSBSTICK.aspx
> [1] http://alex.my-webspace.org/firmwares/rzusb.bin
>      Note: This is temprorary website, I know wpan.cakelab.org is down
>      currently and I working already to a DNS solution to redirect
>      wpan.cakelab.org -> /alex.my-webspace.org . At the moment it looks
>      like the provide has bugs inside his DNS web-frontend configuration
>      page. ;-)
> [2] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/tx.c#L220
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
