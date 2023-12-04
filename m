Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5DD2
	for <linux-wpan@vger.kernel.org>; Mon,  4 Dec 2023 10:31:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-0003EH-OW; Mon, 04 Dec 2023 19:31:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-00DZmu-Ae; Mon, 04 Dec 2023 19:31:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-00EE7o-1D; Mon, 04 Dec 2023 19:31:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 8/9] ieee802154: fakelb: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:48 +0100
Message-ID:  <aa5b6901307cea817df96c123053520a86556aca.1701713943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VKch1ipn7t8ZInXZC+JnFjON308+uqyTcVJMg2wIeM8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbhrmwJOkHywfcmrDcxQWT339/zMTPTD/SY/Ke QjXCz4e5dWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW4a5gAKCRCPgPtYfRL+ TsV7CACYnV6EbdFEaM+ItV2iYgTAbMMT6CZWp9HsqAcJNbcUEBij5A44OBGQ8D0LgDwu05RkN4k OW1kcaPSEDuQxfIatMcMGm/RnIMbwPIR0pYA40eq+9ZKmzrFqcetwKwS/BRs8iJkHXQtMSwDmW8 4LnuZiz6+N4EE3cdqJWaICNaLjgJw9THxK+Tgv0Cx/19DiYgAfPVXL0JmvrSXPAO31mHyHOs1FZ ZVNoa/qWzQfoCooqhKtuRxbXbMuyKvUe1a967Btff4BfKarohbv1PIO2Nm8Vcdeu1knETtxq8zF 5eO55GqY/9dgM+BEUJuSMdZ44fEKTlslEEpqX4gB+xlP49t0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wpan@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Link: https://lore.kernel.org/r/20231117095922.876489-10-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ieee802154/fakelb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 523d13ee02bf..35e55f198e05 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -221,7 +221,7 @@ static int fakelb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int fakelb_remove(struct platform_device *pdev)
+static void fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *tmp;
 
@@ -229,14 +229,13 @@ static int fakelb_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
 	mutex_unlock(&fakelb_phys_lock);
-	return 0;
 }
 
 static struct platform_device *ieee802154fake_dev;
 
 static struct platform_driver ieee802154fake_driver = {
 	.probe = fakelb_probe,
-	.remove = fakelb_remove,
+	.remove_new = fakelb_remove,
 	.driver = {
 			.name = "ieee802154fakelb",
 	},
-- 
2.42.0

