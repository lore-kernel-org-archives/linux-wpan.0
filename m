Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:56849 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbbATUDH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:03:07 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so18524549wev.8
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 12:03:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 1/2] interface: remove twice phy information
Date: Tue, 20 Jan 2015 21:02:34 +0100
Message-Id: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

The phy information is already shown in a previous printout and this
code seems that it was never be functional.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/interface.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/interface.c b/src/interface.c
index 095753b..904b96e 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -212,8 +212,6 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID])));
 	if (tb_msg[NL802154_ATTR_IFTYPE])
 		printf("%s\ttype %s\n", indent, iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
-	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
-		printf("%s\twpan_phy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
 	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
 		printf("%s\tmax_frame_retries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
 	if (tb_msg[NL802154_ATTR_MIN_BE])
-- 
2.2.2

