Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53762 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbbFIHmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 03:42:33 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] ieee802154/mrf24j40: make sure we do not override return values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433768651-5458-1-git-send-email-stefan@osg.samsung.com>
Date: Tue, 9 Jun 2015 09:42:30 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <DF4347EC-065D-4C46-947D-149085EDD466@holtmann.org>
References: <1433768651-5458-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

Hi Stefan,

> If we run into an error during rx we set the the error code in ret, but override
> it afterwards. Using a different variable for the extra case avoids this
> situation.
> 
> CID: 1226982, 1226983
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> Cc: Alan Ott <alan@signal11.us>
> ---
> drivers/net/ieee802154/mrf24j40.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 99c7676..0b9b2ae 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -533,6 +533,7 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
> 	u8 lqi = 0;
> 	u8 val;
> 	int ret = 0;
> +	int ret2 = 0;
> 	struct sk_buff *skb;
> 
> 	/* Turn off reception of packets off the air. This prevents the
> @@ -569,9 +570,9 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
> 
> out:
> 	/* Turn back on reception of packets off the air. */
> -	ret = read_short_reg(devrec, REG_BBREG1, &val);
> -	if (ret)
> -		return ret;
> +	ret2 = read_short_reg(devrec, REG_BBREG1, &val);
> +	if (ret2)
> +		return ret2;

one of the general rule is to not declare a variable and assign it with a value unless really needed. In this case I think a simple int ret2; would be enough.

Regards

Marcel

