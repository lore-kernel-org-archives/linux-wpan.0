Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E224C04A6A
	for <linux-wpan@archiver.kernel.org>; Mon, 14 Aug 2023 21:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjHNVwj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 14 Aug 2023 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHNVwc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Aug 2023 17:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C174E7E
        for <linux-wpan@vger.kernel.org>; Mon, 14 Aug 2023 14:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93AA865815
        for <linux-wpan@vger.kernel.org>; Mon, 14 Aug 2023 21:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF176C433CC;
        Mon, 14 Aug 2023 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692049649;
        bh=d1+BFNNgga8C0IHdw+wkYJ1LyfKNbGzJac7utVQiLLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZiH0tXyA+BCGinp9wUv3ZTYPvXxegvYeNLuk/dyXWxk3jSDhymvHPPEEgSYBh4JA
         CMKZGZg4uSlN7xvWp40Au9HutcretfkhcZAZg8VsjN+UZEvZthA1e8Yr288rZzD//L
         tq4BUvbev/rji2+CBzRa7z57YLJhr4yRyDJ6i1M/CHnGw/iSvxns8pDPk0TEGQcFRS
         +Iv0ee1k/ZDlAwpe4W6RNv7fL3Bbr4jhX59iqDY8nmBgV2mQvhWAXIS8YnDVKgqOg3
         4Da4/oI51N1lkpd1IL9Z4E5n5Jo00E/Yzni5Kr7thS0LLr9He4XtiGpCmNmFmQYBsZ
         W0sKmBLZIZLMg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        jiri@resnulli.us, johannes@sipsolutions.net,
        Jakub Kicinski <kuba@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jiri Pirko <jiri@nvidia.com>, Jason@zx2c4.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        krzysztof.kozlowski@linaro.org, jmaloy@redhat.com,
        ying.xue@windriver.com, floridsleeves@gmail.com, leon@kernel.org,
        jacob.e.keller@intel.com, wireguard@lists.zx2c4.com,
        linux-wpan@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: [PATCH net-next v3 05/10] genetlink: use attrs from struct genl_info
Date:   Mon, 14 Aug 2023 14:47:18 -0700
Message-ID: <20230814214723.2924989-6-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214723.2924989-1-kuba@kernel.org>
References: <20230814214723.2924989-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Since dumps carry struct genl_info now, use the attrs pointer
from genl_info and remove the one in struct genl_dumpit_info.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Jason@zx2c4.com
CC: jiri@resnulli.us
CC: alex.aring@gmail.com
CC: stefan@datenfreihafen.org
CC: krzysztof.kozlowski@linaro.org
CC: jmaloy@redhat.com
CC: ying.xue@windriver.com
CC: floridsleeves@gmail.com
CC: leon@kernel.org
CC: jacob.e.keller@intel.com
CC: wireguard@lists.zx2c4.com
CC: linux-wpan@vger.kernel.org
CC: tipc-discussion@lists.sourceforge.net
---
 drivers/net/wireguard/netlink.c | 2 +-
 include/net/genetlink.h         | 1 -
 net/devlink/health.c            | 2 +-
 net/devlink/leftover.c          | 6 +++---
 net/ethtool/netlink.c           | 3 ++-
 net/ethtool/tunnels.c           | 2 +-
 net/ieee802154/nl802154.c       | 4 ++--
 net/netlink/genetlink.c         | 7 +++----
 net/nfc/netlink.c               | 4 ++--
 net/tipc/netlink_compat.c       | 2 +-
 net/tipc/node.c                 | 4 ++--
 net/tipc/socket.c               | 2 +-
 net/tipc/udp_media.c            | 2 +-
 13 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 6d1bd9f52d02..dc09b75a3248 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -200,7 +200,7 @@ static int wg_get_device_start(struct netlink_callback *cb)
 {
 	struct wg_device *wg;
 
-	wg = lookup_interface(genl_dumpit_info(cb)->attrs, cb->skb);
+	wg = lookup_interface(genl_info_dump(cb)->attrs, cb->skb);
 	if (IS_ERR(wg))
 		return PTR_ERR(wg);
 	DUMP_CTX(cb)->wg = wg;
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 86c8eaaa3a43..a8a15b9c22c8 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -255,7 +255,6 @@ struct genl_split_ops {
 struct genl_dumpit_info {
 	const struct genl_family *family;
 	struct genl_split_ops op;
-	struct nlattr **attrs;
 	struct genl_info info;
 };
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index a85bdec34801..59e7cff22d97 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1266,7 +1266,7 @@ devlink_health_reporter_get_from_cb(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct devlink_health_reporter *reporter;
-	struct nlattr **attrs = info->attrs;
+	struct nlattr **attrs = info->info.attrs;
 	struct devlink *devlink;
 
 	devlink = devlink_get_from_attrs_lock(sock_net(cb->skb->sk), attrs);
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 3883a90d32bb..72ba8a716525 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -5201,7 +5201,7 @@ static int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct nlattr *chunks_attr, *region_attr, *snapshot_attr;
 	u64 ret_offset, start_offset, end_offset = U64_MAX;
-	struct nlattr **attrs = info->attrs;
+	struct nlattr **attrs = info->info.attrs;
 	struct devlink_port *port = NULL;
 	devlink_chunk_fill_t *region_cb;
 	struct devlink_region *region;
@@ -5224,8 +5224,8 @@ static int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
 		goto out_unlock;
 	}
 
-	if (info->attrs[DEVLINK_ATTR_PORT_INDEX]) {
-		index = nla_get_u32(info->attrs[DEVLINK_ATTR_PORT_INDEX]);
+	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
+		index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
 
 		port = devlink_port_get_by_index(devlink, index);
 		if (!port) {
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index ae344f1b0bbd..9fc7c41f4786 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -538,7 +538,8 @@ static int ethnl_default_start(struct netlink_callback *cb)
 		goto free_req_info;
 	}
 
-	ret = ethnl_default_parse(req_info, info->attrs, sock_net(cb->skb->sk),
+	ret = ethnl_default_parse(req_info, info->info.attrs,
+				  sock_net(cb->skb->sk),
 				  ops, cb->extack, false);
 	if (req_info->dev) {
 		/* We ignore device specification in dump requests but as the
diff --git a/net/ethtool/tunnels.c b/net/ethtool/tunnels.c
index 05f752557b5e..b4ce47dd2aa6 100644
--- a/net/ethtool/tunnels.c
+++ b/net/ethtool/tunnels.c
@@ -219,7 +219,7 @@ int ethnl_tunnel_info_start(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct ethnl_tunnel_info_dump_ctx *ctx = (void *)cb->ctx;
-	struct nlattr **tb = info->attrs;
+	struct nlattr **tb = info->info.attrs;
 	int ret;
 
 	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d610c1886160..1a265a421308 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -262,7 +262,7 @@ nl802154_prepare_wpan_dev_dump(struct sk_buff *skb,
 
 	if (!cb->args[0]) {
 		*wpan_dev = __cfg802154_wpan_dev_from_attrs(sock_net(skb->sk),
-							    info->attrs);
+							    info->info.attrs);
 		if (IS_ERR(*wpan_dev)) {
 			err = PTR_ERR(*wpan_dev);
 			goto out_unlock;
@@ -570,7 +570,7 @@ static int nl802154_dump_wpan_phy_parse(struct sk_buff *skb,
 					struct nl802154_dump_wpan_phy_state *state)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
-	struct nlattr **tb = info->attrs;
+	struct nlattr **tb = info->info.attrs;
 
 	if (tb[NL802154_ATTR_WPAN_PHY])
 		state->filter_wpan_phy = nla_get_u32(tb[NL802154_ATTR_WPAN_PHY]);
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 82ad26970b9b..d47879d5a74c 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -846,7 +846,6 @@ static int genl_start(struct netlink_callback *cb)
 	}
 	info->family = ctx->family;
 	info->op = *ops;
-	info->attrs = attrs;
 	info->info.snd_seq	= cb->nlh->nlmsg_seq;
 	info->info.snd_portid	= NETLINK_CB(cb->skb).portid;
 	info->info.nlhdr	= cb->nlh;
@@ -864,7 +863,7 @@ static int genl_start(struct netlink_callback *cb)
 	}
 
 	if (rc) {
-		genl_family_rcv_msg_attrs_free(info->attrs);
+		genl_family_rcv_msg_attrs_free(info->info.attrs);
 		genl_dumpit_info_free(info);
 		cb->data = NULL;
 	}
@@ -898,7 +897,7 @@ static int genl_done(struct netlink_callback *cb)
 		rc = ops->done(cb);
 		genl_op_unlock(info->family);
 	}
-	genl_family_rcv_msg_attrs_free(info->attrs);
+	genl_family_rcv_msg_attrs_free(info->info.attrs);
 	genl_dumpit_info_free(info);
 	return rc;
 }
@@ -1387,7 +1386,7 @@ static int ctrl_dumppolicy_start(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	struct ctrl_dump_policy_ctx *ctx = (void *)cb->ctx;
-	struct nlattr **tb = info->attrs;
+	struct nlattr **tb = info->info.attrs;
 	const struct genl_family *rt;
 	struct genl_op_iter i;
 	int err;
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index e9ac6a6f934e..aa1dbf654c3e 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -110,10 +110,10 @@ static struct nfc_dev *__get_device_from_cb(struct netlink_callback *cb)
 	struct nfc_dev *dev;
 	u32 idx;
 
-	if (!info->attrs[NFC_ATTR_DEVICE_INDEX])
+	if (!info->info.attrs[NFC_ATTR_DEVICE_INDEX])
 		return ERR_PTR(-EINVAL);
 
-	idx = nla_get_u32(info->attrs[NFC_ATTR_DEVICE_INDEX]);
+	idx = nla_get_u32(info->info.attrs[NFC_ATTR_DEVICE_INDEX]);
 
 	dev = nfc_get_device(idx);
 	if (!dev)
diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 299cd6754f14..5bc076f2fa74 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -208,7 +208,7 @@ static int __tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
 		goto err_out;
 	}
 
-	info.attrs = attrbuf;
+	info.info.attrs = attrbuf;
 
 	if (nlmsg_len(cb.nlh) > 0) {
 		err = nlmsg_parse_deprecated(cb.nlh, GENL_HDRLEN, attrbuf,
diff --git a/net/tipc/node.c b/net/tipc/node.c
index a9c5b6594889..3105abe97bb9 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2662,7 +2662,7 @@ static int __tipc_nl_add_node_links(struct net *net, struct tipc_nl_msg *msg,
 int tipc_nl_node_dump_link(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
-	struct nlattr **attrs = genl_dumpit_info(cb)->attrs;
+	struct nlattr **attrs = genl_dumpit_info(cb)->info.attrs;
 	struct nlattr *link[TIPC_NLA_LINK_MAX + 1];
 	struct tipc_net *tn = net_generic(net, tipc_net_id);
 	struct tipc_node *node;
@@ -2870,7 +2870,7 @@ int tipc_nl_node_dump_monitor_peer(struct sk_buff *skb,
 	int err;
 
 	if (!prev_node) {
-		struct nlattr **attrs = genl_dumpit_info(cb)->attrs;
+		struct nlattr **attrs = genl_dumpit_info(cb)->info.attrs;
 		struct nlattr *mon[TIPC_NLA_MON_MAX + 1];
 
 		if (!attrs[TIPC_NLA_MON])
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index ef8e5139a873..bb1118d02f95 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3791,7 +3791,7 @@ int tipc_nl_publ_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct tipc_sock *tsk;
 
 	if (!tsk_portid) {
-		struct nlattr **attrs = genl_dumpit_info(cb)->attrs;
+		struct nlattr **attrs = genl_dumpit_info(cb)->info.attrs;
 		struct nlattr *sock[TIPC_NLA_SOCK_MAX + 1];
 
 		if (!attrs[TIPC_NLA_SOCK])
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 926232557e77..f892b0903dba 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -465,7 +465,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 	int i;
 
 	if (!bid && !skip_cnt) {
-		struct nlattr **attrs = genl_dumpit_info(cb)->attrs;
+		struct nlattr **attrs = genl_dumpit_info(cb)->info.attrs;
 		struct net *net = sock_net(skb->sk);
 		struct nlattr *battrs[TIPC_NLA_BEARER_MAX + 1];
 		char *bname;
-- 
2.41.0

