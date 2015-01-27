Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32795 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbbA0Kcr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Jan 2015 05:32:47 -0500
Received: by mail-wi0-f172.google.com with SMTP id h11so3700941wiw.5
        for <linux-wpan@vger.kernel.org>; Tue, 27 Jan 2015 02:32:46 -0800 (PST)
Message-ID: <54C7694C.2060709@6wind.com>
Date: Tue, 27 Jan 2015 11:32:44 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <20150127093425.GA2698@omega>
In-Reply-To: <20150127093425.GA2698@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dmitry.tarnyagin@lockless.no, arvid.brodin@alten.se, linux-wpan@vger.kernel.org

Le 27/01/2015 10:34, Alexander Aring a écrit :
> Hi,
>
> On Mon, Jan 26, 2015 at 10:28:12PM +0100, Nicolas Dichtel wrote:
>>
[snip]
>> - ieee802154 uses also src_net and does not have NETIF_F_NETNS_LOCAL. Same
>>    question: does this netdevice really supports x-netns?
>
> I am not sure if I understand exactly what you mean. First of all, I
> didn't test anything about net namespaces for the ieee802154 branch.
> In 802.15.4 branch we have two interfaces: wpan and 6LoWPAN.
>
> After running "grep -r "src_net" net" I found this is used in:
>
> net/ieee802154/6lowpan/core.c [0]
Yes, I was talking about this.

>
> This file handles the IEEE 802.15.4 6LoWPAN interface to offering a
> IPv6 interface with an IEEE 802.15.4 6LoWPAN adaption layer.
>
> To the codeline "dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));".
> By calling "ip link add link wpan0 name lowpan0 type lowpan" the
> lowpan_newlink function will be called and we need to find the wpan interface
> (returned as real_dev in this case).
>
> Namespace setting in wpan interface:
>
> Currently we don't use any net namespace settings there, also we don't
> change the net namespace. The default net namespace for a wpan shoule be
> "init_net".
Ok. After grepping for init_net, it seems to be used a lot in net/ieee802154/.

>
> So this line could be also written as (I found also some others code which search
> the wpan interface in &init_net):
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 9dbe0d69..495c6ad 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -151,7 +151,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
>          if (!tb[IFLA_LINK])
>                  return -EINVAL;
>          /* find and hold real wpan device */
> -       real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
> +       real_dev = dev_get_by_index(&init_net, nla_get_u32(tb[IFLA_LINK]));
>          if (!real_dev)
>                  return -ENODEV;
>          if (real_dev->type != ARPHRD_IEEE802154) {
>
>
>
> The above code is for finding the wpan interface (the real 802.15.4 L2 interface).
> For the IEEE 802.15.4 6LoWPAN interface the whole IPv6 implementation is
> used. This interface will be created inside function "newlink".
>
> Running "grep -r "src_net" net/ipv6" reports me alot uses of "src_net".
> Don't know if this information is really necessary.
>
> Should I set now the NETIF_F_NETNS_LOCAL for both interface types?
I think yes. If it's not set, a user may do:
$ ip link add link wpan0 name lowpan0 type lowpan
$ ip netns add foo
$ ip link set lowpan0 netns foo

The flag forbids the last command.

Instead of your patch, what about this one:

 From d9a9cd22d5e1db1417b3ffb53cc020481dc761b2 Mon Sep 17 00:00:00 2001
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue, 27 Jan 2015 11:26:20 +0100
Subject: [PATCH] ieee802154: forbid to create an iface in a netns != init_net

6LoWPAN currently doesn't supports netns.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
  net/ieee802154/6lowpan/core.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 055fbb71ba6f..fe8fd022042e 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -126,6 +126,7 @@ static void lowpan_setup(struct net_device *dev)
  	dev->header_ops		= &lowpan_header_ops;
  	dev->ml_priv		= &lowpan_mlme;
  	dev->destructor		= free_netdev;
+	dev->features		|= NETIF_F_NETNS_LOCAL;
  }

  static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
@@ -148,7 +149,9 @@ static int lowpan_newlink(struct net *src_net, struct 
net_device *dev,

  	pr_debug("adding new link\n");

-	if (!tb[IFLA_LINK])
+	if (!tb[IFLA_LINK] ||
+	    !net_eq(src_net, &init_net) ||
+	    !net_eq(dev_net(dev), &init_net))
  		return -EINVAL;
  	/* find and hold real wpan device */
  	real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
-- 
2.2.2
