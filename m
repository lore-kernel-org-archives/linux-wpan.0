Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:60850 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbaJGQRO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 12:17:14 -0400
Date: Tue, 7 Oct 2014 18:17:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141007161709.GB2216@omega>
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>
 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
 <20141007161420.GA2216@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141007161420.GA2216@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

On Tue, Oct 07, 2014 at 06:14:20PM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Tue, Oct 07, 2014 at 04:33:57PM +0100, Martin Townsend wrote:
> > Currently there are potentially 2 skb_copy_expand calls in IPHC
> > decompression.  This patch replaces this with one call to
> > pskb_expand_head.  It also checks to see if there is enough headroom
> > first to ensure it's only done if necessary.
> > As pskb_expand_head must only have one reference the calling code
> > now ensures this.
> > 
> > Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> > ---
> >  net/6lowpan/iphc.c            | 53 ++++++++++++++++++++++---------------------
> >  net/bluetooth/6lowpan.c       | 19 ++++++++++++----
> >  net/ieee802154/6lowpan_rtnl.c | 13 +++++++++++
> >  3 files changed, 55 insertions(+), 30 deletions(-)
> > 
> > diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> > index 142eef5..fa8f348 100644
> > --- a/net/6lowpan/iphc.c
> > +++ b/net/6lowpan/iphc.c
> > @@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
> >  static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
> >  		       struct net_device *dev, skb_delivery_cb deliver_skb)
> >  {
> > -	struct sk_buff *new;
> >  	int stat;
> >  
> > -	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
> > -			      GFP_ATOMIC);
> > -	kfree_skb(skb);
> > -
> > -	if (!new)
> > -		return -ENOMEM;
> > -
> > -	skb_push(new, sizeof(struct ipv6hdr));
> > -	skb_reset_network_header(new);
> > -	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
> > +	skb_push(skb, sizeof(struct ipv6hdr));
> > +	skb_reset_network_header(skb);
> > +	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
> >  
> > -	new->protocol = htons(ETH_P_IPV6);
> > -	new->pkt_type = PACKET_HOST;
> > -	new->dev = dev;
> > +	skb->protocol = htons(ETH_P_IPV6);
> > +	skb->pkt_type = PACKET_HOST;
> > +	skb->dev = dev;
> >  
> >  	raw_dump_table(__func__, "raw skb data dump before receiving",
> > -		       new->data, new->len);
> > +		       skb->data, skb->len);
> >  
> > -	stat = deliver_skb(new, dev);
> > +	stat = deliver_skb(skb, dev);
> >  
> > -	kfree_skb(new);
> > +	kfree_skb(skb);
> >  
> I know what before but "consume_skb"
> 

oh this sentence wasn't complete. I meant:

"I know you didn't touch it but it's consume_skb here:

- Alex
