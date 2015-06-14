Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34246 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbFNOcr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 10:32:47 -0400
Received: by wicnd19 with SMTP id nd19so3596613wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 14 Jun 2015 07:32:46 -0700 (PDT)
Date: Sun, 14 Jun 2015 16:32:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 2/2] mac802154: add suspend and resume
 callbacks
Message-ID: <20150614143241.GB982@omega>
References: <1433912028-17267-1-git-send-email-varkab@cdac.in>
 <1433912028-17267-3-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433912028-17267-3-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Jun 10, 2015 at 10:23:48AM +0530, Varka Bhadram wrote:
> This patch introduces suspend and resume callbacks to mac802154,
> allowing mac802154 to quiesce its state (bringing down interfaces etc)
> in preparation for suspend.  cfg802154 will call the suspend hook
> before the device suspend, and resume hook after the device resume.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/mac802154.h      |    2 ++
>  net/mac802154/Makefile       |    2 ++
>  net/mac802154/cfg.c          |   17 +++++++++++
>  net/mac802154/driver-ops.h   |   39 ++++++++++++++++++++++++
>  net/mac802154/ieee802154_i.h |    4 +++
>  net/mac802154/pm.c           |   67 ++++++++++++++++++++++++++++++++++++++++++
>  net/mac802154/trace.h        |   10 +++++++
>  7 files changed, 141 insertions(+)
>  create mode 100644 net/mac802154/pm.c
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index de1cdde..5b03ce8 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -247,6 +247,8 @@ struct ieee802154_ops {
>  					     s8 retries);
>  	int             (*set_promiscuous_mode)(struct ieee802154_hw *hw,
>  						const bool on);
> +	int		(*suspend)(struct ieee802154_hw *hw);
> +	int		(*resume)(struct ieee802154_hw *hw);

Remove. See below.

>  };
>  
>  /**
> diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
> index 17a51e8..c96b549 100644
> --- a/net/mac802154/Makefile
> +++ b/net/mac802154/Makefile
> @@ -4,4 +4,6 @@ mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
>  
>  CFLAGS_trace.o := -I$(src)
>  
> +mac802154-$(CONFIG_PM) := pm.o

Remove. See below.

> +
>  ccflags-y += -D__CHECK_ENDIAN__
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 317c466..7c759ed 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -44,6 +44,21 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
>  	ieee802154_if_remove(sdata);
>  }
>  
> +#ifdef CONFIG_PM
> +static int ieee802154_suspend(struct wpan_phy *wpan_phy)
> +{
> +	return __ieee802154_suspend(wpan_phy_priv(wpan_phy));
> +}
> +
> +static int ieee802154_resume(struct wpan_phy *wpan_phy)
> +{
> +	return __ieee802154_resume(wpan_phy_priv(wpan_phy));
> +}
> +#else
> +#define ieee802154_suspend NULL
> +#define ieee802154_resume NULL
> +#endif
> +

Put the complete functionality into this functions, no need for extra
pm.c file.

>  static int
>  ieee802154_add_iface(struct wpan_phy *phy, const char *name,
>  		     unsigned char name_assign_type,
> @@ -227,6 +242,8 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
>  const struct cfg802154_ops mac802154_config_ops = {
>  	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
>  	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
> +	.suspend = ieee802154_suspend,
> +	.resume = ieee802154_resume,
>  	.add_virtual_intf = ieee802154_add_iface,
>  	.del_virtual_intf = ieee802154_del_iface,
>  	.set_channel = ieee802154_set_channel,
> diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
> index 0550f33..f482b8f 100644
> --- a/net/mac802154/driver-ops.h
> +++ b/net/mac802154/driver-ops.h
> @@ -284,4 +284,43 @@ drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM
> +static inline int
> +drv_suspend(struct ieee802154_local *local)
> +{
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (!local->ops->suspend) {
> +		WARN_ON(1);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	trace_802154_drv_suspend(local);
> +	ret = local->ops->suspend(&local->hw);
> +	trace_802154_drv_return_int(local, ret);
> +	return ret;
> +}
> +
> +static inline int
> +drv_resume(struct ieee802154_local *local)
> +{
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (!local->ops->resume) {
> +		WARN_ON(1);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	trace_802154_drv_resume(local);
> +	ret = local->ops->resume(&local->hw);
> +	trace_802154_drv_return_int(local, ret);
> +	return ret;
> +}

Remove this. See below.

> +
> +#endif /* CONFIG_PM */
> +
>  #endif /* __MAC802154_DRIVER_OPS */
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index 34755d5..207fca2 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -177,4 +177,8 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
>  		  __le64 extended_addr);
>  void ieee802154_remove_interfaces(struct ieee802154_local *local);
>  
> +/* Suspend and Resume handling */
> +int __ieee802154_suspend(struct ieee802154_hw *hw);
> +int __ieee802154_resume(struct ieee802154_hw *hw);
> +

Remove this. See below.

>  #endif /* __IEEE802154_I_H */
> diff --git a/net/mac802154/pm.c b/net/mac802154/pm.c
> new file mode 100644
> index 0000000..9055799
> --- /dev/null
> +++ b/net/mac802154/pm.c

Remove this file and put the functionality into cfg.c, it's small
enough.

> @@ -0,0 +1,67 @@
> +#include <net/mac802154.h>
> +#include <net/rtnetlink.h>
> +
> +#include "ieee802154_i.h"
> +#include "driver-ops.h"
> +
> +int __ieee802154_suspend(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +	struct ieee802154_sub_if_data *sdata;
> +
> +	if (!local->open_count)
> +		goto suspend;
> +

This code means, if there is no interface up which belongs to the phy
which should be suspended. It is already in a suspended mode.

The else branch means now, there are interfaces up and we need to
to call the stop the phy that the phy is in suspend mode but the
interfaces should be still ifup in the time of suspend.

> +	ieee802154_stop_queue(hw);
> +
remove whitespace add add a:

        synchronize_net();

This will wait until that all receiving packets will be done.

> +	flush_workqueue(local->workqueue);
> +
> +	/* remove all interfaces that were created in the driver */
> +	list_for_each_entry(sdata, &local->interfaces, list) {
> +		if (!ieee802154_sdata_running(sdata))
> +			continue;
> +
> +		ieee802154_remove_interfaces(local);
> +	}
> +

This loop makes completely no sense and occurs in some random/endless
behaviour. Because ieee802154_remove_interfaces will remove all
interfaces which you already iterate over it.

Try to run your code in qemu with fakelb and try a:

echo "devices" > /sys/power/pm_test 
echo "freeze" > /sys/power/state

> +	/* Stop hardware - this must stop RX */
> +	if (local->open_count)

Remove this branch. This can't happen the rtnl lock is held in this
operation and you already check on if "(!local->open_count)" above.

I know this is also in mac80211 and what I can tell you is that mac80211
also doesn't need to check this again (or they have more side effects
than mac802154). But I also don't see this in mac80211, by running:

grep -r "open_count" net/mac802154/

The open_count is only manipulated when the rtnl is hold.

So maybe prepare also a patch for wireless to remove it.

> +		drv_stop(local);
> +
> +suspend:

We need a suspended variable in local here to make it true and stop
receiving when rx tasklet is still fireing.

Note you need to add handling for this in rx.c then.

> +	return 0;
> +}
> +
> +int __ieee802154_resume(struct ieee802154_hw *hw)
> +{
> +	struct ieee802154_local *local = hw_to_local(hw);
> +	struct ieee802154_sub_if_data *sdata;
> +	struct net_device *ndev = NULL;
> +	int res;
> +
> +	/* nothing to do if HW shouldn't run */
> +	if (!local->open_count)
> +		goto wake_up;
> +
> +	/* restart hardware */
> +	res = drv_start(local);
> +	if (res)
> +		return res;

I don't like res. I see many ret, rc, res, we should make one naming
convention. I like ret.

> +
> +	/* add interfaces */
> +	list_for_each_entry(sdata, &local->interfaces, list) {
> +		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR &&
> +		    ieee802154_sdata_running(sdata)) {
> +			ndev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
> +						 sdata->wpan_dev.iftype,
> +						 sdata->wpan_dev.extended_addr);
> +			if (WARN_ON(ndev))
> +				break;
> +		}
> +	}

This makes no sense. We should not remove the interfaces on suspend.
What mac802154 has this with the drv_add_interfaces is some interface
information inside the driver layer and they try to restore them.

> +wake_up:

Set the suspended then here to false.

> +	ieee802154_wake_queue(hw);
> +
> +	return 0;
> +}
> +
> diff --git a/net/mac802154/trace.h b/net/mac802154/trace.h
> index 6f30e0c..d8179e0 100644
> --- a/net/mac802154/trace.h
> +++ b/net/mac802154/trace.h
> @@ -263,6 +263,16 @@ TRACE_EVENT(802154_drv_set_promiscuous_mode,
>  		  BOOL_TO_STR(__entry->on))
>  );
>  
> +DEFINE_EVENT(local_only_evt, 802154_drv_suspend,
> +	TP_PROTO(struct ieee802154_local *local),
> +	TP_ARGS(local)
> +);
> +
> +DEFINE_EVENT(local_only_evt, 802154_drv_resume,
> +	TP_PROTO(struct ieee802154_local *local),
> +	TP_ARGS(local)
> +);
> +
>  #endif /* !__MAC802154_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
>  

I _think_ we don't need these driver callbacks. mac802154 have them
because they need to tell the driver, in case of one or more interfaces
are up, to do something. If the interfaces are down then the
transceivers should be Suspend (indicated by the stop callback). Please
see my patch to support sleep states in at86rf230.

mac802154 needs that to support WoW, it's not world of warcaft, it's Wake
on WLAN, like WOL. In case interfaces are up and going suspend they do
something for prepare the WoW. (So you can awake the target while
suspending from wireless).

We don't have such feature and the transceivers should go into sleep by
calling stop and wake when calling start.


I have modified this patch and it looks now like:

--- snip ---

---
 net/mac802154/cfg.c          | 46 ++++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h |  1 +
 net/mac802154/rx.c           |  7 +++++++
 3 files changed, 54 insertions(+)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 317c466..2af4d7f 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -44,6 +44,50 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 	ieee802154_if_remove(sdata);
 }
 
+#ifdef CONFIG_PM
+static int ieee802154_suspend(struct wpan_phy *wpan_phy)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	if (!local->open_count)
+		goto suspend;
+
+	ieee802154_stop_queue(&local->hw);
+	synchronize_net();
+	flush_workqueue(local->workqueue);
+
+	/* stop hardware - this must stop RX */
+	ieee802154_stop_device(local);
+
+suspend:
+	local->suspended = true;
+	return 0;
+}
+
+static int ieee802154_resume(struct wpan_phy *wpan_phy)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	/* nothing to do if HW shouldn't run */
+	if (!local->open_count)
+		goto wake_up;
+
+	/* restart hardware */
+	ret = drv_start(local);
+	if (ret)
+		return ret;
+
+wake_up:
+	ieee802154_wake_queue(&local->hw);
+	local->suspended = false;
+	return 0;
+}
+#else
+#define ieee802154_suspend NULL
+#define ieee802154_resume NULL
+#endif
+
 static int
 ieee802154_add_iface(struct wpan_phy *phy, const char *name,
 		     unsigned char name_assign_type,
@@ -227,6 +271,8 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
+	.suspend = ieee802154_suspend,
+	.resume = ieee802154_resume,
 	.add_virtual_intf = ieee802154_add_iface,
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index f0d4691..126d792 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -56,6 +56,7 @@ struct ieee802154_local {
 	struct hrtimer ifs_timer;
 
 	bool started;
+	bool suspended;
 
 	struct tasklet_struct tasklet;
 	struct sk_buff_head skb_queue;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 1bdf980..1053cb2 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -251,6 +251,9 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
+	if (local->suspended)
+		goto drop;
+
 	/* TODO: When a transceiver omits the checksum here, we
 	 * add an own calculated one. This is currently an ugly
 	 * solution because the monitor needs a crc here.
@@ -281,6 +284,10 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	__ieee802154_rx_handle_packet(local, skb);
 
 	rcu_read_unlock();
+
+	return;
+drop:
+	kfree_skb(skb);
 }
 EXPORT_SYMBOL(ieee802154_rx);
 
-- 
2.4.1

--- end snip ---

Additional you need a second patch to do the stop_device global:

--- snip ---

---
 net/mac802154/ieee802154_i.h | 1 +
 net/mac802154/iface.c        | 7 ++-----
 net/mac802154/util.c         | 8 ++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 34755d5..f0d4691 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -176,5 +176,6 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		  unsigned char name_assign_type, enum nl802154_iftype type,
 		  __le64 extended_addr);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
+void ieee802154_stop_device(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 692731d..cb48b1e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -307,11 +307,8 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!local->open_count) {
-		flush_workqueue(local->workqueue);
-		hrtimer_cancel(&local->ifs_timer);
-		drv_stop(local);
-	}
+	if (!local->open_count)
+		ieee802154_stop_device(local);
 
 	return 0;
 }
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 583435f..f9fd095 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -14,6 +14,7 @@
  */
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 /* privid for wpan_phys to determine whether they belong to us or not */
 const void *const mac802154_wpan_phy_privid = &mac802154_wpan_phy_privid;
@@ -92,3 +93,10 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 	dev_consume_skb_any(skb);
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
+
+void ieee802154_stop_device(struct ieee802154_local *local)
+{
+	flush_workqueue(local->workqueue);
+	hrtimer_cancel(&local->ifs_timer);
+	drv_stop(local);
+}
-- 
2.4.1

--- end snip ---

Should I simple send the patches for a second draft to the mailinglist?


Another thing is, to introduce opentask section is _not_ sending patches
which makes some correct interface handling with rdev_ops and mac802154
and let the other people do the rest stuff. 

And I mention this here because your mainly work was to make the handling
of suspend and resume logic. These can't work in your code and was
never tested and there was open source solutions (doing fakelb with
qemu) to test it. You simple copy&paste wireless stuff into this
subsystem and take a hammer to look some similar behaviour what wireless
do, but we can't do 1:1 the stuff from wireless. Please remember that
when you send the next patch. Copy the architecture only, the rest you
need to make some brain work.

I would only ack the first patch and then I will send the two above.

- Alex
