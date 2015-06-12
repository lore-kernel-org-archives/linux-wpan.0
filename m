Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35370 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbFLHPA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Jun 2015 03:15:00 -0400
Received: by pdbnf5 with SMTP id nf5so19118020pdb.2
        for <linux-wpan@vger.kernel.org>; Fri, 12 Jun 2015 00:14:59 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: rx packet handle cleanup
Date: Fri, 12 Jun 2015 12:44:24 +0530
Message-Id: <1434093264-19451-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch replaces !netif_running(sdata->dev) with
!ieee802154_sdata_running(sdata) and also devide the
code two separate if branches.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/rx.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 1bdf980..d93ad2d 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -202,8 +202,10 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
 	}
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE ||
-		    !netif_running(sdata->dev))
+		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE)
+			continue;
+
+		if (!ieee802154_sdata_running(sdata))
 			continue;
 
 		ieee802154_subif_frame(sdata, skb, &hdr);
-- 
1.7.9.5

