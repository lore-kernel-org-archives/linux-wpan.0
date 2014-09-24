Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:53691 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbaIXKWG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 06:22:06 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] mrf24j40: fix Missing a blank line after declarations
Date: Wed, 24 Sep 2014 12:21:30 +0200
Message-Id: <1411554093-14976-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkabhadram@gmail.com>, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkabhadram@gmail.com>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Acked-by: Alan Ott <alan@signal11.us>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 3 +++
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
2.1.0

