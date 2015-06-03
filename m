Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46232 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754005AbbFCLrf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 07:47:35 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id C0DD2140D7F
	for <linux-wpan@vger.kernel.org>; Wed,  3 Jun 2015 07:47:33 -0400 (EDT)
Date: Wed, 3 Jun 2015 13:47:27 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools] info: add frequency output to current channel
Message-ID: <20150603114722.GA7329@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
Not much to say here but I realised that the formatting done by
print_freq_handler() add extra whitespaces when not needed e.g. when used for
the current_channel output. I'm thinking about refactoring print_freq_handler()
to get_freq() and return the float which in the end will let the caller do the
formatting.

As an example to this problem default channel of 13 for channel page 0 with the
openlabs SPI board for RPi will print 2 whitespaces instead of one which would
look better.

	current_channel: 13,  2415 MHz

It's not a big deal but I've put it on my todo list.

 src/info.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/info.c b/src/info.c
index cd6b2b74172e..9e27176f53e6 100644
--- a/src/info.c
+++ b/src/info.c
@@ -193,8 +193,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	if (tb_msg[NL802154_ATTR_PAGE])
 		printf("current_page: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_PAGE]));
 
-	if (tb_msg[NL802154_ATTR_CHANNEL])
-		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+	if (tb_msg[NL802154_ATTR_CHANNEL] &&
+	    tb_msg[NL802154_ATTR_PAGE]) {
+		printf("current_channel: %d, ", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+		print_freq_handler(nla_get_u8(tb_msg[NL802154_ATTR_PAGE]),
+				   nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+		printf(" MHz\n");
+	}
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
 		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
-- 
1.9.1


-- 
Christoffer Holmstedt
