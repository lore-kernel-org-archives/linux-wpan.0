Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51001 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbbA0Ouf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Jan 2015 09:50:35 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so5352682wiv.1
        for <linux-wpan@vger.kernel.org>; Tue, 27 Jan 2015 06:50:33 -0800 (PST)
Message-ID: <54C7A5B7.60103@6wind.com>
Date: Tue, 27 Jan 2015 15:50:31 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <20150127093425.GA2698@omega> <54C7694C.2060709@6wind.com> <20150127122340.GA4338@omega> <54C7928F.9010002@6wind.com> <20150127140620.GA8941@omega>
In-Reply-To: <20150127140620.GA8941@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, arvid.brodin@alten.se, linux-wpan@vger.kernel.org

Le 27/01/2015 15:06, Alexander Aring a écrit :
> Hi,
>
> On Tue, Jan 27, 2015 at 02:28:47PM +0100, Nicolas Dichtel wrote:
> ...
[snip]
>>
>> I don't know how wpan0 is created and if this interface can be created directly
>> in another netns than init_net.
>>
>
> no it can't. The wpan0 interface can be created via the 802.15.4
> userspace tools and we don't have such option for namespaces. It
> should be always to init_net while creation.
Even with 'ip netns exec foo iwpan ...'?

>
>>>
>>>
>>> Summarize:
>>>
>>> I would add the dev->features |= NETIF_F_NETNS_LOCAL; while wpan
>>> interface generation and add only the !net_eq(src_net, &init_net) check
>>> above. I suppose that src_net is the net namespace from "underlaying"
>>> interface wpan by calling:
>>>
>>> $ ip link add link wpan0 name lowpan0 type lowpan
>> No. src_net is the netns where the ip command is launched. With this patch, my
>
> ah, and when no "ip netns" is given it's default to init_net?
The default netns is the netns where your shell is running :)
It may be different from init_net when you are playing on a virtual machine. On
a physical machine, it's usually init_net.

>
>
> Okay, then I agree with that both interfaces should be set
>
> dev->features |= NETIF_F_NETNS_LOCAL
Ok.

>
> because both interfaces should started with "init_net" as default
> namespace. For wpan interface this should always be in "init_net",
> because we don't set anything while creation.
Not sure this is true. It's probably possible to create it directly in another
netns (with 'ip netns exec' or because your system is a virtual machine that
runs over a namespaces construction (see docker [0], lxc [1], etc).

[0] https://www.docker.com/
[1] https://linuxcontainers.org/

>
> For 6LoWPAN interface this should also always in the same namespace like
> the wpan interface and not diffrent namespace between link (wpan) and
> virtual (6LoWPAN) interface.
>
> Do you agree with that?
Yes.

But I still wonder if we should add a check about dev_net(dev) != init_net in
net/ieee802154/6lowpan/core.c.
If my understanding is correct:
  - wpan can be created directly in a netns != init_net
  - 6lowpan must be in the same netns than wpan
  - code under net/ieee802154 only works in init_net, thus 6lowpan only works
    in init_net.

Do you agree?
What about this (based on net-next)?

 From 5ca1c46c68e4e4381b2f7e284f5dadeb28a53b2f Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue, 27 Jan 2015 11:26:20 +0100
Subject: [PATCH] wpan/6lowpan: fix netns settings

6LoWPAN currently doesn't supports x-netns and works only in init_net.

With this patch, we ensure that:
  - the wpan interface cannot be moved to another netns;
  - the 6lowpan interface cannot be moved to another netns;
  - the wpan interface is in the same netns than the 6lowpan interface;
  - the 6lowpan interface is in init_net.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
  net/ieee802154/6lowpan/core.c | 6 ++++--
  net/mac802154/iface.c         | 1 +
  2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 055fbb71ba6f..dfd3c6007f60 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -126,6 +126,7 @@ static void lowpan_setup(struct net_device *dev)
  	dev->header_ops		= &lowpan_header_ops;
  	dev->ml_priv		= &lowpan_mlme;
  	dev->destructor		= free_netdev;
+	dev->features		|= NETIF_F_NETNS_LOCAL;
  }

  static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
@@ -148,10 +149,11 @@ static int lowpan_newlink(struct net *src_net, struct 
net_device *dev,

  	pr_debug("adding new link\n");

-	if (!tb[IFLA_LINK])
+	if (!tb[IFLA_LINK] ||
+	    !net_eq(dev_net(dev), &init_net))
  		return -EINVAL;
  	/* find and hold real wpan device */
-	real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = dev_get_by_index(dev_net(dev), nla_get_u32(tb[IFLA_LINK]));
  	if (!real_dev)
  		return -ENODEV;
  	if (real_dev->type != ARPHRD_IEEE802154) {
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 6fb6bdf9868c..b67da8d578b4 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -475,6 +475,7 @@ static void ieee802154_if_setup(struct net_device *dev)
  	dev->mtu		= IEEE802154_MTU;
  	dev->tx_queue_len	= 300;
  	dev->flags		= IFF_NOARP | IFF_BROADCAST;
+	dev->features		|= NETIF_F_NETNS_LOCAL;
  }

  static int
-- 
2.2.2
