Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:32905 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbFJEya (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 00:54:30 -0400
Received: by pdjn11 with SMTP id n11so29258286pdj.0
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 21:54:29 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [RFC bluetooth-next 2/2] mac802154: add suspend and resume callbacks
Date: Wed, 10 Jun 2015 10:23:48 +0530
Message-Id: <1433912028-17267-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1433912028-17267-1-git-send-email-varkab@cdac.in>
References: <1433912028-17267-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch introduces suspend and resume callbacks to mac802154,
allowing mac802154 to quiesce its state (bringing down interfaces etc)
in preparation for suspend.  cfg802154 will call the suspend hook
before the device suspend, and resume hook after the device resume.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/mac802154.h      |    2 ++
 net/mac802154/Makefile       |    2 ++
 net/mac802154/cfg.c          |   17 +++++++++++
 net/mac802154/driver-ops.h   |   39 ++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h |    4 +++
 net/mac802154/pm.c           |   67 ++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/trace.h        |   10 +++++++
 7 files changed, 141 insertions(+)
 create mode 100644 net/mac802154/pm.c

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index de1cdde..5b03ce8 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -247,6 +247,8 @@ struct ieee802154_ops {
 					     s8 retries);
 	int             (*set_promiscuous_mode)(struct ieee802154_hw *hw,
 						const bool on);
+	int		(*suspend)(struct ieee802154_hw *hw);
+	int		(*resume)(struct ieee802154_hw *hw);
 };
 
 /**
diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 17a51e8..c96b549 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -4,4 +4,6 @@ mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
 
 CFLAGS_trace.o := -I$(src)
 
+mac802154-$(CONFIG_PM) := pm.o
+
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 317c466..7c759ed 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -44,6 +44,21 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 	ieee802154_if_remove(sdata);
 }
 
+#ifdef CONFIG_PM
+static int ieee802154_suspend(struct wpan_phy *wpan_phy)
+{
+	return __ieee802154_suspend(wpan_phy_priv(wpan_phy));
+}
+
+static int ieee802154_resume(struct wpan_phy *wpan_phy)
+{
+	return __ieee802154_resume(wpan_phy_priv(wpan_phy));
+}
+#else
+#define ieee802154_suspend NULL
+#define ieee802154_resume NULL
+#endif
+
 static int
 ieee802154_add_iface(struct wpan_phy *phy, const char *name,
 		     unsigned char name_assign_type,
@@ -227,6 +242,8 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
+	.suspend = ieee802154_suspend,
+	.resume = ieee802154_resume,
 	.add_virtual_intf = ieee802154_add_iface,
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 0550f33..f482b8f 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -284,4 +284,43 @@ drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static inline int
+drv_suspend(struct ieee802154_local *local)
+{
+	int ret;
+
+	might_sleep();
+
+	if (!local->ops->suspend) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	trace_802154_drv_suspend(local);
+	ret = local->ops->suspend(&local->hw);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
+}
+
+static inline int
+drv_resume(struct ieee802154_local *local)
+{
+	int ret;
+
+	might_sleep();
+
+	if (!local->ops->resume) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	trace_802154_drv_resume(local);
+	ret = local->ops->resume(&local->hw);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
+}
+
+#endif /* CONFIG_PM */
+
 #endif /* __MAC802154_DRIVER_OPS */
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 34755d5..207fca2 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -177,4 +177,8 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		  __le64 extended_addr);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
 
+/* Suspend and Resume handling */
+int __ieee802154_suspend(struct ieee802154_hw *hw);
+int __ieee802154_resume(struct ieee802154_hw *hw);
+
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/pm.c b/net/mac802154/pm.c
new file mode 100644
index 0000000..9055799
--- /dev/null
+++ b/net/mac802154/pm.c
@@ -0,0 +1,67 @@
+#include <net/mac802154.h>
+#include <net/rtnetlink.h>
+
+#include "ieee802154_i.h"
+#include "driver-ops.h"
+
+int __ieee802154_suspend(struct ieee802154_hw *hw)
+{
+	struct ieee802154_local *local = hw_to_local(hw);
+	struct ieee802154_sub_if_data *sdata;
+
+	if (!local->open_count)
+		goto suspend;
+
+	ieee802154_stop_queue(hw);
+
+	flush_workqueue(local->workqueue);
+
+	/* remove all interfaces that were created in the driver */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee802154_sdata_running(sdata))
+			continue;
+
+		ieee802154_remove_interfaces(local);
+	}
+
+	/* Stop hardware - this must stop RX */
+	if (local->open_count)
+		drv_stop(local);
+
+suspend:
+	return 0;
+}
+
+int __ieee802154_resume(struct ieee802154_hw *hw)
+{
+	struct ieee802154_local *local = hw_to_local(hw);
+	struct ieee802154_sub_if_data *sdata;
+	struct net_device *ndev = NULL;
+	int res;
+
+	/* nothing to do if HW shouldn't run */
+	if (!local->open_count)
+		goto wake_up;
+
+	/* restart hardware */
+	res = drv_start(local);
+	if (res)
+		return res;
+
+	/* add interfaces */
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR &&
+		    ieee802154_sdata_running(sdata)) {
+			ndev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
+						 sdata->wpan_dev.iftype,
+						 sdata->wpan_dev.extended_addr);
+			if (WARN_ON(ndev))
+				break;
+		}
+	}
+wake_up:
+	ieee802154_wake_queue(hw);
+
+	return 0;
+}
+
diff --git a/net/mac802154/trace.h b/net/mac802154/trace.h
index 6f30e0c..d8179e0 100644
--- a/net/mac802154/trace.h
+++ b/net/mac802154/trace.h
@@ -263,6 +263,16 @@ TRACE_EVENT(802154_drv_set_promiscuous_mode,
 		  BOOL_TO_STR(__entry->on))
 );
 
+DEFINE_EVENT(local_only_evt, 802154_drv_suspend,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local)
+);
+
+DEFINE_EVENT(local_only_evt, 802154_drv_resume,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local)
+);
+
 #endif /* !__MAC802154_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
1.7.9.5

