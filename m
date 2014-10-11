Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:54864 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaJKGzt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Oct 2014 02:55:49 -0400
Date: Sat, 11 Oct 2014 08:55:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141011065541.GA27638@omega>
References: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com>
 <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
 <20141010194116.GA31843@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141010194116.GA31843@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>, werner@almesberger.net

Hi Martin,

On Fri, Oct 10, 2014 at 09:41:16PM +0200, Alexander Aring wrote:

...

> >  	hdr.payload_len = htons(skb->len);
> > diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> > index c2e0d14..6643a7c 100644
> > --- a/net/bluetooth/6lowpan.c
> > +++ b/net/bluetooth/6lowpan.c
> > @@ -343,6 +343,13 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> >  		kfree_skb(local_skb);
> >  		kfree_skb(skb);
> >  	} else {
> > +		/* Decompression may use pskb_expand_head so no shared skb's */
> > +		skb = skb_share_check(skb, GFP_ATOMIC);
> > +		if (!skb) {
> > +			dev->stats.rx_dropped++;
> > +			return NET_RX_DROP;
> > +		}
> > +
> >  		switch (skb->data[0] & 0xe0) {
> >  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> >  			local_skb = skb_clone(skb, GFP_ATOMIC);
> 
> 
> Now we come to this function.
> 
> There exist two global rules here:
> 
> 1.
> 
> If we change only the skb pointers head/tail with e.g. skb_push then we
> need a cloned skb only. We don't change the skb data buffer here.
> 
> We need this in LOWPAN_DISPATCH_IPV6, here we run only one skb_pull for
> one byte, and the FRAGN and FRAG1 dispatches in 802.15.4 6LoWPAN.
> 
> skb_share_check do this, we have surely a clone afterwards and the
> sk_buff attributes are not changed elsewhere, which means we are
> allowed to manipulate the skb attributes.
> 
> 2.
> 
> If we touch the data buffer, then we need a skb_copy. We need this at
> LOWPAN_DISPATCH_IPHC because here we replacing the data buffer.
> 
> skb_unshare do this for us.
> 

This is not correct. I mean the chain of thought is correct. But a
private copy of data buffer is already done by pskb_expand_head, which
is used before modify the data buffer. If we should not run it, then it
would be correct. This handling is done by decompression IPHC.

So we don't need skb_unshare. Now it's very interesting if we can use
skb_cow_head, when replacing transport/network header, because we only
need to modify the headroom. Otherwise we should use skb_cow.

- Alex
