Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55989 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbbHDQmf (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 4 Aug 2015 12:42:35 -0400
Subject: Re: [RFCv3 bluetooth-next 5/6] at86rf230: remove max_frame_retries -1
 check
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-6-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C0EB78.8060200@osg.samsung.com>
Date: Tue, 4 Aug 2015 18:42:32 +0200
MIME-Version: 1.0
In-Reply-To: <1438246542-17633-6-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 30/07/15 10:55, Alexander Aring wrote:
> Since we remove the max_frame_retries "-1" option from mac802154 stack
> we don't need to check on such option as parameter.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 8b9557f..0bb52b2 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1268,12 +1268,8 @@ static int
>   at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
>   {
>   	struct at86rf230_local *lp = hw->priv;
> -	int rc = 0;
>   
> -	if (retries >= 0)
> -		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
> -
> -	return rc;
> +	return at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
>   }
>   
>   static int

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
