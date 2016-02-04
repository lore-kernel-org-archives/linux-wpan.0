Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32942 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965224AbcBDUme (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Feb 2016 15:42:34 -0500
Subject: Re: [PATCH bluetooth-next] mac802154: LED trigger support
References: <1454356810-5600-1-git-send-email-koen@bergzand.net>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <56B3B7B8.1010702@pengutronix.de>
Date: Thu, 4 Feb 2016 21:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <1454356810-5600-1-git-send-email-koen@bergzand.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org

Hi,

we already talked about devm_trigger functions and the wpan prefix inside
the trigger names. I will try to review some other parts.

Please run ./scripts/checkpatch.pl over the patch next time to see code-style
issues.

Am 02/01/2016 um 09:00 PM schrieb Koen Zandberg:
> Hello,
>
> This contains a patch to the mac802154 code for LED trigger support. Two LED
> triggers are added, one for tx events and one for rx events. Trigger names are
> based on the physical device name appended with the function, for example
> "phy0-tx".
> The patches are heavily based on the mac80211 led support.
>
>
>
> This commit adds LED support for transmit and receive events of the
> mac802154 module. A config option is added for the LED triggers
>
> Signed-off-by: Koen Zandberg <koen@bergzand.net>
> ---
>  net/mac802154/Kconfig        |   9 ++++
>  net/mac802154/Makefile       |   2 +
>  net/mac802154/ieee802154_i.h |   6 +++
>  net/mac802154/led.c          | 113 +++++++++++++++++++++++++++++++++++++++++++
>  net/mac802154/led.h          |  58 ++++++++++++++++++++++
>  net/mac802154/main.c         |  11 +++++
>  net/mac802154/rx.c           |   3 ++
>  net/mac802154/tx.c           |   3 ++
>  8 files changed, 205 insertions(+)
>  create mode 100644 net/mac802154/led.c
>  create mode 100644 net/mac802154/led.h
>
> diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
> index fb45287..6b107a5 100644
> --- a/net/mac802154/Kconfig
> +++ b/net/mac802154/Kconfig
> @@ -19,3 +19,12 @@ config MAC802154
>  	  If you plan to use HardMAC IEEE 802.15.4 devices, you can
>  	  say N here. Alternatively you can say M to compile it as
>  	  module.
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
>  mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
>  			   iface.o llsec.o util.o cfg.o trace.o
>  
> +mac802154-$(CONFIG_MAC802154_LEDS) += led.o
> +
>  CFLAGS_trace.o := -I$(src)
>  
>  ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index 56ccffa..00b5fad 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -21,6 +21,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/hrtimer.h>
> +#include <linux/leds.h>
>  #include <net/cfg802154.h>
>  #include <net/mac802154.h>
>  #include <net/nl802154.h>
> @@ -58,6 +59,11 @@ struct ieee802154_local {
>  	bool started;
>  	bool suspended;
>  
> +#ifdef CONFIG_MAC802154_LEDS
> +	struct led_trigger tx_led, rx_led;
> +	atomic_t tx_led_active, rx_led_active;
> +#endif
> +
>  	struct tasklet_struct tasklet;
>  	struct sk_buff_head skb_queue;
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
> +
> +}
> +EXPORT_SYMBOL(ieee802154_alloc_led_names);
> +

EXPORT_SYMBOL is needed only if the function is used by another
module. This is not the case, please remove it.

> +void ieee802154_free_led_names(struct ieee802154_local *local)
> +{
> +	kfree(local->rx_led.name);
> +	kfree(local->tx_led.name);
> +}
> +EXPORT_SYMBOL(ieee802154_free_led_names);
> +

same here.

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
> +	}
> +	printk(KERN_INFO "Registered mac802154 rx LED trigger at %s\n", local->rx_led.name);
> +
remove these printk's.

I would not add them for such information. Also we already talked about that this
function has a silent "error handling", if led_trigger_registers fails then this printk
will be printed and reports it wrong.

But don't add error handling here, failed led triggers should not occur that probing
of drivers fails.

> +	atomic_set(&local->tx_led_active, 0);
> +	local->tx_led.activate = ieee802154_tx_led_activate;
> +	local->tx_led.deactivate = ieee802154_tx_led_deactivate;
> +	if (local->tx_led.name && led_trigger_register(&local->tx_led)) {
> +		kfree(local->tx_led.name);
> +		local->tx_led.name = NULL;
> +	}
> +	printk(KERN_INFO "Registered mac802154 tx LED trigger at %s\n", local->tx_led.name);

same here.

> +}
> +EXPORT_SYMBOL(ieee802154_led_init);
> +
remove the EXPORT_SYMBOL.

> +void ieee802154_led_exit(struct ieee802154_local *local)
> +{
> +	if (local->tx_led.name)
> +		led_trigger_unregister(&local->tx_led);
> +	if (local->rx_led.name)
> +		led_trigger_unregister(&local->rx_led);
> +}
> +EXPORT_SYMBOL(ieee802154_led_exit);
> +
same here.

> +const char *__ieee802154_get_tx_led_name(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +
> +	return local->tx_led.name;
> +}
> +EXPORT_SYMBOL(__ieee802154_get_tx_led_name);
> +

Where is this function used? I don't see that this function is used by your patch
somewhere.

> +const char *__ieee802154_get_rx_led_name(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +
> +	return local->rx_led.name;
> +}
> +EXPORT_SYMBOL(__ieee802154_get_rx_led_name);

same here.

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

Move this function in the

#ifdef CONFIG_MAC802154_LEDS

below, and add empty "dummy" static inline function when it's not set.
I know this comes from mac80211 code but don't know why they did
change here the usually coding style.

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
same here.

> +
> +#ifdef CONFIG_MAC802154_LEDS

Put the static inline function for led_tx/rx here with implementation.

> +void ieee802154_alloc_led_names(struct ieee802154_local *local);
> +void ieee802154_free_led_names(struct ieee802154_local *local);
> +void ieee802154_led_init(struct ieee802154_local *local);
> +void ieee802154_led_exit(struct ieee802154_local *local);
> +void ieee802154_mod_tpt_led_trig(struct ieee802154_local *local,
> +				unsigned int types_on, unsigned int types_off);
> +#else

here, the dummies.

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
>  #include "ieee802154_i.h"
>  #include "cfg.h"
> +#include "led.h"
>  
>  static void ieee802154_tasklet_handler(unsigned long data)
>  {
> @@ -107,6 +108,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>  
>  	INIT_WORK(&local->tx_work, ieee802154_xmit_worker);
>  
> +	ieee802154_alloc_led_names(local);
> +
>  	/* init supported flags with 802.15.4 default ranges */
>  	phy->supported.max_minbe = 8;
>  	phy->supported.min_maxbe = 3;
> @@ -119,6 +122,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>  	/* always supported */
>  	phy->supported.iftypes = BIT(NL802154_IFTYPE_NODE);
>  
> +

remove this empty line.

>  	return &local->hw;
>  }
>  EXPORT_SYMBOL(ieee802154_alloc_hw);
> @@ -131,6 +135,8 @@ void ieee802154_free_hw(struct ieee802154_hw *hw)
>  
>  	mutex_destroy(&local->iflist_mtx);
>  
> +        ieee802154_free_led_names(local);
> +

Here is some whitespace issue, run checkpatch.

>  	wpan_phy_free(local->phy);
>  }
>  EXPORT_SYMBOL(ieee802154_free_hw);
> @@ -188,6 +194,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>  	if (rc < 0)
>  		goto out_wq;
>  
> +	ieee802154_led_init(local);
> +
>  	rtnl_lock();
>  
>  	dev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
> @@ -205,6 +213,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>  
>  out_phy:
>  	wpan_phy_unregister(local->phy);
> +	ieee802154_led_exit(local);
>  out_wq:
>  	destroy_workqueue(local->workqueue);
>  out:
> @@ -226,6 +235,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
>  
>  	rtnl_unlock();
>  
> +	ieee802154_led_exit(local);
> +
>  	wpan_phy_unregister(local->phy);
>  }
>  EXPORT_SYMBOL(ieee802154_unregister_hw);
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 446e130..919ba6b 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -28,6 +28,7 @@
>  #include <net/nl802154.h>
>  
>  #include "ieee802154_i.h"
> +#include "led.h"
>  
>  static int ieee802154_deliver_skb(struct sk_buff *skb)
>  {
> @@ -286,6 +287,8 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
>  
>  	__ieee802154_rx_handle_packet(local, skb);
>  
> +	ieee802154_led_rx(local);
move this handling after rcu_read_unlock, please.

- Alex
