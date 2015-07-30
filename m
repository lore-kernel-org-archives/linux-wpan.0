Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55007 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbbG3QPV (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jul 2015 12:15:21 -0400
Subject: Re: [PATCH bluetooth-next 1/2] ieee802154: 6lowpan: remove multiple
 lowpan support
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <1437742905-5921-2-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55BA4D95.2000405@osg.samsung.com>
Date: Thu, 30 Jul 2015 18:15:17 +0200
MIME-Version: 1.0
In-Reply-To: <1437742905-5921-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 24/07/15 15:01, Alexander Aring wrote:
> We currently supports multiple lowpan interfaces per wpan interface. I
> never saw any use case into such functionality. We drop this feature now
> because it's much easier do deal with address changes inside the under
> laying wpan interface.
>
> This patch removes the multiple lowpan interface and adds a lowpan_dev
> netdev pointer into the wpan_dev, if this pointer isn't null the wpan
> interface belongs to the assigned lowpan interface.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

I did not come up with a use case for it and nobody complained for a 
week so it should be ok to be removed. If this brings trouble and we get 
a good use case we can always bring this back.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

I also tested them on my setup without seeing any trouble. Do we collect 
Tested tags here or are we happy with reviewed tags? In case we collect them

Tested-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt

> ---
>   include/net/cfg802154.h            |  3 ++
>   net/ieee802154/6lowpan/6lowpan_i.h |  6 ----
>   net/ieee802154/6lowpan/core.c      | 67 +++++++++++---------------------------
>   net/ieee802154/6lowpan/rx.c        | 38 +++++----------------
>   4 files changed, 30 insertions(+), 84 deletions(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 382f94b..e53b6bf 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -173,6 +173,9 @@ struct wpan_dev {
>   	struct list_head list;
>   	struct net_device *netdev;
>   
> +	/* lowpan interface, set when the wpan_dev belongs to one lowpan_dev */
> +	struct net_device *lowpan_dev;
> +
>   	u32 identifier;
>   
>   	/* MAC PIB */
> diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> index e50f69d..876f093 100644
> --- a/net/ieee802154/6lowpan/6lowpan_i.h
> +++ b/net/ieee802154/6lowpan/6lowpan_i.h
> @@ -37,15 +37,9 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
>   	}
>   }
>   
> -struct lowpan_dev_record {
> -	struct net_device *ldev;
> -	struct list_head list;
> -};
> -
>   /* private device info */
>   struct lowpan_dev_info {
>   	struct net_device	*real_dev; /* real WPAN device ptr */
> -	struct mutex		dev_list_mtx; /* mutex for list ops */
>   	u16			fragment_tag;
>   };
>   
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index f20a387..a4edee8 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -52,9 +52,6 @@
>   
>   #include "6lowpan_i.h"
>   
> -LIST_HEAD(lowpan_devices);
> -static int lowpan_open_count;
> -
>   static struct header_ops lowpan_header_ops = {
>   	.create	= lowpan_header_create,
>   };
> @@ -114,7 +111,6 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
>   			  struct nlattr *tb[], struct nlattr *data[])
>   {
>   	struct net_device *real_dev;
> -	struct lowpan_dev_record *entry;
>   	int ret;
>   
>   	ASSERT_RTNL();
> @@ -133,31 +129,19 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
>   		return -EINVAL;
>   	}
>   
> -	lowpan_dev_info(dev)->real_dev = real_dev;
> -	mutex_init(&lowpan_dev_info(dev)->dev_list_mtx);
> -
> -	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> -	if (!entry) {
> +	if (real_dev->ieee802154_ptr->lowpan_dev) {
>   		dev_put(real_dev);
> -		lowpan_dev_info(dev)->real_dev = NULL;
> -		return -ENOMEM;
> +		return -EBUSY;
>   	}
>   
> -	entry->ldev = dev;
> -
> +	lowpan_dev_info(dev)->real_dev = real_dev;
>   	/* Set the lowpan hardware address to the wpan hardware address. */
>   	memcpy(dev->dev_addr, real_dev->dev_addr, IEEE802154_ADDR_LEN);
>   
> -	mutex_lock(&lowpan_dev_info(dev)->dev_list_mtx);
> -	INIT_LIST_HEAD(&entry->list);
> -	list_add_tail(&entry->list, &lowpan_devices);
> -	mutex_unlock(&lowpan_dev_info(dev)->dev_list_mtx);
> -
>   	ret = register_netdevice(dev);
>   	if (ret >= 0) {
> -		if (!lowpan_open_count)
> -			lowpan_rx_init();
> -		lowpan_open_count++;
> +		real_dev->ieee802154_ptr->lowpan_dev = dev;
> +		lowpan_rx_init();
>   	}
>   
>   	return ret;
> @@ -167,27 +151,12 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
>   {
>   	struct lowpan_dev_info *lowpan_dev = lowpan_dev_info(dev);
>   	struct net_device *real_dev = lowpan_dev->real_dev;
> -	struct lowpan_dev_record *entry, *tmp;
>   
>   	ASSERT_RTNL();
>   
> -	lowpan_open_count--;
> -	if (!lowpan_open_count)
> -		lowpan_rx_exit();
> -
> -	mutex_lock(&lowpan_dev_info(dev)->dev_list_mtx);
> -	list_for_each_entry_safe(entry, tmp, &lowpan_devices, list) {
> -		if (entry->ldev == dev) {
> -			list_del(&entry->list);
> -			kfree(entry);
> -		}
> -	}
> -	mutex_unlock(&lowpan_dev_info(dev)->dev_list_mtx);
> -
> -	mutex_destroy(&lowpan_dev_info(dev)->dev_list_mtx);
> -
> -	unregister_netdevice_queue(dev, head);
> -
> +	lowpan_rx_exit();
> +	real_dev->ieee802154_ptr->lowpan_dev = NULL;
> +	unregister_netdevice(dev);
>   	dev_put(real_dev);
>   }
>   
> @@ -214,19 +183,21 @@ static int lowpan_device_event(struct notifier_block *unused,
>   			       unsigned long event, void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> -	LIST_HEAD(del_list);
> -	struct lowpan_dev_record *entry, *tmp;
>   
>   	if (dev->type != ARPHRD_IEEE802154)
>   		goto out;
>   
> -	if (event == NETDEV_UNREGISTER) {
> -		list_for_each_entry_safe(entry, tmp, &lowpan_devices, list) {
> -			if (lowpan_dev_info(entry->ldev)->real_dev == dev)
> -				lowpan_dellink(entry->ldev, &del_list);
> -		}
> -
> -		unregister_netdevice_many(&del_list);
> +	switch (event) {
> +	case NETDEV_UNREGISTER:
> +		/* Check if wpan interface is unregistered that we
> +		 * also delete possible lowpan interfaces which belongs
> +		 * to the wpan interface.
> +		 */
> +		if (dev->ieee802154_ptr && dev->ieee802154_ptr->lowpan_dev)
> +			lowpan_dellink(dev->ieee802154_ptr->lowpan_dev, NULL);
> +		break;
> +	default:
> +		break;
>   	}
>   
>   out:
> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> index 4be1d28..d6f5e8e 100644
> --- a/net/ieee802154/6lowpan/rx.c
> +++ b/net/ieee802154/6lowpan/rx.c
> @@ -15,36 +15,14 @@
>   
>   #include "6lowpan_i.h"
>   
> -static int lowpan_give_skb_to_devices(struct sk_buff *skb,
> -				      struct net_device *dev)
> +static int lowpan_give_skb_to_device(struct sk_buff *skb,
> +				     struct net_device *dev)
>   {
> -	struct lowpan_dev_record *entry;
> -	struct sk_buff *skb_cp;
> -	int stat = NET_RX_SUCCESS;
> -
> +	skb->dev = dev->ieee802154_ptr->lowpan_dev;
>   	skb->protocol = htons(ETH_P_IPV6);
>   	skb->pkt_type = PACKET_HOST;
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(entry, &lowpan_devices, list)
> -		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
> -			skb_cp = skb_copy(skb, GFP_ATOMIC);
> -			if (!skb_cp) {
> -				kfree_skb(skb);
> -				rcu_read_unlock();
> -				return NET_RX_DROP;
> -			}
> -
> -			skb_cp->dev = entry->ldev;
> -			stat = netif_rx(skb_cp);
> -			if (stat == NET_RX_DROP)
> -				break;
> -		}
> -	rcu_read_unlock();
> -
> -	consume_skb(skb);
> -
> -	return stat;
> +	return netif_rx(skb);
>   }
>   
>   static int
> @@ -109,7 +87,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>   	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
>   		/* Pull off the 1-byte of 6lowpan header. */
>   		skb_pull(skb, 1);
> -		return lowpan_give_skb_to_devices(skb, NULL);
> +		return lowpan_give_skb_to_device(skb, dev);
>   	} else {
>   		switch (skb->data[0] & 0xe0) {
>   		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> @@ -117,7 +95,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>   			if (ret < 0)
>   				goto drop_skb;
>   
> -			return lowpan_give_skb_to_devices(skb, NULL);
> +			return lowpan_give_skb_to_device(skb, dev);
>   		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
>   			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
>   			if (ret == 1) {
> @@ -125,7 +103,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>   				if (ret < 0)
>   					goto drop_skb;
>   
> -				return lowpan_give_skb_to_devices(skb, NULL);
> +				return lowpan_give_skb_to_device(skb, dev);
>   			} else if (ret == -1) {
>   				return NET_RX_DROP;
>   			} else {
> @@ -138,7 +116,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>   				if (ret < 0)
>   					goto drop_skb;
>   
> -				return lowpan_give_skb_to_devices(skb, NULL);
> +				return lowpan_give_skb_to_device(skb, dev);
>   			} else if (ret == -1) {
>   				return NET_RX_DROP;
>   			} else {

