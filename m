Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49338 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbaIPKje (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 06:39:34 -0400
Date: Tue, 16 Sep 2014 12:39:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916103923.GB4969@omega>
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com>
 <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
 <20140916065703.GA1244@omega>
 <54180B1D.7090602@xsilon.com>
 <20140916101747.GA4969@omega>
 <541810B6.3010508@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541810B6.3010508@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 16, 2014 at 11:28:06AM +0100, Martin Townsend wrote:
> 
> On 16/09/14 11:17, Alexander Aring wrote:
> > On Tue, Sep 16, 2014 at 11:04:13AM +0100, Martin Townsend wrote:
> >> Hi Alex,
> >>
> >> On the lowpan_give_skb_to_devices change.
> >>
> >> As we are iterating over a list of lowpan_devices and could potentially copy the skb more than once, what happens if the first device returns NET_RX_DROP and then the second time it return NET_RX_SUCCESS?  The stat variable is overwritten so stat only ever reflects the return value of netif_rx for the last device?
> >>
> >> Maybe it's better to completely remove the if else at the end and always consume the skb?  For the case whereskb_copy fails then we should kfree_skb,
> >> e.g.
> >>
> >> static int lowpan_give_skb_to_devices(struct sk_buff *skb,
> >> 				      struct net_device *dev)
> >> {
> >> 	struct lowpan_dev_record *entry;
> >> 	struct sk_buff *skb_cp;
> >> 	int stat = NET_RX_SUCCESS;
> >>
> >> 	rcu_read_lock();
> >> 	list_for_each_entry_rcu(entry, &lowpan_devices, list)
> >> 		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
> >> 			skb_cp = skb_copy(skb, GFP_ATOMIC);
> >> 			if (!skb_cp) {
> >> 				kfree_skb(skb);
> >> 				rcu_read_unlock();
> >> 				return NET_RX_DROP;
> >> 			}
> >>
> >> 			skb_cp->dev = entry->ldev;
> >> 			stat = netif_rx(skb_cp);
> > here we should do a:
> >
> > if (stat == NET_RX_DROP)
> > 	kfree_skb(skb_cp);
> >
> > or? It doesn't deliver and then we "could" lost the pointer.
> Doesn't netif_rx always free the buffer?

yes, you are right. [0] Now other things makes more sense for me.
Thanks.

I mean there is another deliver function netif_receive_skb and on
comment always stand "Return values (usually ignored)", depends on
context what you need. But netif_rx in this context is right.

Here we should not ignore the return value, because we already are in
the packet layer (the packet layer func callback). The netif_receive_skb 
function we need for putting frames from the driver (some tasklet context)
into the packet layer.


[0] is some function which is called mainly after "netif_rx" function,
"netif_receive_skb" will call this function, too.

- Alex

[0] http://lxr.free-electrons.com/source/net/core/dev.c#L3280
