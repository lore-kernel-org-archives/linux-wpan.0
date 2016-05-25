Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32854 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcEYFXo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 May 2016 01:23:44 -0400
Received: by mail-pa0-f41.google.com with SMTP id xk12so13956878pac.0
        for <linux-wpan@vger.kernel.org>; Tue, 24 May 2016 22:23:44 -0700 (PDT)
Subject: Re: [RFC 04/12] ndisc: get rid off dev parameter in
 ndisc_opt_addr_space
References: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
 <1464031328-17524-5-git-send-email-aar@pengutronix.de>
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <574534F8.20308@miraclelinux.com>
Date: Wed, 25 May 2016 14:15:36 +0900
MIME-Version: 1.0
In-Reply-To: <1464031328-17524-5-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: hideaki.yoshifuji@miraclelinux.com, kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>



Alexander Aring wrote:
> This patch removes the net_device parameter from ndisc_opt_addr_space
> function. This can be useful for calling such functionality which
> doesn't depends on dev parameter. For current existing functionality
> which depends on dev parameter, we introduce ndisc_dev_opt_addr_space to have
> an easy replacement for the ndisc_opt_addr_space function.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  include/net/ndisc.h | 13 +++++++++----
>  net/ipv6/ndisc.c    | 12 ++++++------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> index 2d8edaa..dbc8d01 100644
> --- a/include/net/ndisc.h
> +++ b/include/net/ndisc.h
> @@ -127,10 +127,15 @@ static inline int ndisc_addr_option_pad(unsigned short type)
>  	}
>  }
>  
> -static inline int ndisc_opt_addr_space(struct net_device *dev)
> +static inline int ndisc_opt_addr_space(unsigned char addr_len, int pad)
>  {
> -	return NDISC_OPT_SPACE(dev->addr_len +
> -			       ndisc_addr_option_pad(dev->type));
> +	return NDISC_OPT_SPACE(addr_len + pad);
> +}
> +
> +static inline int ndisc_dev_opt_addr_space(const struct net_device *dev)
> +{
> +	return ndisc_opt_addr_space(dev->addr_len,
> +				    ndisc_addr_option_pad(dev->type));
>  }
>  

I prefer not to change existing functions such as ndisc_opt_addr_space(),
and name new function __ndisc_opt_addr_space() etc.

Plus, my original thought (when I implement these functions) was to
have per-net_device ndisc_opt_addr_spece(), ndisc_opt_adr_data() etc.

What do you think of that?

>  static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
> @@ -139,7 +144,7 @@ static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
>  	u8 *lladdr = (u8 *)(p + 1);
>  	int lladdrlen = p->nd_opt_len << 3;
>  	int prepad = ndisc_addr_option_pad(dev->type);
> -	if (lladdrlen != ndisc_opt_addr_space(dev))
> +	if (lladdrlen != ndisc_opt_addr_space(dev->addr_len, prepad))
>  		return NULL;
>  	return lladdr + prepad;
>  }
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index c245895..2241f06 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -152,9 +152,9 @@ EXPORT_SYMBOL_GPL(nd_tbl);
>  
>  static void ndisc_fill_addr_option(struct sk_buff *skb, int type, void *data)
>  {
> -	int pad   = ndisc_addr_option_pad(skb->dev->type);
> +	int pad = ndisc_addr_option_pad(skb->dev->type);
>  	int data_len = skb->dev->addr_len;
> -	int space = ndisc_opt_addr_space(skb->dev);
> +	int space = ndisc_opt_addr_space(data_len, pad);
>  	u8 *opt = skb_put(skb, space);
>  
>  	opt[0] = type;
> @@ -509,7 +509,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
>  	if (!dev->addr_len)
>  		inc_opt = 0;
>  	if (inc_opt)
> -		optlen += ndisc_opt_addr_space(dev);
> +		optlen += ndisc_dev_opt_addr_space(dev);
>  
>  	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
>  	if (!skb)
> @@ -574,7 +574,7 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
>  	if (ipv6_addr_any(saddr))
>  		inc_opt = false;
>  	if (inc_opt)
> -		optlen += ndisc_opt_addr_space(dev);
> +		optlen += ndisc_dev_opt_addr_space(dev);
>  
>  	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
>  	if (!skb)
> @@ -626,7 +626,7 @@ void ndisc_send_rs(struct net_device *dev, const struct in6_addr *saddr,
>  	}
>  #endif
>  	if (send_sllao)
> -		optlen += ndisc_opt_addr_space(dev);
> +		optlen += ndisc_dev_opt_addr_space(dev);
>  
>  	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
>  	if (!skb)
> @@ -1563,7 +1563,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
>  			memcpy(ha_buf, neigh->ha, dev->addr_len);
>  			read_unlock_bh(&neigh->lock);
>  			ha = ha_buf;
> -			optlen += ndisc_opt_addr_space(dev);
> +			optlen += ndisc_dev_opt_addr_space(dev);
>  		} else
>  			read_unlock_bh(&neigh->lock);
>  
> 

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION
