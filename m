Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:45352 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757815AbeD0VYn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Apr 2018 17:24:43 -0400
Received: by mail-io0-f195.google.com with SMTP id r22-v6so4014851ioc.12
        for <linux-wpan@vger.kernel.org>; Fri, 27 Apr 2018 14:24:43 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [RFC PATCH wpan-tools 1/2] wpan-ping: fix ifname setting
Date: Fri, 27 Apr 2018 17:24:17 -0400
Message-Id: <20180427212418.29729-2-aring@mojatatu.com>
In-Reply-To: <20180427212418.29729-1-aring@mojatatu.com>
References: <20180427212418.29729-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch fix ifname setting, we should use the ifname stored inside
this string and not give the programming declaration where to find the
string. Founded by code inspection.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 wpan-ping/wpan-ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index f825b22..791346c 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -194,7 +194,7 @@ static int get_interface_info(struct config *conf) {
 	nl_socket_modify_cb(conf->nl_sock, NL_CB_VALID, NL_CB_CUSTOM, nl_msg_cb, conf);
 	msg = nlmsg_alloc();
 	genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, conf->nl802154_id, 0, NLM_F_DUMP, NL802154_CMD_GET_INTERFACE, 0);
-	nla_put_string(msg, NL802154_ATTR_IFNAME, "conf->interface");
+	nla_put_string(msg, NL802154_ATTR_IFNAME, conf->interface);
 	nl_send_sync(conf->nl_sock, msg);
 
 	nl802154_cleanup(conf);
-- 
2.11.0

