Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56095 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbbHEIrW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 5 Aug 2015 04:47:22 -0400
Subject: Re: [RFCv3 bluetooth-next 2/6] ieee802154: add helpers for frame
 control checks
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
 <55C0E859.2010503@osg.samsung.com> <20150804174412.GA22216@omega>
 <55C105F5.80801@osg.samsung.com> <20150804184734.GB22802@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C1CD97.1070100@osg.samsung.com>
Date: Wed, 5 Aug 2015 10:47:19 +0200
MIME-Version: 1.0
In-Reply-To: <20150804184734.GB22802@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 04/08/15 20:47, Alexander Aring wrote:
> On Tue, Aug 04, 2015 at 08:35:33PM +0200, Stefan Schmidt wrote:
> ...
>>> right it doesn't manipulate the skb. For the "problems like we did with
>>> the 6lowpan" you need to decide which problems, I see several:
>>>
>>>   - running skb_pull (which removes) buffer and we don't have the room to
>>>     pull out the bytes of skb, example: skb->len = 3, skb_pull size is 4
>>>     which ends in a BUG(), we need to check it with skb_may_pull before.
>> Sorry, I should have been a bit more verbose here to make it clearer. I
>> meant the above.
>>
> This doesn't happend here. It's just dereferencing frame control field
> which should be always at beginning of skb_mac_header. We need the
> unaligned access, because we cannot assume that the address is at an
> aligned address.
>
> And the frame control field is in little endian byte order, we simple
> use the byte order which we also transmit (everywhere).

Thanks for explaining it again.

regards
Stefan Schmidt

