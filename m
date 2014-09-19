Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65206 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbaISOOQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 10:14:16 -0400
Message-ID: <541C3A36.4090803@xsilon.com>
Date: Fri, 19 Sep 2014 15:14:14 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <541AE5E9.3000407@xsilon.com> <20140918141911.GA9262@omega> <20140919110854.GA21364@omega> <541C133A.7010000@xsilon.com> <20140919114549.GA22396@omega> <541C1AC2.1010308@xsilon.com> <20140919120630.GA23106@omega> <20140919123824.GA2407@omega> <541C2536.5080308@xsilon.com> <20140919125544.GA2500@omega> <20140919125705.GB2500@omega>
In-Reply-To: <20140919125705.GB2500@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

I have implemented and tested the fix and it seems to work!
I used a combination of skb_unshare and pulled some of your wpan_rework 
changes in so the compression is done in lowpan_xmit.

Simon

On 19/09/14 13:57, Alexander Aring wrote:
> On Fri, Sep 19, 2014 at 02:55:44PM +0200, Alexander Aring wrote:
>> Hi Simon,
>>
>> On Fri, Sep 19, 2014 at 01:44:38PM +0100, Simon Vincent wrote:
>> ...
>>>> mhh, take a look on skb_unshare - make a copy of a shared buffe [0].
>>>>
>>>> Seems that we could use that to have a copy of the buffer. Don't know if
>>>> this can work, because we are inside of callback and the caller lost the
>>>> reference then.
>>> I tried that earlier! Didn't work as we lost the reference as you say.
>>> I think if we do it inside lowpan_xmit like you do in your rework we might
>>> be ok. I will have a go.
>>>
>> Yea, with combination of lowpan_xmit and do a:
>>
>> skb = skb_unshare(skb, GFP_ATOMIC);
>>
>> it's woooorrkkinnnnggg.
>>
> I hope it's working now, it doesn't look like garbage anymore.
>
> - Alex

