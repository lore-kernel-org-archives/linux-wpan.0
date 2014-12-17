Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34609 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaLQIKt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 03:10:49 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so14741720wiv.11
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 00:10:48 -0800 (PST)
Date: Wed, 17 Dec 2014 09:10:42 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: add cc2520 support entry
Message-ID: <20141217081038.GA21360@omega>
References: <1418789375-5450-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1418789375-5450-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Wed, Dec 17, 2014 at 09:39:35AM +0530, Varka Bhadram wrote:
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  website/index.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/website/index.txt b/website/index.txt
> index a7ab4bb..9e4c36f 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -33,6 +33,7 @@ Supported Hardware
>  |at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
>  |at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
>  |at86rf212   |yes              |at86rf230  | SPI |
> +|cc2520      |yes              |cc2520     | SPI |
>  |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
>  |=============================================================
>  
> -- 
> 1.7.9.5

Applied and regenerate the website, thanks.

- Alex
