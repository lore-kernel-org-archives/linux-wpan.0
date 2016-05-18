Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2on0065.outbound.protection.outlook.com ([207.46.100.65]:37824
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751119AbcERGn7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 18 May 2016 02:43:59 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/1] net: ieee802154/adf7242: syntax error ifdef DEBUG
References: <1463522320-10964-1-git-send-email-xypron.glpk@gmx.de>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <573C0D22.6060505@analog.com>
Date: Wed, 18 May 2016 08:35:14 +0200
MIME-Version: 1.0
In-Reply-To: <1463522320-10964-1-git-send-email-xypron.glpk@gmx.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/17/2016 11:58 PM, Heinrich Schuchardt wrote:
> If DEBUG is defined, a superfluous closing brace
> is introduced.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/net/ieee802154/adf7242.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index b82e39d..9fa7ac9 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -915,7 +915,6 @@ static void adf7242_debug(u8 irq1)
>   		(stat & 0xf) == RC_STATUS_PHY_RDY ? "RC_STATUS_PHY_RDY" : "",
>   		(stat & 0xf) == RC_STATUS_RX ? "RC_STATUS_RX" : "",
>   		(stat & 0xf) == RC_STATUS_TX ? "RC_STATUS_TX" : "");
> -	}
>   #endif
>   }
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
