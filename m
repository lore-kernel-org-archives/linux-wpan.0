Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43030 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbaKHRBA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Nov 2014 12:01:00 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so6997212wiv.1
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 09:00:58 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/5] interface: backoff exponents print human readable
Date: Sat,  8 Nov 2014 18:00:47 +0100
Message-Id: <1415466050-2630-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
References: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

First print the minumum then the maxmimum backoff exponent attributes.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/interface.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/interface.c b/src/interface.c
index 808b246..40c18ef 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -160,12 +160,12 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		printf("%s\twpan_phy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
 	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
 		printf("%s\tmax_frame_retries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
+	if (tb_msg[NL802154_ATTR_MIN_BE])
+		printf("%s\tmin_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MIN_BE]));
 	if (tb_msg[NL802154_ATTR_MAX_BE])
 		printf("%s\tmax_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_BE]));
 	if (tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS])
 		printf("%s\tmax_csma_backoffs %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS]));
-	if (tb_msg[NL802154_ATTR_MIN_BE])
-		printf("%s\tmin_be %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MIN_BE]));
 	if (tb_msg[NL802154_ATTR_LBT_MODE])
 		printf("%s\tlbt %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_LBT_MODE]));
 
@@ -181,7 +181,6 @@ static int handle_interface_info(struct nl802154_state *state,
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, print_iface_handler, NULL);
 	return 0;
 }
-
 TOPLEVEL(info, NULL, NL802154_CMD_GET_INTERFACE, 0, CIB_NETDEV, handle_interface_info,
 	 "Show information for this interface.");
 
-- 
2.1.3

