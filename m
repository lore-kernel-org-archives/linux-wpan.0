Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33685 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbaIZIGZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 04:06:25 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so779192wgh.3
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 01:06:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 3/3] interface: add dump for iface mac parameters
Date: Fri, 26 Sep 2014 10:06:09 +0200
Message-Id: <1411718769-1986-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
References: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/interface.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/nl802154.h  |   2 ++
 2 files changed, 103 insertions(+)

diff --git a/src/interface.c b/src/interface.c
index e3253c4..808b246 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -10,10 +10,28 @@
 #include <netlink/attr.h>
 
 #include "nl802154.h"
+#include "nl_extras.h"
 #include "iwpan.h"
 
 SECTION(interface);
 
+static char modebuf[100];
+
+const char *iftype_name(enum nl802154_iftype iftype)
+{
+	switch (iftype) {
+	case NL802154_IFTYPE_MONITOR:
+		return "monitor";
+	case NL802154_IFTYPE_NODE:
+		return "node";
+	case NL802154_IFTYPE_COORD:
+		return "coordinator";
+	default:
+		sprintf(modebuf, "Unknown mode (%d)", iftype);
+		return modebuf;
+	}
+}
+
 /* for help */
 #define IFACE_TYPES "Valid interface types are: node, monitor, coordinator."
 
@@ -98,3 +116,86 @@ static int handle_interface_del(struct nl802154_state *state,
 TOPLEVEL(del, NULL, NL802154_CMD_DEL_INTERFACE, 0, CIB_NETDEV, handle_interface_del,
 	 "Remove this virtual interface");
 HIDDEN(interface, del, NULL, NL802154_CMD_DEL_INTERFACE, 0, CIB_NETDEV, handle_interface_del);
+
+static int print_iface_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
+	unsigned int *wpan_phy = arg;
+	const char *indent = "";
+
+	nla_parse(tb_msg, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY]) {
+		unsigned int thiswpan_phy = nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]);
+		indent = "\t";
+		if (*wpan_phy != thiswpan_phy)
+			printf("phy#%d\n", thiswpan_phy);
+		*wpan_phy = thiswpan_phy;
+	}
+
+	if (tb_msg[NL802154_ATTR_IFNAME])
+		printf("%sInterface %s\n", indent, nla_get_string(tb_msg[NL802154_ATTR_IFNAME]));
+	else
+		printf("%sUnnamed/non-netdev interface\n", indent);
+
+	if (tb_msg[NL802154_ATTR_IFINDEX])
+		printf("%s\tifindex %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_IFINDEX]));
+	if (tb_msg[NL802154_ATTR_WPAN_DEV])
+		printf("%s\twpan_dev 0x%llx\n", indent,
+		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
+	/* TODO byteorder? */
+	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
+		printf("%s\textended_addr 0x%016llx\n", indent, nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR]));
+	/* TODO byteorder? */
+	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
+		printf("%s\tshort_addr 0x%04x\n", indent, nla_get_u16(tb_msg[NL802154_ATTR_SHORT_ADDR]));
+	/* TODO byteorder? */
+	if (tb_msg[NL802154_ATTR_PAN_ID])
+		printf("%s\tpan_id 0x%04x\n", indent, nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID]));
+	if (tb_msg[NL802154_ATTR_IFTYPE])
+		printf("%s\ttype %s\n", indent, iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
+	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
+		printf("%s\twpan_phy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
+	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
+		printf("%s\tmax_frame_retries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
+	if (tb_msg[NL802154_ATTR_MAX_BE])
+		printf("%s\tmax_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_BE]));
+	if (tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS])
+		printf("%s\tmax_csma_backoffs %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS]));
+	if (tb_msg[NL802154_ATTR_MIN_BE])
+		printf("%s\tmin_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MIN_BE]));
+	if (tb_msg[NL802154_ATTR_LBT_MODE])
+		printf("%s\tlbt %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_LBT_MODE]));
+
+	return NL_SKIP;
+}
+
+static int handle_interface_info(struct nl802154_state *state,
+				 struct nl_cb *cb,
+				 struct nl_msg *msg,
+				 int argc, char **argv,
+				 enum id_input id)
+{
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_iface_handler, NULL);
+	return 0;
+}
+
+TOPLEVEL(info, NULL, NL802154_CMD_GET_INTERFACE, 0, CIB_NETDEV, handle_interface_info,
+	 "Show information for this interface.");
+
+static unsigned int dev_dump_wpan_phy;
+
+static int handle_dev_dump(struct nl802154_state *state,
+			   struct nl_cb *cb,
+			   struct nl_msg *msg,
+			   int argc, char **argv,
+			   enum id_input id)
+{
+	dev_dump_wpan_phy = -1;
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_iface_handler, &dev_dump_wpan_phy);
+	return 0;
+}
+TOPLEVEL(dev, NULL, NL802154_CMD_GET_INTERFACE, NLM_F_DUMP, CIB_NONE, handle_dev_dump,
+	 "List all network interfaces for wireless hardware.");
diff --git a/src/nl802154.h b/src/nl802154.h
index 2e3ec28..f799d59 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -106,6 +106,8 @@ enum nl802154_attrs {
 	NL802154_ATTR_CHANNELS_SUPPORTED,
 	NL802154_ATTR_SUPPORTED_CHANNEL,
 
+	NL802154_ATTR_EXTENDED_ADDR,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
-- 
2.1.0

