Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:63291 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbaIZIGY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Sep 2014 04:06:24 -0400
Received: by mail-we0-f181.google.com with SMTP id w61so7243511wes.26
        for <linux-wpan@vger.kernel.org>; Fri, 26 Sep 2014 01:06:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/3] info: add support to dump phy pib
Date: Fri, 26 Sep 2014 10:06:08 +0200
Message-Id: <1411718769-1986-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
References: <1411718769-1986-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/Makefile.am |   1 +
 src/info.c      | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/iwpan.h     |   3 ++
 src/nl802154.h  |   7 ++++
 src/nl_extras.h |   5 +++
 5 files changed, 124 insertions(+)
 create mode 100644 src/info.c

diff --git a/src/Makefile.am b/src/Makefile.am
index b702c91..26f73b8 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,6 +4,7 @@ bin_PROGRAMS = \
 iwpan_SOURCES = \
 	iwpan.c \
 	sections.c \
+	info.c \
 	interface.c \
 	phy.c \
 	mac.c
diff --git a/src/info.c b/src/info.c
new file mode 100644
index 0000000..6bbe3f0
--- /dev/null
+++ b/src/info.c
@@ -0,0 +1,108 @@
+#include <stdbool.h>
+#include <errno.h>
+#include <net/if.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "nl802154.h"
+#include "nl_extras.h"
+#include "iwpan.h"
+
+static int print_phy_handler(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	int rem_page, i;
+	int64_t phy_id = -1;
+	bool print_name = true;
+	struct nlattr *nl_page;
+	unsigned long cca_mode;
+
+	nla_parse(tb_msg, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (tb_msg[NL802154_ATTR_WPAN_PHY]) {
+		if (nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]) == phy_id)
+			print_name = false;
+		phy_id = nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]);
+	}
+	if (print_name && tb_msg[NL802154_ATTR_WPAN_PHY_NAME])
+		printf("wpan_phy %s\n", nla_get_string(tb_msg[NL802154_ATTR_WPAN_PHY_NAME]));
+
+	if (tb_msg[NL802154_ATTR_CHANNELS_SUPPORTED]) {
+		unsigned char page = 0;
+		unsigned long channel;
+		printf("supported channels:\n");
+		nla_for_each_nested(nl_page,
+				    tb_msg[NL802154_ATTR_CHANNELS_SUPPORTED],
+				    rem_page) {
+			channel = nla_get_u32(nl_page);
+			if (channel) {
+				printf("\tpage %d: ", page, channel);
+				for (i = 0; i <= 31; i++) {
+					if (channel & 0x1)
+						printf("%d,", i);
+					channel >>= 1;
+				}
+				/* TODO hack use sprintf here */
+				printf("\b \b\n");
+			}
+			page++;
+		}
+	}
+
+	if (tb_msg[NL802154_ATTR_PAGE])
+		printf("current_page: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_PAGE]));
+
+	if (tb_msg[NL802154_ATTR_CHANNEL])
+		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+
+	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
+		cca_mode = nla_get_u8(tb_msg[NL802154_ATTR_CCA_MODE]);
+		printf("cca_mode: %d", cca_mode);
+		if (cca_mode == 3) {
+			if (nla_get_u8(tb_msg[NL802154_ATTR_CCA_MODE3_AND]))
+				printf(" AND ");
+			else
+				printf(" OR ");
+		}
+		printf("\n");
+	}
+
+	if (tb_msg[NL802154_ATTR_TX_POWER])
+		printf("tx_power: %d\n", nla_get_s8(tb_msg[NL802154_ATTR_TX_POWER]));
+
+	return 0;
+}
+
+static bool nl802154_has_split_wiphy = false;
+
+static int handle_info(struct nl802154_state *state,
+		       struct nl_cb *cb,
+		       struct nl_msg *msg,
+		       int argc, char **argv,
+		       enum id_input id)
+{
+	char *feat_args[] = { "features", "-q" };
+	int err;
+
+	err = handle_cmd(state, CIB_NONE, 2, feat_args);
+	if (!err && nl802154_has_split_wiphy) {
+		nla_put_flag(msg, NL802154_ATTR_SPLIT_WPAN_PHY_DUMP);
+		nlmsg_hdr(msg)->nlmsg_flags |= NLM_F_DUMP;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_phy_handler, NULL);
+
+	return 0;
+}
+
+__COMMAND(NULL, info, "info", NULL, NL802154_CMD_GET_WPAN_PHY, 0, 0, CIB_PHY, handle_info,
+	  "Show capabilities for the specified wireless device.", NULL);
+TOPLEVEL(list, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info,
+	 "List all wireless devices and their capabilities.");
+TOPLEVEL(phy, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info, NULL);
diff --git a/src/iwpan.h b/src/iwpan.h
index d35bd7a..867bb18 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -107,6 +107,9 @@ struct cmd {
 #define DECLARE_SECTION(_name)						\
 	extern struct cmd __section ## _ ## _name;
 
+int handle_cmd(struct nl802154_state *state, enum id_input idby,
+	       int argc, char **argv);
+
 DECLARE_SECTION(set);
 DECLARE_SECTION(get);
 
diff --git a/src/nl802154.h b/src/nl802154.h
index a30e9c0..2e3ec28 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -79,6 +79,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_IFACE_SOCKET_OWNER,
 
+	NL802154_ATTR_SPLIT_WPAN_PHY_DUMP,
+
 	NL802154_ATTR_PAGE,
 	NL802154_ATTR_CHANNEL,
 
@@ -99,6 +101,11 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_LBT_MODE,
 
+	NL802154_ATTR_GENERATION,
+
+	NL802154_ATTR_CHANNELS_SUPPORTED,
+	NL802154_ATTR_SUPPORTED_CHANNEL,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
diff --git a/src/nl_extras.h b/src/nl_extras.h
index 39a97c6..a591461 100644
--- a/src/nl_extras.h
+++ b/src/nl_extras.h
@@ -7,6 +7,11 @@
 #define NLA_PUT_S8(n, attrtype, value) \
 	NLA_PUT_TYPE(n, int8_t, attrtype, value)
 
+static inline int8_t nla_get_s8(struct nlattr *nla)
+{
+	return *(int8_t *) nla_data(nla);
+}
+
 #endif /* NLA_S8 */
 
 #ifndef NLA_S16
-- 
2.1.0

