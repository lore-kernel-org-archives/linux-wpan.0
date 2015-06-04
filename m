Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34270 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbFDHiI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:38:08 -0400
Received: by payr10 with SMTP id r10so24236202pay.1
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:38:07 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCHv2 bluetooth-next] nl802154: export supported commands
Date: Thu,  4 Jun 2015 13:07:36 +0530
Message-Id: <1433403456-25913-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch will export the supported commands by the devices
to the userspace. This will be useful to check if HardMAC
drivers can support a specific command or not.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Acked-by: Alexander Aring <alex.aring@gmail.com>
---
changes since v1:
	o fix the commit message
	o update the policy in nl802154.c

 include/net/nl802154.h    |    2 ++
 net/ieee802154/nl802154.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 0badebd..6fc231e 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -102,6 +102,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_WPAN_PHY_CAPS,
 
+	NL802154_ATTR_SUPPORTED_COMMANDS,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 7dbb1f4..68f2401 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -228,6 +228,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 	[NL802154_ATTR_LBT_MODE] = { .type = NLA_U8, },
 
 	[NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
+
+	[NL802154_ATTR_SUPPORTED_COMMANDS] = { .type = NLA_NESTED },
 };
 
 /* message building helper */
@@ -372,7 +374,9 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 				  struct sk_buff *msg, u32 portid, u32 seq,
 				  int flags)
 {
+	struct nlattr *nl_cmds;
 	void *hdr;
+	int i;
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
@@ -431,6 +435,42 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 	if (nl802154_put_capabilities(msg, rdev))
 		goto nla_put_failure;
 
+	nl_cmds = nla_nest_start(msg, NL802154_ATTR_SUPPORTED_COMMANDS);
+	if (!nl_cmds)
+		goto nla_put_failure;
+
+	i = 0;
+#define CMD(op, n)							\
+	do {								\
+		if (rdev->ops->op) {					\
+			i++;						\
+			if (nla_put_u32(msg, i, NL802154_CMD_ ## n))	\
+				goto nla_put_failure;			\
+		}							\
+	} while (0)
+
+	CMD(add_virtual_intf, NEW_INTERFACE);
+	CMD(del_virtual_intf, DEL_INTERFACE);
+	CMD(set_channel, SET_CHANNEL);
+	CMD(set_pan_id, SET_PAN_ID);
+	CMD(set_short_addr, SET_SHORT_ADDR);
+	CMD(set_backoff_exponent, SET_BACKOFF_EXPONENT);
+	CMD(set_max_csma_backoffs, SET_MAX_CSMA_BACKOFFS);
+	CMD(set_max_frame_retries, SET_MAX_FRAME_RETRIES);
+	CMD(set_lbt_mode, SET_LBT_MODE);
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
+		CMD(set_tx_power, SET_TX_POWER);
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_ED_LEVEL)
+		CMD(set_cca_ed_level, SET_CCA_ED_LEVEL);
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE)
+		CMD(set_cca_mode, SET_CCA_MODE);
+
+#undef CMD
+	nla_nest_end(msg, nl_cmds);
+
 finish:
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
1.7.9.5

