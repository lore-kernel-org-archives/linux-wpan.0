Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50092 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707AbaIRXBE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 18 Sep 2014 19:01:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id A372F20B04
	for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 19:01:03 -0400 (EDT)
Message-ID: <541B6430.80108@signal11.us>
Date: Thu, 18 Sep 2014 19:01:04 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: mrf24j40: use pr_* / dev_*
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1410842922-10564-4-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

Take out the "ieee802154." Make the first line of the commit message:
     mrf24j40: use pr_* / dev_* instead of printk()

On 09/16/2014 12:48 AM, Varka Bhadram wrote:
> This patch replace printk() with dev_* if dev is available
> or replace with pr_*


Take out "this patch." Make it:
     Replace printk() with dev_*() pr_*()

>
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   drivers/net/ieee802154/mrf24j40.c |   16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 2c617e3..80b6adf 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -323,8 +323,8 @@ static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
>   #ifdef DEBUG
>   	print_hex_dump(KERN_DEBUG, "mrf24j40 rx: ",
>   		DUMP_PREFIX_OFFSET, 16, 1, data, *len, 0);
> -	printk(KERN_DEBUG "mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
> -		lqi_rssi[0], lqi_rssi[1]);
> +	pr_debug("mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
> +		 lqi_rssi[0], lqi_rssi[1]);
>   #endif
>   
>   out:
> @@ -385,7 +385,7 @@ err:
>   static int mrf24j40_ed(struct ieee802154_dev *dev, u8 *level)
>   {
>   	/* TODO: */
> -	printk(KERN_WARNING "mrf24j40: ed not implemented\n");
> +	pr_warn("mrf24j40: ed not implemented\n");
>   	*level = 0;
>   	return 0;
>   }
> @@ -482,12 +482,10 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
>   		for (i = 0; i < 8; i++)
>   			write_short_reg(devrec, REG_EADR0 + i, addr[i]);
>   
> -#ifdef DEBUG
> -		printk(KERN_DEBUG "Set long addr to: ");
> +		pr_debug("Set long addr to: ");
>   		for (i = 0; i < 8; i++)
> -			printk("%02hhx ", addr[7 - i]);
> -		printk(KERN_DEBUG "\n");
> -#endif
> +			pr_debug("%02hhx ", addr[7 - i]);
> +		pr_debug("\n");

Hmm... You took out the #ifdef DEBUG, but there's still a loop in there 
that will execute (optimizer aside). The pr_debug is ok, but leave it 
all inside the #ifdef DEBUG.


>   	}
>   
>   	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
> @@ -702,7 +700,7 @@ static int mrf24j40_probe(struct spi_device *spi)
>   	int ret = -ENOMEM;
>   	struct mrf24j40 *devrec;
>   
> -	printk(KERN_INFO "mrf24j40: probe(). IRQ: %d\n", spi->irq);
> +	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
>   
>   	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
>   	if (!devrec)

The rest looks ok. Thanks Varka.

Alan.

