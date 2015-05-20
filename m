Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32844 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbETJIo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 May 2015 05:08:44 -0400
Message-ID: <555C4F18.6090404@osg.samsung.com>
Date: Wed, 20 May 2015 11:08:40 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 21/34] ieee802154: add support for atusb
 transceiver
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com> <1431891910-32231-22-git-send-email-alex.aring@gmail.com> <555B1531.3060500@osg.samsung.com> <555C49A5.40202@osg.samsung.com> <20150520090322.GB3978@omega>
In-Reply-To: <20150520090322.GB3978@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, marcel@holtmann.org, Werner Almesberger <werner@almesberger.net>, Richard Sharpe <realrichardsharpe@gmail.com>

Hello.

On 20/05/15 11:03, Alexander Aring wrote:
> Hi,
>
> On Wed, May 20, 2015 at 10:45:25AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 19/05/15 12:49, Stefan Schmidt wrote:
>>> Besides the mentioned things this looks fine. Will give it some testing
>>> later this week.
>> Testing showed no further problems. Driver loads fine, detects the hardware
>> and I'm able to configure it and send ping's over 6LoWPAN to another node.
>>
> thanks, now I can sleep a little bit better.

:)


> Was it a little bit too fast for bringing the atusb driver mainline? I
> really had only the issues with the xmit_sync handling otherwise this
> driver looked always fine for me.
>
> I know you worked a little bit on the driver and hope that I didn't
> destroyed your work and you can rebase it.

No, the timing was fine. It was actually me who has been a bit slow. To 
many other distractions. :)

Rebasing my work on it should be easy to handle. I will look into it 
once I finished preparing the fw release.

regards
Stefan Schmidt

