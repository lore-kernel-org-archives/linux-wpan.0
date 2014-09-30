Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:26432 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbaI3UeT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 30 Sep 2014 16:34:19 -0400
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ieee802154: add __init to lowpan_frags_sysctl_register
Date: Tue, 30 Sep 2014 22:34:08 +0200
Message-Id: <1412109249-7432-1-git-send-email-fabf@skynet.be>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

lowpan_frags_sysctl_register is only called by __init lowpan_net_frag_init
(part of the lowpan module).

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
This is untested.

 net/ieee802154/reassembly.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
index 32755cb..30ec608 100644
--- a/net/ieee802154/reassembly.c
+++ b/net/ieee802154/reassembly.c
@@ -485,7 +485,7 @@ static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
 
 static struct ctl_table_header *lowpan_ctl_header;
 
-static int lowpan_frags_sysctl_register(void)
+static int __init lowpan_frags_sysctl_register(void)
 {
 	lowpan_ctl_header = register_net_sysctl(&init_net,
 						"net/ieee802154/6lowpan",
@@ -498,7 +498,7 @@ static void lowpan_frags_sysctl_unregister(void)
 	unregister_net_sysctl_table(lowpan_ctl_header);
 }
 #else
-static inline int lowpan_frags_ns_sysctl_register(struct net *net)
+static inline int __init lowpan_frags_ns_sysctl_register(struct net *net)
 {
 	return 0;
 }
-- 
1.9.3

