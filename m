Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38564 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeJXX5e (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Oct 2018 19:57:34 -0400
Subject: Re: [PATCH wpan-tools] wpan-hwsim: fix long option argument option
 for dot
References: <20181016153821.10331-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <f802d6d7-7067-e787-1eaa-eb439ab9af9e@datenfreihafen.org>
Date: Wed, 24 Oct 2018 17:28:59 +0200
MIME-Version: 1.0
In-Reply-To: <20181016153821.10331-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 16/10/2018 17:38, Alexander Aring wrote:
> This patch fixes the long option argument option to no argument. The dot
> argument doesn't require any postponed argument.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  wpan-hwsim/wpan-hwsim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
> index dcddb09..3e54348 100644
> --- a/wpan-hwsim/wpan-hwsim.c
> +++ b/wpan-hwsim/wpan-hwsim.c
> @@ -393,7 +393,7 @@ int main(int argc, const char *argv[])
>  		static struct option long_options[] = {
>  			{"help",	no_argument,		0,	'h' },
>  			{"version",	no_argument,		0,	'v' },
> -			{"dot",		required_argument,	0,	'd' },
> +			{"dot",		no_argument,		0,	'd' },
>  			{"ignore",	required_argument,	0,	'i' },
>  			{0,				0,	0,	0 }
>  		};
> 

Applied to wpan-tools repo.

Is there anythign else left you wanted to have in before we look into a
new release?

regards
Stefan Schmidt
