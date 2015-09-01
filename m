Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33248 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595AbbIAHx2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 1 Sep 2015 03:53:28 -0400
Subject: Re: [RFCv2 bluetooth-next 09/16] ieee802154: 6lowpan: earlier
 skb->dev switch
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-10-git-send-email-alex.aring@gmail.com>
 <55E37B85.8020705@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E55975.10303@osg.samsung.com>
Date: Tue, 1 Sep 2015 09:53:25 +0200
MIME-Version: 1.0
In-Reply-To: <55E37B85.8020705@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/08/15 23:54, Stefan Schmidt wrote:
> Hello.
>
> On 20/08/15 18:47, Alexander Aring wrote:
>> We should change the skb->dev pointer earlier to the lowpan interface
>> Sometimes we call iphc_decompress which also use some netdev printout
>> functionality. This patch will change that the correct interface will be
>> displayed in this case, which should be the lowpan interface.
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> ---
>>   net/ieee802154/6lowpan/rx.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
>> index 74d8fec..f9cb70b 100644
>> --- a/net/ieee802154/6lowpan/rx.c
>> +++ b/net/ieee802154/6lowpan/rx.c
>> @@ -18,7 +18,6 @@
>>   static int lowpan_give_skb_to_device(struct sk_buff *skb,
>>                        struct net_device *wdev)
>>   {
>> -    skb->dev = wdev->ieee802154_ptr->lowpan_dev;
>>       skb->protocol = htons(ETH_P_IPV6);
>>       skb->pkt_type = PACKET_HOST;
>>   @@ -71,9 +70,11 @@ static int lowpan_rcv(struct sk_buff *skb, 
>> struct net_device *wdev,
>>       if (!ldev || !netif_running(ldev))
>>           goto drop;
>>   +    /* Replacing skb->dev and followed rx handlers will manipulate 
>> skb. */
>>       skb = skb_share_check(skb, GFP_ATOMIC);
>>       if (!skb)
>>           goto drop;
>> +    skb->dev = ldev;
>>         if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
>>           goto drop_skb;
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>

This should also have been

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
