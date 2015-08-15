Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38745 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbbHOJPW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 05:15:22 -0400
Received: by wicja10 with SMTP id ja10so40882135wic.1
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2015 02:15:21 -0700 (PDT)
Date: Sat, 15 Aug 2015 11:15:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 06/16] ieee802154: 6lowpan: trivial checks at first
Message-ID: <20150815091514.GA5795@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On Mon, Aug 03, 2015 at 08:23:45AM +0200, Alexander Aring wrote:
> This patch moves some trivial checks at first before calling
> skb_share_check which could do some memcpy if the buffer is shared.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/ieee802154/6lowpan/rx.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 7b6b038..11a5629 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -62,16 +62,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
>  	struct ieee802154_hdr hdr;
>  	int ret;
>  
> +	if (skb->pkt_type == PACKET_OTHERHOST ||
> +	    wdev->type != ARPHRD_IEEE802154)
> +		goto drop;
> +
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
>  		goto drop;

mhhh, nothing according to the patch but I think "skb_share_check" is
wrong here and this depends on the dispatch value.

Why it's wrong?

When we do iphc_decompress we manipulate the buffer but "skb_share_check"
unshare the "skb structure" only.


That's the different between skb_clone and skb_copy. skb_clone doesn't
"copy" the buffer, the buffer is still shared afterwards when it's
shared.

Sometimes like ipv6 dispatch we only run skb_pull, then we need
"skb_share_check" only, because skb_pull doesn't manipulate the buffer,
it's doing only some pointer moving inside "skb structure" so skb_clone
if it's shared is enough, skb_clone is too much.

I would remove this from the lowpan_rcv and we need to care that this
function does read_only on "skb buffer" and "skb structure", then we
don't need to call anything.

To do "skb_share_check" (skb_clone if shared) or "skb_unshare" (skb_copy
if shared), should be handled by the dispatch handlers lowpan_rx_h_ipv6,
lowpan_rx_h_iphc, lowpan_rx_h_....

- Alex
