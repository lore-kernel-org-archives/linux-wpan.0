Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55207 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbbG3Tg0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jul 2015 15:36:26 -0400
Subject: Re: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: change netdev_priv
 to lowpan_dev
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
 <1438172674-31028-2-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55BA7CB5.7030605@osg.samsung.com>
Date: Thu, 30 Jul 2015 21:36:21 +0200
MIME-Version: 1.0
In-Reply-To: <1438172674-31028-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no

Hello.

On 29/07/15 14:24, Alexander Aring wrote:
> The usually way to get the btle lowpan private data is to use the
> introduced lowpan_dev inline function. This patch will cleanup by using
> lowpan_dev consequently.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/bluetooth/6lowpan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2fb7b30..93c6ba0 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -871,7 +871,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
>   	       &chan->src, chan->src_type);
>   	set_bit(__LINK_STATE_PRESENT, &netdev->state);
>   
> -	*dev = netdev_priv(netdev);
> +	*dev = lowpan_dev(netdev);
>   	(*dev)->netdev = netdev;
>   	(*dev)->hdev = chan->conn->hcon->hdev;
>   	INIT_LIST_HEAD(&(*dev)->peers);

This patch does no longer apply. There have been 5 patches to the 
6lowpan file in bluetooth from Gleen. You need to rebase this one.

regards
Stefan Schmidt
