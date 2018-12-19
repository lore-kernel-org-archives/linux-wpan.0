Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59625 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbeLSNdP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 19 Dec 2018 08:33:15 -0500
Subject: Re: [PATCH 1/2] iwpan: fix clang compiler warning on absolute-value
References: <20181206202602.22176-1-stefan@datenfreihafen.org>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <8f140636-2b12-4c1f-6d56-4fe65659dde9@datenfreihafen.org>
Date: Wed, 19 Dec 2018 14:33:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181206202602.22176-1-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com

Hello.

On 06.12.18 21:26, Stefan Schmidt wrote:
> Our CI found this when building with clang (seems to have
> the option on by deafult)
> 
> iwpan.c:469:13: warning: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
>         cmd_size = abs((long)&__section_set - (long)&__section_get);
>                    ^
> iwpan.c:469:13: note: use function 'labs' instead
>         cmd_size = abs((long)&__section_set - (long)&__section_get);
>                    ^~~
>                    labs
> 
> This also follows a change in iw, where we derived from.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
>  src/iwpan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/iwpan.c b/src/iwpan.c
> index e7781fd..fb7bef1 100644
> --- a/src/iwpan.c
> +++ b/src/iwpan.c
> @@ -466,7 +466,7 @@ int main(int argc, char **argv)
>  	int err;
>  
>  	/* calculate command size including padding */
> -	cmd_size = abs((long)&__section_set - (long)&__section_get);
> +	cmd_size = labs((long)&__section_set - (long)&__section_get);
>  	/* strip off self */
>  	argc--;
>  	argv0 = *argv++;
> 

This patch has now been applied to wpan-tools.

regards
Stefan Schmidt
