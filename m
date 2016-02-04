Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54931 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933018AbcBDQKw (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 4 Feb 2016 11:10:52 -0500
Subject: Re: [PATCH bluetooth-next] mac802154: LED trigger support
References: <1454356810-5600-1-git-send-email-koen@bergzand.net>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56B37809.9030102@osg.samsung.com>
Date: Thu, 4 Feb 2016 17:10:49 +0100
MIME-Version: 1.0
In-Reply-To: <1454356810-5600-1-git-send-email-koen@bergzand.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org

hello.

On 01/02/16 21:00, Koen Zandberg wrote:
> Hello,
>
> This contains a patch to the mac802154 code for LED trigger support. Two LED
> triggers are added, one for tx events and one for rx events. Trigger names are
> based on the physical device name appended with the function, for example
> "phy0-tx".
> The patches are heavily based on the mac80211 led support.

It looks like you intended the above as some sort of introduction. Its 
already part of the commit messages when applied though. Maybe merge the 
two into one and skip the hello part :)

As a general comment some docs how to enable this feature might be 
useful. We have Documentation/networking/ieee802154.txt. Adding a small 
section about it might be useful
>
>
> This commit adds LED support for transmit and receive events of the
> mac802154 module. A config option is added for the LED triggers
>
> Signed-off-by: Koen Zandberg <koen@bergzand.net>
> ---
>   net/mac802154/Kconfig        |   9 ++++
>   net/mac802154/Makefile       |   2 +
>   net/mac802154/ieee802154_i.h |   6 +++
>   net/mac802154/led.c          | 113 +++++++++++++++++++++++++++++++++++++++++++
>   net/mac802154/led.h          |  58 ++++++++++++++++++++++
>   net/mac802154/main.c         |  11 +++++
>   net/mac802154/rx.c           |   3 ++
>   net/mac802154/tx.c           |   3 ++
>   8 files changed, 205 insertions(+)
>   create mode 100644 net/mac802154/led.c
>   create mode 100644 net/mac802154/led.h
>
> diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
> index fb45287..6b107a5 100644
> --- a/net/mac802154/Kconfig
> +++ b/net/mac802154/Kconfig
> @@ -19,3 +19,12 @@ config MAC802154
>   	  If you plan to use HardMAC IEEE 802.15.4 devices, you can
>   	  say N here. Alternatively you can say M to compile it as
>   	  module.
> +
> +config MAC802154_LEDS
> +	bool "Enable LED triggers"
> +	depends on MAC802154
> +	depends on LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	---help---
> +	  This option enables LED triggers for packet receive/transmit
> +	  events.
> diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
> index 17a51e8..a3ac867 100644
> --- a/net/mac802154/Makefile
> +++ b/net/mac802154/Makefile
> @@ -2,6 +2,8 @@ obj-$(CONFIG_MAC802154)	+= mac802154.o
>   mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
>   			   iface.o llsec.o util.o cfg.o trace.o
>   
> +mac802154-$(CONFIG_MAC802154_LEDS) += led.o
> +
>   CFLAGS_trace.o := -I$(src)
>   
>   ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index 56ccffa..00b5fad 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -21,6 +21,7 @@
>   
>   #include <linux/mutex.h>
>   #include <linux/hrtimer.h>
> +#include <linux/leds.h>
>   #include <net/cfg802154.h>
>   #include <net/mac802154.h>
>   #include <net/nl802154.h>
> @@ -58,6 +59,11 @@ struct ieee802154_local {
>   	bool started;
>   	bool suspended;
>   
> +#ifdef CONFIG_MAC802154_LEDS
> +	struct led_trigger tx_led, rx_led;
> +	atomic_t tx_led_active, rx_led_active;
> +#endif
> +
>   	struct tasklet_struct tasklet;
>   	struct sk_buff_head skb_queue;
>   
> diff --git a/net/mac802154/led.c b/net/mac802154/led.c
> new file mode 100644
> index 0000000..fef6a72
> --- /dev/null
> +++ b/net/mac802154/led.c
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright 2016, Koen Zandberg <koen@bergzand.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/export.h>
> +#include "led.h"
> +
> +
> +void ieee802154_alloc_led_names(struct ieee802154_local *local)
> +{
> +	local->rx_led.name = kasprintf(GFP_KERNEL, "%s-rx",
> +				       wpan_phy_name(local->phy));
> +	local->tx_led.name = kasprintf(GFP_KERNEL, "%s-tx",
> +				       wpan_phy_name(local->phy));

Alex mentioned that already on IRC. phy0-tx is to generic. I think you 
two already agreed on wpan-phy0-tx.
> +
> +}
> +EXPORT_SYMBOL(ieee802154_alloc_led_names);
> +
> +void ieee802154_free_led_names(struct ieee802154_local *local)
> +{
> +	kfree(local->rx_led.name);
> +	kfree(local->tx_led.name);
> +}
> +EXPORT_SYMBOL(ieee802154_free_led_names);
> +
> +static void ieee802154_tx_led_activate(struct led_classdev *led_cdev)
> +{
> +	struct ieee802154_local *local = container_of(led_cdev->trigger,
> +						     struct ieee802154_local,
> +						     tx_led);
> +
> +	atomic_inc(&local->tx_led_active);
> +}
> +
> +static void ieee802154_tx_led_deactivate(struct led_classdev *led_cdev)
> +{
> +	struct ieee802154_local *local = container_of(led_cdev->trigger,
> +						     struct ieee802154_local,
> +						     tx_led);
> +
> +	atomic_dec(&local->tx_led_active);
> +}
> +
> +static void ieee802154_rx_led_activate(struct led_classdev *led_cdev)
> +{
> +	struct ieee802154_local *local = container_of(led_cdev->trigger,
> +						     struct ieee802154_local,
> +						     rx_led);
> +
> +	atomic_inc(&local->rx_led_active);
> +}
> +
> +static void ieee802154_rx_led_deactivate(struct led_classdev *led_cdev)
> +{
> +	struct ieee802154_local *local = container_of(led_cdev->trigger,
> +						     struct ieee802154_local,
> +						     rx_led);
> +
> +	atomic_dec(&local->rx_led_active);
> +}
> +
> +
> +void ieee802154_led_init(struct ieee802154_local *local)
> +{
> +	atomic_set(&local->rx_led_active, 0);
> +	local->rx_led.activate = ieee802154_rx_led_activate;
> +	local->rx_led.deactivate = ieee802154_rx_led_deactivate;
> +	if (local->rx_led.name && led_trigger_register(&local->rx_led)) {
> +		kfree(local->rx_led.name);
> +		local->rx_led.name = NULL;

Do we want to print an error message here?
> +	}
> +	printk(KERN_INFO "Registered mac802154 rx LED trigger at %s\n", local->rx_led.name);
> +
> +	atomic_set(&local->tx_led_active, 0);
> +	local->tx_led.activate = ieee802154_tx_led_activate;
> +	local->tx_led.deactivate = ieee802154_tx_led_deactivate;
> +	if (local->tx_led.name && led_trigger_register(&local->tx_led)) {
> +		kfree(local->tx_led.name);
> +		local->tx_led.name = NULL;
> +	}
> +	printk(KERN_INFO "Registered mac802154 tx LED trigger at %s\n", local->tx_led.name);
> +}
> +EXPORT_SYMBOL(ieee802154_led_init);
> +
> +void ieee802154_led_exit(struct ieee802154_local *local)
> +{
> +	if (local->tx_led.name)
> +		led_trigger_unregister(&local->tx_led);
> +	if (local->rx_led.name)
> +		led_trigger_unregister(&local->rx_led);
> +}
> +EXPORT_SYMBOL(ieee802154_led_exit);
> +
> +const char *__ieee802154_get_tx_led_name(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +
> +	return local->tx_led.name;
> +}
> +EXPORT_SYMBOL(__ieee802154_get_tx_led_name);
> +
> +const char *__ieee802154_get_rx_led_name(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +
> +	return local->rx_led.name;
> +}
> +EXPORT_SYMBOL(__ieee802154_get_rx_led_name);
> diff --git a/net/mac802154/led.h b/net/mac802154/led.h
> new file mode 100644
> index 0000000..e382f11
> --- /dev/null
> +++ b/net/mac802154/led.h
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright 2016, Koen Zandberg <koen@bergzand.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/leds.h>
> +#include "ieee802154_i.h"
> +
> +#define MAC802154_BLINK_DELAY 50 /* ms */
> +
> +static inline void ieee802154_led_rx(struct ieee802154_local *local)
> +{
> +#ifdef CONFIG_MAC802154_LEDS
> +	unsigned long led_delay = MAC802154_BLINK_DELAY;
> +
> +	if (!atomic_read(&local->rx_led_active))
> +		return;
> +	led_trigger_blink_oneshot(&local->rx_led, &led_delay, &led_delay, 0);
> +#endif
> +}
> +
> +static inline void ieee802154_led_tx(struct ieee802154_local *local)
> +{
> +#ifdef CONFIG_MAC802154_LEDS
> +	unsigned long led_delay = MAC802154_BLINK_DELAY;
> +
> +	if (!atomic_read(&local->tx_led_active))
> +		return;
> +	led_trigger_blink_oneshot(&local->tx_led, &led_delay, &led_delay, 0);
> +#endif
> +}
> +
> +#ifdef CONFIG_MAC802154_LEDS
> +void ieee802154_alloc_led_names(struct ieee802154_local *local);
> +void ieee802154_free_led_names(struct ieee802154_local *local);
> +void ieee802154_led_init(struct ieee802154_local *local);
> +void ieee802154_led_exit(struct ieee802154_local *local);
> +void ieee802154_mod_tpt_led_trig(struct ieee802154_local *local,
> +				unsigned int types_on, unsigned int types_off);
> +#else
> +static inline void ieee802154_alloc_led_names(struct ieee802154_local *local)
> +{
> +}
> +static inline void ieee802154_free_led_names(struct ieee802154_local *local)
> +{
> +}
> +static inline void ieee802154_led_init(struct ieee802154_local *local)
> +{
> +}
> +static inline void ieee802154_led_exit(struct ieee802154_local *local)
> +{
> +}
> +#endif
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index e8cab5b..51b294a 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -27,6 +27,7 @@
>   
>   #include "ieee802154_i.h"
>   #include "cfg.h"
> +#include "led.h"
>   
>   static void ieee802154_tasklet_handler(unsigned long data)
>   {
> @@ -107,6 +108,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>   
>   	INIT_WORK(&local->tx_work, ieee802154_xmit_worker);
>   
> +	ieee802154_alloc_led_names(local);
> +
>   	/* init supported flags with 802.15.4 default ranges */
>   	phy->supported.max_minbe = 8;
>   	phy->supported.min_maxbe = 3;
> @@ -119,6 +122,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>   	/* always supported */
>   	phy->supported.iftypes = BIT(NL802154_IFTYPE_NODE);
>   
> +

No need to add an extra empty line here.

>   	return &local->hw;
>   }
>   EXPORT_SYMBOL(ieee802154_alloc_hw);
> @@ -131,6 +135,8 @@ void ieee802154_free_hw(struct ieee802154_hw *hw)
>   
>   	mutex_destroy(&local->iflist_mtx);
>   
> +        ieee802154_free_led_names(local);
> +
>   	wpan_phy_free(local->phy);
>   }
>   EXPORT_SYMBOL(ieee802154_free_hw);
> @@ -188,6 +194,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>   	if (rc < 0)
>   		goto out_wq;
>   
> +	ieee802154_led_init(local);
> +
>   	rtnl_lock();
>   
>   	dev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
> @@ -205,6 +213,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>   
>   out_phy:
>   	wpan_phy_unregister(local->phy);
> +	ieee802154_led_exit(local);
>   out_wq:
>   	destroy_workqueue(local->workqueue);
>   out:
> @@ -226,6 +235,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
>   
>   	rtnl_unlock();
>   
> +	ieee802154_led_exit(local);
> +
>   	wpan_phy_unregister(local->phy);
>   }
>   EXPORT_SYMBOL(ieee802154_unregister_hw);
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 446e130..919ba6b 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -28,6 +28,7 @@
>   #include <net/nl802154.h>
>   
>   #include "ieee802154_i.h"
> +#include "led.h"
>   
>   static int ieee802154_deliver_skb(struct sk_buff *skb)
>   {
> @@ -286,6 +287,8 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
>   
>   	__ieee802154_rx_handle_packet(local, skb);
>   
> +	ieee802154_led_rx(local);
> +
>   	rcu_read_unlock();
>   
>   	return;
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 7e25345..1a6bc87 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -29,6 +29,7 @@
>   
>   #include "ieee802154_i.h"
>   #include "driver-ops.h"
> +#include "led.h"
>   
>   void ieee802154_xmit_worker(struct work_struct *work)
>   {
> @@ -86,6 +87,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
>   		queue_work(local->workqueue, &local->tx_work);
>   	}
>   
> +	ieee802154_led_tx(local);
> +
>   	return NETDEV_TX_OK;
>   
>   err_tx:

regards
Stefan Schmidt
