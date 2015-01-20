Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35108 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbbATU6O (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:58:14 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so15052641wid.2
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 12:58:13 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/4] ieee802154: 6lowpan: fix ARPHRD to ARPHRD_6LOWPAN
Date: Tue, 20 Jan 2015 21:57:40 +0100
Message-Id: <1421787462-24042-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
References: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Currently there exists two interface types with ARPHRD_IEEE802154. These
are the 802.15.4 interfaces and 802.15.4 6LoWPAN interfaces. This is
more a bug because some userspace applications checks on this value like
wireshark. This occurs that wireshark will always try to parse a lowpan
interface as 802.15.4 frames. With ARPHRD_6LOWPAN wireshark will parse
it as IPv6 frames which is correct.

Much applications checks on this value to readout the EUI64 mac address
which should be the same for ARPHRD_6LOWPAN. BTLE 6LoWPAN and ieee802154
6LoWPAN will share now the same ARPHRD.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 055fbb7..9dbe0d69 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -113,7 +113,7 @@ static void lowpan_setup(struct net_device *dev)
 {
 	dev->addr_len		= IEEE802154_ADDR_LEN;
 	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
-	dev->type		= ARPHRD_IEEE802154;
+	dev->type		= ARPHRD_6LOWPAN;
 	/* Frame Control + Sequence Number + Address fields + Security Header */
 	dev->hard_header_len	= 2 + 1 + 20 + 14;
 	dev->needed_tailroom	= 2; /* FCS */
-- 
2.2.2

