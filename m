Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:40155 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfBZUen (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Feb 2019 15:34:43 -0500
Subject: Re: [PATCH] ieee802154:: propagate genlmsg_reply return code
References: <1550553029-1480-1-git-send-email-lirongqing@baidu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <7ddec216-5e54-f656-3be0-a82682588fe1@datenfreihafen.org>
Date: Tue, 26 Feb 2019 21:34:39 +0100
MIME-Version: 1.0
In-Reply-To: <1550553029-1480-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Li RongQing <lirongqing@baidu.com>, linux-wpan@vger.kernel.org

Hello Li.

On 19.02.19 06:10, Li RongQing wrote:
> genlmsg_reply can fail, so propagate its return code
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index b6743f03dce0..3b88846de31b 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -324,7 +324,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
>  			goto out_err;
>  		}
>  
> -		genlmsg_reply(skb, info);
> +		res = genlmsg_reply(skb, info);
>  		break;
>  	}
>  
> 

I would prefer the subject line to also include the part the patch
applies to, in this case the hwsim driver. In my book that is easier to
grasp. But it is a nitpick really and I fixed it up for you when
applying. New subject line is:

 ieee802154: hwsim: propagate genlmsg_reply return code

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
