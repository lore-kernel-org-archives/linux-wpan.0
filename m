Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57891 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934323AbcECSQs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 3 May 2016 14:16:48 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCHv2 bluetooth-next 02/10] 6lowpan: add 802.15.4 short addr
 slaac
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-3-git-send-email-aar@pengutronix.de>
Message-ID: <5728EB0A.5080108@osg.samsung.com>
Date: Tue, 3 May 2016 20:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <1461140382-4784-3-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hello.

On 20/04/16 10:19, Alexander Aring wrote:
> This patch adds the autoconfiguration if a valid 802.15.4 short address
> is available for 802.15.4 6LoWPAN interfaces.
>
> Cc: David S. Miller<davem@davemloft.net>
> Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
> Cc: James Morris<jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy<kaber@trash.net>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   include/net/addrconf.h |  3 +++
>   net/6lowpan/core.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   net/ipv6/addrconf.c    |  5 +++--
>   3 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 730d856..b1774eb 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -94,6 +94,9 @@ int ipv6_rcv_saddr_equal(const struct sock *sk, const struct sock *sk2,
>   void addrconf_join_solict(struct net_device *dev, const struct in6_addr *addr);
>   void addrconf_leave_solict(struct inet6_dev *idev, const struct in6_addr *addr);
>   
> +void addrconf_add_linklocal(struct inet6_dev *idev,
> +			    const struct in6_addr *addr, u32 flags);
> +
>   static inline int addrconf_ifid_eui48(u8 *eui, struct net_device *dev)
>   {
>   	if (dev->addr_len != ETH_ALEN)
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index 7a240b3..fbae31e 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -14,6 +14,7 @@
>   #include <linux/module.h>
>   
>   #include <net/6lowpan.h>
> +#include <net/addrconf.h>
>   
>   #include "6lowpan_i.h"
>   
> @@ -72,16 +73,61 @@ void lowpan_unregister_netdev(struct net_device *dev)
>   }
>   EXPORT_SYMBOL(lowpan_unregister_netdev);
>   
> +static int addrconf_ifid_802154_6lowpan(u8 *eui, struct net_device *dev)
> +{
> +	struct wpan_dev *wpan_dev = lowpan_802154_dev(dev)->wdev->ieee802154_ptr;
> +
> +	/* Set short_addr autoconfiguration if short_addr is present only */
> +	if (!ieee802154_is_valid_src_short_addr(wpan_dev->short_addr))
> +		return -1;

-EINVAL instead of -1?

> +
> +	/* For either address format, all zero addresses MUST NOT be used */
> +	if (wpan_dev->pan_id == cpu_to_le16(0x0000) &&
> +	    wpan_dev->short_addr == cpu_to_le16(0x0000))
> +		return -1;

-EINVAL instead of -1?
> +
> +	/* Alternatively, if no PAN ID is known, 16 zero bits may be used */
> +	if (wpan_dev->pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
> +		memset(eui, 0, 2);
> +	else
> +		ieee802154_le16_to_be16(eui, &wpan_dev->pan_id);
> +
> +	/* The "Universal/Local" (U/L) bit shall be set to zero */
> +	eui[0] &= ~2;
> +	eui[2] = 0;
> +	eui[3] = 0xFF;
> +	eui[4] = 0xFE;
> +	eui[5] = 0;
> +	ieee802154_le16_to_be16(&eui[6], &wpan_dev->short_addr);
> +	return 0;
> +}
> +
>   static int lowpan_event(struct notifier_block *unused,
>   			unsigned long event, void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct inet6_dev *idev;
> +	struct in6_addr addr;
>   	int i;
>   
>   	if (dev->type != ARPHRD_6LOWPAN)
>   		return NOTIFY_DONE;
>   
> +	idev = __in6_dev_get(dev);
> +	if (!idev)
> +		return NOTIFY_DONE;
> +
>   	switch (event) {
> +	case NETDEV_UP:
> +	case NETDEV_CHANGE:
> +		/* (802.15.4 6LoWPAN short address slaac handling */
> +		if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154) &&
> +		    addrconf_ifid_802154_6lowpan(addr.s6_addr + 8, dev) == 0) {

I normally would like to get a define here instead of the magic number 
8, but given how complex this if statement already is I think its fine 
to keep it.

> +			__ipv6_addr_set_half(&addr.s6_addr32[0],
> +					     htonl(0xFE800000), 0);
> +			addrconf_add_linklocal(idev, &addr, 0);
> +		}
> +		break;
>   	case NETDEV_DOWN:
>   		for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
>   			clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 27aed1a..54e18c2 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2948,8 +2948,8 @@ static void init_loopback(struct net_device *dev)
>   	}
>   }
>   
> -static void addrconf_add_linklocal(struct inet6_dev *idev,
> -				   const struct in6_addr *addr, u32 flags)
> +void addrconf_add_linklocal(struct inet6_dev *idev,
> +			    const struct in6_addr *addr, u32 flags)
>   {
>   	struct inet6_ifaddr *ifp;
>   	u32 addr_flags = flags | IFA_F_PERMANENT;
> @@ -2968,6 +2968,7 @@ static void addrconf_add_linklocal(struct inet6_dev *idev,
>   		in6_ifa_put(ifp);
>   	}
>   }
> +EXPORT_SYMBOL(addrconf_add_linklocal);
>   
>   static bool ipv6_reserved_interfaceid(struct in6_addr address)
>   {

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
