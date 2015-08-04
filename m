Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55897 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140AbbHDNLo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 4 Aug 2015 09:11:44 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFCv2 bluetooth-next 1/2] bluetooth: 6lowpan: change netdev_priv
 to lowpan_dev
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
 <1438346288-14546-2-git-send-email-alex.aring@gmail.com>
Message-ID: <55C0BA0B.5000204@osg.samsung.com>
Date: Tue, 4 Aug 2015 15:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <1438346288-14546-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com

Hello.

On 31/07/15 14:38, Alexander Aring wrote:
> The usually way to get the btle lowpan private data is to use the
> introduced lowpan_dev inline function. This patch will cleanup by using
> lowpan_dev consequently.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/bluetooth/6lowpan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 0ffe2e2..24ed5b0 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -859,7 +859,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
>   	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
>   	SET_NETDEV_DEVTYPE(netdev, &bt_type);
>   
> -	*dev = netdev_priv(netdev);
> +	*dev = lowpan_dev(netdev);
>   	(*dev)->netdev = netdev;
>   	(*dev)->hdev = chan->conn->hcon->hdev;
>   	INIT_LIST_HEAD(&(*dev)->peers);

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
