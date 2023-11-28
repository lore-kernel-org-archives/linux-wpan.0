Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RVRvW61c"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200DD6;
	Tue, 28 Nov 2023 03:17:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C018C0006;
	Tue, 28 Nov 2023 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iBZtX0anCTLAf+AwYFYTLyMCZwBIcSzyfNNx7MAlns=;
	b=RVRvW61cnZWSwOBY42XNQW84SmWKFinNae68YCtEy2gHgFJNW0gX/NM0sfwAcmQFfXqhZJ
	exwHNWHChGQG5cqQHgrMxDd+CdtY6eJ+98aA8ndr4iDKcjSXHbaw6kARoVC6t9/gZW725j
	iIjr8vRJ1qa2s+drj2ZO9TWMLlM1SS/YdaOfWRRQycZLRZ2uIitBj7kyF47rfpIa6Xk2qy
	HSlkszwtD/vWGQ1/LXenZA07GOMGM3/S6l9JcAJo9rl4/6WGF9qZy9CtDXKwVe0bAj/FWd
	ZD/B2MJFTeFhYjQ2o6EaHUbyBtqdqc7CBndFsObAsO0E1RFRGcF0hLm85aQRLA==
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
Subject: [PATCH wpan-next 3/5] mac802154: Only allow PAN controllers to process association requests
Date: Tue, 28 Nov 2023 12:16:53 +0100
Message-Id: <20231128111655.507479-4-miquel.raynal@bootlin.com>
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
X-GND-Sasl: miquel.raynal@bootlin.com

It is not very clear in the specification whether simple coordinators
are allowed or not to answer to association requests themselves. As
there is no synchronization mechanism, it is probably best to rely on
the relay feature of these coordinators and avoid processing them in
this case.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 5873da634fb4..1c0eeaa76560 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -781,6 +781,12 @@ int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
 		 unlikely(dest->short_addr != wpan_dev->short_addr))
 		return -ENODEV;
 
+	if (wpan_dev->parent) {
+		dev_dbg(&sdata->dev->dev,
+			"Ignoring ASSOC REQ, not the PAN coordinator\n");
+		return -ENODEV;
+	}
+
 	mutex_lock(&wpan_dev->association_lock);
 
 	memcpy(&assoc_req_pl, skb->data, sizeof(assoc_req_pl));
-- 
2.34.1

