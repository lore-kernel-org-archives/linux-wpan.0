Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53888 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbbE0Im7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 May 2015 04:42:59 -0400
Message-ID: <5565838F.60107@osg.samsung.com>
Date: Wed, 27 May 2015 10:42:55 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] atusb: add support for at86rf230
References: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 24/05/15 14:43, Alexander Aring wrote:
> This patch adds support for the at86rf230 version check which is used
> by the rzusb stick.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   drivers/net/ieee802154/atusb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 1e18774..5b6bb9a 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -515,7 +515,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
>   			man_id_1, man_id_0);
>   		goto fail;
>   	}
> -	if (part_num != 3) {
> +	if (part_num != 3 && part_num != 2) {
>   		dev_err(&usb_dev->dev,
>   			"unexpected transceiver, part 0x%02x version 0x%02x\n",
>   			part_num, version_num);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
