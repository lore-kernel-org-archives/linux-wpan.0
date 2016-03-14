Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53614 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbcCNLG0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 14 Mar 2016 07:06:26 -0400
Subject: Re: [PATCH 3/3] mrf24j40: apply the security-enabled bit on secured
 outbound frames
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457633643-12535-3-git-send-email-web+oss@zopieux.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E69B2F.6020301@osg.samsung.com>
Date: Mon, 14 Mar 2016 12:06:23 +0100
MIME-Version: 1.0
In-Reply-To: <1457633643-12535-3-git-send-email-web+oss@zopieux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: web+oss@zopieux.com, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Hello.

On 10/03/16 19:14, web+oss@zopieux.com wrote:
> From: Alexandre Macabies <web+oss@zopieux.com>
>
> We set the TXNSECEN bit of register TXNCON to on when transmitting a
> security-enabled frame, as described in section 3.12.2 of the MRF
> datasheet.

SOB again.

> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Reported-by: Alexandre Macabies <web+oss@zopieux.com>
> Tested-by: Alexandre Macabies <web+oss@zopieux.com>
> ---
>   drivers/net/ieee802154/mrf24j40.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 96814cf..bf11cbb 100644
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
> @@ -550,6 +551,9 @@ static void write_tx_buf_complete(void *context)
>   	u8 val = BIT_TXNTRIG;
>   	int ret;
>   
> +	if (ieee802154_is_secen(fc))
> +		val |= BIT_TXNSECEN;
> +
>   	if (ieee802154_is_ackreq(fc))
>   		val |= BIT_TXNACKREQ;
>   

Code looks fine. With the SOB fixed you get my:

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
