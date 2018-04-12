Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:41612 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbeDLMI6 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 12 Apr 2018 08:08:58 -0400
Subject: Re: [PATCH] net: ieee802154: atusb: Replace GFP_ATOMIC with
 GFP_KERNEL in atusb_probe
References: <1523412850-2260-1-git-send-email-baijiaju1990@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <46cf6980-ff83-7d68-9a5e-67d874c1900a@osg.samsung.com>
Date: Thu, 12 Apr 2018 14:08:52 +0200
MIME-Version: 1.0
In-Reply-To: <1523412850-2260-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.


On 04/11/2018 04:14 AM, Jia-Ju Bai wrote:
> atusb_probe() is never called in atomic context.
> This function is only set as ".probe" in struct usb_driver.
>
> Despite never getting called from atomic context,
> atusb_probe() calls usb_alloc_urb() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
>
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ieee802154/atusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index ef68851..ab6a505 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -789,7 +789,7 @@ static int atusb_probe(struct usb_interface *interface,
>  	atusb->tx_dr.bRequest = ATUSB_TX;
>  	atusb->tx_dr.wValue = cpu_to_le16(0);
>  
> -	atusb->tx_urb = usb_alloc_urb(0, GFP_ATOMIC);
> +	atusb->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!atusb->tx_urb)
>  		goto fail;
>  

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
