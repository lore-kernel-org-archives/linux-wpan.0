Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33406 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbbFBFka (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 01:40:30 -0400
Received: by pdbqa5 with SMTP id qa5so125001241pdb.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 22:40:29 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [RFC bluetooth-next] nl802154: export supported commands
Date: Tue,  2 Jun 2015 11:09:59 +0530
Message-Id: <1433223599-22548-1-git-send-email-varkab@cdac.in>
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
Hi,

I am looking for the way to export the following commands
	o NL802154_CMD_SET_MAX_FRAME_RETRIES
        o NL802154_CMD_SET_BACKOFF_EXPONENT
        o NL802154_CMD_SET_MAX_CSMA_BACKOFFS

Any inputs..?

Thanks,
Varka Bhadram.

 include/net/nl802154.h    |    2 ++
 net/ieee802154/nl802154.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

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
index 7dbb1f4..29e1ecd 100644
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
@@ -431,6 +433,37 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
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

