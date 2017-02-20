Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:36617
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751390AbdBTV6R (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2017 16:58:17 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH v3 2/5] 6lowpan: Set MAC address lenght according to
 LOWPAN_LLTYPE
References: <20170217155003.4594-1-luiz.dentz@gmail.com>
 <20170217155003.4594-3-luiz.dentz@gmail.com>
Message-ID: <64b054e1-7936-c384-3b58-3550a13d8030@osg.samsung.com>
Date: Mon, 20 Feb 2017 22:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170217155003.4594-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org

Hello.

lenght typo in subject line.

On 02/17/2017 04:50 PM, Luiz Augusto von Dentz wrote:
> From: Patrik Flykt <patrik.flykt@linux.intel.com>
>
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
>  	dev->type = ARPHRD_6LOWPAN;
>  	dev->mtu = IPV6_MIN_MTU;
>  	dev->priv_flags |= IFF_NO_QUEUE;
>

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
