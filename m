Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60275 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbcGLVTt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 Jul 2016 17:19:49 -0400
Subject: Re: [RFC bluetooth-next 20/20] 6lowpan: bluetooth: add new
 implementation
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-21-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <dc82361d-4c3c-8b40-8463-97909c217485@pengutronix.de>
Date: Tue, 12 Jul 2016 23:19:26 +0200
MIME-Version: 1.0
In-Reply-To: <20160711195044.25343-21-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com


Hi,

On 07/11/2016 09:50 PM, Alexander Aring wrote:
> This patch adds a new btle 6lowpan implementation in version 0.2. This
> new implementation has a new userspace API for debugfs.
> 
> It's now possible to decide on which hci interface do you want to run
> your 6LoWPAN interface, for that you can run:
> 
> echo "hci0 1" > /sys/kernel/debug/bluetooth/6lowpan_enable
> 
> to enable, or:
> 
> echo "hci0 0" > /sys/kernel/debug/bluetooth/6lowpan_enable
> 
> to disable it. A cat on this file will show the current hci <-> 6lowpan
> interface mapping.
> 
> Additional the different is, that the interface will be created after
> enable it. The old behaviour is that the interface will be created when
> one first connection is established and deleted after all connections
> (peers) will be disconnected. This handling is different now.
> 
> The reason (in my opinion) is that the existing of such interface should
> not based on if there is a connection or not. At runtime of many IPv6
> application an interface will be removed -> I think the most userspace
> application can and will never handle that an IPv6 interface will be
> deleted and recreating during runtime.
> 
> The new handling is that the interface will not removed and you can
> re-establish the connection to your peers.
> 
> Connection to peers:
> 
> Connection to peers are not binded to hci interface, it's binded to your
> 6LoWPAN interface. This will prepare handling for multiple 6LoWPAN
> interfaces on one hci (maybe also with netns support, which isn't
> available yet) and you can choose which peers should be handled by
> different BTLE 6LoWPAN interfaces. Example:
> 
> L2: hci0 is connected to node A, B, C, D
> 
> L3: 6lo0 and 6lo1 are two interfaces based on hci0.
>     6lo0 is connected to nodes: A, B, C
>     6lo1 is connected to nodes: D, C, B
> 
> as one possible example. Handle this peer interface will have a possible
> more fine-granularity connection for peers.
> 
> To connect to peers, there exists no "6lowpan_control" anymore. The
> control file is now peer interface, it's simple:
> 
> echo "connect $PEER_ADDRESS 1" > /sys/kernel/debug/bluetooth/6lo0
> 
> Also after connecting to peers it's still possible that another peer can
> to connect to the peer which has already a connected peer (complicated
> to describe). I saw that is somehow disabled in version before, see:
> 
> http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L1247
> 
> I am not a bluetooth expert, but I guess that is somehow if there exists
> limitation to devices which are not "peers" that means devices which can
> be run as master or slave only. So far I know such limitations for
> devices doesn't exists for BTLE 6LoWPAN, or?
> 

I think the following will explain somehow when it's a SLAVE and when
MASTER as my current view.

SLAVES:

They don't makes this echo "connect ..." foo in control files.
they only do "hciconfig hci0 leadv" that somebody other can connect to
that node (some MASTER node).

MASTERS:

can do the same what the SLAVES does but to be as MASTER they need to call
additional stuff:

hcitool lecc $SLAVE_ADDR (one or more times)

Additional for different lowpan interfaces (don't need the same addresses
which was used by previous one or more hcitool lecc calls):

echo "connect SLAVE_ADDR 1" > /sys/kernel/debug/bluetooth/6lo0

is this a correct view and can all BTLE transceivers run as SLAVE or
MASTER, or exists there some special transceivers outside which can be
run as SLAVE only?

> Nevertheless I disabled that stuff, it's still possible to connect to
> some node which already run "connect ..." on his side.
> 
> Otherwise I fixed the ndisc stuff and removed a lot of races/side
> effects. The old code had some static "lowpan_devices" list and most
> time there was some lookup mapping according to bdaddr to get the right
> 6lo netdevice struct. I removed that, also the skb->cb is used a lot in
> some callback which had some side-effects.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  include/net/bluetooth/hci_core.h |   10 +
>  net/bluetooth/6lowpan.c          | 1015 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/Makefile           |    3 +
>  3 files changed, 1028 insertions(+)
>  create mode 100644 net/bluetooth/6lowpan.c
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a37027a..37a2256 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -399,6 +399,16 @@ struct hci_dev {
>  
>  	struct led_trigger	*power_led;
>  
> +#if IS_ENABLED(CONFIG_BT_6LOWPAN)
> +	/* TODO for netns support this need to be a list
> +	 * variables are protected by RTNL here
> +	 */
> +	struct net_device *ldev;
> +	bool lowpan_enable;
> +	/* delete lowpan iface via debugfs workaround */
> +	bool pending_deletion;
> +#endif
> +
>  	int (*open)(struct hci_dev *hdev);
>  	int (*close)(struct hci_dev *hdev);
>  	int (*flush)(struct hci_dev *hdev);
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> new file mode 100644
> index 0000000..a8a3410
> --- /dev/null
> +++ b/net/bluetooth/6lowpan.c
> @@ -0,0 +1,1015 @@
> +/*
> +   (C) 2016 Pengutronix, Alexander Aring <aar@pengutronix.de>
> +   Copyright (c) 2013-2014 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#include <linux/if_arp.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +
> +#include <net/ipv6.h>
> +#include <net/ip6_route.h>
> +#include <net/addrconf.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
> +
> +#include <net/6lowpan.h>
> +
> +#define LOWPAN_BTLE_VERSION "0.2"
> +
> +#define lowpan_le48_to_be48(dst, src) baswap((bdaddr_t *)dst, (bdaddr_t *)src)
> +#define lowpan_be48_to_le48(dst, src) baswap((bdaddr_t *)dst, (bdaddr_t *)src)
> +
> +struct lowpan_btle_cb {
> +	struct l2cap_chan *chan;
> +};
> +
> +struct lowpan_btle_dev {
> +	struct hci_dev *hdev;
> +	struct workqueue_struct *workqueue;
> +	struct l2cap_chan *listen;
> +	struct list_head peers;
> +	struct dentry *control;
> +};
> +
> +struct lowpan_peer {
> +	struct l2cap_chan *chan;
> +
> +	struct list_head list;
> +};
> +
> +struct lowpan_chan_data {
> +	struct lowpan_peer peer;
> +	struct net_device *dev;
> +};
> +
> +struct lowpan_xmit_work {
> +	struct work_struct work;
> +	struct l2cap_chan *chan;
> +	struct net_device *dev;
> +	unsigned int true_len;
> +	struct sk_buff *skb;
> +};
> +
> +static inline struct lowpan_btle_cb *
> +lowpan_btle_cb(const struct sk_buff *skb)
> +{
> +	return (struct lowpan_btle_cb *)skb->cb;
> +}
> +
> +static inline struct lowpan_chan_data *
> +lowpan_chan_data(const struct l2cap_chan *chan)
> +{
> +	return (struct lowpan_chan_data *)chan->data;
> +}
> +
> +static inline struct lowpan_btle_dev *
> +lowpan_btle_dev(const struct net_device *dev)
> +{
> +	return (struct lowpan_btle_dev *)lowpan_dev(dev)->priv;
> +}
> +
> +static inline struct lowpan_peer *
> +lowpan_lookup_peer(struct lowpan_btle_dev *btdev, bdaddr_t *addr)
> +{
> +	struct lowpan_peer *entry;
> +
> +	list_for_each_entry_rcu(entry, &btdev->peers, list) {
> +		if (!bacmp(&entry->chan->dst, addr))
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int lowpan_give_skb_to_device(struct sk_buff *skb)
> +{
> +	skb->protocol = htons(ETH_P_IPV6);
> +	skb->dev->stats.rx_packets++;
> +	skb->dev->stats.rx_bytes += skb->len;
> +
> +	return netif_rx_ni(skb);
> +}
> +
> +static int lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
> +{
> +	switch (res) {
> +	case RX_CONTINUE:
> +		/* nobody cared about this packet */
> +		net_warn_ratelimited("%s: received unknown dispatch\n",
> +				     __func__);

that printout isn't corrected, for simplification I drop all non iphc
frames at recv callback.

I want to have this receive handling into "net/6lowpan" but I want to
not doing this now in this patch-series. It will prepare it.

After moving it to "net/6lowpan" unknown dispatches should be really
dispatches which are not known in the current state of implementation.

I think it's okay to leave this right there as it is, also somebody can
trigger this warning by sending lot of frames with the right dispatch,
not sure if that's normal that somebody from outside can trigger a lot
of system messages which are show up in dmesg. Need to think about it,
maybe some "ONCE" mechanism or using debug stuff.

> +
> +		/* fall-through */
> +	case RX_DROP_UNUSABLE:
> +		kfree_skb(skb);
> +
> +		/* fall-through */
> +	case RX_DROP:
> +		return NET_RX_DROP;
> +	case RX_QUEUED:
> +		return lowpan_give_skb_to_device(skb);
> +	default:
> +		break;
> +	}
> +
> +	return NET_RX_DROP;
> +}
> +
> +static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
> +{
> +	struct l2cap_chan *chan = lowpan_btle_cb(skb)->chan;
> +	bdaddr_t daddr, saddr;
> +	int ret;
> +
> +	if (!lowpan_is_iphc(*skb_network_header(skb)))
> +		return RX_CONTINUE;
> +
> +	BT_DBG("recv %s dst: %pMR type %d src: %pMR chan %p",
> +	       skb->dev->name, &chan->dst, chan->dst_type, &chan->src, chan);
> +
> +	/* bluetooth chan view is vice-versa */
> +	bacpy(&daddr, &chan->src);
> +	bacpy(&saddr, &chan->dst);
> +
> +	ret = lowpan_header_decompress(skb, skb->dev, &daddr, &saddr);
> +	if (ret < 0)
> +		return RX_DROP_UNUSABLE;
> +
> +	return RX_QUEUED;
> +}
> +
> +static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
> +{
> +	lowpan_rx_result res;
> +
> +#define CALL_RXH(rxh)			\
> +	do {				\
> +		res = rxh(skb);		\
> +		if (res != RX_CONTINUE)	\
> +			goto rxh_next;	\
> +	} while (0)
> +
> +	/* likely at first */
> +	CALL_RXH(lowpan_rx_h_iphc);
> +
> +rxh_next:
> +	return lowpan_rx_handlers_result(skb, res);
> +#undef CALL_RXH
> +}
> +
> +static int lowpan_chan_recv(struct l2cap_chan *chan, struct sk_buff *skb)
> +{
> +	struct lowpan_chan_data *data = lowpan_chan_data(chan);
> +	struct net_device *dev = data->dev;
> +	int ret;
> +
> +	/* TODO handle BT_CONNECTED in bluetooth subsytem? on
> +	 * when calling recv callback, I hit that case somehow
> +	 */
> +	if (!netif_running(dev) || chan->state != BT_CONNECTED ||
> +	    !skb->len || !lowpan_is_iphc(skb->data[0]))
> +		goto drop;
> +
> +	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
> +	skb = skb_unshare(skb, GFP_ATOMIC);

can be GFP_KERNEL here.

> +	if (!skb)
> +		goto out;
> +
> +	skb->dev = dev;
> +	skb_reset_network_header(skb);
> +
> +	/* remember that one for dst bdaddr. TODO handle that as priv data for
> +	 * lowpan_invoke_rx_handlers parameter. Not necessary for skb->cb.
> +	 */

After fixing that, skb->cb isn't needed anymore in this implementation.
But I will do that when moving to receive handling to "net/6lowpan".

> +	lowpan_btle_cb(skb)->chan = chan;
> +
> +	ret = lowpan_invoke_rx_handlers(skb);
> +	if (ret == NET_RX_DROP)
> +		BT_DBG("recv %s dropped chan %p", skb->dev->name, chan);
> +
> +	return 0;
> +
> +drop:
> +	kfree_skb(skb);
> +out:
> +	/* we handle to free skb on error, so must 0
> +	 * seems that callback free the skb on error
> +	 * otherwise.
> +	 */

btw:

This is also a MUST to return 0 here always. Because netif_rx_ni will handle
also freeing on error and we cannot change this handling. (Or we doing
some crazy reference counting before foo, but will more confuse
everybody).

> +	return 0;
> +}
> +
> +static void lowpan_xmit_worker(struct work_struct *work)
> +{
> +	struct lowpan_btle_dev *btdev;
> +	struct lowpan_xmit_work *xw;
> +	struct l2cap_chan *chan;
> +	struct net_device *dev;
> +	struct msghdr msg = { };
> +	struct kvec iv;
> +	int ret;
> +
> +	xw = container_of(work, struct lowpan_xmit_work, work);
> +	dev = xw->dev;
> +	chan = xw->chan;
> +	btdev = lowpan_btle_dev(dev);
> +
> +	iv.iov_base = xw->skb->data;
> +	iv.iov_len = xw->skb->len;
> +	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, xw->skb->len);
> +
> +	BT_DBG("l2cap_chan_send %s dst: %pMR type %d src: %pMR chan %p",
> +	       dev->name, &chan->dst, chan->dst_type, &chan->src, chan);
> +
> +	l2cap_chan_lock(chan);
> +
> +	ret = l2cap_chan_send(chan, &msg, xw->skb->len);
> +	BT_DBG("transmit return value %d", ret);
> +	if (ret < 0) {
> +		BT_DBG("send %s failed chan %p", dev->name, chan);
> +		kfree_skb(xw->skb);
> +	} else {
> +		consume_skb(xw->skb);
> +		dev->stats.tx_bytes += xw->true_len;
> +		dev->stats.tx_packets++;
> +	}
> +
> +	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
> +
> +	kfree(xw);
> +}
> +
> +static void lowpan_send_unicast_pkt(struct net_device *dev,
> +				    struct l2cap_chan *chan,
> +				    struct sk_buff *skb,
> +				    unsigned int true_len)
> +{
> +	struct lowpan_xmit_work *xw;
> +
> +	/* copy to xmit work buffer */
> +	xw = kzalloc(sizeof(*xw), GFP_ATOMIC);
> +	if (!xw)
> +		return;
> +
> +	/* chan->lock mutex need to be hold so change context to workqueue */
> +	INIT_WORK(&xw->work, lowpan_xmit_worker);
> +	xw->true_len = true_len;
> +	/* freeing protected by ifdown workqueue sync */
> +	xw->dev = dev;
> +	/* disallow freeing of skb while context switch */
> +	xw->skb = skb_get(skb);
> +	/* disallow freeing while context switch */
> +	l2cap_chan_hold(chan);
> +	xw->chan = chan;
> +
> +	queue_work(lowpan_btle_dev(dev)->workqueue, &xw->work);
> +}
> +
> +static void lowpan_send_mcast_pkt(struct net_device *dev, struct sk_buff *skb,
> +				  unsigned int true_len)
> +{
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +	struct lowpan_peer *peer;
> +
> +	rcu_read_lock();
> +
> +	BT_DBG("xmit %s starts multicasting", dev->name);
> +
> +	/* We need to send the packet to every device behind this
> +	 * interface, because multicasting.
> +	 */
> +	list_for_each_entry_rcu(peer, &btdev->peers, list)
> +		lowpan_send_unicast_pkt(dev, peer->chan, skb, true_len);
> +
> +	rcu_read_unlock();
> +}
> +
> +static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct lowpan_addr_info *info = lowpan_addr_info(skb);
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +	unsigned int true_len = skb->len;
> +	struct lowpan_peer *peer;
> +	bdaddr_t daddr, saddr;
> +	int ret;
> +
> +	/* We must take a copy of the skb before we modify/replace the ipv6
> +	 * header as the header could be used elsewhere.
> +	 */
> +	skb = skb_unshare(skb, GFP_ATOMIC);
> +	if (!skb) {
> +		kfree_skb(skb);
> +		goto out;
> +	}
> +
> +	lowpan_be48_to_le48(&daddr, info->daddr);
> +	lowpan_be48_to_le48(&saddr, info->saddr);
> +
> +	BT_DBG("xmit ndisc %s dst: %pMR src: %pMR",
> +	       dev->name, &daddr, &saddr);
> +
> +	ret = lowpan_header_compress(skb, dev, &daddr, &saddr);
> +	if (ret < 0) {
> +		kfree_skb(skb);
> +		goto out;
> +	}
> +
> +	/* this should never be the case, otherwise iphc is broken */
> +	WARN_ON_ONCE(skb->len > dev->mtu);
> +
> +	if (!memcmp(&daddr, dev->broadcast, dev->addr_len)) {
> +		lowpan_send_mcast_pkt(dev, skb, true_len);
> +	} else {
> +		btdev = lowpan_btle_dev(dev);
> +

btdev = can be removed here.

> +		rcu_read_lock();
> +
> +		peer = lowpan_lookup_peer(btdev, &daddr);
> +		if (peer)
> +			lowpan_send_unicast_pkt(dev, peer->chan, skb,
> +						true_len);
> +
> +		rcu_read_unlock();
> +	}
> +
> +	consume_skb(skb);
> +
> +out:
> +	return NETDEV_TX_OK;
> +}
> +
> +static int lowpan_stop(struct net_device *dev)
> +{
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +
> +	/* synchronize with xmit worker */
> +	flush_workqueue(btdev->workqueue);
> +	return 0;
> +}
> +
> +static struct sk_buff *lowpan_chan_alloc_skb(struct l2cap_chan *chan,
> +					     unsigned long hdr_len,
> +					     unsigned long len, int nb)
> +{
> +	return bt_skb_alloc(hdr_len + len, GFP_KERNEL);
> +}
> +
> +static long lowpan_chan_get_sndtimeo(struct l2cap_chan *chan)
> +{
> +	return L2CAP_CONN_TIMEOUT;
> +}
> +
> +static struct l2cap_chan *lowpan_chan_create(struct net_device *dev)
> +{
> +	struct lowpan_chan_data *data;
> +	struct l2cap_chan *chan;
> +
> +	chan = l2cap_chan_create();
> +	if (!chan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data = kmalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		l2cap_chan_put(chan);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	l2cap_chan_set_defaults(chan);
> +	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
> +	chan->mode = L2CAP_MODE_LE_FLOWCTL;
> +	chan->imtu = dev->mtu;
> +	chan->data = data;
> +
> +	data->peer.chan = chan;
> +	data->dev = dev;
> +
> +	return chan;
> +}
> +
> +static struct l2cap_chan *lowpan_chan_new_conn(struct l2cap_chan *pchan)
> +{
> +	struct lowpan_chan_data *data = lowpan_chan_data(pchan);
> +	struct l2cap_chan *chan;
> +
> +	chan = lowpan_chan_create(data->dev);
> +	if (IS_ERR(chan))
> +		return NULL;
> +
> +	chan->ops = pchan->ops;
> +	return chan;
> +}
> +
> +static void lowpan_chan_ready(struct l2cap_chan *chan)
> +{
> +	struct lowpan_chan_data *data = lowpan_chan_data(chan);
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(data->dev);
> +
> +	BT_DBG("%s chan %p ready ", data->dev->name, chan);
> +
> +	/* make it visible for xmit */
> +	list_add_tail_rcu(&data->peer.list, &btdev->peers);
> +	synchronize_rcu();
> +}
> +
> +static void lowpan_chan_close(struct l2cap_chan *chan)
> +{
> +	struct lowpan_chan_data *data = lowpan_chan_data(chan);
> +
> +	BT_DBG("%s chan %p closed ", data->dev->name, chan);
> +
> +	/* make it unvisible for xmit */
> +	list_del_rcu(&data->peer.list);
> +	synchronize_rcu();
> +	kfree(data);

I currently think much about to run kfree here and I think I need
bluetooth experts to answer the correct handling here.

We allocate that data on chan_create, but doing a free in chan_close
requires that the chan state system will never run chan_ready
afterwards. Is this correct?

Correct handling for me is to do the free when the last chan_put was
called and free everything. Maybe it could be useful to add some
private_data _room_ to l2cap_chan_create, which sits after "struct
l2cap_chan" as something like "u8 data[0]", to allocate/free everything
at once.

I didn't hit any issues yet that after a close, the ready callback will
be called again so I think this can never happen.

btw:

previous implementation had kfree_rcu here, but we run synchronize_rcu
before and this is not needed anymore. I think kfree_rcu will not block,
but I feeling better to not leave that callback after running
synchronize_rcu. :-/

> +}
> +
> +static const struct l2cap_ops lowpan_chan_ops = {
> +	.name			= "L2CAP 6LoWPAN channel",
> +	.new_connection		= lowpan_chan_new_conn,
> +	.recv			= lowpan_chan_recv,
> +	.close			= lowpan_chan_close,
> +	.state_change		= l2cap_chan_no_state_change,
> +	.ready			= lowpan_chan_ready,
> +	.get_sndtimeo		= lowpan_chan_get_sndtimeo,
> +	.alloc_skb		= lowpan_chan_alloc_skb,
> +	.teardown		= l2cap_chan_no_teardown,
> +	.defer			= l2cap_chan_no_defer,
> +	.set_shutdown		= l2cap_chan_no_set_shutdown,
> +	.resume			= l2cap_chan_no_resume,
> +	.suspend		= l2cap_chan_no_suspend,
> +};
> +
> +static int lowpan_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +
> +	/* if dev is down, peers list are protected by RTNL */
> +	if (netif_running(dev) || !list_empty(&btdev->peers))
> +		return -EBUSY;
> +
> +	if (new_mtu < IPV6_MIN_MTU)
> +		return -EINVAL;
> +
> +	dev->mtu = new_mtu;
> +	return 0;
> +}
> +
> +static const struct net_device_ops netdev_ops = {
> +	.ndo_init		= lowpan_dev_init,
> +	.ndo_stop		= lowpan_stop,
> +	.ndo_start_xmit		= lowpan_xmit,
> +	.ndo_change_mtu		= lowpan_change_mtu,
> +};
> +
> +static void lowpan_free_netdev(struct net_device *dev)
> +{
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +	struct lowpan_peer *peer, *tmp;
> +	struct l2cap_chan *chan;
> +
> +	l2cap_chan_close(btdev->listen, 0);
> +	l2cap_chan_put(btdev->listen);
> +
> +	/* no rcu here? should be safe netdev is down */
> +	list_for_each_entry_safe(peer, tmp, &btdev->peers, list) {
> +		/* close will free peer data, so save chan here */
> +		chan = peer->chan;
> +
> +		/* will del peer from list and and free.
> +		 * should be safe by tmp pointer which has
> +		 * a pointer for the next entry.
> +		 */
> +		l2cap_chan_close(chan, 0);
> +		l2cap_chan_put(chan);
> +	}
> +
> +	destroy_workqueue(btdev->workqueue);
> +	btdev->hdev->lowpan_enable = false;
> +	debugfs_remove(btdev->control);
> +	hci_dev_put(btdev->hdev);
> +}
> +
> +static void lowpan_setup(struct net_device *dev)
> +{
> +	memset(dev->broadcast, 0xff, sizeof(bdaddr_t));
> +
> +	dev->netdev_ops	= &netdev_ops;
> +	dev->destructor	= lowpan_free_netdev;
> +	dev->features	|= NETIF_F_NETNS_LOCAL;
> +}
> +
> +static struct device_type bt_type = {
> +	.name	= "bluetooth",
> +};
> +
> +static struct l2cap_chan *lowpan_listen_chan_new_conn(struct l2cap_chan *pchan)
> +{
> +	struct l2cap_chan *chan;
> +
> +	chan = lowpan_chan_create(pchan->data);
> +	if (IS_ERR(chan))
> +		return NULL;
> +
> +	/* change ops with more functionality than listen,
> +	 * which also free chan->data stuff.
> +	 */
> +	chan->ops = &lowpan_chan_ops;
> +
> +	return chan;
> +}
> +
> +static const struct l2cap_ops lowpan_listen_chan_ops = {
> +	.name			= "L2CAP 6LoWPAN listen channel",
> +	.new_connection		= lowpan_listen_chan_new_conn,
> +	.recv			= l2cap_chan_no_recv,
> +	.close			= l2cap_chan_no_close,
> +	.state_change		= l2cap_chan_no_state_change,
> +	.ready			= l2cap_chan_no_ready,
> +	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
> +	.alloc_skb		= l2cap_chan_no_alloc_skb,
> +	.teardown		= l2cap_chan_no_teardown,
> +	.defer			= l2cap_chan_no_defer,
> +	.set_shutdown		= l2cap_chan_no_set_shutdown,
> +	.resume			= l2cap_chan_no_resume,
> +	.suspend		= l2cap_chan_no_suspend,
> +};
> +
> +static int lowpan_create_listen_chan(struct net_device *dev)
> +{
> +	struct lowpan_btle_dev *btdev = lowpan_btle_dev(dev);
> +	struct l2cap_chan *chan;
> +	u8 bdaddr_type;
> +	int ret;
> +
> +	/* don't use lowpan_chan_create here, because less functionality */
> +	chan = l2cap_chan_create();
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	chan->data = dev;

I will add a comment here that this private_data of chan is really
"struct net_device *dev" only, it's for listen stuff only.

Looks wrong at the first sight.

> +	chan->ops = &lowpan_listen_chan_ops;
> +	hci_copy_identity_address(btdev->hdev, &chan->src, &bdaddr_type);
> +	if (bdaddr_type == ADDR_LE_DEV_PUBLIC)
> +		chan->src_type = BDADDR_LE_PUBLIC;
> +	else
> +		chan->src_type = BDADDR_LE_RANDOM;
> +
> +	chan->state = BT_LISTEN;
> +	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
> +
> +	BT_DBG("chan %p src type %d", chan, chan->src_type);
> +	ret = l2cap_add_psm(chan, BDADDR_ANY, cpu_to_le16(L2CAP_PSM_IPSP));
> +	if (ret) {
> +		l2cap_chan_put(chan);
> +		BT_ERR("psm cannot be added err %d", ret);
> +		return ret;
> +	}
> +	btdev->listen = chan;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations lowpan_control_fops;
> +
> +static struct net_device *lowpan_btle_newlink(struct hci_dev *hdev)
> +{
> +	struct lowpan_btle_dev *btdev;
> +	struct net_device *dev;
> +	int err = -ENOMEM;
> +
> +	dev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_btle_dev)),
> +			   LOWPAN_IFNAME_TEMPLATE, NET_NAME_ENUM, lowpan_setup);
> +	if (!dev)
> +		goto out;
> +
> +	dev->addr_assign_type = NET_ADDR_PERM;
> +	dev->addr_len = sizeof(hdev->bdaddr.b);
> +	lowpan_le48_to_be48(dev->dev_addr, &hdev->bdaddr);
> +
> +	SET_NETDEV_DEV(dev, &hdev->dev);
> +	SET_NETDEV_DEVTYPE(dev, &bt_type);
> +
> +	btdev = lowpan_btle_dev(dev);
> +	/* avoid freeing */
> +	btdev->hdev = hci_dev_hold(hdev);
> +	INIT_LIST_HEAD(&btdev->peers);
> +
> +	btdev->workqueue = create_singlethread_workqueue(dev->name);
> +	if (!btdev->workqueue) {
> +		free_netdev(dev);
> +		goto out;
> +	}
> +
> +	err = lowpan_create_listen_chan(dev);
> +	if (err < 0) {
> +		destroy_workqueue(btdev->workqueue);
> +		free_netdev(dev);
> +		goto out;
> +	}
> +
> +	err = lowpan_register_netdevice(dev, LOWPAN_LLTYPE_BTLE);
> +	if (err < 0) {
> +		BT_ERR("register_netdev failed %d", err);
> +		l2cap_chan_close(btdev->listen, 0);
> +		l2cap_chan_put(btdev->listen);
> +		free_netdev(dev);
> +		goto out;
> +	}
> +	hdev->ldev = dev;
> +
> +	/* ignore error handling here, we cannot call unregister anymore
> +	 * It's a bug, but it's debugfs... so ignore it.
> +	 */
> +	btdev->control = debugfs_create_file(dev->name, 0644,
> +					     bt_debugfs, btdev,
> +					     &lowpan_control_fops);
> +	if (!btdev->control)
> +		BT_ERR("debugfs error for %s, disable/enable 6lowpan again",
> +		       dev->name);
> +
> +	return dev;
> +
> +out:
> +	return ERR_PTR(err);
> +}
> +
> +static void lowpan_btle_dellink(struct net_device *dev)
> +{
> +	lowpan_unregister_netdevice(dev);
> +}
> +
> +static int lowpan_parse_le_bdaddr(struct hci_dev *hdev, unsigned char *buf,
> +				  bdaddr_t *addr, u8 *addr_type)
> +{
> +	int n;
> +
> +	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
> +		   &addr->b[5], &addr->b[4], &addr->b[3],
> +		   &addr->b[2], &addr->b[1], &addr->b[0],
> +		   addr_type);
> +	if (n < 7)
> +		return -EINVAL;
> +
> +	/* check if we handle le addresses and not own source address */
> +	if (!bdaddr_type_is_le(*addr_type) ||
> +	    !bacmp(&hdev->bdaddr, addr))
> +		return -EINVAL;
> +
> +	return n;
> +}
> +
> +static ssize_t __lowpan_control_write(struct file *fp,
> +				      const char __user *user_buffer,
> +				      size_t count, loff_t *position)
> +{
> +	char buf[32] = { };
> +	size_t buf_size = min(count, sizeof(buf) - 1);
> +	struct seq_file *file = fp->private_data;
> +	struct lowpan_btle_dev *btdev = file->private;
> +	struct hci_dev *hdev = btdev->hdev;
> +	struct lowpan_peer *peer;
> +	/* slave address */
> +	bdaddr_t addr;
> +	u8 addr_type;
> +	int ret;
> +
> +	if (copy_from_user(buf, user_buffer, buf_size))
> +		return -EFAULT;
> +
> +	if (memcmp(buf, "connect ", 8) == 0) {
> +		struct lowpan_peer *peer;

peer can be removed here.

> +		struct l2cap_chan *chan;
> +
> +		ret = lowpan_parse_le_bdaddr(hdev, &buf[8], &addr, &addr_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check if we already know that slave */
> +		rcu_read_lock();
> +		peer = lowpan_lookup_peer(btdev, &addr);
> +		if (peer) {
> +			rcu_read_unlock();
> +			BT_DBG("6LoWPAN connection already exists");
> +			return -EEXIST;
> +		}
> +		rcu_read_unlock();
> +
> +		chan = lowpan_chan_create(hdev->ldev);
> +		if (IS_ERR(chan))
> +			return PTR_ERR(chan);
> +		chan->ops = &lowpan_chan_ops;
> +
> +		ret = l2cap_hdev_chan_connect(hdev, chan,
> +					      cpu_to_le16(L2CAP_PSM_IPSP),
> +					      0, &addr, addr_type);
> +		if (ret < 0) {
> +			l2cap_chan_put(chan);
> +			return ret;
> +		}
> +
> +		return count;
> +	} else if (memcmp(buf, "disconnect ", 11) == 0) {
> +		ret = lowpan_parse_le_bdaddr(hdev, &buf[11], &addr, &addr_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check if we don't know that slave */
> +		rcu_read_lock();
> +		peer = lowpan_lookup_peer(btdev, &addr);
> +		if (!peer) {
> +			rcu_read_unlock();
> +			BT_DBG("6LoWPAN connection not found in peers");
> +			return -ENOENT;
> +		}
> +		rcu_read_unlock();
> +
> +		/* first delete the peer out of list,
> +		 * which makes it visiable to netdev,
> +		 * will be done by close callback.
> +		 */
> +		l2cap_chan_close(peer->chan, 0);
> +		l2cap_chan_put(peer->chan);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t lowpan_control_write(struct file *fp,
> +				    const char __user *user_buffer,
> +				    size_t count, loff_t *position)
> +{
> +	ssize_t ret;
> +
> +	rtnl_lock();
> +	ret = __lowpan_control_write(fp, user_buffer, count, position);
> +	rtnl_unlock();
> +
> +	return ret;
> +}
> +
> +static int lowpan_control_show(struct seq_file *f, void *ptr)
> +{
> +	struct lowpan_btle_dev *btdev = f->private;
> +	struct hci_dev *hdev = btdev->hdev;
> +	struct lowpan_peer *peer;
> +
> +	rtnl_lock();
> +
> +	if (!hdev->lowpan_enable) {
> +		rtnl_unlock();
> +		return 0;
> +	}
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(peer, &btdev->peers, list) {
> +		seq_printf(f, "%pMR (type %u) state: %s\n",
> +			   &peer->chan->dst, peer->chan->dst_type,
> +			   state_to_string(peer->chan->state));
> +	}
> +
> +	rcu_read_unlock();
> +
> +	rtnl_unlock();
> +	return 0;
> +}
> +
> +static int lowpan_control_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, lowpan_control_show, inode->i_private);
> +}
> +
> +static const struct file_operations lowpan_control_fops = {
> +	.open		= lowpan_control_open,
> +	.read		= seq_read,
> +	.write		= lowpan_control_write,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +/* TODO remove this when add non debugfs API, it's a workaround */
> +static struct workqueue_struct *workqueue_cleanup;
> +
> +struct lowpan_cleanup_work {
> +	struct work_struct work;
> +	struct net_device *dev;
> +};
> +
> +static void lowpan_cleanup_worker(struct work_struct *work)
> +{
> +	struct lowpan_cleanup_work *xw;
> +
> +	xw = container_of(work, struct lowpan_cleanup_work, work);
> +
> +	rtnl_lock();
> +	lowpan_btle_dellink(xw->dev);
> +	lowpan_btle_dev(xw->dev)->hdev->pending_deletion = false;
> +	rtnl_unlock();
> +
> +	kfree(xw);
> +}
> +
> +/* TODO workaround, debugfs doesn't like recursion remove while debugfs
> + * handling, this should be removed for by using real UAPI.
> + */
> +static int __lowpan_btle_dellink(struct net_device *dev,
> +				 struct hci_dev *hdev)
> +{
> +	struct lowpan_cleanup_work *xw;
> +
> +	xw = kzalloc(sizeof(*xw), GFP_KERNEL);
> +	if (!xw)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&xw->work, lowpan_cleanup_worker);
> +	xw->dev = dev;
> +
> +	hdev->pending_deletion = true;
> +	queue_work(workqueue_cleanup, &xw->work);
> +	return 0;
> +}
> +
> +static int lowpan_enable_set(struct hci_dev *hdev, bool enabled)
> +{
> +	int ret = 0;
> +
> +	if (hdev->lowpan_enable == enabled)
> +		goto out;
> +
> +	if (enabled) {
> +		struct net_device *dev;
> +
> +		/* create one interface by default */
> +		dev = lowpan_btle_newlink(hdev);
> +		if (IS_ERR(dev))
> +			return PTR_ERR(dev);
> +
> +		/* TODO should be done by user network managers? */
> +		ret = dev_open(dev);
> +		if (ret < 0) {
> +			BT_ERR("iface %s cannot be opened %d", dev->name, ret);
> +			ret = __lowpan_btle_dellink(dev, hdev);
> +			if (ret < 0)
> +				BT_ERR("failed to remove interface %s",
> +				       hdev->ldev->name);
> +
> +			return ret;
> +		}
> +
> +		hdev->lowpan_enable = true;
> +	} else {
> +		/* ignore pending deletions */
> +		if (hdev->pending_deletion)
> +			return 0;
> +
> +		__lowpan_btle_dellink(hdev->ldev, hdev);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static void lowpan_btle_hci_unregister(struct hci_dev *hdev)
> +{
> +	/* no need to cleanup debugfs, will be done by hci_core */

comment can be removed.

Well..., I had this comment because I did some stuff before per
"hci->debugfs". This is also the question here.

Maybe "6lowpan_enable" makes no sense to move it to per hci_dev debugfs
entry. For write, it makes sense - but read, you want some "global"
mapping of "hci_dev <-> lowpan interface", this may easy realizied for
netlink UAPI but for debugfs it's complicated because you need to
iterate over all hci%d entries and making cat on "6lowpan_enable".

That's the current reason why "6lowpan_enable" is global.

---

The control file for btle lowpan interface could be moved per hci_dev
and maybe I will change it again, then the above comment makes sense
again. :-)

> +
> +	/* TODO netns support with multiple lowpan interfaces */
> +	if (hdev->lowpan_enable)
> +		lowpan_btle_dellink(hdev->ldev);
> +}
> +
> +static int lowpan_hci_dev_event(struct notifier_block *unused,
> +				unsigned long event, void *ptr)
> +{
> +	struct hci_dev *hdev = ptr;
> +	int ret = NOTIFY_OK;
> +
> +	rtnl_lock();
> +
> +	/* bluetooth handles that event type as int,
> +	 * but there is no overflow yet.
> +	 */
> +	switch (event) {
> +	case HCI_DEV_UNREG:
> +		lowpan_btle_hci_unregister(hdev);
> +		ret = NOTIFY_DONE;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	rtnl_unlock();
> +
> +	return ret;
> +}
> +
> +static struct notifier_block lowpan_hcI_dev_notifier = {
> +	.notifier_call = lowpan_hci_dev_event,
> +};
> +
> +static ssize_t lowpan_enable_write(struct file *fp,
> +				   const char __user *user_buffer,
> +				   size_t count, loff_t *position)
> +{
> +	char buf[32] = { };
> +	size_t buf_size = min(count, sizeof(buf) - 1);
> +	struct hci_dev *hdev;
> +	int idx, enabled, n, ret;
> +
> +	if (copy_from_user(buf, user_buffer, buf_size))
> +		return -EFAULT;
> +
> +	n = sscanf(buf, "hci%d %d", &idx, &enabled);
> +	if (n != 2)
> +		return -EINVAL;
> +
> +	hdev = hci_dev_get(idx);
> +	if (!hdev)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	ret = lowpan_enable_set(hdev, enabled);
> +	rtnl_unlock();
> +
> +	hci_dev_put(hdev);
> +
> +	return count;
> +}
> +
> +static int lowpan_enable_show(struct seq_file *f, void *ptr)
> +{
> +	struct hci_dev *hdev;
> +
> +	rtnl_lock();
> +	read_lock(&hci_dev_list_lock);
> +	list_for_each_entry(hdev, &hci_dev_list, list) {
> +		if (hdev->lowpan_enable)
> +			seq_printf(f, "hci%d -> %s\n", hdev->id,
> +				   hdev->ldev->name);
> +	}
> +	read_unlock(&hci_dev_list_lock);
> +	rtnl_unlock();
> +
> +	return 0;
> +}
> +
> +static int lowpan_enable_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, lowpan_enable_show, inode->i_private);
> +}
> +
> +static const struct file_operations lowpan_enable_fops = {
> +	.open		= lowpan_enable_open,
> +	.read		= seq_read,
> +	.write		= lowpan_enable_write,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init bt_6lowpan_init(void)
> +{
> +	int err;
> +
> +	workqueue_cleanup = create_singlethread_workqueue("btle 6lowpan");
> +	if (!workqueue_cleanup)
> +		return -ENOMEM;
> +
> +	debugfs_create_file("6lowpan_enable", 0644,  bt_debugfs, NULL,
> +			    &lowpan_enable_fops);
> +
> +	err = register_hci_dev_notifier(&lowpan_hcI_dev_notifier);
> +	if (err < 0)
> +		destroy_workqueue(workqueue_cleanup);
> +
> +	return err;
> +}
> +
> +static void __exit bt_6lowpan_exit(void)
> +{
> +	destroy_workqueue(workqueue_cleanup);
> +	unregister_hci_dev_notifier(&lowpan_hcI_dev_notifier);
> +}
> +
> +module_init(bt_6lowpan_init);
> +module_exit(bt_6lowpan_exit);
> +
> +MODULE_AUTHOR("Jukka Rissanen <jukka.rissanen@linux.intel.com>");
> +MODULE_DESCRIPTION("Bluetooth 6LoWPAN");
> +MODULE_VERSION(LOWPAN_BTLE_VERSION);
> +MODULE_LICENSE("GPL");
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index e347828..b3ff12e 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -7,6 +7,9 @@ obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
>  obj-$(CONFIG_BT_BNEP)	+= bnep/
>  obj-$(CONFIG_BT_CMTP)	+= cmtp/
>  obj-$(CONFIG_BT_HIDP)	+= hidp/
> +obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
> +
> +bluetooth_6lowpan-y := 6lowpan.o
>  
>  bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
>  	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
> 

- Alex
