Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60559 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752AbcFOPJk (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 15 Jun 2016 11:09:40 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCHv3 net-next 04/12] ndisc: add __ndisc_opt_addr_space
 function
References: <20160614115239.17788-1-aar@pengutronix.de>
 <20160614115239.17788-5-aar@pengutronix.de>
Message-ID: <57616FAD.9080106@osg.samsung.com>
Date: Wed, 15 Jun 2016 17:09:33 +0200
MIME-Version: 1.0
In-Reply-To: <20160614115239.17788-5-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hello.

On 14/06/16 13:52, Alexander Aring wrote:
> This patch adds __ndisc_opt_addr_space as low-level function for
> ndisc_opt_addr_space which doesn't depend on net_device parameter.
>
> Cc: David S. Miller<davem@davemloft.net>
> Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
> Cc: James Morris<jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy<kaber@trash.net>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   include/net/ndisc.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> index 2d8edaa..4cee826 100644
> --- a/include/net/ndisc.h
> +++ b/include/net/ndisc.h
> @@ -127,10 +127,15 @@ static inline int ndisc_addr_option_pad(unsigned short type)
>   	}
>   }
>   
> +static inline int __ndisc_opt_addr_space(unsigned char addr_len, int pad)
> +{
> +	return NDISC_OPT_SPACE(addr_len + pad);
> +}
> +
>   static inline int ndisc_opt_addr_space(struct net_device *dev)
>   {
> -	return NDISC_OPT_SPACE(dev->addr_len +
> -			       ndisc_addr_option_pad(dev->type));
> +	return __ndisc_opt_addr_space(dev->addr_len,
> +				      ndisc_addr_option_pad(dev->type));
>   }
>   
>   static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
