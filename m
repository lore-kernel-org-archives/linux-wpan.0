Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:54755 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbATUaa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:30:30 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIH00HP8T5H5N20@mailout4.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 20 Jan 2015 20:34:29 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
 <1421784155-2670-2-git-send-email-alex.aring@gmail.com>
In-reply-to: <1421784155-2670-2-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-tools 2/2] info: remove unused features argument
Date: Tue, 20 Jan 2015 20:30:08 +0000
Message-id: <00af01d034ef$e2595dc0$a70c1940$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 20/01/15 21:02, Alexander Aring wrote:
> This patch removes an unused argument string for the phy information
> call. This is copied from the original iw tool. If we need really such
> argument then we can add this later again.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   src/info.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/src/info.c b/src/info.c
> index 83f2e3e..e155470 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -94,10 +94,6 @@ static int handle_info(struct nl802154_state *state,
>   		       int argc, char **argv,
>   		       enum id_input id)
>   {
> -	char *feat_args[] = { "features", "-q" };
> -
> -	handle_cmd(state, CIB_NONE, 2, feat_args);
> -
>   	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_phy_handler, NULL);
>
>   	return 0;
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


