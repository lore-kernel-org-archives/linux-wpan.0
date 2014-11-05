Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38846 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaKETwJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:09 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so1749942wgg.32
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:07 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/18] ieee802154: remove nl802154 unused functions
Date: Wed,  5 Nov 2014 20:51:13 +0100
Message-Id: <1415217089-24919-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The include/net/nl802154.h file contains a lot of prototypes which are
not used inside of ieee802154 subsystem. This patch removes this file
and make the only one used prototype "ieee802154_nl_start_confirm" as
static declaration in ieee802154/nl-mac.c

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 MAINTAINERS             |   1 -
 include/net/nl802154.h  | 122 -------------------------------
 net/ieee802154/nl-mac.c | 187 ++----------------------------------------------
 net/mac802154/mac_cmd.c |   6 --
 4 files changed, 6 insertions(+), 310 deletions(-)
 delete mode 100644 include/net/nl802154.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ec37a3..b42eb50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4699,7 +4699,6 @@ F:	net/mac802154/
 F:	drivers/net/ieee802154/
 F:	include/linux/nl802154.h
 F:	include/linux/ieee802154.h
-F:	include/net/nl802154.h
 F:	include/net/mac802154.h
 F:	include/net/af_ieee802154.h
 F:	include/net/cfg802154.h
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
deleted file mode 100644
index b5cdea2..0000000
--- a/include/net/nl802154.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * nl802154.h
- *
- * Copyright (C) 2007, 2008, 2009 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef IEEE802154_NL_H
-#define IEEE802154_NL_H
-
-struct net_device;
-struct ieee802154_addr;
-
-/**
- * ieee802154_nl_assoc_indic - Notify userland of an association request.
- * @dev: The network device on which this association request was
- *       received.
- * @addr: The address of the device requesting association.
- * @cap: The capability information field from the device.
- *
- * This informs a userland coordinator of a device requesting to
- * associate with the PAN controlled by the coordinator.
- *
- * Note: This is in section 7.3.1 of the IEEE 802.15.4-2006 document.
- */
-int ieee802154_nl_assoc_indic(struct net_device *dev,
-		struct ieee802154_addr *addr, u8 cap);
-
-/**
- * ieee802154_nl_assoc_confirm - Notify userland of association.
- * @dev: The device which has completed association.
- * @short_addr: The short address assigned to the device.
- * @status: The status of the association.
- *
- * Inform userland of the result of an association request. If the
- * association request included asking the coordinator to allocate
- * a short address then it is returned in @short_addr.
- *
- * Note: This is in section 7.3.2 of the IEEE 802.15.4 document.
- */
-int ieee802154_nl_assoc_confirm(struct net_device *dev,
-		__le16 short_addr, u8 status);
-
-/**
- * ieee802154_nl_disassoc_indic - Notify userland of disassociation.
- * @dev: The device on which disassociation was indicated.
- * @addr: The device which is disassociating.
- * @reason: The reason for the disassociation.
- *
- * Inform userland that a device has disassociated from the network.
- *
- * Note: This is in section 7.3.3 of the IEEE 802.15.4 document.
- */
-int ieee802154_nl_disassoc_indic(struct net_device *dev,
-		struct ieee802154_addr *addr, u8 reason);
-
-/**
- * ieee802154_nl_disassoc_confirm - Notify userland of disassociation
- * completion.
- * @dev: The device on which disassociation was ordered.
- * @status: The result of the disassociation.
- *
- * Inform userland of the result of requesting that a device
- * disassociate, or the result of requesting that we disassociate from
- * a PAN managed by another coordinator.
- *
- * Note: This is in section 7.1.4.3 of the IEEE 802.15.4 document.
- */
-int ieee802154_nl_disassoc_confirm(struct net_device *dev,
-		u8 status);
-
-/**
- * ieee802154_nl_scan_confirm - Notify userland of completion of scan.
- * @dev: The device which was instructed to scan.
- * @status: The status of the scan operation.
- * @scan_type: What type of scan was performed.
- * @unscanned: Any channels that the device was unable to scan.
- * @edl: The energy levels (if a passive scan).
- *
- *
- * Note: This is in section 7.1.11 of the IEEE 802.15.4 document.
- * Note: This API does not permit the return of an active scan result.
- */
-int ieee802154_nl_scan_confirm(struct net_device *dev,
-		u8 status, u8 scan_type, u32 unscanned, u8 page,
-		u8 *edl/*, struct list_head *pan_desc_list */);
-
-/**
- * ieee802154_nl_beacon_indic - Notify userland of a received beacon.
- * @dev: The device on which a beacon was received.
- * @panid: The PAN of the coordinator.
- * @coord_addr: The short address of the coordinator on that PAN.
- *
- * Note: This is in section 7.1.5 of the IEEE 802.15.4 document.
- * Note: This API does not provide extended information such as what
- * channel the PAN is on or what the LQI of the beacon frame was on
- * receipt.
- * Note: This API cannot indicate a beacon frame for a coordinator
- *       operating in long addressing mode.
- */
-int ieee802154_nl_beacon_indic(struct net_device *dev, __le16 panid,
-		__le16 coord_addr);
-
-/**
- * ieee802154_nl_start_confirm - Notify userland of completion of start.
- * @dev: The device which was instructed to scan.
- * @status: The status of the scan operation.
- *
- * Note: This is in section 7.1.14 of the IEEE 802.15.4 document.
- */
-int ieee802154_nl_start_confirm(struct net_device *dev, u8 status);
-
-#endif
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index cc2919d..91a1855 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -29,7 +29,6 @@
 #include <linux/nl802154.h>
 #include <linux/export.h>
 #include <net/af_ieee802154.h>
-#include <net/nl802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
 
@@ -55,186 +54,7 @@ static __le16 nla_get_shortaddr(const struct nlattr *nla)
 	return cpu_to_le16(nla_get_u16(nla));
 }
 
-int ieee802154_nl_assoc_indic(struct net_device *dev,
-			      struct ieee802154_addr *addr,
-			      u8 cap)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	if (addr->mode != IEEE802154_ADDR_LONG) {
-		pr_err("%s: received non-long source address!\n", __func__);
-		return -EINVAL;
-	}
-
-	msg = ieee802154_nl_create(0, IEEE802154_ASSOCIATE_INDIC);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr) ||
-	    nla_put_hwaddr(msg, IEEE802154_ATTR_SRC_HW_ADDR,
-			   addr->extended_addr) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_CAPABILITY, cap))
-		goto nla_put_failure;
-
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_assoc_indic);
-
-int ieee802154_nl_assoc_confirm(struct net_device *dev, __le16 short_addr,
-				u8 status)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	msg = ieee802154_nl_create(0, IEEE802154_ASSOCIATE_CONF);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr) ||
-	    nla_put_shortaddr(msg, IEEE802154_ATTR_SHORT_ADDR, short_addr) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_STATUS, status))
-		goto nla_put_failure;
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_assoc_confirm);
-
-int ieee802154_nl_disassoc_indic(struct net_device *dev,
-				 struct ieee802154_addr *addr,
-				 u8 reason)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	msg = ieee802154_nl_create(0, IEEE802154_DISASSOCIATE_INDIC);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr))
-		goto nla_put_failure;
-	if (addr->mode == IEEE802154_ADDR_LONG) {
-		if (nla_put_hwaddr(msg, IEEE802154_ATTR_SRC_HW_ADDR,
-				   addr->extended_addr))
-			goto nla_put_failure;
-	} else {
-		if (nla_put_shortaddr(msg, IEEE802154_ATTR_SRC_SHORT_ADDR,
-				      addr->short_addr))
-			goto nla_put_failure;
-	}
-	if (nla_put_u8(msg, IEEE802154_ATTR_REASON, reason))
-		goto nla_put_failure;
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_disassoc_indic);
-
-int ieee802154_nl_disassoc_confirm(struct net_device *dev, u8 status)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	msg = ieee802154_nl_create(0, IEEE802154_DISASSOCIATE_CONF);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_STATUS, status))
-		goto nla_put_failure;
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_disassoc_confirm);
-
-int ieee802154_nl_beacon_indic(struct net_device *dev, __le16 panid,
-			       __le16 coord_addr)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	msg = ieee802154_nl_create(0, IEEE802154_BEACON_NOTIFY_INDIC);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr) ||
-	    nla_put_shortaddr(msg, IEEE802154_ATTR_COORD_SHORT_ADDR,
-			      coord_addr) ||
-	    nla_put_shortaddr(msg, IEEE802154_ATTR_COORD_PAN_ID, panid))
-		goto nla_put_failure;
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_beacon_indic);
-
-int ieee802154_nl_scan_confirm(struct net_device *dev,
-			       u8 status, u8 scan_type,
-			       u32 unscanned, u8 page,
-			       u8 *edl/* , struct list_head *pan_desc_list */)
-{
-	struct sk_buff *msg;
-
-	pr_debug("%s\n", __func__);
-
-	msg = ieee802154_nl_create(0, IEEE802154_SCAN_CONF);
-	if (!msg)
-		return -ENOBUFS;
-
-	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_DEV_INDEX, dev->ifindex) ||
-	    nla_put(msg, IEEE802154_ATTR_HW_ADDR, IEEE802154_ADDR_LEN,
-		    dev->dev_addr) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_STATUS, status) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_SCAN_TYPE, scan_type) ||
-	    nla_put_u32(msg, IEEE802154_ATTR_CHANNELS, unscanned) ||
-	    nla_put_u8(msg, IEEE802154_ATTR_PAGE, page) ||
-	    (edl &&
-	     nla_put(msg, IEEE802154_ATTR_ED_LIST, 27, edl)))
-		goto nla_put_failure;
-	return ieee802154_nl_mcast(msg, IEEE802154_COORD_MCGRP);
-
-nla_put_failure:
-	nlmsg_free(msg);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(ieee802154_nl_scan_confirm);
-
-int ieee802154_nl_start_confirm(struct net_device *dev, u8 status)
+static int ieee802154_nl_start_confirm(struct net_device *dev, u8 status)
 {
 	struct sk_buff *msg;
 
@@ -530,6 +350,11 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 	ret = ieee802154_mlme_ops(dev)->start_req(dev, &addr, channel, page,
 		bcn_ord, sf_ord, pan_coord, blx, coord_realign);
 
+	/* FIXME: add validation for unused parameters to be sane
+	 * for SoftMAC
+	 */
+	ieee802154_nl_start_confirm(dev, IEEE802154_SUCCESS);
+
 out:
 	dev_put(dev);
 	return ret;
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 9c2d6f6..e1ad83e 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -25,7 +25,6 @@
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
-#include <net/nl802154.h>
 
 #include "ieee802154_i.h"
 #include "driver-ops.h"
@@ -65,11 +64,6 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 		rc = ops->llsec->set_params(dev, &params, changed);
 	}
 
-	/* FIXME: add validation for unused parameters to be sane
-	 * for SoftMAC
-	 */
-	ieee802154_nl_start_confirm(dev, IEEE802154_SUCCESS);
-
 	return rc;
 }
 
-- 
2.1.3

