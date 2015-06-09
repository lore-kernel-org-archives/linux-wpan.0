Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36764 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbbFIJVn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 05:21:43 -0400
Received: by pabqy3 with SMTP id qy3so9890783pab.3
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 02:21:42 -0700 (PDT)
Message-ID: <5576B00C.6020003@gmail.com>
Date: Tue, 09 Jun 2015 14:51:16 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] ieee802154/cc2520: check for return values
 in cc2520_filter()
References: <1433841108-1122-1-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433841108-1122-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

On 06/09/2015 02:41 PM, Stefan Schmidt wrote:

> neither ram nor register write return values have been checked here. Checking
> both now. Assign ret with 0 as all other assignments are inside if blocks and
> might not happen before we return ret.
>
> CID: 1230469
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> Cc: Varka Bhadram <varkabhadram@gmail.com>
> ---
>   drivers/net/ieee802154/cc2520.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 15f263c..54c15e0 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -590,22 +590,23 @@ cc2520_filter(struct ieee802154_hw *hw,
>   	      struct ieee802154_hw_addr_filt *filt, unsigned long changed)
>   {
>   	struct cc2520_private *priv = hw->priv;
> +	int ret = 0;
>   
>   	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
>   		u16 panid = le16_to_cpu(filt->pan_id);
>   
>   		dev_vdbg(&priv->spi->dev,
>   			 "cc2520_filter called for pan id\n");
> -		cc2520_write_ram(priv, CC2520RAM_PANID,
> -				 sizeof(panid), (u8 *)&panid);
> +		ret = cc2520_write_ram(priv, CC2520RAM_PANID,
> +				       sizeof(panid), (u8 *)&panid);
>   	}
>   
>   	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
>   		dev_vdbg(&priv->spi->dev,
>   			 "cc2520_filter called for IEEE addr\n");
> -		cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
> -				 sizeof(filt->ieee_addr),
> -				 (u8 *)&filt->ieee_addr);
> +		ret = cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
> +				       sizeof(filt->ieee_addr),
> +				       (u8 *)&filt->ieee_addr);
>   	}
>   
>   	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
> @@ -613,20 +614,20 @@ cc2520_filter(struct ieee802154_hw *hw,
>   
>   		dev_vdbg(&priv->spi->dev,
>   			 "cc2520_filter called for saddr\n");
> -		cc2520_write_ram(priv, CC2520RAM_SHORTADDR,
> -				 sizeof(addr), (u8 *)&addr);
> +		ret = cc2520_write_ram(priv, CC2520RAM_SHORTADDR,
> +				       sizeof(addr), (u8 *)&addr);
>   	}
>   
>   	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
>   		dev_vdbg(&priv->spi->dev,
>   			 "cc2520_filter called for panc change\n");
>   		if (filt->pan_coord)
> -			cc2520_write_register(priv, CC2520_FRMFILT0, 0x02);
> +			ret = cc2520_write_register(priv, CC2520_FRMFILT0, 0x02);
>   		else
> -			cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
> +			ret = cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static inline int cc2520_set_tx_power(struct cc2520_private *priv, s32 mbm)

Thanks for the patch.

I found two check patch warnings on this patch.

As Alex pointed on other thread that you should use commit message
like "subsytem: file:" or only "subsytem:" in the subject.
But not "subsytem/subsubsystem:"

Thanks.

-- 
Varka Bhadram

