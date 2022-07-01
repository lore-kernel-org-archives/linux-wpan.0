Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AA7C433EF
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiGAOiX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiGAOh6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:58 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038B3DA50
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:45 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 63C4520000B;
        Fri,  1 Jul 2022 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bb5v/Hsp0+jefA3mGLCm/+wQVouPCXtqwXFQo/gwD5E=;
        b=YN6Fo8+55nro/OVQuzRm7DtpAXW5GVQ6exWuMzFyQrFmS9xy90cbGIJwn874yQebl7Ssmg
        pNJwDYpWIkxxxum2Rj02bsoF1JFfyzf+D/aNQMcd9OzZFvRxcsR8cR5BfEklOmfDN3iElR
        UyOhCl3h6y23mVRRSTutg0qfxO4ReTxk766yagauYE5G1grsAoTTyH5VvLHqGqnUszKqK2
        GYK8PxE1s7qY6iFPXDU+/922tuAJ4j86ylGiTn+IToOIszEU2agF6ZFC1zqH6CL57EnTaN
        zcnSHx+1ZCi8qNZwELQi6I1egRhvQZI2/AIEoWweLI/JtIFv1HtDTHfIiYkv/g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 7/7] iwpan: Add events support
Date:   Fri,  1 Jul 2022 16:34:34 +0200
Message-Id: <20220701143434.1267864-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: David Girault <david.girault@qorvo.com>

Add the possibility to listen to the scan multicast netlink family in
order to print all the events happening in the 802.15.4 stack, like the
discovery of a new coordinator or an end of scan.

Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/Makefile.am |   1 +
 src/event.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/iwpan.h     |   3 +
 src/scan.c      |   5 +-
 4 files changed, 228 insertions(+), 3 deletions(-)
 create mode 100644 src/event.c

diff --git a/src/Makefile.am b/src/Makefile.am
index 18b3569..7933daf 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -10,6 +10,7 @@ iwpan_SOURCES = \
 	phy.c \
 	mac.c \
 	scan.c \
+	event.c \
 	nl_extras.h \
 	nl802154.h
 
diff --git a/src/event.c b/src/event.c
new file mode 100644
index 0000000..2eab144
--- /dev/null
+++ b/src/event.c
@@ -0,0 +1,222 @@
+#include <net/if.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <inttypes.h>
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
+struct print_event_args {
+	struct timeval ts; /* internal */
+	bool have_ts; /* must be set false */
+	bool frame, time, reltime;
+};
+
+static void parse_scan_terminated(struct nlattr **tb)
+{
+	struct nlattr *a;
+	if ((a = tb[NL802154_ATTR_SCAN_TYPE])) {
+		enum nl802154_scan_types st =
+			(enum nl802154_scan_types)nla_get_u8(a);
+		const char *stn = scantype_name(st);
+		printf(" type %s,", stn);
+	}
+	if ((a = tb[NL802154_ATTR_SCAN_FLAGS])) {
+		printf(" flags 0x%x,", nla_get_u32(a));
+	}
+	if ((a = tb[NL802154_ATTR_PAGE])) {
+		printf(" page %u,", nla_get_u8(a));
+	}
+	if ((a = tb[NL802154_ATTR_SCAN_CHANNELS])) {
+		printf(" channels mask 0x%x,", nla_get_u32(a));
+	}
+	/* TODO: show requested IEs */
+	if ((a = tb[NL802154_ATTR_COORDINATOR])) {
+		parse_scan_result_pan(a, tb[NL802154_ATTR_IFINDEX]);
+	}
+}
+
+static int print_event(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL802154_ATTR_MAX + 1], *nst;
+	struct print_event_args *args = arg;
+	char ifname[100];
+
+	uint8_t reg_type;
+	uint32_t wpan_phy_idx = 0;
+	int rem_nst;
+	uint16_t status;
+
+	if (args->time || args->reltime) {
+		unsigned long long usecs, previous;
+
+		previous = 1000000ULL * args->ts.tv_sec + args->ts.tv_usec;
+		gettimeofday(&args->ts, NULL);
+		usecs = 1000000ULL * args->ts.tv_sec + args->ts.tv_usec;
+		if (args->reltime) {
+			if (!args->have_ts) {
+				usecs = 0;
+				args->have_ts = true;
+			} else
+				usecs -= previous;
+		}
+		printf("%llu.%06llu: ", usecs/1000000, usecs % 1000000);
+	}
+
+	nla_parse(tb, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (tb[NL802154_ATTR_IFINDEX] && tb[NL802154_ATTR_WPAN_PHY]) {
+		if_indextoname(nla_get_u32(tb[NL802154_ATTR_IFINDEX]), ifname);
+		printf("%s (phy #%d): ", ifname, nla_get_u32(tb[NL802154_ATTR_WPAN_PHY]));
+	} else if (tb[NL802154_ATTR_WPAN_DEV] && tb[NL802154_ATTR_WPAN_PHY]) {
+		printf("wdev 0x%llx (phy #%d): ",
+			(unsigned long long)nla_get_u64(tb[NL802154_ATTR_WPAN_DEV]),
+			nla_get_u32(tb[NL802154_ATTR_WPAN_PHY]));
+	} else if (tb[NL802154_ATTR_IFINDEX]) {
+		if_indextoname(nla_get_u32(tb[NL802154_ATTR_IFINDEX]), ifname);
+		printf("%s: ", ifname);
+	} else if (tb[NL802154_ATTR_WPAN_DEV]) {
+		printf("wdev 0x%llx: ", (unsigned long long)nla_get_u64(tb[NL802154_ATTR_WPAN_DEV]));
+	} else if (tb[NL802154_ATTR_WPAN_PHY]) {
+		printf("phy #%d: ", nla_get_u32(tb[NL802154_ATTR_WPAN_PHY]));
+	}
+
+	switch (gnlh->cmd) {
+	case NL802154_CMD_NEW_WPAN_PHY:
+		printf("renamed to %s\n", nla_get_string(tb[NL802154_ATTR_WPAN_PHY_NAME]));
+		break;
+	case NL802154_CMD_DEL_WPAN_PHY:
+		printf("delete wpan_phy\n");
+		break;
+	case NL802154_CMD_TRIGGER_SCAN:
+		printf("scan started\n");
+		break;
+	case NL802154_CMD_SCAN_DONE:
+		printf("scan finished\n");
+		break;
+	case NL802154_CMD_NEW_COORDINATOR:
+		printf("new coordinator\n");
+		break;
+	default:
+		printf("unknown event %d\n", gnlh->cmd);
+		break;
+	}
+	fflush(stdout);
+	return NL_SKIP;
+}
+
+static int __prepare_listen_events(struct nl802154_state *state)
+{
+	int mcid, ret;
+
+	/* Configuration multicast group */
+	mcid = genl_ctrl_resolve_grp(state->nl_sock, NL802154_GENL_NAME,
+				     "config");
+	if (mcid < 0)
+		return mcid;
+	ret = nl_socket_add_membership(state->nl_sock, mcid);
+	if (ret)
+		return ret;
+
+	/* Scan multicast group */
+	mcid = genl_ctrl_resolve_grp(state->nl_sock, NL802154_GENL_NAME,
+				     "scan");
+	if (mcid >= 0) {
+		ret = nl_socket_add_membership(state->nl_sock, mcid);
+		if (ret)
+			return ret;
+	}
+
+	/* MLME multicast group */
+	mcid = genl_ctrl_resolve_grp(state->nl_sock, NL802154_GENL_NAME,
+				     "mlme");
+	if (mcid >= 0) {
+		ret = nl_socket_add_membership(state->nl_sock, mcid);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __do_listen_events(struct nl802154_state *state,
+			      struct print_event_args *args)
+{
+	struct nl_cb *cb = nl_cb_alloc(iwpan_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		return -ENOMEM;
+	}
+	nl_socket_set_cb(state->nl_sock, cb);
+	/* No sequence checking for multicast messages */
+	nl_socket_disable_seq_check(state->nl_sock);
+	/* Install print_event message handler */
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_event, args);
+
+	/* Loop waiting until interrupted by signal */
+	while (1) {
+		int ret = nl_recvmsgs(state->nl_sock, cb);
+		if (ret) {
+			fprintf(stderr, "nl_recvmsgs return error %d\n", ret);
+			break;
+		}
+	}
+	/* Free allocated nl_cb structure */
+	nl_cb_put(cb);
+	return 0;
+}
+
+static int print_events(struct nl802154_state *state,
+			struct nl_cb *cb,
+			struct nl_msg *msg,
+			int argc, char **argv,
+			enum id_input id)
+{
+	struct print_event_args args;
+	int ret;
+
+	memset(&args, 0, sizeof(args));
+
+	argc--;
+	argv++;
+
+	while (argc > 0) {
+		if (strcmp(argv[0], "-f") == 0)
+			args.frame = true;
+		else if (strcmp(argv[0], "-t") == 0)
+			args.time = true;
+		else if (strcmp(argv[0], "-r") == 0)
+			args.reltime = true;
+		else
+			return 1;
+		argc--;
+		argv++;
+	}
+	if (args.time && args.reltime)
+		return 1;
+	if (argc)
+		return 1;
+
+	/* Prepare reception of all multicast messages */
+	ret = __prepare_listen_events(state);
+	if (ret)
+		return ret;
+
+	/* Read message loop */
+	return __do_listen_events(state, &args);
+}
+TOPLEVEL(event, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
+	"Monitor events from the kernel.\n"
+	"-t - print timestamp\n"
+	"-r - print relative timestamp\n"
+	"-f - print full frame for auth/assoc etc.");
diff --git a/src/iwpan.h b/src/iwpan.h
index 406940a..a71b991 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -114,6 +114,9 @@ DECLARE_SECTION(get);
 
 const char *iftype_name(enum nl802154_iftype iftype);
 
+const char *scantype_name(enum nl802154_scan_types scantype);
+int parse_scan_result_pan(struct nlattr *nestedpan, struct nlattr *ifattr);
+
 extern int iwpan_debug;
 
 #endif /* __IWPAN_H */
diff --git a/src/scan.c b/src/scan.c
index de6caf4..bc06069 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -16,7 +16,7 @@
 
 static char scantypebuf[100];
 
-static const char *scantype_name(enum nl802154_scan_types scantype)
+const char *scantype_name(enum nl802154_scan_types scantype)
 {
 	switch (scantype) {
 	case NL802154_SCAN_ED:
@@ -168,8 +168,7 @@ static int scan_abort_handler(struct nl802154_state *state,
 }
 
 
-static int parse_new_coordinator(struct nlattr *nestedcoord,
-				 struct nlattr *ifattr)
+int parse_new_coordinator(struct nlattr *nestedcoord, struct nlattr *ifattr)
 {
 	struct nlattr *pan[NL802154_COORD_MAX + 1];
 	static struct nla_policy pan_policy[NL802154_COORD_MAX + 1] = {
-- 
2.34.1

