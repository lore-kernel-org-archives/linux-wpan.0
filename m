Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63034 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbCTJUV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 05:20:21 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NLI00DZ97GP5F30@mailout1.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Fri, 20 Mar 2015 09:24:25 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
 <1426836141-21528-2-git-send-email-varkab@cdac.in>
In-reply-to: <1426836141-21528-2-git-send-email-varkab@cdac.in>
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: add set transmit power support
Date: Fri, 20 Mar 2015 09:19:56 +0000
Message-id: <105301d062ef$08380820$18a81860$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Varka Bhadram' <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, 'Varka Bhadram' <varkab@cdac.in>

Hello.

On 20/03/15 08:22, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   drivers/net/ieee802154/cc2520.c |   56
> ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/cc2520.c
> b/drivers/net/ieee802154/cc2520.c
> index f833b8b..f96cc50 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -53,6 +53,17 @@
>   #define	CC2520_MAXCHANNEL		26
>   #define	CC2520_CHANNEL_SPACING		5
>
> +/* Tx power values */
> +#define CC2520_TXPOWER_0		0x03 /* -18dbm */
> +#define CC2520_TXPOWER_1		0x2c /* -7dbm */
> +#define CC2520_TXPOWER_2		0x88 /* -4dbm */
> +#define CC2520_TXPOWER_3		0x81 /* -2dbm */
> +#define CC2520_TXPOWER_4		0x32 /* 0dbm */
> +#define CC2520_TXPOWER_5		0x13 /* 1dbm */
> +#define CC2520_TXPOWER_6		0xab /* 2dbm */
> +#define CC2520_TXPOWER_7		0xf2 /* 3dbm */
> +#define CC2520_TXPOWER_8		0xf7 /* 5dbm */
> +
>   /* command strobes */
>   #define	CC2520_CMD_SNOP			0x00
>   #define	CC2520_CMD_IBUFLD		0x02
> @@ -628,6 +639,48 @@ cc2520_filter(struct ieee802154_hw *hw,
>   	return 0;
>   }
>
> +static int
> +cc2520_set_txpower(struct ieee802154_hw *hw, int db)
> +{
> +	struct cc2520_private *priv = hw->priv;
> +	u8 power;
> +
> +	switch (db) {
> +	case 5:
> +		power = CC2520_TXPOWER_8;
> +		break;
> +	case 3:
> +		power = CC2520_TXPOWER_7;
> +		break;
> +	case 2:
> +		power = CC2520_TXPOWER_6;
> +		break;
> +	case 1:
> +		power = CC2520_TXPOWER_5;
> +		break;
> +	case 0:
> +		power = CC2520_TXPOWER_4;
> +		break;
> +	case -2:
> +		power = CC2520_TXPOWER_3;
> +		break;
> +	case -4:
> +		power = CC2520_TXPOWER_2;
> +		break;
> +	case -7:
> +		power = CC2520_TXPOWER_1;
> +		break;
> +	case -18:
> +		power = CC2520_TXPOWER_0;
> +		break;
> +	default:
> +		dev_err(&priv->spi->dev, "invalid tx power setting\n");
> +		return -EINVAL;
> +	}
> +
> +	return cc2520_write_register(priv, CC2520_TXPOWER, power);
> +}
> +

Thanks for working on the power setting API.

One thing I find problematic here is that the user has to know the 
values it can set for the db level beforehand and these values can 
change for different transceivers. Which makes these nl call hardware 
depended.

We should at least have a way to query what db levels are available or 
better see if we can harmonize the setting over different drivers and 
transceivers.

regards
Stefan Schmidt


