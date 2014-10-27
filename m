Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:58253 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbaJ0QOU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:20 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so3363809wiv.15
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 10/16] mac802154: rx: add monitor pkt_type information
Date: Mon, 27 Oct 2014 17:13:37 +0100
Message-Id: <1414426423-24856-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a PACKET_OTHERHOST setting when a monitor interface
receives a skb. All receiving skb's to the monitor interface should
be PACKET_OTHERHOST.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 14eecac..f7f09b4 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -228,6 +228,7 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	u8 *data;
 
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->pkt_type = PACKET_OTHERHOST;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	rcu_read_lock();
-- 
2.1.2

