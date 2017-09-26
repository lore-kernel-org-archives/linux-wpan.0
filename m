Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53987
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S969198AbdIZNps (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2017 09:45:48 -0400
Subject: Re: [PATCH] ieee802154: atusb: fix firmware version check to enable
 frame retries
References: <20170922084457.30497-1-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d0ee30d6-9328-7fdd-a499-e4decfac43ff@osg.samsung.com>
Date: Tue, 26 Sep 2017 15:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170922084457.30497-1-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>

Hello.

On 09/22/2017 10:44 AM, Stefan Schmidt wrote:
> Geert reported: as fw_ver_maj is unsigned char, gcc 4.1.2 complains:
> 
> warning: comparison is always true due to limited range of data type
> 
> Besides the warning the old check would also fail for firmware versions
> like 1.x with x < 3. These would support frame retries, but the driver
> would not enable the feature.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 115fa3f37a86..6b3cdf4bd667 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -1060,7 +1060,7 @@ static int atusb_probe(struct usb_interface *interface,
>  	atusb_get_and_show_build(atusb);
>  	atusb_set_extended_addr(atusb);
>  
> -	if (atusb->fw_ver_maj >= 0 && atusb->fw_ver_min >= 3)
> +	if ((atusb->fw_ver_maj == 0 && atusb->fw_ver_min >= 3) || atusb->fw_ver_maj > 0)
>  		hw->flags |= IEEE802154_HW_FRAME_RETRIES;
>  
>  	ret = atusb_get_and_clear_error(atusb);
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
