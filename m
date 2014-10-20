Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35235 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaJTTZu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 15:25:50 -0400
Date: Mon, 20 Oct 2014 21:25:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next 1/4] 6lowpan: remove skb_deliver from
 IPHC
Message-ID: <20141020192541.GA1630@omega>
References: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com>
 <1413815991-5078-2-git-send-email-martin.townsend@xsilon.com>
 <20141020191855.GB31180@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141020191855.GB31180@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

On Mon, Oct 20, 2014 at 09:18:55PM +0200, Alexander Aring wrote:

...

> >  
> > diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> > index 0c1a49b..898d317 100644
> > --- a/net/ieee802154/6lowpan_rtnl.c
> > +++ b/net/ieee802154/6lowpan_rtnl.c
> > @@ -146,8 +146,9 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
> >  		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
> >  			skb_cp = skb_copy(skb, GFP_ATOMIC);
> >  			if (!skb_cp) {
> > -				stat = -ENOMEM;
> > -				break;
> > +				kfree_skb(skb);
> > +				rcu_read_unlock();
> > +				return NET_RX_DROP;
> >  			}
> >  
> >  			skb_cp->dev = entry->ldev;
> > @@ -155,6 +156,11 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
> >  		}
> >  	rcu_read_unlock();
> >  
> > +	if (stat == NET_RX_SUCCESS)
> > +		consume_skb(skb);
> > +	else
> > +		kfree_skb(skb);
> > +
> 
> You will not see it because somebody forgot brackets in the above
> "list_for_each_entry_rcu" loop. But variable "stat" in this case is only
> for the last entry of netif_rx call.
> 
> Also if netif_rx returns NET_RX_DROP, which is the else branch in this
> case. In case of netif_rx the skb will be freed somewhere else.
> 
> Calltrace:
> 
> - netif_rx
> - netif_rx_internal
> - enqueue_to_backlog
>   - kfree_skb(skb);
>   - return NET_RX_DROP;
> 

I think, we need here something like:

stat = netif_rx(foo);
if (stat == NET_RX_SUCCESS)
	consume_skb(foo);

inside the loop.

- Alex
