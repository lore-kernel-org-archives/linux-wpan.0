Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C2C43334
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiGAOiW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437A3EA90
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3ED66200016;
        Fri,  1 Jul 2022 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9NUH5yjbyQsyMLIKzsycBkRITi01Pv43GRQn0t2uNw=;
        b=C01144IHGgky3kiF8yvC0TO5Ce7yyXavgMrZPkSPAhIk1BlRXEOmrekormF+GIOwR5XbhT
        yZtlAWX4zBe5I+yvyK+82kiwtCmOw2KO7A7xNJumxvYiV+pOsd2lWOX8G95vk/BC0e8WQm
        TJ1w5owA+6+u8BJJmX37qSYtrGF9dAkyZcMJasKFa0QA9Q1kO8ABbgq4XWTFly75PO0acE
        krza6cXBraG0IvSSH1oGw5nn8aMnADxlyMGAVPusWwluiUs4BJnylIbsjWBrGudwG1QOBi
        7KWjY+Rpx+iqS/3F4fbcP1OW859v2H2vJi474wXPFsKn3TzPNUhIhP+ZzLMGAw==
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
Subject: [PATCH wpan-tools 6/7] iwpan: Add full scan support
Date:   Fri,  1 Jul 2022 16:34:33 +0200
Message-Id: <20220701143434.1267864-7-miquel.raynal@bootlin.com>
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

Bring support for different scanning operations, such as starting or
aborting a scan operation with a given configuration, and dumping the
discovered coordinators.

It also brings support for additional PAN management features, such as a
beacon request to ask the mac to send or stop sending beacons out of a
particular interface.

Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/Makefile.am |   1 +
 src/mac.c       |   1 +
 src/scan.c      | 421 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 src/scan.c

diff --git a/src/Makefile.am b/src/Makefile.am
index 2d54576..18b3569 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -9,6 +9,7 @@ iwpan_SOURCES = \
 	interface.c \
 	phy.c \
 	mac.c \
+	scan.c \
 	nl_extras.h \
 	nl802154.h
 
diff --git a/src/mac.c b/src/mac.c
index 286802c..19bb328 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -234,3 +234,4 @@ nla_put_failure:
 COMMAND(set, ackreq_default, "<1|0>",
 	NL802154_CMD_SET_ACKREQ_DEFAULT, 0, CIB_NETDEV, handle_ackreq_default,
 	NULL);
+
diff --git a/src/scan.c b/src/scan.c
new file mode 100644
index 0000000..de6caf4
--- /dev/null
+++ b/src/scan.c
@@ -0,0 +1,421 @@
+#include <net/if.h>
+#include <errno.h>
+#include <string.h>
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
+static char scantypebuf[100];
+
+static const char *scantype_name(enum nl802154_scan_types scantype)
+{
+	switch (scantype) {
+	case NL802154_SCAN_ED:
+		return "ed";
+	case NL802154_SCAN_ACTIVE:
+		return "active";
+	case NL802154_SCAN_PASSIVE:
+		return "passive";
+	case NL802154_SCAN_ENHANCED_ACTIVE:
+		return "enhanced";
+	case NL802154_SCAN_RIT_PASSIVE:
+		return "rit";
+	default:
+		sprintf(scantypebuf, "Invalid scantype (%d)", scantype);
+		return scantypebuf;
+	}
+}
+
+/* for help */
+#define SCAN_TYPES "Valid scanning types are: ed, active, passive, enhanced, rit."
+
+/* return 0 if ok, internal error otherwise */
+static int get_scan_type(int *argc, char ***argv, enum nl802154_scan_types *type)
+{
+	char *tpstr;
+
+	if (*argc < 2)
+		return 1;
+
+	if (strcmp((*argv)[0], "type"))
+		return 1;
+
+	tpstr = (*argv)[1];
+	*argc -= 2;
+	*argv += 2;
+
+	if (strcmp(tpstr, "ed") == 0) {
+		*type = NL802154_SCAN_ED;
+		return 0;
+	} else if (strcmp(tpstr, "active") == 0) {
+		*type = NL802154_SCAN_ACTIVE;
+		return 0;
+	} else if (strcmp(tpstr, "passive") == 0) {
+		*type = NL802154_SCAN_PASSIVE;
+		return 0;
+	} else if (strcmp(tpstr, "enhanced") == 0) {
+		*type = NL802154_SCAN_ENHANCED_ACTIVE;
+		return 0;
+	} else if (strcmp(tpstr, "rit") == 0) {
+		*type = NL802154_SCAN_RIT_PASSIVE;
+		return 0;
+	}
+
+	fprintf(stderr, "invalid interface type %s\n", tpstr);
+	return 2;
+}
+
+static int get_option_value(int *argc, char ***argv, const char *marker, unsigned long *result, bool *valid)
+{
+	unsigned long value;
+	char *tpstr, *end;
+
+	*valid = false;
+
+	if (*argc < 2)
+		return 0;
+
+	if (strcmp((*argv)[0], marker))
+		return 0;
+
+	tpstr = (*argv)[1];
+	*argc -= 2;
+	*argv += 2;
+
+	value = strtoul(tpstr, &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	*result = value;
+	*valid = true;
+
+	return 0;
+}
+
+static int scan_trigger_handler(struct nl802154_state *state,
+				struct nl_cb *cb,
+				struct nl_msg *msg,
+				int argc, char **argv,
+				enum id_input id)
+{
+	enum nl802154_scan_types type;
+	unsigned long page, channels, duration;
+	int tpset;
+	bool valid_page, valid_channels, valid_duration;
+
+	if (argc < 2)
+		return 1;
+
+	tpset = get_scan_type(&argc, &argv, &type);
+	if (tpset)
+		return tpset;
+
+	tpset = get_option_value(&argc, &argv, "page", &page, &valid_page);
+	if (tpset)
+		return tpset;
+	if (valid_page && page > UINT8_MAX)
+		return 1;
+
+	tpset = get_option_value(&argc, &argv, "channels", &channels, &valid_channels);
+	if (tpset)
+		return tpset;
+	if (valid_channels && channels > UINT32_MAX)
+		return 1;
+
+	tpset = get_option_value(&argc, &argv, "duration", &duration, &valid_duration);
+	if (tpset)
+		return tpset;
+	if (valid_duration && duration > UINT8_MAX)
+		return 1;
+
+	if (argc)
+		return 1;
+
+	/* Mandatory argument */
+	NLA_PUT_U8(msg, NL802154_ATTR_SCAN_TYPE, type);
+	/* Optional arguments */
+	if (valid_duration)
+		NLA_PUT_U8(msg, NL802154_ATTR_SCAN_DURATION, duration);
+	if (valid_page)
+		NLA_PUT_U8(msg, NL802154_ATTR_PAGE, page);
+	if (valid_channels)
+		NLA_PUT_U32(msg, NL802154_ATTR_SCAN_CHANNELS, channels);
+
+	/* TODO: support IES parameters for active scans */
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
+static int scan_abort_handler(struct nl802154_state *state,
+			      struct nl_cb *cb,
+			      struct nl_msg *msg,
+			      int argc, char **argv,
+			      enum id_input id)
+{
+	return 0;
+}
+
+
+static int parse_new_coordinator(struct nlattr *nestedcoord,
+				 struct nlattr *ifattr)
+{
+	struct nlattr *pan[NL802154_COORD_MAX + 1];
+	static struct nla_policy pan_policy[NL802154_COORD_MAX + 1] = {
+		[NL802154_COORD_PANID] = { .type = NLA_U16, },
+		[NL802154_COORD_ADDR] = { .minlen = 2, .maxlen = 8, }, /* 2 or 8 */
+		[NL802154_COORD_CHANNEL] = { .type = NLA_U8, },
+		[NL802154_COORD_PAGE] = { .type = NLA_U8, },
+		[NL802154_COORD_PREAMBLE_CODE] = { .type = NLA_U8, },
+		[NL802154_COORD_MEAN_PRF] = { .type = NLA_U8, },
+		[NL802154_COORD_SUPERFRAME_SPEC] = { .type = NLA_U16, },
+		[NL802154_COORD_LINK_QUALITY] = { .type = NLA_U8, },
+		[NL802154_COORD_GTS_PERMIT] = { .type = NLA_FLAG, },
+	};
+	char dev[20];
+	int ret;
+
+	ret = nla_parse_nested(pan, NL802154_COORD_MAX, nestedcoord, pan_policy);
+	if (ret < 0) {
+		fprintf(stderr, "failed to parse nested attributes! (ret = %d)\n",
+			ret);
+		return NL_SKIP;
+	}
+	if (!pan[NL802154_COORD_PANID])
+		return NL_SKIP;
+
+	printf("PAN 0x%04x", le16toh(nla_get_u16(pan[NL802154_COORD_PANID])));
+	if (ifattr) {
+		if_indextoname(nla_get_u32(ifattr), dev);
+		printf(" (on %s)", dev);
+	}
+	printf("\n");
+	if (pan[NL802154_COORD_ADDR]) {
+		struct nlattr *coord = pan[NL802154_COORD_ADDR];
+		if (nla_len(coord) == 2) {
+			uint16_t addr = nla_get_u16(coord);
+			printf("\tcoordinator 0x%04x\n", le16toh(addr));
+		} else {
+			uint64_t addr = nla_get_u64(coord);
+			printf("\tcoordinator 0x%016" PRIx64 "\n", le64toh(addr));
+		}
+	}
+	if (pan[NL802154_COORD_PAGE]) {
+		printf("\tpage %u\n", nla_get_u8(pan[NL802154_COORD_PAGE]));
+	}
+	if (pan[NL802154_COORD_CHANNEL]) {
+		printf("\tchannel %u\n", nla_get_u8(pan[NL802154_COORD_CHANNEL]));
+	}
+	if (pan[NL802154_COORD_SUPERFRAME_SPEC]) {
+		printf("\tsuperframe spec. 0x%x\n", nla_get_u16(
+				pan[NL802154_COORD_SUPERFRAME_SPEC]));
+	}
+	if (pan[NL802154_COORD_LINK_QUALITY]) {
+		printf("\tLQI %x\n", nla_get_u8(
+				pan[NL802154_COORD_LINK_QUALITY]));
+	}
+	if (pan[NL802154_COORD_GTS_PERMIT]) {
+		printf("\tGTS permitted\n");
+	}
+
+	/* TODO: Beacon IES display/decoding */
+
+	return NL_OK;
+}
+
+static int print_new_coordinator_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL802154_ATTR_MAX + 1];
+	struct nlattr *nestedcoord;
+
+	nla_parse(tb, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	nestedcoord = tb[NL802154_ATTR_COORDINATOR];
+	if (!nestedcoord) {
+		fprintf(stderr, "coordinator info missing!\n");
+		return NL_SKIP;
+	}
+
+	return parse_new_coordinator(nestedcoord, tb[NL802154_ATTR_IFINDEX]);
+}
+
+struct scan_done
+{
+	volatile int done;
+	int devidx;
+};
+
+static int wait_scan_done_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct scan_done *sd = (struct scan_done *)arg;
+
+	if (gnlh->cmd == NL802154_CMD_NEW_COORDINATOR)
+		return print_new_coordinator_handler(msg, arg);
+
+	if (gnlh->cmd != NL802154_CMD_SCAN_DONE)
+		return 0;
+
+	if (sd->devidx != -1) {
+		struct nlattr *tb[NL802154_ATTR_MAX + 1];
+		nla_parse(tb, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+			genlmsg_attrlen(gnlh, 0), NULL);
+		if (!tb[NL802154_ATTR_IFINDEX] ||
+			nla_get_u32(tb[NL802154_ATTR_IFINDEX]) != sd->devidx)
+			return 0;
+	}
+
+	sd->done = 1;
+	return 0;
+}
+
+static int no_seq_check(struct nl_msg *msg, void *arg)
+{
+	return NL_OK;
+}
+
+static int scan_done_handler(struct nl802154_state *state,
+			     struct nl_cb *cb,
+			     struct nl_msg *msg,
+			     int argc, char **argv,
+			     enum id_input id)
+{
+	struct nl_cb *s_cb;
+	struct scan_done sd;
+	int ret, group;
+
+	/* Configure socket to receive messages in Scan multicast group */
+	group = genl_ctrl_resolve_grp(state->nl_sock, "nl802154", "scan");
+	if (group < 0)
+		return group;
+	ret = nl_socket_add_membership(state->nl_sock, group);
+	if (ret)
+		return ret;
+	/* Init netlink callbacks as if we run a command */
+	cb = nl_cb_alloc(iwpan_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		return 2;
+	}
+	nl_socket_set_cb(state->nl_sock, cb);
+	/* no sequence checking for multicast messages */
+	nl_socket_disable_seq_check(state->nl_sock);
+	/* install scan done message handler */
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, wait_scan_done_handler, &sd);
+	/* set net device filter */
+	sd.devidx = if_nametoindex(*argv);
+	if (sd.devidx == 0)
+		sd.devidx = -1;
+	sd.done = 0;
+	/* loop waiting */
+	while (sd.done == 0)
+		nl_recvmsgs(state->nl_sock, cb);
+	/* restore seq & leave multicast group */
+	ret = nl_socket_drop_membership(state->nl_sock, group);
+	nl_cb_put(cb);
+	return ret;
+}
+
+static int scan_combined_handler(struct nl802154_state *state,
+				 struct nl_cb *cb,
+				 struct nl_msg *msg,
+				 int argc, char **argv,
+				 enum id_input id)
+{
+	char **trig_argv;
+	static char *show_argv[] = {
+		NULL,
+		"scan",
+		"done",
+	};
+	int trig_argc, err;
+	int i;
+
+	/* dev wpan0 scan trigger ... */
+	trig_argc = 3 + (argc - 2);
+	trig_argv = calloc(trig_argc, sizeof(*trig_argv));
+	if (!trig_argv)
+		return -ENOMEM;
+	trig_argv[0] = argv[0];
+	trig_argv[1] = "scan";
+	trig_argv[2] = "trigger";
+	for (i = 0; i < argc - 2; i++)
+		trig_argv[i + 3] = argv[i + 2];
+	err = handle_cmd(state, id, trig_argc, trig_argv);
+	free(trig_argv);
+	if (err)
+		return err;
+
+	/* dev wpanX scan show */
+	show_argv[0] = argv[0];
+	return handle_cmd(state, id, 3, show_argv);
+}
+TOPLEVEL(scan, "type <type> [page <page>] [channels <bitfield>] [duration <duration-order>]",
+	0, 0, CIB_NETDEV, scan_combined_handler,
+	"Scan on this virtual interface with the given configuration.\n"
+	SCAN_TYPES);
+COMMAND(scan, abort, NULL, NL802154_CMD_ABORT_SCAN, 0, CIB_NETDEV, scan_abort_handler,
+	"Abort ongoing scanning on this virtual interface");
+COMMAND(scan, done, NULL, 0, 0, CIB_NETDEV, scan_done_handler,
+	"Wait the scan operation to finish on this virtual interface, showing discoveries");
+COMMAND(scan, trigger,
+	"type <type> [page <page>] [channels <bitfield>] [duration <duration-order>]",
+	NL802154_CMD_TRIGGER_SCAN, 0, CIB_NETDEV, scan_trigger_handler,
+	"Launch scanning on this virtual interface with the given configuration.\n"
+	SCAN_TYPES);
+
+SECTION(beacons);
+
+static int send_beacons_handler(struct nl802154_state *state, struct nl_cb *cb,
+				struct nl_msg *msg, int argc, char **argv,
+				enum id_input id)
+{
+	unsigned long interval;
+	bool valid_interval;
+	int tpset;
+
+	tpset = get_option_value(&argc, &argv, "interval", &interval, &valid_interval);
+	if (tpset)
+		return tpset;
+	if (valid_interval && interval > UINT8_MAX)
+		return 1;
+
+	if (argc)
+		return 1;
+
+	/* Optional arguments */
+	if (valid_interval)
+		NLA_PUT_U8(msg, NL802154_ATTR_BEACON_INTERVAL, interval);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
+static int stop_beacons_handler(struct nl802154_state *state, struct nl_cb *cb,
+				struct nl_msg *msg, int argc, char **argv,
+				enum id_input id)
+{
+	return 0;
+}
+
+COMMAND(beacons, stop, NULL,
+	NL802154_CMD_STOP_BEACONS, 0, CIB_NETDEV, stop_beacons_handler,
+	"Stop sending beacons on this interface.");
+COMMAND(beacons, send, "[interval <interval-order>]",
+	NL802154_CMD_SEND_BEACONS, 0, CIB_NETDEV, send_beacons_handler,
+	"Send beacons on this virtual interface at a regular pace.");
-- 
2.34.1

