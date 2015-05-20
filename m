Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34935 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbbETQhm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 May 2015 12:37:42 -0400
Message-ID: <555CB851.4030402@osg.samsung.com>
Date: Wed, 20 May 2015 18:37:37 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH atubs-fw 1/4] Revert "atusb/fw/usb/: enable MCU reset
 on USB bus reset after config selection"
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org> <1432127894-4760-2-git-send-email-stefan@datenfreihafen.org> <20150520153302.GK3978@omega>
In-Reply-To: <20150520153302.GK3978@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, jlu@pengutronix.de

Hello.

[resend as I dropped cc :(]

On 20/05/15 17:33, Alexander Aring wrote:
> On Wed, May 20, 2015 at 03:18:11PM +0200, Stefan Schmidt wrote:
>> This reverts commit 9b2696b8488dbc39b0fdcdefdfad775913cb6e2d.
>>
>> With this patch ATUSB resets constantly when I use it in QEMU with USB
>> poassthrough.
>>
>> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <alex.aring@gmail.com>
>
> Yea, atusb running now with qemu version behind 1.6.2 on my side :-)
> I/We always had issues with newer qemu releases.

Ah, so you worked around it with staying on an old qemu interesting.

Given that it fixes problems for you and me while I have not seen a 
downside yet I would like to keep this revert for the 0.2 release. We 
can investigate later what the culprit is as long as we have a stable 
setup now.

I run some longer tests with ping6 packets on various sizes and counts 
of 1000 or more. All of them looked good. Stable average rrt and packet 
loss in the range of 1-3%.

Werner, if you do not have any objections please apply these patches to 
the ben-wpan repo. Once that is done we need to think where we want to 
put the firmware file for now. I would think having it on the atusb side 
on qi-hardware would make sense. An alternative would be wpan.cakelabs.org.

I will also try to get in into linux-firmware over the next weeks one we 
are happy with what we have.

regards
Stefan Schmidt
