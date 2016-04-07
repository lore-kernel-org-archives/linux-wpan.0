Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bl2on0061.outbound.protection.outlook.com ([65.55.169.61]:36192
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755526AbcDGLu4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 7 Apr 2016 07:50:56 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] ieee802154/adf7242: fix memory leak of firmware
References: <1460027764-27428-1-git-send-email-sudipm.mukherjee@gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <57064005.2040801@analog.com>
Date: Thu, 7 Apr 2016 13:09:57 +0200
MIME-Version: 1.0
In-Reply-To: <1460027764-27428-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Alexander Aring <aar@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

On 04/07/2016 01:16 PM, Sudip Mukherjee wrote:
> If the firmware upload or the firmware verification fails then we
> printed the error message and exited but we missed releasing the
> firmware.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/net/ieee802154/adf7242.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 89154c0..91d4531 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1030,6 +1030,7 @@ static int adf7242_hw_init(struct adf7242_local *lp)
>   	if (ret) {
>   		dev_err(&lp->spi->dev,
>   			"upload firmware failed with %d\n", ret);
> +		release_firmware(fw);
>   		return ret;
>   	}
>
> @@ -1037,6 +1038,7 @@ static int adf7242_hw_init(struct adf7242_local *lp)
>   	if (ret) {
>   		dev_err(&lp->spi->dev,
>   			"verify firmware failed with %d\n", ret);
> +		release_firmware(fw);
>   		return ret;
>   	}
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
