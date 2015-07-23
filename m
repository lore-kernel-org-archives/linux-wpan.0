Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37753 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbGWHzZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2015 03:55:25 -0400
Date: Thu, 23 Jul 2015 09:55:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC v2 4/4] Bluetooth: 6lowpan: Enable stateful compression in
 bluetooth_6lowpan
Message-ID: <20150723075523.GA19536@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
 <1436788233-13960-5-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1436788233-13960-5-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

On Mon, Jul 13, 2015 at 01:50:33PM +0200, Lukasz Duda wrote:
> Allocating context table for stateful compression when interface is set
> up. Removing context table when interface is being unregistered.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 2fb7b30..60c7e80 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -871,6 +871,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
>  	       &chan->src, chan->src_type);
>  	set_bit(__LINK_STATE_PRESENT, &netdev->state);
>  
> +	/* Allocate context table for stateful compression. */
> +	lowpan_context_table_alloc(netdev);
> +
>  	*dev = netdev_priv(netdev);
>  	(*dev)->netdev = netdev;
>  	(*dev)->hdev = chan->conn->hcon->hdev;
> @@ -1415,6 +1418,7 @@ static int device_event(struct notifier_block *unused,
>  			if (entry->netdev == netdev) {
>  				BT_DBG("Unregistered netdev %s %p",
>  				       netdev->name, netdev);
> +				lowpan_context_table_free(netdev);
>  				list_del(&entry->list);
>  				break;
>  			}

Don't we need similar allocation in net/ieee802154/6lowpan/core.c ?

- Alex
