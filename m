Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:51381 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGMIa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 May 2018 08:08:30 -0400
Subject: Re: [RFC PATCH wpan-tools 1/2] wpan-ping: fix ifname setting
References: <20180427212418.29729-1-aring@mojatatu.com>
 <20180427212418.29729-2-aring@mojatatu.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <659d6c3b-bc47-d909-6e90-27b76da5f50f@datenfreihafen.org>
Date: Mon, 7 May 2018 14:02:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180427212418.29729-2-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello.

On 27.04.2018 23:24, Alexander Aring wrote:
> This patch fix ifname setting, we should use the ifname stored inside
> this string and not give the programming declaration where to find the
> string. Founded by code inspection.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  wpan-ping/wpan-ping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
> index f825b22..791346c 100644
> --- a/wpan-ping/wpan-ping.c
> +++ b/wpan-ping/wpan-ping.c
> @@ -194,7 +194,7 @@ static int get_interface_info(struct config *conf) {
>  	nl_socket_modify_cb(conf->nl_sock, NL_CB_VALID, NL_CB_CUSTOM, nl_msg_cb, conf);
>  	msg = nlmsg_alloc();
>  	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, conf->nl802154_id, 0, NLM_F_DUMP, NL802154_CMD_GET_INTERFACE, 0);
> -	nla_put_string(msg, NL802154_ATTR_IFNAME, "conf->interface");
> +	nla_put_string(msg, NL802154_ATTR_IFNAME, conf->interface);
>  	nl_send_sync(conf->nl_sock, msg);
>  
>  	nl802154_cleanup(conf);
> 

Taking this fix out of the RFC series. Thanks for catching this.
Applied to wpan-tools repo.

regards
Stefan Schmidt
