Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43642 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbeDXALl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Apr 2018 20:11:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id j11so10668713pff.10
        for <linux-wpan@vger.kernel.org>; Mon, 23 Apr 2018 17:11:41 -0700 (PDT)
Subject: Re: [PATCH wpan] net: ieee802154: 6lowpan: fix frag reassembly
References: <20180420185413.8818-1-aring@mojatatu.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <da1db914-bf92-ac44-9f60-5e5dfbc59b94@gmail.com>
Date: Mon, 23 Apr 2018 17:11:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180420185413.8818-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com



On 04/20/2018 11:54 AM, Alexander Aring wrote:
> This patch initialize stack variables which are used in
> frag_lowpan_compare_key to zero. In my case there are padding bytes in the
> structures ieee802154_addr as well in frag_lowpan_compare_key. Otherwise
> the key variable contains random bytes. The result is that a compare of
> two keys by memcmp works incorrect.
> 
> Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> So far I see it's a case of 32 alignment in frag_v4_compare_key and
> frag_v6_compare_key and I am not sure about if this works on all arch
> correctly.
> 
>  net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
>  net/ieee802154/6lowpan/reassembly.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> index b8d95cb71c25..44a7e16bf3b5 100644
> --- a/net/ieee802154/6lowpan/6lowpan_i.h
> +++ b/net/ieee802154/6lowpan/6lowpan_i.h
> @@ -20,8 +20,8 @@ typedef unsigned __bitwise lowpan_rx_result;
>  struct frag_lowpan_compare_key {
>  	u16 tag;
>  	u16 d_size;
> -	const struct ieee802154_addr src;
> -	const struct ieee802154_addr dst;
> +	struct ieee802154_addr src;
> +	struct ieee802154_addr dst;
>  };
>  
>  /* Equivalent of ipv4 struct ipq
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index 1790b65944b3..2cc224106b69 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -75,14 +75,14 @@ fq_find(struct net *net, const struct lowpan_802154_cb *cb,
>  {
>  	struct netns_ieee802154_lowpan *ieee802154_lowpan =
>  		net_ieee802154_lowpan(net);
> -	struct frag_lowpan_compare_key key = {
> -		.tag = cb->d_tag,
> -		.d_size = cb->d_size,
> -		.src = *src,
> -		.dst = *dst,
> -	};
> +	struct frag_lowpan_compare_key key = {};
>  	struct inet_frag_queue *q;
>  
> +	key.tag = cb->d_tag;
> +	key.d_size = cb->d_size;
> +	key.src = *src;
> +	key.dst = *dst;
> +
>  	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
>  	if (!q)
>  		return NULL;
> @@ -372,7 +372,7 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
>  	struct lowpan_frag_queue *fq;
>  	struct net *net = dev_net(skb->dev);
>  	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
> -	struct ieee802154_hdr hdr;
> +	struct ieee802154_hdr hdr = {};
>  	int err;
>  
>  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
> 

Hi Alexander.

Thanks for working on this !

It looks like only the last chunk was really needed to fix this bug, right ?

Compiler should really init everything, and not leave garbage bytes in :

	struct frag_lowpan_compare_key key = {
		.tag = cb->d_tag,
		.d_size = cb->d_size,
		.src = *src,
		.dst = *dst,
	};


