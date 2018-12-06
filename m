Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53407 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFTex (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Dec 2018 14:34:53 -0500
Subject: Re: [PATCH wpan-tools] hwsim: make sure lqi is always initialized
References: <20181129195800.28483-1-stefan@datenfreihafen.org>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <46d93ad8-889d-199c-bb12-1e4d5a86a431@datenfreihafen.org>
Date: Thu, 6 Dec 2018 20:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181129195800.28483-1-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com

Hello.

On 29.11.18 20:58, Stefan Schmidt wrote:
> The lqi variable was not initialized in all code paths.
> 
> CID: 185497
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
>  wpan-hwsim/wpan-hwsim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
> index 3e54348..0a7c492 100644
> --- a/wpan-hwsim/wpan-hwsim.c
> +++ b/wpan-hwsim/wpan-hwsim.c
> @@ -382,7 +382,7 @@ static void print_version(void)
>  
>  int main(int argc, const char *argv[])
>  {
> -	unsigned long int idx, idx2, lqi, ignore_idx = ULONG_MAX;
> +	unsigned long int idx, idx2, lqi = 0, ignore_idx = ULONG_MAX;
>  	bool dot = false;
>  	int cmd;
>  	int rc;
> 

No complains and trivial enough. Applied to wpan-tools master.

regards
Stefan Schmidt
