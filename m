Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33245 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605AbbIAHxF (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Sep 2015 03:53:05 -0400
Subject: Re: [RFCv2 bluetooth-next 06/16] ieee802154: 6lowpan: change if
 lowpan dev is running
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-7-git-send-email-alex.aring@gmail.com>
 <55E37AEF.80703@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E5595E.8020709@osg.samsung.com>
Date: Tue, 1 Sep 2015 09:53:02 +0200
MIME-Version: 1.0
In-Reply-To: <55E37AEF.80703@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/08/15 23:51, Stefan Schmidt wrote:
> Hello.
>
> On 20/08/15 18:47, Alexander Aring wrote:
>> We don't need to check if the wpan interface is running because the
>> lowpan_rcv is the packet layer receive handler for the wpan interface.
>>
>> Instead doing a check if wpan interface is running we should check if
>> the lowpan interface is running before starting 6lowpan adaptation 
>> layer.
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> ---
>>   net/ieee802154/6lowpan/rx.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
>> index b1442f3..c529d9f 100644
>> --- a/net/ieee802154/6lowpan/rx.c
>> +++ b/net/ieee802154/6lowpan/rx.c
>> @@ -65,19 +65,20 @@ static int lowpan_rcv(struct sk_buff *skb, struct 
>> net_device *wdev,
>>                 struct packet_type *pt, struct net_device *orig_wdev)
>>   {
>>       struct ieee802154_hdr hdr;
>> +    struct net_device *ldev;
>>       int ret;
>>   -    if (wdev->type != ARPHRD_IEEE802154 ||
>> -        !wdev->ieee802154_ptr->lowpan_dev)
>> +    if (wdev->type != ARPHRD_IEEE802154)
>> +        goto drop;
>> +
>> +    ldev = wdev->ieee802154_ptr->lowpan_dev;
>> +    if (!ldev || !netif_running(ldev))
>>           goto drop;
>>         skb = skb_share_check(skb, GFP_ATOMIC);
>>       if (!skb)
>>           goto drop;
>>   -    if (!netif_running(wdev))
>> -        goto drop_skb;
>> -
>>       if (skb->pkt_type == PACKET_OTHERHOST)
>>           goto drop_skb;
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>

This should also have been

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
