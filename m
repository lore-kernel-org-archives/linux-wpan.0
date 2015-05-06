Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34331 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbEFLnU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:43:20 -0400
Received: by wicmx19 with SMTP id mx19so123086579wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:43:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 1/2] treewide: change transmit power to mbm
Date: Wed,  6 May 2015 13:43:06 +0200
Message-Id: <1430912587-17824-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the transmit power nl802154 setting variable to
handle as a mbm values instead dbm.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c      | 2 +-
 src/iwpan.h     | 5 +++++
 src/nl_extras.h | 5 +++++
 src/phy.c       | 4 ++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/info.c b/src/info.c
index e155470..c52d304 100644
--- a/src/info.c
+++ b/src/info.c
@@ -83,7 +83,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_TX_POWER])
-		printf("tx_power: %d\n", nla_get_s8(tb_msg[NL802154_ATTR_TX_POWER]));
+		printf("tx_power: %.2g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_TX_POWER])));
 
 	return 0;
 }
diff --git a/src/iwpan.h b/src/iwpan.h
index 867bb18..2c309fc 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -107,6 +107,11 @@ struct cmd {
 #define DECLARE_SECTION(_name)						\
 	extern struct cmd __section ## _ ## _name;
 
+#define DBM_TO_MBM(gain)						\
+	((int)(((float)gain) * 100))
+#define MBM_TO_DBM(gain)						\
+	((float)(gain) / 100)
+
 int handle_cmd(struct nl802154_state *state, enum id_input idby,
 	       int argc, char **argv);
 
diff --git a/src/nl_extras.h b/src/nl_extras.h
index a591461..9d841aa 100644
--- a/src/nl_extras.h
+++ b/src/nl_extras.h
@@ -28,6 +28,11 @@ static inline int8_t nla_get_s8(struct nlattr *nla)
 #define NLA_PUT_S32(n, attrtype, value) \
 	NLA_PUT_TYPE(n, int32_t, attrtype, value)
 
+static inline int32_t nla_get_s32(struct nlattr *nla)
+{
+	return *(int32_t *) nla_data(nla);
+}
+
 #endif /* NLA_S32 */
 
 #ifndef NLA_S64
diff --git a/src/phy.c b/src/phy.c
index 2e25013..ee0e7ad 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -64,7 +64,7 @@ static int handle_tx_power_set(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
-	NLA_PUT_S8(msg, NL802154_ATTR_TX_POWER, dbm);
+	NLA_PUT_S32(msg, NL802154_ATTR_TX_POWER, DBM_TO_MBM(dbm));
 
 	return 0;
 
@@ -132,7 +132,7 @@ static int handle_cca_ed_level(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
-	NLA_PUT_S32(msg, NL802154_ATTR_CCA_ED_LEVEL, level);
+	NLA_PUT_S32(msg, NL802154_ATTR_CCA_ED_LEVEL, DBM_TO_MBM(level));
 
 	return 0;
 
-- 
2.3.7

