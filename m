Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56116 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752503AbcF1K2R (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 28 Jun 2016 06:28:17 -0400
Subject: Re: [PATCHv2 bluetooth-next 2/8] ieee802154: add
 ieee802154_skb_src_pan helper
References: <20160627220037.10108-1-aar@pengutronix.de>
 <20160627220037.10108-3-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <8447696d-0912-b48c-37c5-22790fc22ae7@pengutronix.de>
Date: Tue, 28 Jun 2016 12:28:15 +0200
MIME-Version: 1.0
In-Reply-To: <20160627220037.10108-3-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de


Hi,

On 06/28/2016 12:00 AM, Alexander Aring wrote:
> This patch adds ieee802154_skb_src_pan function to get the pointer
> address of the source pan id at skb mac pointer.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  include/linux/ieee802154.h | 13 ++++++++++++
>  include/net/mac802154.h    | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
...
>  
>  /**
> + * ieee802154_skb_src_pan - get the pointer to source pan field
> + * @fc: mac header frame control field
> + * @skb: skb where the source pan pointer will be get from
> + */
> +static inline unsigned char *ieee802154_skb_src_pan(__le16 fc,
> +						    const struct sk_buff *skb)
> +{
> +	unsigned char *src_pan;
> +
> +	switch (ieee802154_saddr_mode(fc)) {
> +	case cpu_to_le16(IEEE802154_FCTL_ADDR_NONE):
> +		src_pan = NULL;
> +		break;
> +	case cpu_to_le16(IEEE802154_FCTL_SADDR_SHORT):
> +	case cpu_to_le16(IEEE802154_FCTL_SADDR_EXTENDED):
> +		src_pan = skb_mac_header(skb) +
> +			  IEEE802154_FC_LEN +
> +			  IEEE802154_SEQ_LEN;
> +
> +		switch (ieee802154_daddr_mode(fc)) {
> +		case cpu_to_le16(IEEE802154_FCTL_ADDR_NONE):

This case is more complicated than it looks like:

If it's intra_pan and there is no destination pan (because daddr is
none), then the source pan should be NULL. If it's not intra_pan then
there is no destination address but source address is available with
own pan id field.

I will fix it in v3.

> +			break;
> +		case cpu_to_le16(IEEE802154_FCTL_DADDR_SHORT):
> +			if (!ieee802154_is_intra_pan(fc)) {
> +				src_pan += IEEE802154_PAN_ID_LEN +
> +					   IEEE802154_SHORT_ADDR_LEN;
> +			}
> +			break;
> +		case cpu_to_le16(IEEE802154_FCTL_DADDR_EXTENDED):
> +			if (!ieee802154_is_intra_pan(fc)) {
> +				src_pan += IEEE802154_PAN_ID_LEN +
> +					   IEEE802154_EXTENDED_ADDR_LEN;
> +			}
> +			break;
> +		default:
> +			WARN_ONCE(1, "invalid addr mode detected");
> +			src_pan = NULL;
> +			break;
> +		}
> +		break;

- Alex
