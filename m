Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57961 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbaIPEvW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 00:51:22 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: mrf24j40: fix Missing a blank line after declarations
Date: Tue, 16 Sep 2014 10:18:40 +0530
Message-Id: <1410842922-10564-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1410842922-10564-1-git-send-email-varkab@cdac.in>
References: <1410842922-10564-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/mrf24j40.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 9e6a124..466da57 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -412,6 +412,7 @@ static void mrf24j40_stop(struct ieee802154_dev *dev)
 	struct mrf24j40 *devrec = dev->priv;
 	u8 val;
 	int ret;
+
 	dev_dbg(printdev(devrec), "stop\n");
 
 	ret = read_short_reg(devrec, REG_INTCON, &val);
@@ -465,6 +466,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 	if (changed & IEEE802515_AFILT_SADDR_CHANGED) {
 		/* Short Addr */
 		u8 addrh, addrl;
+
 		addrh = le16_to_cpu(filt->short_addr) >> 8 & 0xff;
 		addrl = le16_to_cpu(filt->short_addr) & 0xff;
 
@@ -493,6 +495,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
 		/* PAN ID */
 		u8 panidl, panidh;
+
 		panidh = le16_to_cpu(filt->pan_id) >> 8 & 0xff;
 		panidl = le16_to_cpu(filt->pan_id) & 0xff;
 		write_short_reg(devrec, REG_PANIDH, panidh);
-- 
1.7.9.5

