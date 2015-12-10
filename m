Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57892 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbbLJAEZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 9 Dec 2015 19:04:25 -0500
Subject: Re: [PATCH] drivers/net/ieee802154/adf7242: Driver for ADF7242 MAC
 IEEE802154
References: <1449220149-14096-1-git-send-email-michael.hennerich@analog.com>
 <566181E6.9070306@osg.samsung.com> <56657561.70305@osg.samsung.com>
 <56657926.5070604@analog.com> <20151207132506.GA20826@omega>
 <56658AE5.9010209@analog.com> <20151207141239.GC20826@omega>
 <56668FCF.3070206@analog.com> <20151208155332.GA766@omega>
 <5666FF07.6050706@analog.com> <20151209103124.GA1036@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5668C185.6010902@osg.samsung.com>
Date: Thu, 10 Dec 2015 01:04:21 +0100
MIME-Version: 1.0
In-Reply-To: <20151209103124.GA1036@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, chrisfriedt@gmail.com

Hello.

On 09/12/15 11:31, Alexander Aring wrote:
> Hi,
>
> On Tue, Dec 08, 2015 at 05:02:15PM +0100, Michael Hennerich wrote:
>> On 12/08/2015 04:53 PM, Alexander Aring wrote:
>>> Hi,
>>>
>>> On Tue, Dec 08, 2015 at 09:07:43AM +0100, Michael Hennerich wrote:
>>>> On 12/07/2015 03:12 PM, Alexander Aring wrote:
>>>>> On Mon, Dec 07, 2015 at 02:34:29PM +0100, Michael Hennerich wrote:
>>>>> ...
>>>>>>> Stefan, maybe you testing with the ATUSB firmware which going _not_
>>>>>>> into RX_AACK_ON. This was one of my lastest changes according to the
>>>>>>> ATUSB firmware. Please check that, otherwise the atusb doesn't send
>>>>>>> ack frames if ackrequest bit is set after receiving.
>>>>>> I was wondering where can I buy the ATUSB?
>>>>>> On the pulster page I can't find it.
>>>>>>
>>>>> They are all out of stock, everywhere. I cc Werner maybe he will bring
>>>>> back the atusb again. He do his stuff all open source and a possible
>>>>> solution would be a Kickstarter project.
>>>>>
>>>>> Another option would be:
>>>>>
>>>>>   - Produce your own atusb
>>>>>   - I know that "Christopher Friedt" produced some, maybe he will give/sell
>>>>>     some. :-) I cc'ed him here.
>>>>>   - use the experimental firmware [1] on RZUSBStick [0] support. Basics
>>>>>     functionality only and not stable such atusb. I ported the firmware
>>>>>     to this stick, it can be used by atusb driver. The transceiver is a
>>>>>     different -> at86rf230... and this transceiver we also doesn't
>>>>>     support by the at86rf230 because it's too different and a huge
>>>>>     errata.
>>>> Would be nice to have a USB MAC8021511.
>>>> Guess I need to wait for the next lot being produced.
>>>>
>>>>
>>> ok. The RZUSBSTICK is still available but very poor state.
>>>
>>>>>> In general why is the framework not requesting ACKs on all non broadcast
>>>>>> DATA frames?
>>>>>>
>>>>>> There is an option if turned on - it'll also request ACks on broadcasts...
>>>>> I suppose you use the af802154 socket family. I didn't touched the code
>>>>> and this socket family is full of bugs. We need a replacement for that.
>>>>>
>>>>> The socket code which I was working is AF_PACKET.
>>>>>
>>>>> In case of AF_PACKET:
>>>>>
>>>>>   dgram sockets: extended address and intra_pan communciaton only. The
>>>>>                  AF_PACKET UAPI doesn't offer more address information.
>>>>> 		We do a mapping to this currently, other option would be
>>>>> 		to disable DGRAM on AF_PACKET. It's not possible to send
>>>>> 		broadcast frames with that.
>>>>> 		If you need that, something similar like af802154 should
>>>>> 		be available, but it's currently broken.
>>>>>
>>>>>   raw sockets:   You can build the mac frame inside userspace with
>>>>>                  complete control fc and address settings. We don't check
>>>>> 		this frame if it's valid. This is not a bug.
>>>>>
>>>>>
>>>>> and 6LoWPAN:
>>>>>
>>>>> 6LoWPAN doesn't do that, the check should be at [2]. If it's currently
>>>>> broken at your side?
>>>> Maybe - I still use the lowpan-tools.
>>>> And it locks like ACKs must be enabled via NL802154_CMD_SET_ACKREQ_DEFAULT,
>>>> which lowpan-tools doesn't do.
>>>> Wondering why it's not by default enabled...
>>>> So I patched my kernel, probably in the wrong place.
>>>>
>>> The lowpan-tools are deprecated. The official website is back (from what
>>> I recovered), you can get wpan-tools at [0].
>>>
>>> The ackreq_default is false by default (which indicates no ARET
>>> handling/no ackrequest bit is set) because this requires that the other
>>> side can deal with ack handling. Otherwise the node will get the frame 3
>>> times.
>>>
>>> The conclusion is to set the ack handling default to false, if you know
>>> your network can do ack handling then you can turn it on with the
>>> wpan-tools.
>>>
>>> Do you think we should enable it by default and if there are non IEEE
>>> 802.15.4 valid nodes around which doesn't support ACK handling we should
>>> simple ignore that?
>> I thought that ACK handling is mandatory for 802.15.4.
> It is, otherwise some MLME-ops would not functional. The _open_ _source_
> reality outside looks different. There are of course nodes which doesn't
> support ack handling (I have some contiki nodes with cc2520, but so far
> I know contiki also handles dataframes with 6LoWPAN only).
>
> I also didn't saw any OS implementation for MLME-ops :( I know the Xbee [0]
> transceiver which is a "kind" of HardMAC transceiver. MLME-ops can be
> triggered by right "AT-FOO" uart command.
>
> I know that Christopher Friedt want to have some MLME features inside
> the kernel and already worked on some parts for scanning.
>
>> So if there are non compliant IEEE802154 nodes around we can turn it off.
>>
>> Either way is fine with me.
>>
> Okay. It's one simple switch to change it. I would wait here for Stefans
> opinion about that.
>

Before we are going to switch it back on by default we really need more 
data to understand the situation in my opinion.

Pro enabled by default:
o Spec compliant
o More reliable connection as l2 cares about resend
o Needed for some MLME-ops we want to support later on

Pro disabled by default:
o Avoid problems with hardware and or software which does not support 
the ACK request bit (we need a list here)


To understand better what kind of hardware and software we have out 
there which does not support the ack requests correctly we need to look 
around.
o What hardware do we know about that does not have a hardware 
accelerated ACK handling (sometimes called automatic ACK or AACK)? The 
transceivers I have seen so far all have support for it (at86rf2xx, 
cc24xx, cc25xx, adf7242, mrf24j40)
o How is the status in other OSes for this? Do they enable the hardware 
feature? Do they have software fallback support?
   o Contiki might be hard to track here with different forks and releases.
   o What is the status in RIOT?

Not an easy answer as you can see. :) I would suggest we keep it as is 
for now (disabled by default) and try to collect some of the above 
mentioned data to base our decision on. With the need of some MLME-ops 
we might have a deal breaker here anyway.

regards
Stefan Schmidt
