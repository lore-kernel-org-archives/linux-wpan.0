Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33703 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbbHJPih (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Aug 2015 11:38:37 -0400
Message-ID: <55C8C570.9060102@gmail.com>
Date: Mon, 10 Aug 2015 21:08:24 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv1 bluetooth-next] cc2520: set the default fifo pin value
 from platform data
References: <BLU168-W12778BE0A70F0EA756A9E8CD6700@phx.gbl>
In-Reply-To: <BLU168-W12778BE0A70F0EA756A9E8CD6700@phx.gbl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: LIYONG <sdliyong@gmail.com>, "alex.aring@gmail.com" <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Yup...  :-)  Your name in the From (LIYONG) address is different from SOB (Yong Li) address.
It should be same, please fix your email-client.

On 08/10/2015 12:59 PM, LIYONG wrote:

> In case of the device tree support is disabled, the fifo_pin is uninitialized, this
> patch will set the fifo_pin value based on platform data
>
> Signed-off-by: Yong Li<sdliyong@gmail.com>
> ---
>   drivers/net/ieee802154/cc2520.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index 613dae5..c5b54a1 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -833,6 +833,7 @@ static int cc2520_get_platform_data(struct spi_device *spi,
>                  if (!spi_pdata)
>                          return -ENOENT;
>                  *pdata = *spi_pdata;
> +               priv->fifo_pin = pdata->fifo;
>                  return 0;
>          }
>
> --
> 2.1.0
>
>   		 	   		

This patch is not applying.

Please use 'git format-patch' to generate the patch. And send it by 'git send-email'

In your case:
	git commit -am -s "cc2520: set the default fifo pin value from platform data"
	git format-patch --subject-prefix="PATCH v2 bluetooth-next" -1
	git send-email 0001-....


-- 
Varka Bhadram.

