Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35736 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbFCEOf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 00:14:35 -0400
Received: by padjw17 with SMTP id jw17so75255155pad.2
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 21:14:35 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] nl802154: export supported commands
Date: Wed,  3 Jun 2015 09:44:01 +0530
Message-Id: <1433304841-12734-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch will export the supported commands by the devices
to the user. This is required because user should know supported
commands by the IEEE-802.15.4 devices. Drivers that are there in
the mainline are not supporting all the functionalities that the
core is providing to us.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/nl802154.h    |    2 ++
 net/ieee802154/nl802154.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index 7dbb1f4..310a519 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -372,7 +372,9 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 				  struct sk_buff *msg, u32 portid, u32 seq,
 				  int flags)
 {
+	struct nlattr *nl_cmds;
 	void *hdr;
+	int i;
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
@@ -431,6 +433,40 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
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
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
+		CMD(set_tx_power, SET_TX_POWER);
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_ED_LEVEL)
+		CMD(set_cca_ed_level, SET_CCA_ED_LEVEL);
+
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE)
+		CMD(set_cca_mode, SET_CCA_MODE);
+#undef CMD
+	nla_nest_end(msg, nl_cmds);
+
 finish:
 	genlmsg_end(msg, hdr);
 	return 0;
-- 
1.7.9.5

