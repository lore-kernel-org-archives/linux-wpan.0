Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61716 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbaIPMkg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 08:40:36 -0400
Message-ID: <54182FB8.4080103@xsilon.com>
Date: Tue, 16 Sep 2014 13:40:24 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <1410865319-16310-1-git-send-email-martin.townsend@xsilon.com> <1410865319-16310-2-git-send-email-martin.townsend@xsilon.com> <20140916113614.GC4969@omega> <5418215F.5050308@xsilon.com> <20140916114759.GD4969@omega> <20140916115357.GE4969@omega> <20140916120247.GA5217@omega> <20140916121844.GA5349@omega> <54182C6B.6090801@xsilon.com> <20140916123421.GA5576@omega>
In-Reply-To: <20140916123421.GA5576@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com


On 16/09/14 13:34, Alexander Aring wrote:
> On Tue, Sep 16, 2014 at 01:26:19PM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> On 16/09/14 13:18, Alexander Aring wrote:
>>> On Tue, Sep 16, 2014 at 02:02:47PM +0200, Alexander Aring wrote:
>>>> On Tue, Sep 16, 2014 at 01:53:57PM +0200, Alexander Aring wrote:
>>>>> On Tue, Sep 16, 2014 at 01:47:59PM +0200, Alexander Aring wrote:
>>>>>> On Tue, Sep 16, 2014 at 12:39:11PM +0100, Martin Townsend wrote:
>>>>>>> Hi Alex,
>>>>>>> On 16/09/14 12:36, Alexander Aring wrote:
>>>>>>>> On Tue, Sep 16, 2014 at 12:01:59PM +0100, Martin Townsend wrote:
>>>>> ...
>>>>>> and this also smells like side effects for me, because we have the
>>>>>> local_skb which is sometimes freed inside of lowpan_process_data and
>>>>>> returning skb. Then we don't know which we should kfree_skb now, the skb
>>>>>> or local_skb now. Need to thing more about this to offer some solution,
>>>>>> somebody agree here with me?
>>>>>>
>>>>> I mean sometimes we do this *skb = *new and skb is the parameter and before we
>>>>> did a consume_skb(skb); then local_skb is already freed after this and
>>>>> returning an errno and we make kfree_skb(local_skb) will crash something,
>>>>> I suppose.
>>>> I meant skb = new for the expand skb thing. And we can't never free
>>>> kfree_skb(skb) here if (IS_ERR(skb) is true, but we can't decide if
>>>> we need a kfree_skb(local_skb) or not, because we do a
>>>> consume_skb($SKB_FROM_PARAMTER) in lowpan_process_data.
>>>>
>>> This all comes now in, because the ERR_PTR conversion. So we have two
>>> choices:
>>>
>>>  - drop the ERR_PTR convertsion and make old behaviour
>>>  - handle consume_skb/kfree_skb inside lowpan_process_data
>>>
>>> - Alex
>>>
>> How about a label for drop_local_skb?
>>
>> 		switch (skb->data[0] & 0xe0) {
>> 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
>> 			local_skb = skb_clone(skb, GFP_ATOMIC);
>> 			if (!local_skb)
>> 				goto drop;
>>
>> 			local_skb = process_data(local_skb, dev, chan);
>> 			if (IS_ERR(local_skb))
>> 				goto drop_local_skb;
>>
>> 			local_skb->protocol = htons(ETH_P_IPV6);
>> 			local_skb->pkt_type = PACKET_HOST;
>>
>> 			if (give_skb_to_upper(local_skb, dev)
>> 							!= NET_RX_SUCCESS) {
>> 				kfree_skb(local_skb);
>> 				goto drop;
>> 			}
>>
>> 			dev->stats.rx_bytes += skb->len;
>> 			dev->stats.rx_packets++;
>>
>> 			kfree_skb(skb);
>> 			break;
>> 		default:
>> 			break;
>> 		}
>> 	}
>>
>> 	return NET_RX_SUCCESS;
>>
>> drop_local_skb:
>> 	kfree_skb(local_skb);
> no this can't work, when IS_ERR(local_skb) is true, local_skb is an
> invalid pointer some "((void *) -errno)", you can rescue it with if
> (!IS_ERR(local_skb)), but... I don't know it looks complicated. :-)
>
> What I mean is in lowpan_process_data you have a paramater skb and a skb
> as return value.
>
> Sometimes we need a consume_skb($PARAMETER_SKB), because we make the
> copy_expand. After this the $PARAMETER_SKB is invalid and we have the
> $RETURN_SKB as our new skb.
>
> We don't know here if we need a kfree_skb($PARAMETER_SKB) or not because
> we don't know if we did a consume_skb($PARAMETER_SKB). I think the error
> handling need to be in lowpan_process_data again or make something which
> handle this case.
>
>
> I hope it was understandable what I mean here.
>
> - Alex

Yes I see the problem now, maybe it's better to revert back to skb_inout, less chance of introducing bugs and then we have a well defined return value.

- Martin.
