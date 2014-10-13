Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61379 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaJMJ2u (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 05:28:50 -0400
Message-ID: <543B9B4C.1010303@xsilon.com>
Date: Mon, 13 Oct 2014 10:28:44 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com> <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com> <20141011073620.GA28500@omega> <543B90FA.2060603@xsilon.com> <20141013085538.GA20544@omega>
In-Reply-To: <20141013085538.GA20544@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Alex,

On 13/10/14 09:55, Alexander Aring wrote:
> Hi Martin,
>
> On Mon, Oct 13, 2014 at 09:44:42AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> On 11/10/14 08:36, Alexander Aring wrote:
>>> Hi Martin,
>>>
>>> This is only a summarize what we should now to try to do here for next
>>> version.
>>>
>>> I know... this patch ends in a global debate on principles how we deal
>>> with the replacement of 6LoWPAN -> IPv6 header. Current behaviour is
>>> more a hack.
>>>
>>> On Thu, Oct 09, 2014 at 08:46:34AM +0100, Martin Townsend wrote:
>>>> Currently there are potentially 2 skb_copy_expand calls in IPHC
>>>> decompression.  This patch replaces this with one call to
>>>> pskb_expand_head.  It also checks to see if there is enough headroom
>>>> first to ensure it's only done if necessary.
>>>> As pskb_expand_head must only have one reference the calling code
>>>> now ensures this.
>>>>
>>>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
>>>> ---
>>>>  net/6lowpan/iphc.c      | 51 ++++++++++++++++++++++++-------------------------
>>>>  net/bluetooth/6lowpan.c |  7 +++++++
>>>>  2 files changed, 32 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>>>> index 142eef5..853b4b8 100644
>>>> --- a/net/6lowpan/iphc.c
>>>> +++ b/net/6lowpan/iphc.c
>>>> @@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
>>>>  static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>>>>  		       struct net_device *dev, skb_delivery_cb deliver_skb)
>>>>  {
>>>> -	struct sk_buff *new;
>>>>  	int stat;
>>>>  
>>>> -	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
>>>> -			      GFP_ATOMIC);
>>>> -	kfree_skb(skb);
>>>> -
>>>> -	if (!new)
>>>> -		return -ENOMEM;
>>>> -
>>>> -	skb_push(new, sizeof(struct ipv6hdr));
>>>> -	skb_reset_network_header(new);
>>>> -	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
>>>> +	skb_push(skb, sizeof(struct ipv6hdr));
>>>> +	skb_reset_network_header(skb);
>>>> +	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
>>>>  
>>>> -	new->protocol = htons(ETH_P_IPV6);
>>>> -	new->pkt_type = PACKET_HOST;
>>>> -	new->dev = dev;
>>>> +	skb->protocol = htons(ETH_P_IPV6);
>>>> +	skb->pkt_type = PACKET_HOST;
>>>> +	skb->dev = dev;
>>>>  
>>>>  	raw_dump_table(__func__, "raw skb data dump before receiving",
>>>> -		       new->data, new->len);
>>>> +		       skb->data, skb->len);
>>>>  
>>>> -	stat = deliver_skb(new, dev);
>>>> +	stat = deliver_skb(skb, dev);
>>>>  
>>>> -	kfree_skb(new);
>>>> +	consume_skb(skb);
>>>>  
>>>>  	return stat;
>>>>  }
>>>> @@ -460,7 +452,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>>>  	/* UDP data uncompression */
>>>>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>>>>  		struct udphdr uh;
>>>> -		struct sk_buff *new;
>>>> +		const int needed = sizeof(struct udphdr) + sizeof(hdr);
>>>>  
>>>>  		if (uncompress_udp_header(skb, &uh))
>>>>  			goto drop;
>>>> @@ -468,14 +460,13 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>>>  		/* replace the compressed UDP head by the uncompressed UDP
>>>>  		 * header
>>>>  		 */
>>>> -		new = skb_copy_expand(skb, sizeof(struct udphdr),
>>>> -				      skb_tailroom(skb), GFP_ATOMIC);
>>>> -		kfree_skb(skb);
>>>> -
>>>> -		if (!new)
>>>> -			return -ENOMEM;
>>>> -
>>>> -		skb = new;
>>>> +		if (skb_headroom(skb) < needed) {
>>>> +			err = pskb_expand_head(skb, needed, 0, GFP_ATOMIC);
>>>> +			if (unlikely(err)) {
>>>> +				kfree_skb(skb);
>>>> +				return err;
>>>> +			}
>>>> +		}
>>> use skb_cow_head here.
>> I don't know much about skb_cow_head but from the description it says that only the head is writable which I assume is the newly requested headroom?  I imagine this is for the usual case where you are adding headers and you go through the protocol layers.  For 6lowpan aren't we removing one header and replacing with a decompressed header which would suggest that we are going to modify the data (which would contain the 6lowpan header).
>>
>> skb_cow seems a good fit to me though.
> okay, then use skb_cow here. I will remember that we could possible
> maybe use "skb_cow_head" here. But yea I mean we running lot of pulls
> and move the head pointer, then push now data on it, this would
> overwrite the pulled data and other skb's may not pull here. If the data
> is shared there, this would crash.
>
>>>>  
>>>>  		skb_push(skb, sizeof(struct udphdr));
>>>>  		skb_reset_transport_header(skb);
>>>> @@ -485,6 +476,14 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>>>>  			       (u8 *)&uh, sizeof(uh));
>>>>  
>>>>  		hdr.nexthdr = UIP_PROTO_UDP;
>>>> +	} else {
>>>> +		if (skb_headroom(skb) < sizeof(hdr)) {
>>>> +			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
>>>> +			if (unlikely(err)) {
>>>> +				kfree_skb(skb);
>>>> +				return err;
>>>> +			}
>>>> +		}
>>> same here.
>>>
>>>>  	}
>>>>  
>>>>  	hdr.payload_len = htons(skb->len);
>>>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>>>> index c2e0d14..6643a7c 100644
>>>> --- a/net/bluetooth/6lowpan.c
>>>> +++ b/net/bluetooth/6lowpan.c
>>>> @@ -343,6 +343,13 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>>>  		kfree_skb(local_skb);
>>>>  		kfree_skb(skb);
>>>>  	} else {
>>>> +		/* Decompression may use pskb_expand_head so no shared skb's */
>>>> +		skb = skb_share_check(skb, GFP_ATOMIC);
>>>> +		if (!skb) {
>>>> +			dev->stats.rx_dropped++;
>>>> +			return NET_RX_DROP;
>>>> +		}
>>>> +
>>> I see now that case LOWPAN_DISPATCH_IPHC: runs a "local_skb =
>>> skb_clone(skb, GFP_ATOMIC);" and send the local_skb to process_data. So
>>> is the share_check really needed? In my opinion there are several things
>>> wrong.
>>>
>>> What bluetooth should do here is:
>>>
>>> Always run skb = skb_share_check(skb, GFP_ATOMIC); at first of this function.
>>>
>>> In if (skb->data[0] == LOWPAN_DISPATCH_IPV6):
>>>
>>>  - only run a skb_pull (doesn't change the data buffer, only skb attribute)
>>>    for the one byte dispatch.
>>>  - run other things like skb_reset_network_header, etc...
>>>
>>>  -> Currently this works because we run a complete skb_copy_expand here.
>>>     But this is not needed, we need a clone because we don't modify the
>>>     data buffer.
>>>
>>>  -> To Jukka: I don't see a skb_pull for the one byte dispatch value?
>>>     What's happend here? Also IPv6 dispatch is part of rfc4944 and btle
>>>     6LoWPAN is only realted to rfc6282 (IPHC). I think you don't need handling
>>>     for this here.
>>>
>>>
>>>
>>> In "case LOWPAN_DISPATCH_IPHC:" we should remove the skb_clone, because
>>> this is already handled by "skb_share_check" then.
>> Not necessarily, if the skb isn't shared, ie no-one has called skb_get on it then the clone will not happen.  I tried removing the skb_clone as in theory psk_expand_head should handle cloned skb's but I think it caused the oops that Jukka was seeing.  Because of this I only want to make changes absolutely necessary to get pskb_expand_head or skb_cow working as I can't test the bluetooth code and have to rely on Jukka.
>>
>> If it's ok with everyone I'll change pskb_expand_head to skb_cow or skb_cow_head and leave the bluetooth code as it is with this v5 patch.
> For me it's confusing, you do that on skb, but we never used skb
> afterwards (maybe on freeing) but we use local_skb, the local_skb should
> always be cloned because we running skb_clone before.
skb_clone does ensure that the skb isn't shared anymore so I think it will be safe to remove the skb_share_check.  Or I can move it to the start of the function like we do for 802.15.4?
>
> skb_share_check is a function which checks is the skb shared, then clone
> it. But we don't do anything with skb afterwards.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-Martin.
