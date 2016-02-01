Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58028 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088AbcBAKKW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Feb 2016 05:10:22 -0500
Subject: Re: [RFC bluetooth-next] 6lowpan: move reciving handling to generic
References: <1453927574-5074-1-git-send-email-aar@pengutronix.de>
 <56AB7411.3000700@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56AF2F08.2030603@pengutronix.de>
Date: Mon, 1 Feb 2016 11:10:16 +0100
MIME-Version: 1.0
In-Reply-To: <56AB7411.3000700@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hi Stefan,

Am 01/29/2016 um 03:15 PM schrieb Stefan Schmidt:
> Hello.
>
> On 27/01/16 21:46, Alexander Aring wrote:
>> This patch moves 6lowpan receive handling into 6lowpan generic. I
>> introduced some callback ops to make some link-layer specific handling.
>>
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> ---
>> Hi,
>>
>> this patch is a draft to talking about to move the receive handling
>> and evaluation of 6LoWPAN dispatches into net/6lowpan instead that
>> every 6lowpan specific link-layer implementation will do that on his
>> own.
>>
>> I added some callbacks for receive handling, other solutions would
>> be to add runtime decisions into net/6lowpan/rx.c by eval the
>> interface type.
>>
>> Any comments are welcome. It's not perfect yet and it can be still
>> improved at some places, if we really like to go that way.
>
> The first questions that comes to mind is why rx only and not tx?

because I think the rx handling is "easier" to do this now, because I did the
receiving handling rework and "in my opinion" - it looks well.

For transmit part we need some other framwork to handle the dispatch
generation well.

I think we need something for transmit handling also a "6lowpan" socket
interface. What we have in 6lowpan is:

1. We getting IPv6 packets and need to do some adaptation: That's what
    we currently use for IPHC and FRAG1, FRAGN.

2. Some parts which has nothing to do with IPv6 (I suppose), like the other
    dispatch values, e.g. MESH. I didn't saw any implementation of that yet and
    RFC which describes that "more".

We currently do "1." part only, but doing transmit to net/6lowpan we should
be able to think about other "dispatch values" which doesn't fit to "1.".

But currently I suppose that there are dispatches for 6LoWPAN which are not
"indicated" by some IPv6 Header only. -> That's why we need some
socket-interface stuff.

> This would also allow the fragment handling to move into the generic part. I'm aware that bluetooth is not using it but other 6LoWPAN adaptation layers do and it part of the RFC4944.
>

Okay, I also thought about that.

1. Currently I did a lot of stuff with callbacks... in my opinion it's hard to
    understand how it works then and confuses more.

To move the fragment handling into "net/6lowpan" there are some linklayers
like btle which don't use that and moving this part to "net/6lowpan" will
blow-up the 6lowpan module if somebody wants "btle" support only.

I think what we need is handling the dispatch headers like NHC - per module.
So we have 6lowpan.ko and 6lowpan-frag.ko, 6lowpan-iphc.ko, etc.

While interface registration we can auto-load modules which are necessary for
doing 6lowpan stuff for $LINK_LAYER, e.g.:

 - 802.15.4: 6lowpan.ko 6lowpan-iphc.ko 6lowpan-frag.ko
 - BTLE: 6lowpan.ko 6lowpan-iphc.ko

This will helps also for kernel-tinyfication, also for MESH it's needed when using
the socket-interface for that and then we can load the handling for that as module.
Also auto-loading when reciving MESH header.

In short:

I think I let there only one callback, this callback ist to parse the mac-address from skb,
which sounds like something which need to be implemented as callback.
All other callbacks can be removed and indicated by "registering lowpan interface".

Then also I will try to have the "per-dispatch module idea". And moving ALL dispatch
handlers into "net/6lowpan" and have some registering "lowpan_iphc_module" macro
to have each implementation in one file.

This all sounds like a good idea for me, but is really big work. :-)

- Alex
