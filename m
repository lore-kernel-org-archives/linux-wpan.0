Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36534 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706AbbFAEZP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 00:25:15 -0400
Received: by pdjm12 with SMTP id m12so15325246pdj.3
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 21:25:14 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCHv2 bluetooth-next] mac802154: add trace functionality for driver ops
Date: Mon,  1 Jun 2015 09:54:44 +0530
Message-Id: <1433132684-14931-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds trace events for driver operations.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/Makefile     |    4 +-
 net/mac802154/driver-ops.h |   92 ++++++++++++---
 net/mac802154/trace.c      |    9 ++
 net/mac802154/trace.h      |  272 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+), 15 deletions(-)
 create mode 100644 net/mac802154/trace.c
 create mode 100644 net/mac802154/trace.h

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 702d8b4..17a51e8 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,7 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   iface.o llsec.o util.o cfg.o
+			   iface.o llsec.o util.o cfg.o trace.o
+
+CFLAGS_trace.o := -I$(src)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index caecd5f..0550f33 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -7,6 +7,7 @@
 #include <net/mac802154.h>
 
 #include "ieee802154_i.h"
+#include "trace.h"
 
 static inline int
 drv_xmit_async(struct ieee802154_local *local, struct sk_buff *skb)
@@ -27,19 +28,25 @@ drv_xmit_sync(struct ieee802154_local *local, struct sk_buff *skb)
 
 static inline int drv_start(struct ieee802154_local *local)
 {
+	int ret;
+
 	might_sleep();
 
+	trace_802154_drv_start(local);
 	local->started = true;
 	smp_mb();
-
-	return local->ops->start(&local->hw);
+	ret = local->ops->start(&local->hw);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline void drv_stop(struct ieee802154_local *local)
 {
 	might_sleep();
 
+	trace_802154_drv_stop(local);
 	local->ops->stop(&local->hw);
+	trace_802154_drv_return_void(local);
 
 	/* sync away all work on the tasklet before clearing started */
 	tasklet_disable(&local->tasklet);
@@ -53,13 +60,20 @@ static inline void drv_stop(struct ieee802154_local *local)
 static inline int
 drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
 {
+	int ret;
+
 	might_sleep();
 
-	return local->ops->set_channel(&local->hw, page, channel);
+	trace_802154_drv_set_channel(local, page, channel);
+	ret = local->ops->set_channel(&local->hw, page, channel);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int drv_set_tx_power(struct ieee802154_local *local, s32 mbm)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_txpower) {
@@ -67,12 +81,17 @@ static inline int drv_set_tx_power(struct ieee802154_local *local, s32 mbm)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_txpower(&local->hw, mbm);
+	trace_802154_drv_set_tx_power(local, mbm);
+	ret = local->ops->set_txpower(&local->hw, mbm);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int drv_set_cca_mode(struct ieee802154_local *local,
 				   const struct wpan_phy_cca *cca)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_cca_mode) {
@@ -80,11 +99,16 @@ static inline int drv_set_cca_mode(struct ieee802154_local *local,
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_cca_mode(&local->hw, cca);
+	trace_802154_drv_set_cca_mode(local, cca);
+	ret = local->ops->set_cca_mode(&local->hw, cca);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_lbt) {
@@ -92,12 +116,17 @@ static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_lbt(&local->hw, mode);
+	trace_802154_drv_set_lbt_mode(local, mode);
+	ret = local->ops->set_lbt(&local->hw, mode);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_cca_ed_level) {
@@ -105,12 +134,16 @@ drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_cca_ed_level(&local->hw, mbm);
+	trace_802154_drv_set_cca_ed_level(local, mbm);
+	ret = local->ops->set_cca_ed_level(&local->hw, mbm);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
 {
 	struct ieee802154_hw_addr_filt filt;
+	int ret;
 
 	might_sleep();
 
@@ -121,14 +154,18 @@ static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
 
 	filt.pan_id = pan_id;
 
-	return local->ops->set_hw_addr_filt(&local->hw, &filt,
+	trace_802154_drv_set_pan_id(local, pan_id);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
 					    IEEE802154_AFILT_PANID_CHANGED);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_extended_addr(struct ieee802154_local *local, __le64 extended_addr)
 {
 	struct ieee802154_hw_addr_filt filt;
+	int ret;
 
 	might_sleep();
 
@@ -139,14 +176,18 @@ drv_set_extended_addr(struct ieee802154_local *local, __le64 extended_addr)
 
 	filt.ieee_addr = extended_addr;
 
-	return local->ops->set_hw_addr_filt(&local->hw, &filt,
+	trace_802154_drv_set_extended_addr(local, extended_addr);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
 					    IEEE802154_AFILT_IEEEADDR_CHANGED);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_short_addr(struct ieee802154_local *local, __le16 short_addr)
 {
 	struct ieee802154_hw_addr_filt filt;
+	int ret;
 
 	might_sleep();
 
@@ -157,14 +198,18 @@ drv_set_short_addr(struct ieee802154_local *local, __le16 short_addr)
 
 	filt.short_addr = short_addr;
 
-	return local->ops->set_hw_addr_filt(&local->hw, &filt,
+	trace_802154_drv_set_short_addr(local, short_addr);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
 					    IEEE802154_AFILT_SADDR_CHANGED);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_pan_coord(struct ieee802154_local *local, bool is_coord)
 {
 	struct ieee802154_hw_addr_filt filt;
+	int ret;
 
 	might_sleep();
 
@@ -175,14 +220,19 @@ drv_set_pan_coord(struct ieee802154_local *local, bool is_coord)
 
 	filt.pan_coord = is_coord;
 
-	return local->ops->set_hw_addr_filt(&local->hw, &filt,
+	trace_802154_drv_set_pan_coord(local, is_coord);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
 					    IEEE802154_AFILT_PANC_CHANGED);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_csma_params(struct ieee802154_local *local, u8 min_be, u8 max_be,
 		    u8 max_csma_backoffs)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_csma_params) {
@@ -190,13 +240,19 @@ drv_set_csma_params(struct ieee802154_local *local, u8 min_be, u8 max_be,
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_csma_params(&local->hw, min_be, max_be,
+	trace_802154_drv_set_csma_params(local, min_be, max_be,
+					 max_csma_backoffs);
+	ret = local->ops->set_csma_params(&local->hw, min_be, max_be,
 					   max_csma_backoffs);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_max_frame_retries(struct ieee802154_local *local, s8 max_frame_retries)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_frame_retries) {
@@ -204,12 +260,17 @@ drv_set_max_frame_retries(struct ieee802154_local *local, s8 max_frame_retries)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_frame_retries(&local->hw, max_frame_retries);
+	trace_802154_drv_set_max_frame_retries(local, max_frame_retries);
+	ret = local->ops->set_frame_retries(&local->hw, max_frame_retries);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
 drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 {
+	int ret;
+
 	might_sleep();
 
 	if (!local->ops->set_promiscuous_mode) {
@@ -217,7 +278,10 @@ drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_promiscuous_mode(&local->hw, on);
+	trace_802154_drv_set_promiscuous_mode(local, on);
+	ret = local->ops->set_promiscuous_mode(&local->hw, on);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 #endif /* __MAC802154_DRIVER_OPS */
diff --git a/net/mac802154/trace.c b/net/mac802154/trace.c
new file mode 100644
index 0000000..863e5e6
--- /dev/null
+++ b/net/mac802154/trace.c
@@ -0,0 +1,9 @@
+#include <linux/module.h>
+
+#ifndef __CHECKER__
+#include <net/cfg802154.h>
+#include "driver-ops.h"
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#endif
diff --git a/net/mac802154/trace.h b/net/mac802154/trace.h
new file mode 100644
index 0000000..0f24d45
--- /dev/null
+++ b/net/mac802154/trace.h
@@ -0,0 +1,272 @@
+/* Based on net/mac80211/trace.h */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mac802154
+
+#if !defined(__MAC802154_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __MAC802154_DRIVER_TRACE
+
+#include <linux/tracepoint.h>
+
+#include <net/mac802154.h>
+#include "ieee802154_i.h"
+
+#define MAXNAME		32
+#define LOCAL_ENTRY	__array(char, wpan_phy_name, MAXNAME)
+#define LOCAL_ASSIGN	strlcpy(__entry->wpan_phy_name, \
+				wpan_phy_name(local->hw.phy), MAXNAME)
+#define LOCAL_PR_FMT	"%s"
+#define LOCAL_PR_ARG	__entry->wpan_phy_name
+
+#define CCA_ENTRY __field(enum nl802154_cca_modes, cca_mode) \
+		  __field(enum nl802154_cca_opts, cca_opt)
+#define CCA_ASSIGN \
+	do {                                     \
+		(__entry->cca_mode) = cca->mode; \
+		(__entry->cca_opt) = cca->opt;   \
+	} while (0)
+#define CCA_PR_FMT "cca_mode: %d, cca_opt: %d"
+#define CCA_PR_ARG __entry->cca_mode, __entry->cca_opt
+
+#define BOOL_TO_STR(bo) (bo) ? "true" : "false"
+
+/* Tracing for driver callbacks */
+
+DECLARE_EVENT_CLASS(local_only_evt,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+	),
+	TP_printk(LOCAL_PR_FMT, LOCAL_PR_ARG)
+);
+
+DEFINE_EVENT(local_only_evt, 802154_drv_return_void,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local)
+);
+
+TRACE_EVENT(802154_drv_return_int,
+	TP_PROTO(struct ieee802154_local *local, int ret),
+	TP_ARGS(local, ret),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->ret = ret;
+	),
+	TP_printk(LOCAL_PR_FMT ", returned: %d", LOCAL_PR_ARG,
+		  __entry->ret)
+);
+
+DEFINE_EVENT(local_only_evt, 802154_drv_start,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local)
+);
+
+DEFINE_EVENT(local_only_evt, 802154_drv_stop,
+	TP_PROTO(struct ieee802154_local *local),
+	TP_ARGS(local)
+);
+
+TRACE_EVENT(802154_drv_set_channel,
+	TP_PROTO(struct ieee802154_local *local, u8 page, u8 channel),
+	TP_ARGS(local, page, channel),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u8, page)
+		__field(u8, channel)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->page = page;
+		__entry->channel = channel;
+	),
+	TP_printk(LOCAL_PR_FMT ", page: %d, channel: %d", LOCAL_PR_ARG,
+		  __entry->page, __entry->channel)
+);
+
+TRACE_EVENT(802154_drv_set_cca_mode,
+	TP_PROTO(struct ieee802154_local *local,
+		 const struct wpan_phy_cca *cca),
+	TP_ARGS(local, cca),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		CCA_ENTRY
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		CCA_ASSIGN;
+	),
+	TP_printk(LOCAL_PR_FMT ", " CCA_PR_FMT, LOCAL_PR_ARG,
+		  CCA_PR_ARG)
+);
+
+TRACE_EVENT(802154_drv_set_cca_ed_level,
+	TP_PROTO(struct ieee802154_local *local, s32 mbm),
+	TP_ARGS(local, mbm),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(s32, mbm)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->mbm = mbm;
+	),
+	TP_printk(LOCAL_PR_FMT ", ed level: %d", LOCAL_PR_ARG,
+		  __entry->mbm)
+);
+
+TRACE_EVENT(802154_drv_set_tx_power,
+	TP_PROTO(struct ieee802154_local *local, s32 power),
+	TP_ARGS(local, power),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(s32, power)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->power = power;
+	),
+	TP_printk(LOCAL_PR_FMT ", mbm: %d", LOCAL_PR_ARG,
+		 __entry->power)
+);
+
+TRACE_EVENT(802154_drv_set_lbt_mode,
+	TP_PROTO(struct ieee802154_local *local, bool mode),
+	TP_ARGS(local, mode),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(bool, mode)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->mode = mode;
+	),
+	TP_printk(LOCAL_PR_FMT ", lbt mode: %s", LOCAL_PR_ARG,
+		  BOOL_TO_STR(__entry->mode))
+);
+
+TRACE_EVENT(802154_drv_set_short_addr,
+	TP_PROTO(struct ieee802154_local *local, __le16 short_addr),
+	TP_ARGS(local, short_addr),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(__le16, short_addr)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->short_addr = short_addr;
+	),
+	TP_printk(LOCAL_PR_FMT ", sa: 0x%04x", LOCAL_PR_ARG,
+		  le16_to_cpu(__entry->short_addr))
+);
+
+TRACE_EVENT(802154_drv_set_pan_id,
+	TP_PROTO(struct ieee802154_local *local, __le16 pan_id),
+	TP_ARGS(local, pan_id),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(__le16, pan_id)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->pan_id = pan_id;
+	),
+	TP_printk(LOCAL_PR_FMT ", pan id: 0x%04x", LOCAL_PR_ARG,
+		  le16_to_cpu(__entry->pan_id))
+);
+
+TRACE_EVENT(802154_drv_set_extended_addr,
+	TP_PROTO(struct ieee802154_local *local, __le64 extended_addr),
+	TP_ARGS(local, extended_addr),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(__le64, extended_addr)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->extended_addr = extended_addr;
+	),
+	TP_printk(LOCAL_PR_FMT ", extended addr: 0x%llx", LOCAL_PR_ARG,
+		  le64_to_cpu(__entry->extended_addr))
+);
+
+TRACE_EVENT(802154_drv_set_pan_coord,
+	TP_PROTO(struct ieee802154_local *local, bool is_coord),
+	TP_ARGS(local, is_coord),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(bool, is_coord)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->is_coord = is_coord;
+	),
+	TP_printk(LOCAL_PR_FMT ", is_coord: %s", LOCAL_PR_ARG,
+		  BOOL_TO_STR(__entry->is_coord))
+);
+
+TRACE_EVENT(802154_drv_set_csma_params,
+	TP_PROTO(struct ieee802154_local *local, u8 min_be, u8 max_be,
+		 u8 max_csma_backoffs),
+	TP_ARGS(local, min_be, max_be, max_csma_backoffs),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u8, min_be)
+		__field(u8, max_be)
+		__field(u8, max_csma_backoffs)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN,
+		__entry->min_be = min_be;
+		__entry->max_be = max_be;
+		__entry->max_csma_backoffs = max_csma_backoffs;
+	),
+	TP_printk(LOCAL_PR_FMT ", min be: %d, max be: %d, max csma backoffs: %d",
+		  LOCAL_PR_ARG, __entry->min_be, __entry->max_be,
+		  __entry->max_csma_backoffs)
+);
+
+TRACE_EVENT(802154_drv_set_max_frame_retries,
+	TP_PROTO(struct ieee802154_local *local, s8 max_frame_retries),
+	TP_ARGS(local, max_frame_retries),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(s8, max_frame_retries)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->max_frame_retries = max_frame_retries;
+	),
+	TP_printk(LOCAL_PR_FMT ", max frame retries: %d", LOCAL_PR_ARG,
+		  __entry->max_frame_retries)
+);
+
+TRACE_EVENT(802154_drv_set_promiscuous_mode,
+	TP_PROTO(struct ieee802154_local *local, bool on),
+	TP_ARGS(local, on),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(bool, on)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->on = on;
+	),
+	TP_printk(LOCAL_PR_FMT ", promiscuous mode: %s", LOCAL_PR_ARG,
+		  BOOL_TO_STR(__entry->on))
+);
+
+#endif /* !__MAC802154_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
1.7.9.5

