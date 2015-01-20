Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:54373 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbbATKgV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 05:36:21 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so14533951wev.8
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 02:36:20 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/2] interface: remove twice phy information
Date: Tue, 20 Jan 2015 11:35:40 +0100
Message-Id: <1421750140-24760-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
References: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
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
index 9e59f15..559a104 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -212,8 +212,6 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID])));
 	if (tb_msg[NL802154_ATTR_IFTYPE])
 		printf("%s\ttype %s\n", indent, iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
-	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
-		printf("%s\tWPANphy %d\n", indent, nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
 	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
 		printf("%s\tframeretries %d\n", indent, nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
 	if (tb_msg[NL802154_ATTR_MIN_BE])
-- 
2.2.2

