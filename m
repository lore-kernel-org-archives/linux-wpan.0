Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34843 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbbEVIZE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:25:04 -0400
Received: by wgfl8 with SMTP id l8so10539720wgf.2
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 01:25:02 -0700 (PDT)
Date: Fri, 22 May 2015 10:25:00 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: Update status of atusb driver which
 is now mainline.
Message-ID: <20150522082456.GB1087@omega>
References: <1432281282-7707-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432281282-7707-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Fri, May 22, 2015 at 09:54:42AM +0200, Stefan Schmidt wrote:
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  website/index.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/website/index.txt b/website/index.txt
> index 7cede5d..d8ccbb7 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -42,7 +42,7 @@ Supported Hardware
>  |at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
>  |cc2520      |yes              |cc2520     | SPI |
>  |cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
> -|atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
> +|atusb       |yes              |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
>  |RZUSBstick  |no, WIP          |atusb      | USB |
>  |=============================================================
>  
> -- 
> 2.1.0

Applied und regenerate the website. Thanks.

- Alex
