Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37445 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbCTPiI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 11:38:08 -0400
Received: by wixw10 with SMTP id w10so24223188wix.0
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 08:38:06 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:38:04 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/3] cc2520: fix in updated register
 settings
Message-ID: <20150320153800.GC3952@omega>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
 <1426836141-21528-3-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426836141-21528-3-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

On Fri, Mar 20, 2015 at 12:52:20PM +0530, Varka Bhadram wrote:
> This patch fix the updated register settings for transmit power.
> 
> As per the datasheet [section 28.1 Register Settings Update]
> the transmit power register value has to be updated to 0x32 (0 dBm)
> from the default value.
> 
> CC2520_TXPOWER_4 indicates the value 0x32 (0 dBm).
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  drivers/net/ieee802154/cc2520.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index f96cc50..d9135ec 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -860,7 +860,8 @@ static int cc2520_hw_init(struct cc2520_private *priv)
>  		if (ret)
>  			goto err_ret;
>  	} else {
> -		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
> +		ret = cc2520_write_register(priv, CC2520_TXPOWER,
> +					    CC2520_TXPOWER_4);
>  		if (ret)
>  			goto err_ret;

you also need to set _always_ the default phy value after reset in the
wpan_phy struct.

Example:

/* sets default transmit_power */
foobar->hw->phy->transmit_power = 4;


otherwise the phy layer doesn't know the initial txpower. In cc2520
there is also a missing initial value for the CCA mode. There must be
running some CCA mode which also stands in the datasheet (I doesn't
looked into that now).

Example:

foobar->hw->phy->cca.mode = NL802154_CCA_ENERGY_CARRIER;


btw:
We have also there a lack of support because this describes energy
above threshold. Currently we have not implemented to get this threshold
from the phy. (We also need support for that, in case of at86rf230 the
default value is used).

- Alex
