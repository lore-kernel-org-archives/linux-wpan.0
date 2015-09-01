Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33253 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbbIAH4t (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Sep 2015 03:56:49 -0400
Subject: Re: [RFCv2 bluetooth-next 13/16] ieee802154: 6lowpan: add check for
 reserved dispatch
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-14-git-send-email-alex.aring@gmail.com>
 <55E37D16.8010901@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E55A3E.2090404@osg.samsung.com>
Date: Tue, 1 Sep 2015 09:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <55E37D16.8010901@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 31/08/15 00:00, Stefan Schmidt wrote:
> Hello.
>
> On 20/08/15 18:47, Alexander Aring wrote:
>> This patch adds checks for reserved dispatch value. When we have a
>> reserved dispatch value we should drop the skb immediately.
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> ---
>>   net/ieee802154/6lowpan/rx.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
>> index d309d91..f98ebf5 100644
>> --- a/net/ieee802154/6lowpan/rx.c
>> +++ b/net/ieee802154/6lowpan/rx.c
>> @@ -260,6 +260,17 @@ static inline bool lowpan_is_nalp(u8 dispatch)
>>       return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
>>   }
>>   +/* Lookup for reserved dispatch values at:
>> + * 
>> https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
> It might be worth noting down the update date here as well. The do not 
> seem to have a version I can find easily so the update date might be a 
> good idea to help helping looking at it to decide if we should update 
> our code.
>
>> + */
>> +static inline bool lowpan_is_reserved(u8 dispatch)
>> +{
>> +    return ((dispatch >= 0x44 && dispatch <= 0x4F) ||
>> +        (dispatch >= 0x51 && dispatch <= 0x5F) ||
>> +        (dispatch >= 0xc8 && dispatch <= 0xdf) ||
>> +        (dispatch >= 0xe8 && dispatch <= 0xff));
>> +}
>> +
>>   /* lowpan_rx_h_check checks on generic 6LoWPAN requirements
>>    * in MAC and 6LoWPAN header.
>>    *
>> @@ -271,7 +282,8 @@ static inline bool lowpan_rx_h_check(struct 
>> sk_buff *skb)
>>       if (unlikely(!skb->len))
>>           return false;
>>   -    if (lowpan_is_nalp(*skb_network_header(skb)))
>> +    if (lowpan_is_nalp(*skb_network_header(skb)) ||
>> +        lowpan_is_reserved(*skb_network_header(skb)))
>>           return false;
>>         return true;
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>

This should also have been

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
