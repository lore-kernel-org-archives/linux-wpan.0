Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47822 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbdKFPda (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:33:30 -0500
Subject: Re: [PATCH] MAINTAINERS: Update ca8210 driver contact emails
References: <20171031112206.2952-1-h.morris@cascoda.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <2e2024bf-53e6-97ca-48e7-aed949be390c@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112206.2952-1-h.morris@cascoda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

Hello.

On 31.10.2017 12:22, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
> 
> Remove non-functioning secondary email address from maintainer information.
> 
> Signed-off-by: Harry Morris <h.morris@cascoda.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11dde28..852c308 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3035,7 +3035,6 @@ F:	arch/c6x/
>  
>  CA8210 IEEE-802.15.4 RADIO DRIVER
>  M:	Harry Morris <h.morris@cascoda.com>
> -M:	linuxdev@cascoda.com
>  L:	linux-wpan@vger.kernel.org
>  W:	https://github.com/Cascoda/ca8210-linux.git
>  S:	Maintained
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
