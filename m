Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59233 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbcC3IqA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 04:46:00 -0400
Subject: Re: [PATCH v2 3/3] mrf24j40: apply the security-enabled bit on
 secured outbound frames
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-3-git-send-email-web+oss@zopieux.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FB9244.9070502@osg.samsung.com>
Date: Wed, 30 Mar 2016 10:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <1457988374-31220-3-git-send-email-web+oss@zopieux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Alan Ott <alan@signal11.us>

Hello.

Added Alan Ott in CC.

regards
Stefan Schmidt

On 14/03/16 21:46, Alexandre Macabies wrote:
> We set the TXNSECEN bit of register TXNCON to on when transmitting a
> security-enabled frame, as described in section 3.12.2 of the MRF
> datasheet.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index adc67be..f446db8 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -61,6 +61,7 @@
>   #define REG_TXBCON0	0x1A
>   #define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
>   #define BIT_TXNTRIG	BIT(0)
> +#define BIT_TXNSECEN	BIT(1)
>   #define BIT_TXNACKREQ	BIT(2)
>   
>   #define REG_TXG1CON	0x1C
> @@ -551,6 +552,9 @@ static void write_tx_buf_complete(void *context)
>   	u8 val = BIT_TXNTRIG;
>   	int ret;
>   
> +	if (ieee802154_is_secen(fc))
> +		val |= BIT_TXNSECEN;
> +
>   	if (ieee802154_is_ackreq(fc))
>   		val |= BIT_TXNACKREQ;
>   

