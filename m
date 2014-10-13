Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56917 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaJMId0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 04:33:26 -0400
Received: by mail-wi0-f174.google.com with SMTP id h11so2970322wiw.7
        for <linux-wpan@vger.kernel.org>; Mon, 13 Oct 2014 01:33:25 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] ieee802154: 6lowpan: add RTNL assertion
Date: Mon, 13 Oct 2014 10:33:07 +0200
Message-Id: <1413189187-27123-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1413189187-27123-1-git-send-email-alex.aring@gmail.com>
References: <1413189187-27123-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch ensure that the rtnl lock is hold while newlink callback.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index da78fae..0c1a49b 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -584,6 +584,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	struct lowpan_dev_record *entry;
 	int ret;
 
+	ASSERT_RTNL();
+
 	pr_debug("adding new link\n");
 
 	if (!tb[IFLA_LINK])
-- 
2.1.2

