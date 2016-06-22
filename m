Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49638 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbcFVNnd (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Jun 2016 09:43:33 -0400
Subject: Re: [PATCH bluetooth-next 2/2] 6lowpan: ndisc: add missing 802.15.4
 only check
References: <20160621082719.9903-1-aar@pengutronix.de>
 <20160621082719.9903-2-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <576A9441.5080506@osg.samsung.com>
Date: Wed, 22 Jun 2016 15:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <20160621082719.9903-2-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, dan.carpenter@oracle.com

Hello.

On 21/06/16 10:27, Alexander Aring wrote:
> This patch adds a missing check to handle short address parsing for
> 802.15.4 6LoWPAN only.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/6lowpan/ndisc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
> index 030504e..79c5fa9 100644
> --- a/net/6lowpan/ndisc.c
> +++ b/net/6lowpan/ndisc.c
> @@ -47,6 +47,9 @@ static int lowpan_ndisc_parse_options(const struct net_device *dev,
>   				      struct nd_opt_hdr *nd_opt,
>   				      struct ndisc_options *ndopts)
>   {
> +	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
> +		return 0;
> +
>   	switch (nd_opt->nd_opt_type) {
>   	case ND_OPT_SOURCE_LL_ADDR:
>   	case ND_OPT_TARGET_LL_ADDR:

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com> regards Stefan Schmidt


