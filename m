Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33443 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbFANkm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 09:40:42 -0400
Received: by wicmx19 with SMTP id mx19so71328533wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 06:40:41 -0700 (PDT)
Date: Mon, 1 Jun 2015 15:40:38 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] info: fix printf taking the wrong amount of
 arguments
Message-ID: <20150601134037.GC1195@omega>
References: <20150601090407.GA2974@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150601090407.GA2974@raspberrypi>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Mon, Jun 01, 2015 at 09:04:15AM +0000, Christoffer Holmstedt wrote:
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
>  src/info.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/info.c b/src/info.c
> index e8f5dda8da94..926a63adecce 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -54,7 +54,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
>  				    rem_page) {
>  			channel = nla_get_u32(nl_page);
>  			if (channel) {
> -				printf("\tpage %d: ", page, channel);
> +				printf("\tpage %d: ", page);
>  				for (i = 0; i <= 31; i++) {
>  					if (channel & 0x1)
>  						printf("%d,", i);

Thanks, applied.

- Alex
