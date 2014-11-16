Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56253 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaKPUG1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Nov 2014 15:06:27 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so2317561wid.11
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 12:06:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/2] interface: add support for extended addr while iface add
Date: Sun, 16 Nov 2014 21:05:57 +0100
Message-Id: <1416168358-28088-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds support for given extended addr while adding a new interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/interface.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/src/interface.c b/src/interface.c
index 40c18ef..0ac9c5a 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -66,6 +66,56 @@ static int get_if_type(int *argc, char ***argv, enum nl802154_iftype *type,
 	return 2;
 }
 
+#define EUI64_ALEN	8
+
+static int extendedaddr_a2n(unsigned char *mac_addr, char *arg)
+{
+	int i;
+
+	for (i = 0; i < EUI64_ALEN ; i++) {
+		int temp;
+		char *cp = strchr(arg, ':');
+		if (cp) {
+			*cp = 0;
+			cp++;
+		}
+		if (sscanf(arg, "%x", &temp) != 1)
+			return -1;
+		if (temp < 0 || temp > 255)
+			return -1;
+
+		mac_addr[EUI64_ALEN - 1 - i] = temp;
+		if (!cp)
+			break;
+		arg = cp;
+	}
+	if (i < EUI64_ALEN - 1)
+		return -1;
+
+	return 0;
+}
+
+/* return 0 if ok, internal error otherwise */
+static int get_eui64(int *argc, char ***argv, void *eui64)
+{
+	int ret;
+
+	if (*argc < 1)
+		return 0;
+
+	ret = extendedaddr_a2n(eui64, (*argv)[0]);
+	if (ret) {
+		fprintf(stderr, "invalid extended address\n");
+		return 2;
+	}
+
+
+	*argc -= 1;
+	*argv += 1;
+
+	return 0;
+}
+
 static int handle_interface_add(struct nl802154_state *state,
 				struct nl_cb *cb,
 				struct nl_msg *msg,
@@ -74,6 +124,7 @@ static int handle_interface_add(struct nl802154_state *state,
 {
 	char *name;
 	enum nl802154_iftype type;
+	uint64_t eui64 = 0;
 	int tpset;
 
 	if (argc < 1)
@@ -87,22 +138,27 @@ static int handle_interface_add(struct nl802154_state *state,
 	if (tpset)
 		return tpset;
 
+	tpset = get_eui64(&argc, &argv, &eui64);
+	if (tpset)
+		return tpset;
+
 	if (argc)
 		return 1;
 
 	NLA_PUT_STRING(msg, NL802154_ATTR_IFNAME, name);
 	NLA_PUT_U32(msg, NL802154_ATTR_IFTYPE, type);
+	NLA_PUT_U64(msg, NL802154_ATTR_EXTENDED_ADDR, eui64);
 
 	return 0;
 
 nla_put_failure:
 	return -ENOBUFS;
 }
-COMMAND(interface, add, "<name> type <type>",
+COMMAND(interface, add, "<name> type <type> [extended address <hex as 00:11:..>]",
 	NL802154_CMD_NEW_INTERFACE, 0, CIB_PHY, handle_interface_add,
 	"Add a new virtual interface with the given configuration.\n"
 	IFACE_TYPES "\n\n");
-COMMAND(interface, add, "<name> type <type>",
+COMMAND(interface, add, "<name> type <type> [extended address <hex as 00:11:..>]",
 	NL802154_CMD_NEW_INTERFACE, 0, CIB_NETDEV, handle_interface_add, NULL);
 
 static int handle_interface_del(struct nl802154_state *state,
-- 
2.1.3

