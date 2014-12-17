Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:40007 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaLQVUz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 16:20:55 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so21512702wgh.36
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 13:20:53 -0800 (PST)
Date: Wed, 17 Dec 2014 22:20:48 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] at86rf230: fix register read for part version
Message-ID: <20141217212043.GA25328@omega>
References: <1418850882-4234-1-git-send-email-andrey@snupi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1418850882-4234-1-git-send-email-andrey@snupi.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andrey Yurovsky <andrey@snupi.com>
Cc: linux-wpan@vger.kernel.org

Hi Andrey,

On Wed, Dec 17, 2014 at 01:14:42PM -0800, Andrey Yurovsky wrote:
> The driver was reading the PART_NUM register for both the part number
> (type of device) and the part version, the version is actually in
> register 0x1D, VERSION_NUM.  I believe that this was a copy-paste error.
> 
> Tested on AT86RF212B where the part is detected to be the expected part
> number (0x07) and version (0x03 on mine).
> 
> Signed-off-by: Andrey Yurovsky <andrey@snupi.com>
> ---
>  drivers/net/ieee802154/at86rf230.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 1c01356..aa1005f 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1400,7 +1400,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
>  	if (rc)
>  		return rc;
>  
> -	rc = __at86rf230_read(lp, RG_PART_NUM, &version);
> +	rc = __at86rf230_read(lp, RG_VERSION_NUM, &version);

oops, yes this is indeed wrong here. Thanks!

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
