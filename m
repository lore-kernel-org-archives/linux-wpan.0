Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U9sSTkEo"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F327D63
	for <linux-wpan@vger.kernel.org>; Tue, 28 Nov 2023 03:29:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B0341BF20E;
	Tue, 28 Nov 2023 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzcGMClqwGuoiKTrbp1FVMovVQLOOnkL6gPOA4UUcnk=;
	b=U9sSTkEo5HSJjRRB9eGC4I1rKX8cUfiwWKDTGPyeWYFU534G7Bsm/TeXJrdlhUcEeAr/wU
	mN151E90s74Ajgdq53geNqDHyjMF7AiTn1e1TgoEBZZIL3f8kmGBG5lRDrO5VP1iOVjd3M
	ZlP8+xGGL46+RP6Wzue2372TkqAIB21IDUp1TLZ73DhLNQPIRTcSs0MjUeUgdGH4Y/w1n8
	EXwFDZ/KeUxt0CszDGag7IqajcoM7wDmM6pTsYxcFRYZLgZ9dumk2eBp3APVccPM7lr5Le
	cI9Mw3wFsZ8ozw0i+wkD9IVUf/KEIJEWEqUa8fh0LAW+dbVy3kCEZNm0EB+QLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 2/2] iwpan: Add associations support
Date: Tue, 28 Nov 2023 12:29:45 +0100
Message-Id: <20231128112945.509331-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128112945.509331-1-miquel.raynal@bootlin.com>
References: <20231128112945.509331-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Show how to interact with the kernel to request an
association/disassociation or listing the associated devices.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/info.c |   4 ++
 src/mac.c  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/src/info.c b/src/info.c
index 8b7e98e..1386624 100644
--- a/src/info.c
+++ b/src/info.c
@@ -217,6 +217,10 @@ static const char *commands[NL802154_CMD_MAX + 1] = {
 	[NL802154_CMD_SET_MAX_CSMA_BACKOFFS] = "set_max_csma_backoffs",
 	[NL802154_CMD_SET_LBT_MODE] = "set_lbt_mode",
 	[NL802154_CMD_SET_ACKREQ_DEFAULT] = "set_ackreq_default",
+	[NL802154_CMD_LIST_ASSOCIATIONS] = "list_associations",
+	[NL802154_CMD_SET_MAX_ASSOCIATIONS] = "set_max_associations",
+	[NL802154_CMD_ASSOCIATE] = "associate",
+	[NL802154_CMD_DISASSOCIATE] = "disassociate",
 };
 
 static char cmdbuf[100];
diff --git a/src/mac.c b/src/mac.c
index 79b3ab9..48f6be4 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -238,3 +238,190 @@ nla_put_failure:
 COMMAND(set, ackreq_default, "<1|0>",
 	NL802154_CMD_SET_ACKREQ_DEFAULT, 0, CIB_NETDEV, handle_ackreq_default,
 	NULL);
+
+static int handle_set_max_associations(struct nl802154_state *state,
+				      struct nl_cb *cb,
+				      struct nl_msg *msg,
+				      int argc, char **argv,
+				      enum id_input id)
+{
+	unsigned long max_associations;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* Maximum number of PAN entries */
+	max_associations = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U32(msg, NL802154_ATTR_MAX_ASSOCIATIONS, max_associations);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, max_associations, "<max_associations>",
+	NL802154_CMD_SET_MAX_ASSOCIATIONS, 0, CIB_NETDEV,
+	handle_set_max_associations, NULL);
+
+int parse_associated_devices(struct nlattr *nestedassoc)
+{
+	struct nlattr *assoc[NL802154_DEV_ADDR_ATTR_MAX + 1];
+	static struct nla_policy assoc_policy[NL802154_DEV_ADDR_ATTR_MAX + 1] = {
+		[NL802154_DEV_ADDR_ATTR_PEER_TYPE] = { .type = NLA_U8, },
+		[NL802154_DEV_ADDR_ATTR_MODE] = { .type = NLA_U8, },
+		[NL802154_DEV_ADDR_ATTR_SHORT] = { .type = NLA_U16, },
+		[NL802154_DEV_ADDR_ATTR_EXTENDED] = { .type = NLA_U64, },
+	};
+	bool short_addressing;
+	uint8_t peer_type;
+	int ret;
+
+	ret = nla_parse_nested(assoc, NL802154_DEV_ADDR_ATTR_MAX, nestedassoc,
+			       assoc_policy);
+	if (ret < 0) {
+		fprintf(stderr, "failed to parse nested attributes! (ret = %d)\n",
+			ret);
+		return NL_SKIP;
+	}
+
+	if (!assoc[NL802154_DEV_ADDR_ATTR_PEER_TYPE] ||
+	    !assoc[NL802154_DEV_ADDR_ATTR_SHORT] ||
+	    !assoc[NL802154_DEV_ADDR_ATTR_EXTENDED])
+		return NL_SKIP;
+
+	peer_type = nla_get_u8(assoc[NL802154_DEV_ADDR_ATTR_PEER_TYPE]);
+	printf("%s: 0x%04x / 0x%016llx\n",
+	       peer_type == NL802154_PEER_TYPE_PARENT ? "parent" : "child ",
+	       nla_get_u16(assoc[NL802154_DEV_ADDR_ATTR_SHORT]),
+	       nla_get_u64(assoc[NL802154_DEV_ADDR_ATTR_EXTENDED]));
+
+	return NL_OK;
+}
+
+static int print_association_list_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NL802154_ATTR_MAX + 1];
+	struct nlattr *nestedassoc;
+
+	nla_parse(tb, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+	nestedassoc = tb[NL802154_ATTR_PEER];
+	if (!nestedassoc) {
+		fprintf(stderr, "peer info missing!\n");
+		return NL_SKIP;
+	}
+	return parse_associated_devices(nestedassoc);
+}
+
+static int list_associations_handler(struct nl802154_state *state,
+				     struct nl_cb *cb,
+				     struct nl_msg *msg,
+				     int argc, char **argv,
+				     enum id_input id)
+{
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_association_list_handler, NULL);
+
+	return 0;
+}
+TOPLEVEL(list_associations, NULL, NL802154_CMD_LIST_ASSOCIATIONS,
+	NLM_F_DUMP, CIB_NETDEV,	list_associations_handler,
+	"List the associated devices on this virtual interface");
+
+static int associate_handler(struct nl802154_state *state,
+			     struct nl_cb *cb,
+			     struct nl_msg *msg,
+			     int argc, char **argv,
+			     enum id_input id)
+{
+	unsigned int pan_id;
+	uint64_t laddr = 0;
+	char *end;
+	int tpset;
+
+	if (argc < 4)
+		return 1;
+
+	/* PAN ID */
+	if (strcmp(argv[0], "pan_id"))
+		return 1;
+
+	pan_id = strtoul(argv[1], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	if (pan_id > UINT16_MAX)
+		return 1;
+
+	argc -= 2;
+	argv += 2;
+
+	/* Coordinator */
+	if (strcmp(argv[0], "coord"))
+		return 1;
+
+	laddr = strtoull(argv[1], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U16(msg, NL802154_ATTR_PAN_ID, htole16(pan_id));
+	NLA_PUT_U64(msg, NL802154_ATTR_EXTENDED_ADDR, htole64(laddr));
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+TOPLEVEL(associate, "pan_id <pan_id> coord <coord>", NL802154_CMD_ASSOCIATE, 0,
+	 CIB_NETDEV, associate_handler,
+	 "Join a PAN by sending an association request to the given coordinator");
+
+static int disassociate_handler(struct nl802154_state *state,
+				struct nl_cb *cb,
+				struct nl_msg *msg,
+				int argc, char **argv,
+				enum id_input id)
+{
+	bool use_extended_addressing;
+	uint64_t laddr;
+	unsigned int saddr;
+	char *end;
+	int tpset;
+
+	if (argc < 2)
+		return 1;
+
+	if (!strcmp(argv[0], "ext_addr")) {
+		use_extended_addressing = true;
+		laddr = strtoull(argv[1], &end, 0);
+		if (*end != '\0')
+			return 1;
+	} else if (!strcmp(argv[0], "short_addr")) {
+		use_extended_addressing = false;
+		saddr = strtoul(argv[1], &end, 0);
+		if (*end != '\0')
+			return 1;
+
+		if (saddr > UINT16_MAX - 2)
+			return 1;
+	} else {
+		return 1;
+	}
+
+	if (use_extended_addressing)
+		NLA_PUT_U64(msg, NL802154_ATTR_EXTENDED_ADDR, htole64(laddr));
+	else
+		NLA_PUT_U16(msg, NL802154_ATTR_SHORT_ADDR, htole16(saddr));
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+TOPLEVEL(disassociate, "short_addr|ext_addr <addr>", NL802154_CMD_DISASSOCIATE,
+	 0, CIB_NETDEV, disassociate_handler,
+	 "Send a disassociation notification to a device");
-- 
2.34.1

