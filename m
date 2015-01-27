Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43110 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbbA0N2v (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Jan 2015 08:28:51 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so4954754wiv.4
        for <linux-wpan@vger.kernel.org>; Tue, 27 Jan 2015 05:28:49 -0800 (PST)
Message-ID: <54C7928F.9010002@6wind.com>
Date: Tue, 27 Jan 2015 14:28:47 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <20150127093425.GA2698@omega> <54C7694C.2060709@6wind.com> <20150127122340.GA4338@omega>
In-Reply-To: <20150127122340.GA4338@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, arvid.brodin@alten.se, linux-wpan@vger.kernel.org

Le 27/01/2015 13:23, Alexander Aring a écrit :
> Hi,
>
> (removing the bounced mail address).
>
> On Tue, Jan 27, 2015 at 11:32:44AM +0100, Nicolas Dichtel wrote:
>> Le 27/01/2015 10:34, Alexander Aring a écrit :
>>> Hi,
>>>
>>> On Mon, Jan 26, 2015 at 10:28:12PM +0100, Nicolas Dichtel wrote:
>>>>
[snip]
>>>
>>> This file handles the IEEE 802.15.4 6LoWPAN interface to offering a
>>> IPv6 interface with an IEEE 802.15.4 6LoWPAN adaption layer.
>>>
>>> To the codeline "dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));".
>>> By calling "ip link add link wpan0 name lowpan0 type lowpan" the
>>> lowpan_newlink function will be called and we need to find the wpan interface
>>> (returned as real_dev in this case).
>>>
>>> Namespace setting in wpan interface:
>>>
>>> Currently we don't use any net namespace settings there, also we don't
>>> change the net namespace. The default net namespace for a wpan shoule be
>>> "init_net".
>> Ok. After grepping for init_net, it seems to be used a lot in net/ieee802154/.
>>
>
> Yes, but the code in net/ieee802154 (except net/ieee802154/6lowpan) is only for
> the WPAN interface. Currently the WPAN interface is created in mac802154
> implementation only [0].
Ok. How is this interface created?

>
>>>
>>> So this line could be also written as (I found also some others code which search
>>> the wpan interface in &init_net):
>>>
>>> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
>>> index 9dbe0d69..495c6ad 100644
>>> --- a/net/ieee802154/6lowpan/core.c
>>> +++ b/net/ieee802154/6lowpan/core.c
>>> @@ -151,7 +151,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
>>>          if (!tb[IFLA_LINK])
>>>                  return -EINVAL;
>>>          /* find and hold real wpan device */
>>> -       real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
>>> +       real_dev = dev_get_by_index(&init_net, nla_get_u32(tb[IFLA_LINK]));
>>>          if (!real_dev)
>>>                  return -ENODEV;
>>>          if (real_dev->type != ARPHRD_IEEE802154) {
>>>
>>>
>>>
>>> The above code is for finding the wpan interface (the real 802.15.4 L2 interface).
>>> For the IEEE 802.15.4 6LoWPAN interface the whole IPv6 implementation is
>>> used. This interface will be created inside function "newlink".
>>>
>>> Running "grep -r "src_net" net/ipv6" reports me alot uses of "src_net".
>>> Don't know if this information is really necessary.
>>>
>>> Should I set now the NETIF_F_NETNS_LOCAL for both interface types?
>> I think yes. If it's not set, a user may do:
>> $ ip link add link wpan0 name lowpan0 type lowpan
>> $ ip netns add foo
>> $ ip link set lowpan0 netns foo
>>
>
> We should forbid that for the wpan interface. The code line:
>
> real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
>
> searches for the "wpan0" interface which is given by:
> $ ip link add link wpan0 name lowpan0 type lowpan
>
> The returned real_dev netdevice pointer is the wpan interface. The given
> "lowpan0" interface is a virtual interface for making IPv6 stuff.
Yes. But with the current code, it seems that you can also do (not tested):
$ ip link add link wpan0 netns foo name lowpan0 type lowpan
With this cmd, src_net points to the netns where the ip cmd is launched (let's
say init_net in this case) but the interface lowpan0 will be created in the
netns foo. To summarize: wpan0 is in init_net and lowpan0 in foo.

Now, if you use this line:
real_dev = dev_get_by_index(dev_net(dev), nla_get_u32(tb[IFLA_LINK]));
With the same command, dev_net(dev) will point to foo.

>
>
>
> For 6LoWPAN:
>
> This interface is created in 6lowpan/core.c file and is used in the
> whole IPv6 stack, because we set the skb->protocol to htons(ETH_P_IPV6). [1]
>
> The IPv6 stack uses alot of "src_net".
In fact, src_net is used by IP tunnels (sit, ip6gre, ip6_tunnels, ip6_vti). But
these interfaces ignore this parameter.

The IPv6 stack is fully netns aware, thus it will use correctly the netns from
the netdevice and/or from the socket.

>
>> The flag forbids the last command.
>>
>> Instead of your patch, what about this one:
>>
>>  From d9a9cd22d5e1db1417b3ffb53cc020481dc761b2 Mon Sep 17 00:00:00 2001
>> From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Date: Tue, 27 Jan 2015 11:26:20 +0100
>> Subject: [PATCH] ieee802154: forbid to create an iface in a netns != init_net
>>
>> 6LoWPAN currently doesn't supports netns.
>>
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>   net/ieee802154/6lowpan/core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
>> index 055fbb71ba6f..fe8fd022042e 100644
>> --- a/net/ieee802154/6lowpan/core.c
>> +++ b/net/ieee802154/6lowpan/core.c
>> @@ -126,6 +126,7 @@ static void lowpan_setup(struct net_device *dev)
>>   	dev->header_ops		= &lowpan_header_ops;
>>   	dev->ml_priv		= &lowpan_mlme;
>>   	dev->destructor		= free_netdev;
>> +	dev->features		|= NETIF_F_NETNS_LOCAL;
>>   }
>>
>>   static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
>> @@ -148,7 +149,9 @@ static int lowpan_newlink(struct net *src_net, struct
>> net_device *dev,
>>
>>   	pr_debug("adding new link\n");
>>
>> -	if (!tb[IFLA_LINK])
>> +	if (!tb[IFLA_LINK] ||
>> +	    !net_eq(src_net, &init_net) ||
>> +	    !net_eq(dev_net(dev), &init_net))
>>   		return -EINVAL;
>>   	/* find and hold real wpan device */
>>   	real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
>
> With the check of "!net_eq(src_net, &init_net)" we need to be sure
> that the wpan interface is always in "init_net". This means we need
> definitely a dev->features |= NETIF_F_NETNS_LOCAL; somewhere in [0].
>
> To adding "dev->features |= NETIF_F_NETNS_LOCAL;" for a 6LoWPAN interface,
> I am not sure about this. I didn't test it yet and it will not break
> anything, but we will lost the support for making net namespaces stuff
> inside the IPv6/(netfilter) stack.
Adding NETIF_F_NETNS_LOCAL does not mean that the netdevice can be used only
in init_net, this flag means that the netdevice cannot be moved to another
netns. You can still create a netdevice in another netns (if wpan0 is in netns
foo):

$ ip netns exec foo ip link add link wpan0 name lowpan0 type lowpan

I don't know how wpan0 is created and if this interface can be created directly
in another netns than init_net.

>
>
> Summarize:
>
> I would add the dev->features |= NETIF_F_NETNS_LOCAL; while wpan
> interface generation and add only the !net_eq(src_net, &init_net) check
> above. I suppose that src_net is the net namespace from "underlaying"
> interface wpan by calling:
>
> $ ip link add link wpan0 name lowpan0 type lowpan
No. src_net is the netns where the ip command is launched. With this patch, my
previous cmd (ip link add link wpan0 netns foo name lowpan0 type lowpan) will
still work and lowpan0 will be in netns foo.
Note: I just saw your patch proposal in another reply [0], with it, my sentence
is still true I think ;-)

But:
$ git grep "net_eq.*init_net" net/ieee802154/' | wc -l
7
So I wonder if it's really possible to use lowpan0 in another netns than
init_net (my proposal was based on this).

Maybe this can help you to understand my point.
A virtual interface can be across two netns:
  - the link netns (the interface receives and sends packets to/from the link
    layer into this netns)
  - the netns where the interface is visible (the user receives and sends
    packets to/from the interface into this netns)

[0] http://patchwork.ozlabs.org/patch/433467/

Regards,
Nicolas
