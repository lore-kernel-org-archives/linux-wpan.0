Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38251 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbETH1O (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 03:27:14 -0400
Received: by wichy4 with SMTP id hy4so49232233wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 00:27:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: add missing cca ed level values
Date: Wed, 20 May 2015 09:27:03 +0200
Message-Id: <1432106823-1778-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch add missing values for at86rf212 ed level values. Currently
there are 15 values and the register setting supports 16 different ed
level values.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Craig Younkins <craig@freshtemp.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index d417ceb..2f25a5e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -892,12 +892,12 @@ static const s32 at86rf23x_ed_levels[AT86RF2XX_MAX_ED_LEVELS + 1] = {
 
 static const s32 at86rf212_ed_levels_100[AT86RF2XX_MAX_ED_LEVELS + 1] = {
 	-10000, -9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200,
-	-8000, -7800, -7600, -7400, -7200,
+	-8000, -7800, -7600, -7400, -7200, -7000,
 };
 
 static const s32 at86rf212_ed_levels_98[AT86RF2XX_MAX_ED_LEVELS + 1] = {
 	-9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200, -8000,
-	-7800, -7600, -7400, -7200, -7000,
+	-7800, -7600, -7400, -7200, -7000, -6800,
 };
 
 static inline int
-- 
2.3.7

