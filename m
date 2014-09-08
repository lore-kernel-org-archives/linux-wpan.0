Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55238 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaIHSNP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 14:13:15 -0400
Message-ID: <540DF1AE.2070709@xsilon.com>
Date: Mon, 08 Sep 2014 19:13:02 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb
 is freed in lowpan_rcv when dropped.
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org> <53FE446D.6040805@xsilon.com> <20140908104008.GB6981@omega>
In-Reply-To: <20140908104008.GB6981@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

On 08/09/14 11:40, Alexander Aring wrote:
> Hi Martin,
>
> On Wed, Aug 27, 2014 at 09:49:49PM +0100, Martin Townsend wrote:
>> On 21/08/14 14:24, Marcel Holtmann wrote:
>>> Hi Alex,
>>>
>>>> this patch wasn't able to apply and now it doesn't apply either (because
>>>> lot of other changes). I thought you will resend a v3 and then I will
>>>> care about reviewing. Then putting Acked-by, then Marcel will put it on
>>>> the right repositories.
>>>>
>>>> If you can, describe the changes in the commit msg (please note the 80
>>>> line width there).
>>>>
>>>> This patch is also something for bluetooth (not bluetooth-next), it's a
>>>> bug fix. But this depends how Marcel will dealing with this issue. It's
>>>> a bugfix with a huge change of lines. I would base it on bluetooth,
>>>> because it's a bug fix.
>>> simplifying something is not for -stable or a bug fix. If there is a memory leak, then fix that memory leak first in a separate patch. The rules are pretty clear here. Only bug fixes after the merge window has closed.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Hi,
>>
>> I'll respin and include the memory leak fix and this patch and a couple of
>> others I have and send as a series to bluetooth.  What bluetooth git
>> repository should I base the series on?
>>
> What's the state about to fix this bad issue? :-)
>
> I didn't saw any new patches because of this.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sorry for the delay, been on hols for a few days, I will create the 
patches tomorrow if I get time.

I have also implemented Generic Header Compression[0] which is still in 
draft at the moment but I can't imagine it will change much before being 
released.  I'm going to integrate it into our linux repository this 
week.  Would you be interested in putting it in linux-wpan or 
linux-wpan-next or would you prefer to wait until it gets it RFC status?

[0] http://tools.ietf.org/html/draft-ietf-6lo-ghc-03

- Martin.
