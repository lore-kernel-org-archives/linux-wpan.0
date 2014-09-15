Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50789 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbaIOKZK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Sep 2014 06:25:10 -0400
Date: Mon, 15 Sep 2014 12:24:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140915102457.GB10580@omega>
References: <1410514480-9070-1-git-send-email-martin.townsend@xsilon.com>
 <1410514480-9070-3-git-send-email-martin.townsend@xsilon.com>
 <20140915101331.GA10580@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140915101331.GA10580@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

On Mon, Sep 15, 2014 at 12:13:31PM +0200, Alexander Aring wrote:
...
> 
> >  			if (ret == 1) {
> > -				ret = process_data(skb, &hdr);
> > -				if (ret == NET_RX_DROP)
> > +				ret = process_data(&skb, &hdr);
> > +				if (ret < 0)
> >  					goto drop;
> this function returning an errno, you can't return the errno here. goto
> drop returns the ret variable. Maybe just make a return NET_RX_DROP at
> drop. We should never return a different variable.
Oops, I looked at the wong please I mean before drop, when all things
are fine.

> 
> Also this need to be drop_skb at several places in this code, we don't
> have a kfree_skb at process_data anymore. This leaks memory.
> 
> > +			} else {
> > +				return NET_RX_SUCCESS;
> >  			}
> >  			break;
> >  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
> >  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
> 
> same here.
> >  			if (ret == 1) {
> > -				ret = process_data(skb, &hdr);
> > -				if (ret == NET_RX_DROP)
> > +				ret = process_data(&skb, &hdr);
> > +				if (ret < 0)
> >  					goto drop;
> 
> same here.
> 
> > +			} else {
> > +				return NET_RX_SUCCESS;
> >  			}
> >  			break;
> >  		default:
> > @@ -515,7 +514,16 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
> >  		}
> >  	}
> >  

If all things are fine, there is somewhere a return ret;

We should change it to return NET_RX_SUCCESS.

- Alex
