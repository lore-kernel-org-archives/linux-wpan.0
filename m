Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38490 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368AbbHLJV1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Aug 2015 05:21:27 -0400
Received: by wicja10 with SMTP id ja10so19199810wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 12 Aug 2015 02:21:25 -0700 (PDT)
Date: Wed, 12 Aug 2015 11:21:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 06/16] ieee802154: 6lowpan: trivial checks at first
Message-ID: <20150812092118.GB31881@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
 <55CB0C12.4050001@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55CB0C12.4050001@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Aug 12, 2015 at 11:04:18AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 03/08/15 08:23, Alexander Aring wrote:
> >This patch moves some trivial checks at first before calling
> >skb_share_check which could do some memcpy if the buffer is shared.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  net/ieee802154/6lowpan/rx.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> >diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> >index 7b6b038..11a5629 100644
> >--- a/net/ieee802154/6lowpan/rx.c
> >+++ b/net/ieee802154/6lowpan/rx.c
> >@@ -62,16 +62,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
> >  	struct ieee802154_hdr hdr;
> >  	int ret;
> >+	if (skb->pkt_type == PACKET_OTHERHOST ||
> >+	    wdev->type != ARPHRD_IEEE802154)
> >+		goto drop;
> >+
> >  	skb = skb_share_check(skb, GFP_ATOMIC);
> >  	if (!skb)
> >  		goto drop;
> >-	if (skb->pkt_type == PACKET_OTHERHOST)
> >-		goto drop_skb;
> >-
> >-	if (wdev->type != ARPHRD_IEEE802154)
> >-		goto drop_skb;
> >-
> >  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
> >  		goto drop_skb;
> 
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> 

Maybe I should switch also the conditions, means first check on
wdev-type. Because this function is called for all registered net_devices
(in my opinion) and do first check on type ARPHRD_IEEE802154 sounds more
resonable. We don't care about the other stuff (means different types).

In short: I think "wdev->type != ARPHRD_IEEE802154" is a more likely case
than "skb->pkt_type == PACKET_OTHERHOST".

- Alex
