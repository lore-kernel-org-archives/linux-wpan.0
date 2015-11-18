Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34113 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbbKRNzG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Nov 2015 08:55:06 -0500
Received: by lffu14 with SMTP id u14so26772686lff.1
        for <linux-wpan@vger.kernel.org>; Wed, 18 Nov 2015 05:55:05 -0800 (PST)
Subject: Re: [RFCv2 bluetooth-next 2/3] ipv6: add ipv6_addr_prefix_cpy
References: <1447799594-6050-1-git-send-email-alex.aring@gmail.com>
 <1447799594-6050-3-git-send-email-alex.aring@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <564C8336.7000100@cogentembedded.com>
Date: Wed, 18 Nov 2015 16:55:02 +0300
MIME-Version: 1.0
In-Reply-To: <1447799594-6050-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hello.

On 11/18/2015 1:33 AM, Alexander Aring wrote:

> This patch adds a static inline function ipv6_addr_prefix_cpy which

    I suggest not to reduce "copy".

> copies a ipv6 address prefix(argument pfx) into the ipv6 address prefix.
> The prefix len is given by plen as bits. This function mainly based on
> ipv6_addr_prefix which copies one address prefix from address into a new
> ipv6 address destination and zero all other address bits.
>
> The difference is that ipv6_addr_prefix_cpy don't get a prefix from an
> ipv6 address, it sets a prefix to an ipv6 address with keeping other
> address bits. The use case is for context based address compression
> inside 6LoWPAN IPHC header which keeping ipv6 prefixes inside a context
> table to lookup address-bits without sending them.
>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   include/net/ipv6.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index e1a10b0..9d38fc2 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -382,6 +382,21 @@ static inline void ipv6_addr_prefix(struct in6_addr *pfx,
>   		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
>   }
>
> +static inline void ipv6_addr_prefix_cpy(struct in6_addr *addr,
> +					const struct in6_addr *pfx,
> +					int plen)
> +{
> +	/* caller must guarantee 0 <= plen <= 128 */
> +	int o = plen >> 3,
> +	    b = plen & 0x7;

    Unusual declaration style, why not just have *int* on both lines?

[...]

MBR, Sergei

