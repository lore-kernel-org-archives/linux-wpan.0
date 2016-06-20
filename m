Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48983 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751954AbcFTKri (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 20 Jun 2016 06:47:38 -0400
Subject: Re: [RFC 2/4] 6lowpan: Set MAC address lenght according to
 LOWPAN_LLTYPE
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
 <1466408993-3808-3-git-send-email-patrik.flykt@linux.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <776ee1e1-3c13-f75d-3f51-460782e750dc@pengutronix.de>
Date: Mon, 20 Jun 2016 12:46:12 +0200
MIME-Version: 1.0
In-Reply-To: <1466408993-3808-3-git-send-email-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Patrik Flykt <patrik.flykt@linux.intel.com>, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Cc: linux-wpan@vger.kernel.org


Hi,

On 06/20/2016 09:49 AM, Patrik Flykt wrote:
> Set MAC address length according to the 6LoWPAN link layer in use.
> Bluetooth Low Energy uses 48 bit addressing while IEEE802.15.4 uses
> 64 bits.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
>  net/6lowpan/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index 5945f7e..5f9909a 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -23,7 +23,16 @@ int lowpan_register_netdevice(struct net_device *dev,
>  {
>  	int i, ret;
>  
> -	dev->addr_len = EUI64_ADDR_LEN;
> +	switch (lltype) {
> +	case LOWPAN_LLTYPE_IEEE802154:
> +		dev->addr_len = EUI64_ADDR_LEN;
> +		break;

remove this case.

> +
> +	case LOWPAN_LLTYPE_BTLE:
> +		dev->addr_len = ETH_ALEN;
> +		break;
> +	}
> +

I would add here an default branch which does the EUI64 handling. EUI64
should be the normal case, all others doesn't has a EUI64 and then there
exists some mechanism to create the EUI64 from e.g. EUI48 address.

Switch case with one case branch makes not really sense, maybe use if
here.

Also cc linux-wpan for net/6lowpan/ patches.

- Alex
