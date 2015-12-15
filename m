Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:47840
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752194AbbLOH4R (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 15 Dec 2015 02:56:17 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH bluetooth-next] adf7242: remove multiple returns
References: <1450128644-9659-1-git-send-email-alex.aring@gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <566FC618.3070900@analog.com>
Date: Tue, 15 Dec 2015 08:49:44 +0100
MIME-Version: 1.0
In-Reply-To: <1450128644-9659-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On 12/14/2015 10:30 PM, Alexander Aring wrote:
> This patch removes an unnecessary return inside the adf7242 driver.
>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/net/ieee802154/adf7242.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 89154c0..738b373 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1114,8 +1114,6 @@ static int adf7242_debugfs_init(struct adf7242_local *lp)
>   					    lp->debugfs_root,
>   					    adf7242_stats_show);
>   	return PTR_ERR_OR_ZERO(stats);
> -
> -	return 0;
>   }
>
>   static const s32 adf7242_powers[] = {
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
