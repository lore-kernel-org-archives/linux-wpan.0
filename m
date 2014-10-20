Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50918 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbaJTVfc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 17:35:32 -0400
Message-ID: <5445801D.30800@xsilon.com>
Date: Mon, 20 Oct 2014 22:35:25 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next 1/4] 6lowpan: remove skb_deliver from
 IPHC
References: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com> <1413815991-5078-2-git-send-email-martin.townsend@xsilon.com> <20141020191855.GB31180@omega>
In-Reply-To: <20141020191855.GB31180@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Alex,

On 20/10/14 20:18, Alexander Aring wrote:
> Hi Martin,
>
> On Mon, Oct 20, 2014 at 03:39:48PM +0100, Martin Townsend wrote:
>> Separating skb delivery from decompression ensures that we can support further
>> decompression schemes and removes the mixed return value of error codes with
>> NET_RX_FOO.
>>
>> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> All your patches have two different "Signed-off-by". Please use only one
> here.
I think I know how this occurred, 2 difference computers with 2 
different git configs :)  I'll fix this in the next series.
>> ---
>>   include/net/6lowpan.h         |  4 +---
>>   net/6lowpan/iphc.c            | 32 ++++++--------------------------
>>   net/bluetooth/6lowpan.c       | 12 +++++++++++-
>>   net/ieee802154/6lowpan_rtnl.c | 26 ++++++++++++++------------
>>   4 files changed, 32 insertions(+), 42 deletions(-)
>>
> ...
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index 6c5c2ef..03787e0 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -290,7 +290,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>>   	return lowpan_process_data(skb, netdev,
>>   				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>>   				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>> -				   iphc0, iphc1, give_skb_to_upper);
>> +				   iphc0, iphc1);
>>   
>>   drop:
>>   	kfree_skb(skb);
>> @@ -350,6 +350,16 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>   			if (ret != NET_RX_SUCCESS)
>>   				goto drop;
>>   
>> +			local_skb->protocol = htons(ETH_P_IPV6);
>> +			local_skb->pkt_type = PACKET_HOST;
>> +			local_skb->dev = dev;
>> +
>> +			if (give_skb_to_upper(local_skb, dev)
>> +					!= NET_RX_SUCCESS) {
> There is still a  NET_RX_FOO and errno conversion in function
> "give_skb_to_upper". Please check that, maybe introduce a new patch for
> this one.
I thought give_skb_to_upper only returned NET_RX_FOO return values? I'll 
double check and fix.
>
>> +				kfree_skb(local_skb);
>> +				goto drop;
>> +			}
>> +
>>   			dev->stats.rx_bytes += skb->len;
>>   			dev->stats.rx_packets++;
>>   
>> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
>> index 0c1a49b..898d317 100644
>> --- a/net/ieee802154/6lowpan_rtnl.c
>> +++ b/net/ieee802154/6lowpan_rtnl.c
>> @@ -146,8 +146,9 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
>>   		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
>>   			skb_cp = skb_copy(skb, GFP_ATOMIC);
>>   			if (!skb_cp) {
>> -				stat = -ENOMEM;
>> -				break;
>> +				kfree_skb(skb);
>> +				rcu_read_unlock();
>> +				return NET_RX_DROP;
>>   			}
>>   
>>   			skb_cp->dev = entry->ldev;
>> @@ -155,6 +156,11 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
>>   		}
>>   	rcu_read_unlock();
>>   
>> +	if (stat == NET_RX_SUCCESS)
>> +		consume_skb(skb);
>> +	else
>> +		kfree_skb(skb);
>> +
> You will not see it because somebody forgot brackets in the above
> "list_for_each_entry_rcu" loop. But variable "stat" in this case is only
> for the last entry of netif_rx call.
This is a bug that's probably outside the scope of this patch.
> Also if netif_rx returns NET_RX_DROP, which is the else branch in this
> case. In case of netif_rx the skb will be freed somewhere else.
>
> Calltrace:
>
> - netif_rx
> - netif_rx_internal
> - enqueue_to_backlog
>    - kfree_skb(skb);
>    - return NET_RX_DROP;
The copy will be freed not the skb that is passed to the function.
     skb_cp = skb_copy(skb, GFP_ATOMIC);
     ....
     stat = netif_rx(skb_cp);

What to do with stat that is set multiple times in a loop.  We could 
call skb_consume if stat is always NET_RX_SUCCESS or call skb_consume if 
stat is at least NET_RX_SUCCESS once, or maybe remove the loop further 
out the call chain  ...   if possible??

>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
- Martin.
