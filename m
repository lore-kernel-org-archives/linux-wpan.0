Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:54645 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbDTSha (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 14:37:30 -0400
Received: from honk.sigxcpu.org (localhost [127.0.0.1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 45FD3695
	for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 20:37:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id DE19CFB03
	for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 20:37:28 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIXXvgB1qwQU for <linux-wpan@vger.kernel.org>;
	Mon, 20 Apr 2015 20:37:26 +0200 (CEST)
Date: Mon, 20 Apr 2015 20:36:56 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2] ieee802154: Add trace events for rdev->ops
Message-ID: <20150420183656.GC5248@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Enabling tracing via

 echo 1 > /sys/kernel/debug/tracing/events/cfg802154/enable

enables event tracing like

 iwpan dev wpan0 set pan_id 0xbeef
 cat /sys/kernel/debug/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:1
 #
 #                              _-----=> irqs-off
 #                             / _----=> need-resched
 #                            | / _---=> hardirq/softirq
 #                            || / _--=> preempt-depth
 #                            ||| /     delay
 #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
 #              | |       |   ||||       |         |
            iwpan-2663  [000] ....   170.369142: 802154_rdev_set_pan_id: phy0, wpan_dev(1), pan id: 0xbeef
            iwpan-2663  [000] ....   170.369177: 802154_rdev_return_int: phy0, returned: 0

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Changes from v1:
    * delay __le16_to_cpu until we print the argument
    * detail usage in ChangeLog

 net/ieee802154/Makefile   |   4 +-
 net/ieee802154/rdev-ops.h |  77 ++++++++++++---
 net/ieee802154/trace.c    |   7 ++
 net/ieee802154/trace.h    | 246 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 322 insertions(+), 12 deletions(-)
 create mode 100644 net/ieee802154/trace.c
 create mode 100644 net/ieee802154/trace.h

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 05dab29..4adfd4d 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -3,7 +3,9 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
 obj-y += 6lowpan/
 
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
-                header_ops.o sysfs.o nl802154.o
+                header_ops.o sysfs.o nl802154.o trace.o
 ieee802154_socket-y := socket.o
 
+CFLAGS_trace.o := -I$(src)
+
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 7c46732..624413e 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -4,6 +4,7 @@
 #include <net/cfg802154.h>
 
 #include "core.h"
+#include "trace.h"
 
 static inline struct net_device *
 rdev_add_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
@@ -24,73 +25,127 @@ static inline int
 rdev_add_virtual_intf(struct cfg802154_registered_device *rdev, char *name,
 		      enum nl802154_iftype type, __le64 extended_addr)
 {
-	return rdev->ops->add_virtual_intf(&rdev->wpan_phy, name, type,
+	int ret;
+
+	trace_802154_rdev_add_virtual_intf(&rdev->wpan_phy, name, type,
 					   extended_addr);
+	ret = rdev->ops->add_virtual_intf(&rdev->wpan_phy, name, type,
+					  extended_addr);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_del_virtual_intf(struct cfg802154_registered_device *rdev,
 		      struct wpan_dev *wpan_dev)
 {
-	return rdev->ops->del_virtual_intf(&rdev->wpan_phy, wpan_dev);
+	int ret;
+
+	trace_802154_rdev_del_virtual_intf(&rdev->wpan_phy, wpan_dev);
+	ret = rdev->ops->del_virtual_intf(&rdev->wpan_phy, wpan_dev);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 {
-	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
+	int ret;
+
+	trace_802154_rdev_set_channel(&rdev->wpan_phy, page, channel);
+	ret = rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
 		  const struct wpan_phy_cca *cca)
 {
-	return rdev->ops->set_cca_mode(&rdev->wpan_phy, cca);
+	int ret;
+
+	trace_802154_rdev_set_cca_mode(&rdev->wpan_phy, cca);
+	ret = rdev->ops->set_cca_mode(&rdev->wpan_phy, cca);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_pan_id(struct cfg802154_registered_device *rdev,
 		struct wpan_dev *wpan_dev, __le16 pan_id)
 {
-	return rdev->ops->set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
+	int ret;
+
+	trace_802154_rdev_set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
+	ret = rdev->ops->set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_short_addr(struct cfg802154_registered_device *rdev,
 		    struct wpan_dev *wpan_dev, __le16 short_addr)
 {
-	return rdev->ops->set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
+	int ret;
+
+	trace_802154_rdev_set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
+	ret = rdev->ops->set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_backoff_exponent(struct cfg802154_registered_device *rdev,
 			  struct wpan_dev *wpan_dev, u8 min_be, u8 max_be)
 {
-	return rdev->ops->set_backoff_exponent(&rdev->wpan_phy, wpan_dev,
+	int ret;
+
+	trace_802154_rdev_set_backoff_exponent(&rdev->wpan_phy, wpan_dev,
 					       min_be, max_be);
+	ret = rdev->ops->set_backoff_exponent(&rdev->wpan_phy, wpan_dev,
+					      min_be, max_be);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_max_csma_backoffs(struct cfg802154_registered_device *rdev,
 			   struct wpan_dev *wpan_dev, u8 max_csma_backoffs)
 {
-	return rdev->ops->set_max_csma_backoffs(&rdev->wpan_phy, wpan_dev,
-						max_csma_backoffs);
+	int ret;
+
+	trace_802154_rdev_set_csma_backoffs(&rdev->wpan_phy, wpan_dev,
+					    max_csma_backoffs);
+	ret = rdev->ops->set_max_csma_backoffs(&rdev->wpan_phy, wpan_dev,
+					       max_csma_backoffs);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_max_frame_retries(struct cfg802154_registered_device *rdev,
 			   struct wpan_dev *wpan_dev, s8 max_frame_retries)
 {
-	return rdev->ops->set_max_frame_retries(&rdev->wpan_phy, wpan_dev,
+	int ret;
+
+	trace_802154_rdev_set_max_frame_retries(&rdev->wpan_phy, wpan_dev,
 						max_frame_retries);
+	ret = rdev->ops->set_max_frame_retries(&rdev->wpan_phy, wpan_dev,
+					       max_frame_retries);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 static inline int
 rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
 		  struct wpan_dev *wpan_dev, bool mode)
 {
-	return rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
+	int ret;
+
+	trace_802154_rdev_set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
+	ret = rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
 }
 
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/ieee802154/trace.c b/net/ieee802154/trace.c
new file mode 100644
index 0000000..95f997f
--- /dev/null
+++ b/net/ieee802154/trace.c
@@ -0,0 +1,7 @@
+#include <linux/module.h>
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#endif
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
new file mode 100644
index 0000000..8ed9f97
--- /dev/null
+++ b/net/ieee802154/trace.h
@@ -0,0 +1,246 @@
+/* Based on net/wireless/tracing.h */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cfg802154
+
+#if !defined(__RDEV_CFG802154_OPS_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __RDEV_CFG802154_OPS_TRACE
+
+#include <linux/tracepoint.h>
+
+#include <net/cfg802154.h>
+
+#define MAXNAME		32
+#define WPAN_PHY_ENTRY	__array(char, wpan_phy_name, MAXNAME)
+#define WPAN_PHY_ASSIGN	strlcpy(__entry->wpan_phy_name,	 \
+				wpan_phy_name(wpan_phy), \
+				MAXNAME)
+#define WPAN_PHY_PR_FMT	"%s"
+#define WPAN_PHY_PR_ARG	__entry->wpan_phy_name
+
+#define WPAN_DEV_ENTRY	__field(u32, identifier)
+#define WPAN_DEV_ASSIGN	(__entry->identifier) = (!IS_ERR_OR_NULL(wpan_dev) \
+					 ? wpan_dev->identifier : 0)
+#define WPAN_DEV_PR_FMT	"wpan_dev(%u)"
+#define WPAN_DEV_PR_ARG	(__entry->identifier)
+
+#define WPAN_CCA_ENTRY	__field(enum nl802154_cca_modes, cca_mode) \
+			__field(enum nl802154_cca_opts, cca_opt)
+#define WPAN_CCA_ASSIGN \
+	do {					 \
+		(__entry->cca_mode) = cca->mode; \
+		(__entry->cca_opt) = cca->opt;	 \
+	} while (0)
+#define WPAN_CCA_PR_FMT	"cca_mode: %d, cca_opt: %d"
+#define WPAN_CCA_PR_ARG __entry->cca_mode, __entry->cca_opt
+
+#define BOOL_TO_STR(bo) (bo) ? "true" : "false"
+
+/*************************************************************
+ *			rdev->ops traces		     *
+ *************************************************************/
+
+TRACE_EVENT(802154_rdev_add_virtual_intf,
+	TP_PROTO(struct wpan_phy *wpan_phy, char *name,
+		 enum nl802154_iftype type, __le64 extended_addr),
+	TP_ARGS(wpan_phy, name, type, extended_addr),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__string(vir_intf_name, name ? name : "<noname>")
+		__field(enum nl802154_iftype, type)
+		__field(__le64, extended_addr)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__assign_str(vir_intf_name, name ? name : "<noname>");
+		__entry->type = type;
+		__entry->extended_addr = extended_addr;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, ea %llx",
+		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
+		  __entry->extended_addr)
+);
+
+TRACE_EVENT(802154_rdev_del_virtual_intf,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev),
+	TP_ARGS(wpan_phy, wpan_dev),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT, WPAN_PHY_PR_ARG,
+		  WPAN_DEV_PR_ARG)
+);
+
+TRACE_EVENT(802154_rdev_set_channel,
+	TP_PROTO(struct wpan_phy *wpan_phy, u8 page, u8 channel),
+	TP_ARGS(wpan_phy, page, channel),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(u8, page)
+		__field(u8, channel)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->page = page;
+		__entry->channel = channel;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", page: %d, channel: %d", WPAN_PHY_PR_ARG,
+		  __entry->page, __entry->channel)
+);
+
+TRACE_EVENT(802154_rdev_set_cca_mode,
+	TP_PROTO(struct wpan_phy *wpan_phy, const struct wpan_phy_cca *cca),
+	TP_ARGS(wpan_phy, cca),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_CCA_ENTRY
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_CCA_ASSIGN;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_CCA_PR_FMT, WPAN_PHY_PR_ARG,
+		  WPAN_CCA_PR_ARG)
+);
+
+DECLARE_EVENT_CLASS(802154_le16_template,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 __le16 le16arg),
+	TP_ARGS(wpan_phy, wpan_dev, le16arg),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(__le16, le16arg)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->le16arg = le16arg;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", pan id: 0x%04x",
+		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG,
+		  __le16_to_cpu(__entry->le16arg))
+);
+
+DEFINE_EVENT(802154_le16_template, 802154_rdev_set_pan_id,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 __le16 le16arg),
+	TP_ARGS(wpan_phy, wpan_dev, le16arg)
+);
+
+DEFINE_EVENT_PRINT(802154_le16_template, 802154_rdev_set_short_addr,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 __le16 le16arg),
+	TP_ARGS(wpan_phy, wpan_dev, le16arg),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", sa: 0x%04x",
+		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG, __entry->le16arg)
+);
+
+TRACE_EVENT(802154_rdev_set_backoff_exponent,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 u8 min_be, u8 max_be),
+	TP_ARGS(wpan_phy, wpan_dev, min_be, max_be),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(u8, min_be)
+		__field(u8, max_be)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->min_be = min_be;
+		__entry->max_be = max_be;
+	),
+
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
+		  ", min be: %d, max_be: %d", WPAN_PHY_PR_ARG,
+		  WPAN_DEV_PR_ARG, __entry->min_be, __entry->max_be)
+);
+
+TRACE_EVENT(802154_rdev_set_csma_backoffs,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 u8 max_csma_backoffs),
+	TP_ARGS(wpan_phy, wpan_dev, max_csma_backoffs),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(u8, max_csma_backoffs)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->max_csma_backoffs = max_csma_backoffs;
+	),
+
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
+		  ", max csma backoffs: %d", WPAN_PHY_PR_ARG,
+		  WPAN_DEV_PR_ARG, __entry->max_csma_backoffs)
+);
+
+TRACE_EVENT(802154_rdev_set_max_frame_retries,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 s8 max_frame_retries),
+	TP_ARGS(wpan_phy, wpan_dev, max_frame_retries),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(s8, max_frame_retries)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->max_frame_retries = max_frame_retries;
+	),
+
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
+		  ", max frame retries: %d", WPAN_PHY_PR_ARG,
+		  WPAN_DEV_PR_ARG, __entry->max_frame_retries)
+);
+
+TRACE_EVENT(802154_rdev_set_lbt_mode,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 bool mode),
+	TP_ARGS(wpan_phy, wpan_dev, mode),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(bool, mode)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->mode = mode;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
+		", lbt mode: %s", WPAN_PHY_PR_ARG,
+		WPAN_DEV_PR_ARG, BOOL_TO_STR(__entry->mode))
+);
+
+TRACE_EVENT(802154_rdev_return_int,
+	TP_PROTO(struct wpan_phy *wpan_phy, int ret),
+	TP_ARGS(wpan_phy, ret),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->ret = ret;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", returned: %d", WPAN_PHY_PR_ARG,
+		  __entry->ret)
+);
+
+#endif /* !__RDEV_CFG802154_OPS_TRACE || TRACE_HEADER_MULTI_READ */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.1.4
