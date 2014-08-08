Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63734 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbaHHGij (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 02:38:39 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so6671897pad.8
        for <linux-wpan@vger.kernel.org>; Thu, 07 Aug 2014 23:38:39 -0700 (PDT)
Message-ID: <53E4700E.5020506@gmail.com>
Date: Fri, 08 Aug 2014 12:07:02 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
References: <1407479079-5114-1-git-send-email-alex.aring@gmail.com> <20140808062814.GA20055@omega>
In-Reply-To: <20140808062814.GA20055@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next] 6lowpan_rtnl: fix correct return of errno value
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

On 08/08/2014 11:58 AM, Alexander Aring wrote:
> On Fri, Aug 08, 2014 at 08:24:39AM +0200, Alexander Aring wrote:
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> ---
>>   net/ieee802154/6lowpan_rtnl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
>> index 0acd273..b6ec3b1 100644
>> --- a/net/ieee802154/6lowpan_rtnl.c
>> +++ b/net/ieee802154/6lowpan_rtnl.c
>> @@ -238,7 +238,7 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
>>   			return ERR_PTR(-rc);
>>   		}
>>   	} else {
>> -		frag = ERR_PTR(ENOMEM);
>> +		frag = ERR_PTR(-ENOMEM);
>>   	}
>>   
>>   	return frag;
>> -- 
>> 2.0.3
>>
> Sorry, I will also add a "ieee802154: " to beginning of this commit msg.
>
Also some description about patch..?

-- 
Regards,
Varka Bhadram.

