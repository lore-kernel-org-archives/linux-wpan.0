Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:40431 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbbA1UuI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Jan 2015 15:50:08 -0500
Received: by mail-wi0-f175.google.com with SMTP id fb4so15064261wid.2
        for <linux-wpan@vger.kernel.org>; Wed, 28 Jan 2015 12:50:07 -0800 (PST)
Message-ID: <54C8FB16.6040006@6wind.com>
Date: Wed, 28 Jan 2015 16:07:02 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] caif: remove wrong dev_net_set() call
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <1422307694-10079-2-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1422307694-10079-2-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, arvid.brodin@alten.se, alex.aring@gmail.com, linux-wpan@vger.kernel.org, Dmitry Tarnyagin <abi.dmitryt@gmail.com>

Removing bouncing email addresses (dmitry.tarnyagin@lockless.no and
sjur.brandeland@stericsson.com)
CC: Dmitry Tarnyagin <abi.dmitryt@gmail.com>

Dmitry, please also have a look to
http://permalink.gmane.org/gmane.linux.network/347942


Thank you,
Nicolas

Le 26/01/2015 22:28, Nicolas Dichtel a écrit :
> src_net points to the netns where the netlink message has been received. This
> netns may be different from the netns where the interface is created (because
> the user may add IFLA_NET_NS_[PID|FD]). In this case, src_net is the link netns.
>
> It seems wrong to override the netns in the newlink() handler because if it
> was not already src_net, it means that the user explicitly asks to create the
> netdevice in another netns.
>
> CC: Sjur Brændeland <sjur.brandeland@stericsson.com>
> CC: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>
> Fixes: 8391c4aab1aa ("caif: Bugfixes in CAIF netdevice for close and flow control")
> Fixes: c41254006377 ("caif-hsi: Add rtnl support")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>   drivers/net/caif/caif_hsi.c | 1 -
>   net/caif/chnl_net.c         | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/net/caif/caif_hsi.c b/drivers/net/caif/caif_hsi.c
> index 5e40a8b68cbe..b3b922adc0e4 100644
> --- a/drivers/net/caif/caif_hsi.c
> +++ b/drivers/net/caif/caif_hsi.c
> @@ -1415,7 +1415,6 @@ static int caif_hsi_newlink(struct net *src_net, struct net_device *dev,
>
>   	cfhsi = netdev_priv(dev);
>   	cfhsi_netlink_parms(data, cfhsi);
> -	dev_net_set(cfhsi->ndev, src_net);
>
>   	get_ops = symbol_get(cfhsi_get_ops);
>   	if (!get_ops) {
> diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> index 4589ff67bfa9..67a4a36febd1 100644
> --- a/net/caif/chnl_net.c
> +++ b/net/caif/chnl_net.c
> @@ -470,7 +470,6 @@ static int ipcaif_newlink(struct net *src_net, struct net_device *dev,
>   	ASSERT_RTNL();
>   	caifdev = netdev_priv(dev);
>   	caif_netlink_parms(data, &caifdev->conn_req);
> -	dev_net_set(caifdev->netdev, src_net);
>
>   	ret = register_netdevice(dev);
>   	if (ret)
>

