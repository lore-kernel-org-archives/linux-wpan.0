Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A13C54EBF
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjAFLSy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjAFLSv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:51 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A2625DF
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 82FFD240008;
        Fri,  6 Jan 2023 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9BokGGjpAInouafUidXyQ6lPlLt+AXEAwDeJ9zY+Xk=;
        b=J2pK6bMS+ktIhfQfL1/w5YjFZQ64CiL8XvgmmYcHff1TQjd83Pq1OwNm5zbhw3znPPZeQJ
        f5A8AfJvYVU9KiFCgrAD7KPVdTMcusvVQJAbEaID1dvLdVGfCa5MTEGyeqcFWuaPvvFK47
        wqy2JH7gQ/0VThYZhXBlW0Ws4qVQWWCTKwKuHAe/i0ErI9kp2jwT+KHf+asg0Yk56mRJny
        g8el1MyUFb8X+6s4MGn54oKaa19tv8Va1hCWVcvdue9vLBMxpwKERGxv9VXyNneSIzT3Us
        XynpKxQQ0OTlCmtp5MG6OeESy1/fCmdIxgdseFXRDFiTpRULFoh8EsOjY5Ea3Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools v2 8/8] iwpan: Add events support
Date:   Fri,  6 Jan 2023 12:18:31 +0100
Message-Id: <20230106111831.692202-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
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
 src/event.c     | 230 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+)
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
index 0000000..5ec597d
--- /dev/null
+++ b/src/event.c
@@ -0,0 +1,230 @@
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
+static int print_event(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL802154_ATTR_MAX + 1], *nst, *nestedcoord;
+	struct nlattr *pan[NL802154_COORD_MAX + 1];
+	struct print_event_args *args = arg;
+	char ifname[100];
+	static struct nla_policy pan_policy[NL802154_COORD_MAX + 1] = {
+		[NL802154_COORD_PANID] = { .type = NLA_U16, },
+		[NL802154_COORD_ADDR] = { .minlen = 2, .maxlen = 8, }, /* 2 or 8 */
+	};
+	uint8_t reg_type;
+	uint32_t wpan_phy_idx = 0;
+	int rem_nst;
+	uint16_t status;
+	int ret;
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
+		if (tb[NL802154_ATTR_SCAN_DONE_REASON])
+			status = nla_get_u8(tb[NL802154_ATTR_SCAN_DONE_REASON]);
+		if (status == NL802154_SCAN_DONE_REASON_ABORTED)
+			printf("scan aborted\n");
+		else
+			printf("scan finished\n");
+		break;
+	case NL802154_CMD_ABORT_SCAN:
+		printf("scan aborted\n");
+		break;
+	case NL802154_CMD_SCAN_EVENT:
+		nestedcoord = tb[NL802154_ATTR_COORDINATOR];
+		if (!nestedcoord)
+			break;
+		ret = nla_parse_nested(pan, NL802154_COORD_MAX, nestedcoord, pan_policy);
+		if (ret < 0)
+			break;
+		if (!pan[NL802154_COORD_PANID])
+			break;
+		printf("beacon received: PAN 0x%04x",
+		       le16toh(nla_get_u16(pan[NL802154_COORD_PANID])));
+		if (pan[NL802154_COORD_ADDR]) {
+			struct nlattr *coord = pan[NL802154_COORD_ADDR];
+			if (nla_len(coord) == 2) {
+				uint16_t addr = nla_get_u16(coord);
+				printf(", addr 0x%04x\n", le16toh(addr));
+			} else {
+				uint64_t addr = nla_get_u64(coord);
+				printf(", addr 0x%016" PRIx64 "\n", le64toh(addr));
+			}
+		}
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
+TOPLEVEL(monitor, "[-t|-r] [-f]", 0, 0, CIB_NONE, print_events,
+	"Monitor events from the kernel.\n"
+	"-t - print timestamp\n"
+	"-r - print relative timestamp\n"
+	"-f - print full frame for auth/assoc etc.");
-- 
2.34.1

