Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A26F0
	for <linux-wpan@vger.kernel.org>; Mon,  4 Dec 2023 10:31:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-0003Ex-Up; Mon, 04 Dec 2023 19:31:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-00DZmx-GY; Mon, 04 Dec 2023 19:31:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-00EE7r-7B; Mon, 04 Dec 2023 19:31:26 +0100
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
Subject: [PATCH net-next v2 9/9] ieee802154: hwsim: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:49 +0100
Message-ID:  <29b9d8edea7bc03d9726253afcc7259d4dd5d431.1701713943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=C0ftBvvArAEACL2sNAQ3DQ2N8lu4DJJST9N+PNpK0YY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbhrpAfo+Ey/oKNme5QtDMIBIZNARHKvIiADJZ gxujNE74d2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW4a6QAKCRCPgPtYfRL+ ThIMB/9PonopCsA6WMmgplNNDhzAM4byiT+LgjISMi175umw8zTQjvG2MGRqfZK3530xSZeBuae u+h3n4tQGbO203KsJJz0CEs4260Q2rwZbUi9GLWnMHRnWj9hZOKzgTHZ6QDRoCQgUmHsHNkGV3h SS+K2LHlQdY465kp2CJzvbztLV4nnBrCli59sNBNDl3O+4k1nPVc+2u76ElO1FCWhm+2ilm+iAO 8RyUZNiaCXNK/c/YYGd4sp07M3TBfUR15g392JJ1mwgWaGrNdCOwuyfh/0t+NhbCR3kUgTKYy5J Ic0dD7+OwEqrQEu5tG2EUjDsR6M/nR3fWOaqdxszYv1HmeCO
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
Link: https://lore.kernel.org/r/20231117095922.876489-11-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 31cba9aa7636..2c2483bbe780 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1035,7 +1035,7 @@ static int hwsim_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int hwsim_remove(struct platform_device *pdev)
+static void hwsim_remove(struct platform_device *pdev)
 {
 	struct hwsim_phy *phy, *tmp;
 
@@ -1043,13 +1043,11 @@ static int hwsim_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(phy, tmp, &hwsim_phys, list)
 		hwsim_del(phy);
 	mutex_unlock(&hwsim_phys_lock);
-
-	return 0;
 }
 
 static struct platform_driver mac802154hwsim_driver = {
 	.probe = hwsim_probe,
-	.remove = hwsim_remove,
+	.remove_new = hwsim_remove,
 	.driver = {
 			.name = "mac802154_hwsim",
 	},
-- 
2.42.0

