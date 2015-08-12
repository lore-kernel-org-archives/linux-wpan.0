Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36509 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932885AbbHLJ0N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Aug 2015 05:26:13 -0400
Received: by wicja10 with SMTP id ja10so105622739wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 12 Aug 2015 02:26:12 -0700 (PDT)
Date: Wed, 12 Aug 2015 11:26:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 08/16] ieee802154: 6lowpan: change frag return value
 handling
Message-ID: <20150812092604.GC31881@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-9-git-send-email-alex.aring@gmail.com>
 <55CB0E63.7040909@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55CB0E63.7040909@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Aug 12, 2015 at 11:14:11AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 03/08/15 08:23, Alexander Aring wrote:
> >The function lowpan_frag_rcv does return only:
> >
> >  - "1": skb is reassmbled
> >  - "-1": skb is putted into the frag bucket or failure.
> >
> >Other values can't happend. This patch will change that we return on "1"
> >the return value of netif_rx and "-1" to NET_RX_DROP, which means that
> >the packet doesn't reach the next layer.
> >
> >Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> >---
> >  net/ieee802154/6lowpan/rx.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> >diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> >index 3871804a..bf6e857 100644
> >--- a/net/ieee802154/6lowpan/rx.c
> >+++ b/net/ieee802154/6lowpan/rx.c
> >@@ -94,11 +94,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
> >  					goto drop_skb;
> >  				return lowpan_give_skb_to_device(skb);
> >-			} else if (ret == -1) {
> >-				return NET_RX_DROP;
> >-			} else {
> >-				return NET_RX_SUCCESS;
> >  			}
> >+
> >+			return NET_RX_DROP;
> >  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
> >  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
> >  			if (ret == 1) {
> >@@ -107,11 +105,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
> >  					goto drop_skb;
> >  				return lowpan_give_skb_to_device(skb);
> >-			} else if (ret == -1) {
> >-				return NET_RX_DROP;
> >-			} else {
> >-				return NET_RX_SUCCESS;
> >  			}
> >+
> >+			return NET_RX_DROP;
> >  		default:
> >  			break;
> >  		}
> 
> Looking at the next patch (9) to me it looks like this one could get folded
> in it as the part you change here gets a rewrite anyway.
> 

ok.

- Alex
