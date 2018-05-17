Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:55937 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeEQT5x (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 May 2018 15:57:53 -0400
Received: by mail-it0-f66.google.com with SMTP id 144-v6so10335048iti.5
        for <linux-wpan@vger.kernel.org>; Thu, 17 May 2018 12:57:53 -0700 (PDT)
Date: Thu, 17 May 2018 15:57:47 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC PATCH wpan-next 1/2] ieee802154: hwsim: add replacement for
 fakelb
Message-ID: <20180517195747.oouz57nskrnmtega@x220t>
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-2-aring@mojatatu.com>
 <6f789057-24b1-9d43-e7af-26c6c8650805@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f789057-24b1-9d43-e7af-26c6c8650805@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Mon, May 07, 2018 at 04:00:49PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> 
> On 04/27/2018 11:21 PM, Alexander Aring wrote:
> > This patch adds a new virtual driver mac802154_hwsim which is based on
> > the fakelb driver.
> > The fakelb driver will get deprecated and hopefully removed someday.
> > The main reason for doing this step is to rename the driver to
> > mac802154_hwsim to have a similar naming scheme as mac80211_hwsim,
> > which is more popular in the 802.11 wireless word and the idea is the
> > same behind this driver.
> >
> > The new features of this driver are to have knowledge about connected
> > edges, which can be changed during runtime. This offers a testing
> > environment for routing protocols e.g. RPL.
> > The default behaviour is still as fakelb: two radios connected to each
> > other. New added radios during runtime will not be connected to other
> > wpan_hwsim instances.
> >
> > The netlink api is not namespace aware on purpose, only the registered
> > wpan_phy's can be moved to namespaces. The physical layer according to
> > wiresless "air" communication can be handled across namespaces.
> >
> > Furthermore the edges can be weighted with the LQI value according IEEE
> > 802.15.4 which offers additional handling to mark bad or good connection
> > indicators to other connected virtual phys.
> >
> > Signed-off-by: Alexander Aring <aring@mojatatu.com>
> > ---
> >  drivers/net/ieee802154/Kconfig           |  11 +
> >  drivers/net/ieee802154/Makefile          |   1 +
> >  drivers/net/ieee802154/mac802154_hwsim.c | 925 +++++++++++++++++++++++++++++++
> >  drivers/net/ieee802154/mac802154_hwsim.h |  73 +++
> >  4 files changed, 1010 insertions(+)
> >  create mode 100644 drivers/net/ieee802154/mac802154_hwsim.c
> >  create mode 100644 drivers/net/ieee802154/mac802154_hwsim.h
> >
> > diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
> > index 8782f5655e3f..ff3552044679 100644
> > --- a/drivers/net/ieee802154/Kconfig
> > +++ b/drivers/net/ieee802154/Kconfig
> > @@ -115,3 +115,14 @@ config IEEE802154_MCR20A
> >  
> >  	  This driver can also be built as a module. To do so, say M here.
> >  	  the module will be called 'mcr20a'.
> > +
> > +config MAC802154_HWSIM
> > +	depends on IEEE802154_DRIVERS && MAC802154
> > +	tristate "Simulated radio testing tool for mac802154"
> > +	---help---
> > +	  This driver is a developer testing tool that can be used to test
> > +	  IEEE 802.15.4 networking stack (mac802154) functionality. This is not
> > +	  needed for normal wireless LAN usage and is only for testing.
> 
> The wireless LAN wording seems to be a left over :-)
> 
> 

ok.

> > +	  This driver can also be built as a module. To do so say M here.
> > +	  The module will be called 'mac802154_hwsim'.
> > diff --git a/drivers/net/ieee802154/Makefile b/drivers/net/ieee802154/Makefile
> > index 104744d5a668..3b17aa17d46a 100644
> > --- a/drivers/net/ieee802154/Makefile
> > +++ b/drivers/net/ieee802154/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_IEEE802154_ATUSB) += atusb.o
> >  obj-$(CONFIG_IEEE802154_ADF7242) += adf7242.o
> >  obj-$(CONFIG_IEEE802154_CA8210) += ca8210.o
> >  obj-$(CONFIG_IEEE802154_MCR20A) += mcr20a.o
> > +obj-$(CONFIG_MAC802154_HWSIM) += mac802154_hwsim.o
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> > new file mode 100644
> > index 000000000000..eea0d355bbd8
> > --- /dev/null
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> > @@ -0,0 +1,925 @@
> > +/*
> > + * HWSIM IEEE 802.15.4 interface
> > + *
> > + * (C) 2018 Mojatau, Alexander Aring <aring@mojatau.com>
> > + * Copyright 2007-2012 Siemens AG
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2
> > + * as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> Not only related to this patch but we might want to think about moving from the license boiler plate text to SPDX for the ieee802154
> subsystem at some point.
> 

ok. Yea I saw that, it's somehow new...

> > + * Based on fakelb, original Written by:
> > + * Sergey Lapin <slapin@ossfans.org>
> > + * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > + * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/timer.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/device.h>
> > +#include <linux/spinlock.h>
> > +#include <net/mac802154.h>
> > +#include <net/cfg802154.h>
> > +#include <net/genetlink.h>
> > +#include "mac802154_hwsim.h"
> > +
> > +MODULE_DESCRIPTION("Software simulator of 802.15.4 radio(s) for mac802154");
> 
> "IEEE 802.15.4", please.
> 

ok.

> > +MODULE_LICENSE("GPL");
> 
> The license text does not have the "or any later version" part which means we should indicate it really is GPL v2 only.
> 

I copied from fakelb but GPLv2 is standard for all kernel code so far I
know (except 'UAPI?' headers). I will change it to GPLv2

> > +
> > +/* Number of dummy devices to be set up by this module. */
> > +static int radios = 2;
> 
> Does this really need to be a global variable?
>

module_param works like that. Question is if we really like to have such
feature as parameter since we can add/del during runtime?

But then the default should be 2. Two nodes are the common case to test
non-big/complex setups.

> > +module_param(radios, int, 0444);
> > +MODULE_PARM_DESC(radios, "Number of simulated radios");
> 
> What happens if more than 2 devices are given as module parameter, are only the first two connected and the rest unconnected?
> 

No, I the current implementation as it is. Everything what you specified
as module parameter "radios" e.g. 2 will end that every radio is
connected to each other except to itself. It's full mesh...

Adding during runtime will occur nothing is connected.

In my feeling with handling of this driver... I usually start with two
radios connected to each other (default behaviour) and then I add
another radios, because I want a bigger/complex setup.

Maybe an argument to let 2 radios always as default and remove this
handling of radios parameters. Will reduce some code handling in init...
and I am always for to make it simple as possible. Okay edge handling is
complex, but so far needed to make experiments in LL networks.

> 
> > +static LIST_HEAD(hwsim_phys);
> > +static DEFINE_MUTEX(hwsim_phys_lock);
> > +
> > +static __rcu LIST_HEAD(hwsim_ifup_phys);
> > +
> > +static struct platform_device *mac802154hwsim_dev;
> > +
> > +/* MAC802154_HWSIM netlink family */
> > +static struct genl_family hwsim_genl_family;
> > +
> > +static int hwsim_radio_idx;
> 
> Another global variable I would like to avoid, if it make sense.
> 

needed to have a global max idx which is currently given and the whole
mess is because dump feature of netlink. We cannot add some private data
pointer when registering netlink ops.

See hwsim_dump_radio_nl() it's our identify when dump is done.

I will see if I can put put all the globals in a hwsim_driver_globals
struct and define this only once... if this is what you want. :-/

> > +
> > +enum hwsim_multicast_groups {
> > +	HWSIM_MCGRP_CONFIG,
> > +};
> > +
> > +static const struct genl_multicast_group hwsim_mcgrps[] = {
> > +	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
> > +};
> > +
> > +struct hwsim_pib {
> > +	u8 page;
> > +	u8 channel;
> > +
> > +	struct rcu_head rcu;
> > +};
> > +
> > +struct hwsim_edge_info {
> > +	u8 lqi;
> > +
> > +	struct rcu_head rcu;
> > +};
> > +
> > +struct hwsim_edge {
> > +	struct hwsim_phy *endpoint;
> > +	struct hwsim_edge_info *info;
> > +
> > +	struct list_head list;
> > +	struct rcu_head rcu;
> > +};
> > +
> > +struct hwsim_phy {
> > +	struct ieee802154_hw *hw;
> > +	u32 idx;
> > +
> > +	struct hwsim_pib __rcu *pib;
> > +
> > +	bool suspended;
> > +	struct list_head __rcu edges;
> > +
> > +	struct list_head list;
> > +	struct list_head list_ifup;
> > +};
> > +
> > +static int hwsim_hw_ed(struct ieee802154_hw *hw, u8 *level)
> > +{
> > +	*level = 0xbe;
> > +
> > +	return 0;
> > +}
> > +
> > +static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
> > +{
> > +	struct hwsim_phy *phy = hw->priv;
> > +	struct hwsim_pib *pib, *pib_old;
> > +
> > +	pib = kzalloc(sizeof(*pib), GFP_KERNEL);
> > +	if (!pib)
> > +		return -ENOMEM;
> > +
> > +	pib->page = page;
> > +	pib->channel = channel;
> > +
> > +	pib_old = phy->pib;
> > +	rcu_assign_pointer(phy->pib, pib);
> > +	kfree_rcu(pib_old, rcu);
> > +	return 0;
> > +}
> > +
> > +static int hwsim_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
> > +{
> > +	struct hwsim_phy *current_phy = hw->priv;
> > +	struct hwsim_pib *current_pib, *endpoint_pib;
> > +	struct hwsim_edge_info *einfo;
> > +	struct hwsim_edge *e;
> > +
> > +	WARN_ON(current_phy->suspended);
> > +
> > +	rcu_read_lock();
> > +	current_pib = rcu_dereference(current_phy->pib);
> > +	list_for_each_entry_rcu(e, &current_phy->edges, list) {
> > +		/* Can be changed later in rx_irqsafe, but this is only a
> > +		 * performance tweak. Received radio should drop the frame
> > +		 * in mac802154 stack anyway... so we don't need to be
> > +		 * 100% of locking here to check on suspended
> > +		 */
> > +		if (e->endpoint->suspended)
> > +			continue;
> > +
> > +		endpoint_pib = rcu_dereference(e->endpoint->pib);
> > +		if (current_pib->page == endpoint_pib->page &&
> > +		    current_pib->channel == endpoint_pib->channel) {
> > +			struct sk_buff *newskb = pskb_copy(skb, GFP_ATOMIC);
> > +
> > +			einfo = rcu_dereference(e->info);
> > +			if (newskb)
> > +				ieee802154_rx_irqsafe(e->endpoint->hw, newskb,
> > +						      einfo->lqi);
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	ieee802154_xmit_complete(hw, skb, false);
> > +	return 0;
> > +}
> > +
> > +static int hwsim_hw_start(struct ieee802154_hw *hw)
> > +{
> > +	struct hwsim_phy *phy = hw->priv;
> > +
> > +	phy->suspended = false;
> > +	list_add_rcu(&phy->list_ifup, &hwsim_ifup_phys);
> > +	synchronize_rcu();
> > +
> > +	return 0;
> > +}
> > +
> > +static void hwsim_hw_stop(struct ieee802154_hw *hw)
> > +{
> > +	struct hwsim_phy *phy = hw->priv;
> > +
> > +	phy->suspended = true;
> > +	list_del_rcu(&phy->list_ifup);
> > +	synchronize_rcu();
> > +}
> > +
> > +static int
> > +hwsim_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
> > +{
> > +	return 0;
> > +}
> > +
> > +static const struct ieee802154_ops hwsim_ops = {
> > +	.owner = THIS_MODULE,
> > +	.xmit_async = hwsim_hw_xmit,
> > +	.ed = hwsim_hw_ed,
> > +	.set_channel = hwsim_hw_channel,
> > +	.start = hwsim_hw_start,
> > +	.stop = hwsim_hw_stop,
> > +	.set_promiscuous_mode = hwsim_set_promiscuous_mode,
> > +};
> > +
> > +static int hwsim_add_one(struct genl_info *info, struct device *dev,
> > +			 bool init);
> 
> Please re-order the functions so we can avoid forward declarations.
> 

What I wanted here is to have netlink handling at one place.
I want to move it:

Then I need a forward declaration for hwsim_new_radio_nl() because
hwsim_nl_ops need to know about that this function. Then I need to move
the whole struct of hwsim_nl_ops under hwsim_add_one() as well and I
stopped thinking about other changes.

Alternative is moving hwsim_add_one() implementation before
hwsim_new_radio_nl(), but then I need a forward declaration of
hwsim_genl_family struct. If I move hwsim_genl_family as well I need a
forward declaration of hwsim_genl_family before it.


I think I will move these forward declaration in begin of this file,
then it's not an eye catcher anymore... but I have no idea how to handle
it and nl_ops should be sit in front of struct genl_ops hwsim_nl_ops[].

> > +static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
> > +{
> > +	return hwsim_add_one(info, &mac802154hwsim_dev->dev, false);
> > +}
> > +
> > +static void hwsim_del(struct hwsim_phy *phy);
> 
> Another forward declaration to avoid.

Actually this function has less logic so I can move this above... BUT
the whole reason why this doesn't work at hwsim_add_one is because it
need to specify some global netlink struct foo.

I can move it but then del is not anymore at add_one (del should
cleanup what add_one is doing also, so they depends logically to each other).
... and here comes the another BUT, we don't notify about deleted hwsim
phy's if we do that, then we need to move the function anyway below...

Tell me what to do here. BTW: better name here would be hwsim_del_one()
in contrast to hwsim_add_one.

---

Btw: I can move these functions very easily if we load hwsim without any
phy, so I don't need to use these functions in init()/exit()... but most
common setup is 2 radios connected to each other... if you want complex:
use wpan-hwsim.

> 
> > +static int hwsim_del_radio_nl(struct sk_buff *msg, struct genl_info *info)
> > +{
> > +	struct hwsim_phy *phy, *tmp;
> > +	s64 idx = -1;
> > +
> > +	if (!info->attrs[MAC802154_HWSIM_ATTR_RADIO_ID])
> > +		return -EINVAL;
> > +
> > +	idx = nla_get_u32(info->attrs[MAC802154_HWSIM_ATTR_RADIO_ID]);
> > +
> > +	mutex_lock(&hwsim_phys_lock);
> > +	list_for_each_entry_safe(phy, tmp, &hwsim_phys, list) {
> > +		if (idx == phy->idx) {
> > +			hwsim_del(phy);
> > +			mutex_unlock(&hwsim_phys_lock);
> > +			return 0;
> > +		}
> > +	}
> > +	mutex_unlock(&hwsim_phys_lock);
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +static int append_radio_msg(struct sk_buff *skb, struct hwsim_phy *phy)
> > +{
> > +	struct nlattr *nl_edges, *nl_edge;
> > +	struct hwsim_edge_info *einfo;
> > +	struct hwsim_edge *e;
> > +	int ret;
> > +
> > +	ret = nla_put_u32(skb, MAC802154_HWSIM_ATTR_RADIO_ID, phy->idx);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rcu_read_lock();
> > +	if (list_empty(&phy->edges)) {
> > +		rcu_read_unlock();
> > +		return 0;
> > +	}
> > +
> > +	nl_edges = nla_nest_start(skb, MAC802154_HWSIM_ATTR_RADIO_EDGES);
> > +	if (!nl_edges) {
> > +		rcu_read_unlock();
> > +		return -ENOBUFS;
> > +	}
> > +
> > +	list_for_each_entry_rcu(e, &phy->edges, list) {
> > +		nl_edge = nla_nest_start(skb, MAC802154_HWSIM_ATTR_RADIO_EDGE);
> > +		if (!nl_edges) {
> 
> You save the return of bla_nest_start in nl_edge but you are checking on nl_edges.
> 

ok. sorry.

> > +			rcu_read_unlock();
> > +			nla_nest_cancel(skb, nl_edges);
> > +			return -ENOBUFS;
...
> > +
> > +/* Generic Netlink operations array */
> > +static const struct genl_ops hwsim_nl_ops[] = {
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_NEW_RADIO,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_new_radio_nl,
> > +		.flags = GENL_UNS_ADMIN_PERM,
> > +	},
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_DEL_RADIO,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_del_radio_nl,
> > +		.flags = GENL_UNS_ADMIN_PERM,
> > +	},
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_GET_RADIO,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_get_radio_nl,
> > +		.dumpit = hwsim_dump_radio_nl,
> > +	},
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_NEW_EDGE,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_new_edge_nl,
> > +		.flags = GENL_UNS_ADMIN_PERM,
> > +	},
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_DEL_EDGE,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_del_edge_nl,
> > +		.flags = GENL_UNS_ADMIN_PERM,
> > +	},
> > +	{
> > +		.cmd = MAC802154_HWSIM_CMD_SET_EDGE,
> > +		.policy = hwsim_genl_policy,
> > +		.doit = hwsim_set_edge_lqi,
> > +		.flags = GENL_UNS_ADMIN_PERM,
> > +	},
> > +};
> > +
> 
> This answers my questions on why MAC802154_HWSIM_CMD_SET_RADIO and MAC802154_HWSIM_CMD_GET_EDGE are not used in wpan-hwsim.
> The kernel does not really expose them. If you think they are not needed I would say we need to remove these enum types from the header below.

I wanted to have there because this is general design from wireless to
make something like that (I catch it up for future use).
SET_RADIO could have use later for changing HWFLAGS, I have some ideas
in my mind. GET_EDGE: only dump Edge information with vector specified,
I currently dump radio and it has the list of edges appended.
Use cases for me... HWFLAGS would be to make stuff in driverlayer to
fake that the hardware would do it. e.g. CRC can be set/verified by
softmac or hardware, we could switch that check (ignoring the case of
locking for that yet... should be fine).

Can we rename it to __MAC802154_HWSIM_RESERVED{1...N} ? This offers us to
rename this thing and use it for future use at place it in order. But
then I can ask myself... it's a compile define and would break userspace
(by just renaming) when somebody use that define for whatever the reason
is..., but then it's their problem when they use a reserved define. :-)

> > +static struct genl_family hwsim_genl_family __ro_after_init = {
> > +	.name = "MAC802154_HWSIM",
> > +	.version = 1,
> > +	.maxattr = MAC802154_HWSIM_ATTR_MAX,
> > +	.module = THIS_MODULE,
> > +	.ops = hwsim_nl_ops,
> > +	.n_ops = ARRAY_SIZE(hwsim_nl_ops),
> > +	.mcgrps = hwsim_mcgrps,
> > +	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
> > +};
> > +
...
> > +
> > +module_init(hwsim_init_module);
> > +module_exit(hwsim_remove_module);
> > diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/ieee802154/mac802154_hwsim.h
> > new file mode 100644
> > index 000000000000..6009214c0d75
> > --- /dev/null
> > +++ b/drivers/net/ieee802154/mac802154_hwsim.h
> > @@ -0,0 +1,73 @@
> > +#ifndef __MAC802154_HWSIM_H
> > +#define __MAC802154_HWSIM_H
> > +
> > +/* mac802154 hwsim netlink commands
> > + *
> > + * @MAC802154_HWSIM_CMD_UNSPEC: unspecified command to catch error
> > + * @MAC802154_HWSIM_CMD_GET_RADIO: fetch information about existing radios
> > + * @MAC802154_HWSIM_CMD_SEL_RADIO: change radio parameters during runtime
> 
> Same typo as I mentioned in the wpan-hwsim patch. SET_RADIO.
> 

ok.

- Alex
