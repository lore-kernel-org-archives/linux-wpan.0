Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64255 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbaIPKEZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 06:04:25 -0400
Message-ID: <54180B1D.7090602@xsilon.com>
Date: Tue, 16 Sep 2014 11:04:13 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com> <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com> <20140916065703.GA1244@omega>
In-Reply-To: <20140916065703.GA1244@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On the lowpan_give_skb_to_devices change.

As we are iterating over a list of lowpan_devices and could potentially copy the skb more than once, what happens if the first device returns NET_RX_DROP and then the second time it return NET_RX_SUCCESS?  The stat variable is overwritten so stat only ever reflects the return value of netif_rx for the last device?

Maybe it's better to completely remove the if else at the end and always consume the skb?  For the case whereskb_copy fails then we should kfree_skb,
e.g.

static int lowpan_give_skb_to_devices(struct sk_buff *skb,
				      struct net_device *dev)
{
	struct lowpan_dev_record *entry;
	struct sk_buff *skb_cp;
	int stat = NET_RX_SUCCESS;

	rcu_read_lock();
	list_for_each_entry_rcu(entry, &lowpan_devices, list)
		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
			skb_cp = skb_copy(skb, GFP_ATOMIC);
			if (!skb_cp) {
				kfree_skb(skb);
				rcu_read_unlock();
				return NET_RX_DROP;
			}

			skb_cp->dev = entry->ldev;
			stat = netif_rx(skb_cp);
		}
	rcu_read_unlock();

	consume_skb(skb);

	return stat;
}


 what are your thoughts?

-Martin.


On 16/09/14 07:57, Alexander Aring wrote:
>
> --- snap
>
> Ignore the below one, I will only note about this... that we don't
> forget that.
>
> This code should be a generic function for increasing headroom for
> decompressing headers (IPv6, next hdr's). Still issues with
> consume_skb/kfree_skb here.
>
>
> +	if (stat < 0) {
> +		kfree_skb(skb);
> +		stat = NET_RX_DROP;
> +	} else {
> +		consume_skb(skb);
> +	}
> This basically works now, but it confuse developers.
>
> Look how stat is initzialed.
> There is mixed errno and NET_RX_FOO handling here. Which is part of the
> complete error handling mess. And correct freeing of skb's required a
> correct error handling.
>
> The function looks now like this:
>
>         struct lowpan_dev_record *entry;
>         struct sk_buff *skb_cp;
>         int stat = NET_RX_SUCCESS;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(entry, &lowpan_devices, list)
>                 if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
>                         skb_cp = skb_copy(skb, GFP_ATOMIC);
>                         if (!skb_cp) {
>                                 stat = -ENOMEM;
> Simple assign stat = NET_RX_DROP.
>                                 break;
>                         }
>
>                         skb_cp->dev = entry->ldev;
>                         stat = netif_rx(skb_cp);
>                 }
>         rcu_read_unlock();          
>         
>         if (stat < 0) {
> remove brackets and check on NET_RX_DROP. or vice versa.
>                 kfree_skb(skb);
>                 stat = NET_RX_DROP;
>         } else {                
>                 consume_skb(skb);
>         }
>         return stat;
>
> Now if the list is empty we check if (stat < 0) with a NET_RX_FOO stuff,
> we should avoid that. I mean the current situation is because somebody
> mixed this stuff and that's why we have this now.
>
> Another developers look of some code (that's what I did) and see, aaah
> returning NET_RX_FOO so we can check on it, but at this situation he
> need to think a little bit more what it is the correct handline because
> there is still some errno conversion.
>
>>  	return stat;
>>  }
>>  

