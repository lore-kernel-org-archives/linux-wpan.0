Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54606 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522AbcEFJgc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 6 May 2016 05:36:32 -0400
Subject: Re: [PATCHv2 bluetooth-next 07/10] ipv6: introduce neighbour
 discovery ops
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-8-git-send-email-aar@pengutronix.de>
 <fbd4c25c-2673-2848-c636-a5d21a6890d7@stressinduktion.org>
 <5728EB3F.2060808@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <0b2da619-75e8-71dd-44be-8dc66065135c@pengutronix.de>
Date: Fri, 6 May 2016 11:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <5728EB3F.2060808@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>


Hi,

On 05/03/2016 08:17 PM, Stefan Schmidt wrote:
> Hello.
> 
> On 02/05/16 21:36, Hannes Frederic Sowa wrote:
>> On 20.04.2016 10:19, Alexander Aring wrote:
>>> This patch introduces neighbour discovery ops callback structure. The
>>> structure contains at first receive and transmit handling for NS/NA and
>>> userspace option field functionality.
>>>
>>> These callback offers 6lowpan different handling, such as 802.15.4 short
>>> address handling or RFC6775 (Neighbor Discovery Optimization for IPv6 over
>>> 6LoWPANs).
>>>
>>> Cc: David S. Miller<davem@davemloft.net>
>>> Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
>>> Cc: James Morris<jmorris@namei.org>
>>> Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
>>> Cc: Patrick McHardy<kaber@trash.net>
>>> Signed-off-by: Alexander Aring<aar@pengutronix.de>
>>> ---
>>>   include/linux/netdevice.h |  3 ++
>>>   include/net/ndisc.h       | 96 +++++++++++++++++++++++++++++++++++++++++++----
>>>   net/ipv6/addrconf.c       |  1 +
>>>   net/ipv6/ndisc.c          | 71 ++++++++++++++++++++++++-----------
>>>   net/ipv6/route.c          |  2 +-
>>>   5 files changed, 144 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 0052c42..bc60033 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -1677,6 +1677,9 @@ struct net_device {
>>>   #ifdef CONFIG_NET_L3_MASTER_DEV
>>>       const struct l3mdev_ops    *l3mdev_ops;
>>>   #endif
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +    const struct ndisc_ops *ndisc_ops;
>>> +#endif
>>>         const struct header_ops *header_ops;
>>>   diff --git a/include/net/ndisc.h b/include/net/ndisc.h
>>> index aac868e..14ed016 100644
>>> --- a/include/net/ndisc.h
>>> +++ b/include/net/ndisc.h
>>> @@ -110,7 +110,8 @@ struct ndisc_options {
>>>     #define NDISC_OPT_SPACE(len) (((len)+2+7)&~7)
>>>   -struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len,
>>> +struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
>>> +                      u8 *opt, int opt_len,
>>>                         struct ndisc_options *ndopts);
>>>     /*
>>> @@ -173,6 +174,93 @@ static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, cons
>>>       return n;
>>>   }
>>>   +static inline int __ip6_ndisc_is_useropt(struct nd_opt_hdr *opt)
>>> +{
>>> +    return opt->nd_opt_type == ND_OPT_RDNSS ||
>>> +        opt->nd_opt_type == ND_OPT_DNSSL;
>>> +}
>>> +
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +struct ndisc_ops {
>>> +    int    (*is_useropt)(struct nd_opt_hdr *opt);
>>> +    void    (*send_na)(struct net_device *dev,
>>> +               const struct in6_addr *daddr,
>>> +               const struct in6_addr *solicited_addr,
>>> +               bool router, bool solicited,
>>> +               bool override, bool inc_opt);
>>> +    void    (*recv_na)(struct sk_buff *skb);
>>> +    void    (*send_ns)(struct net_device *dev,
>>> +               const struct in6_addr *solicit,
>>> +               const struct in6_addr *daddr,
>>> +               const struct in6_addr *saddr);
>>> +    void    (*recv_ns)(struct sk_buff *skb);
>>> +};
>>> +
>>> +static inline int ndisc_is_useropt(const struct net_device *dev,
>>> +                   struct nd_opt_hdr *opt)
>>> +{
>>> +    if (likely(dev->ndisc_ops->is_useropt))
>>> +        return dev->ndisc_ops->is_useropt(opt);
>>> +    else
>>> +        return 0;
>>> +}
>>> +
>>> +static inline void ndisc_send_na(struct net_device *dev,
>>> +                 const struct in6_addr *daddr,
>>> +                 const struct in6_addr *solicited_addr,
>>> +                 bool router, bool solicited, bool override,
>>> +                 bool inc_opt)
>>> +{
>>> +    if (likely(dev->ndisc_ops->send_na))
>>> +        dev->ndisc_ops->send_na(dev, daddr, solicited_addr, router,
>>> +                    solicited, override, inc_opt);
>>> +}
>>> +
>>> +static inline void ndisc_recv_na(struct sk_buff *skb)
>>> +{
>>> +    if (likely(skb->dev->ndisc_ops->recv_na))
>>> +        skb->dev->ndisc_ops->recv_na(skb);
>>> +}
>>> +
>>> +static inline void ndisc_send_ns(struct net_device *dev,
>>> +                 const struct in6_addr *solicit,
>>> +                 const struct in6_addr *daddr,
>>> +                 const struct in6_addr *saddr)
>>> +{
>>> +    if (likely(dev->ndisc_ops->send_ns))
>>> +        dev->ndisc_ops->send_ns(dev, solicit, daddr, saddr);
>>> +}
>>> +
>>> +static inline void ndisc_recv_ns(struct sk_buff *skb)
>>> +{
>>> +    if (likely(skb->dev->ndisc_ops->recv_ns))
>>> +        skb->dev->ndisc_ops->recv_ns(skb);
>>> +}
>>> +#else
>>> +static inline int ndisc_is_useropt(const struct net_device *dev,
>>> +                   struct nd_opt_hdr *opt)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static inline void ndisc_send_na(struct net_device *dev,
>>> +                 const struct in6_addr *daddr,
>>> +                 const struct in6_addr *solicited_addr,
>>> +                 bool router, bool solicited, bool override,
>>> +                 bool inc_opt) { }
>>> +
>>> +static inline void ndisc_recv_na(struct sk_buff *skb) { }
>>> +
>>> +static inline void ndisc_send_ns(struct net_device *dev,
>>> +                 const struct in6_addr *solicit,
>>> +                 const struct in6_addr *daddr,
>>> +                 const struct in6_addr *saddr) { }
>>> +
>>> +static inline void ndisc_recv_ns(struct sk_buff *skb) { }
>>> +#endif
>> Do those empty functions actually make sense? I wonder a bit because
>> 6lowpan strictly depends on ipv6 and they should never be called without
>> IPv6, no?
> 
> Agreed. 6LoWAPN is only an adaptation layer so we know that IPv6 must be enabled here. I would also argue for removing this ifdef and the empty functions.
> 

I removed the empty function, removing ifdef is not possible. There are
still somewhere net/ipv6.h includes at do_mounts/networking filesystems.
I need to leave the ifdef there otherwise compiling will fail that
"ndisc->ops" are not available.

I tested it with several randconfigs.

- Alex
