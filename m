Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45647 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaLQJGY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 04:06:24 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so15166866wiw.15
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 01:06:23 -0800 (PST)
Date: Wed, 17 Dec 2014 10:06:20 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: change theme to 'volnitsky'
Message-ID: <20141217090616.GC21360@omega>
References: <1418806440-7768-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1418806440-7768-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Wed, Dec 17, 2014 at 02:24:00PM +0530, Varka Bhadram wrote:
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  website/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/website/Makefile b/website/Makefile
> index cc090bc..41a152b 100644
> --- a/website/Makefile
> +++ b/website/Makefile
> @@ -1,5 +1,5 @@
>  all:
> -	asciidoc -b html5 -a icons -a toc2 -a theme=flask index.txt
> +	asciidoc -b html5 -a icons -a toc2 -a theme=volnitsky index.txt
>  
>  clean:
>  	rm index.html
> -- 
> 1.7.9.5

Applied and regenerate the website, thanks.

- Alex
