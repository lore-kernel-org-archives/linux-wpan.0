Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39954 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752207AbcFTLSd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 20 Jun 2016 07:18:33 -0400
Subject: Re: [RFC 2/4] 6lowpan: Set MAC address lenght according to
 LOWPAN_LLTYPE
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
 <1466408993-3808-3-git-send-email-patrik.flykt@linux.intel.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <59963202-1abe-f003-5be3-0e956d3f417a@pengutronix.de>
Date: Mon, 20 Jun 2016 13:18:31 +0200
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
> +
> +	case LOWPAN_LLTYPE_BTLE:
> +		dev->addr_len = ETH_ALEN;
> +		break;
> +	}
> +

btw: this patch breaks a lot of things where net/bluetooth/6lowpan.c
access the dev->addr_len as eui64. e.g. [0].

Seems to fixed in PATCH 3/4, but dev->addr is also used in IPHC code,
e.g. [1], which still handle it as 8 byte address.

I think you need to fixup the whole thing into one patch, to not break
anything in the middle.

btw: if we change that, we need to add some stuff in radvd that they
know it's 48 bit hardware address not 64. See [2], but I think we can
use struct ifreq for that, to get the dev->addr_len in userspace.

- Alex

[0] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L674
[1] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L479
[2] https://github.com/linux-wpan/radvd/blob/6lowpan/device-linux.c#L118
