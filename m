Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hDD7HRH6"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E9109;
	Tue, 28 Nov 2023 03:17:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91213C000F;
	Tue, 28 Nov 2023 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTh1FtK8KxFr4g7tE0WFtAC6xt11QyMpr4cp9khROnQ=;
	b=hDD7HRH6glOLkZIQfmkpTAt/Iffn8WSug+GMZs5ApFRw3mrpxb1xMxszo6vE84WHZfDVt+
	8WlCSH05ZRNOMzOe8xU0/6VNxEJZ3cD4ks4YAtY/MWfzJqnpg2va4H3sSiQ+bhIcVsyhLv
	D2vE7ahDThBcYirvX+gO8uMqdB8gHSNMZv+xDOHNMK4aVuow0nUHldoJidDaOJgcm6RhoG
	xh6m4fXUiVF38/9S6t/HbxkfrEMP5MlkXbYvdFT4ufA3t+lAACM+WtIQ5cXyP0rt5boq7C
	SsRua32772EI5coKjl9NjM5bWhF/G/Y4chaxQ+ZeF3m6C+qMCdzCjCXMlmisfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next 1/5] mac80254: Provide real PAN coordinator info in beacons
Date: Tue, 28 Nov 2023 12:16:51 +0100
Message-Id: <20231128111655.507479-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-1-miquel.raynal@bootlin.com>
References: <20231128111655.507479-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: miquel.raynal@bootlin.com

Sending a beacon is a way to advertise a PAN, but also ourselves as
coordinator in the PAN. There is only one PAN coordinator in a PAN, this
is the device without parent (not associated itself to an "upper"
coordinator). Instead of blindly saying that we are the PAN coordinator,
let's actually use our internal information to fill this field.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 7597072aed57..5873da634fb4 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -466,6 +466,7 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
 				  struct cfg802154_beacon_request *request)
 {
 	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
 	ASSERT_RTNL();
 
@@ -495,8 +496,7 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
 		local->beacon.mac_pl.superframe_order = request->interval;
 	local->beacon.mac_pl.final_cap_slot = 0xf;
 	local->beacon.mac_pl.battery_life_ext = 0;
-	/* TODO: Fill this field with the coordinator situation in the network */
-	local->beacon.mac_pl.pan_coordinator = 1;
+	local->beacon.mac_pl.pan_coordinator = !wpan_dev->parent;
 	local->beacon.mac_pl.assoc_permit = 1;
 
 	if (request->interval == IEEE802154_ACTIVE_SCAN_DURATION)
-- 
2.34.1

