Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbdDEMXT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 5 Apr 2017 08:23:19 -0400
Message-ID: <1491394992.3437.6.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] Bluetooth: 6lowpan: Remove unnecessary peer lookup
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 05 Apr 2017 15:23:12 +0300
In-Reply-To: <20170403144857.4661-1-luiz.dentz@gmail.com>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: aar@pengutronix.de, linux-wpan@vger.kernel.org

Hi Luiz,

On Mon, 2017-04-03 at 17:48 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> During chan_recv_cb there is already a peer lookup which can be
> passed
> to recv_pkt directly instead of the channel.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index b39da8d..2063e96 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -269,27 +269,20 @@ static int give_skb_to_upper(struct sk_buff
> *skb, struct net_device *dev)
>  }
>  
>  static int iphc_decompress(struct sk_buff *skb, struct net_device
> *netdev,
> -			   struct l2cap_chan *chan)
> +			   struct lowpan_peer *peer)
>  {
>  	const u8 *saddr;
>  	struct lowpan_btle_dev *dev;
> -	struct lowpan_peer *peer;
>  
>  	dev = lowpan_btle_dev(netdev);
>  
> -	rcu_read_lock();
> -	peer = __peer_lookup_chan(dev, chan);
> -	rcu_read_unlock();
> -	if (!peer)
> -		return -EINVAL;
> -
>  	saddr = peer->lladdr;
>  
>  	return lowpan_header_decompress(skb, netdev, netdev-
> >dev_addr, saddr);
>  }
>  
>  static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> -		    struct l2cap_chan *chan)
> +		    struct lowpan_peer *peer)
>  {
>  	struct sk_buff *local_skb;
>  	int ret;
> @@ -342,7 +335,7 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  
>  		local_skb->dev = dev;
>  
> -		ret = iphc_decompress(local_skb, dev, chan);
> +		ret = iphc_decompress(local_skb, dev, peer);
>  		if (ret < 0) {
>  			kfree_skb(local_skb);
>  			goto drop;
> @@ -388,7 +381,7 @@ static int chan_recv_cb(struct l2cap_chan *chan,
> struct sk_buff *skb)
>  	if (!dev || !dev->netdev)
>  		return -ENOENT;
>  
> -	err = recv_pkt(skb, dev->netdev, chan);
> +	err = recv_pkt(skb, dev->netdev, peer);
>  	if (err) {
>  		BT_DBG("recv pkt %d", err);
>  		err = -EAGAIN;


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


