Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lM3SiAEB"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8971A5;
	Tue, 28 Nov 2023 03:17:02 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F405EC000C;
	Tue, 28 Nov 2023 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHdGd2zzkKYvEZysTBsYqr5HfSWPcxyAVoJcqSobQ9g=;
	b=lM3SiAEBiKoKC6fToOH5g7dgKhjwcrv06zEayNvk79IaZX4Bi8BB+ki/1WRj0XnGLcD9L+
	qUeM4dTlD7G/4qjUbXX3WFV3k8MIq9jShzOSo/Rs/eMi3znBu8yd4HNr3OZH6n2mF16uzW
	YCwTfxkF+GlVzNPkPEW3EZexA+XbqcZw43XohyB3hCzrHlGGAxhBHd1xoM3dKwcQAIM4h2
	dN8zXEtrJRcR3C7jLjb0ZDp6TpgswiJmWXFID8HYWIdpUpgbe72ndLFO77362Th2cxFCAb
	4Av4YJ8mQB8WaDeQHCKR+3IlThCFddnHkUwkI+uO4VYGO4W2pH4GefyEzKPFYQ==
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
Subject: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator parameter when stamping packets
Date: Tue, 28 Nov 2023 12:16:52 +0100
Message-Id: <20231128111655.507479-3-miquel.raynal@bootlin.com>
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

ACKs come with the source and destination address empty, this has been
clarified already. But there is something else: if the destination
address is empty but the source address is valid, it may be a way to
reach the PAN coordinator. Either the device receiving this frame is the
PAN coordinator itself and should process what it just received
(PACKET_HOST) or it is not and may, if supported, relay the packet as it
is targeted to another device in the network.

Right now we do not support relaying so the packet should be dropped in
the first place, but the stamping looks more accurate this way.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 0024341ef9c5..e40a988d6c80 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -156,12 +156,15 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 	switch (mac_cb(skb)->dest.mode) {
 	case IEEE802154_ADDR_NONE:
-		if (hdr->source.mode != IEEE802154_ADDR_NONE)
-			/* FIXME: check if we are PAN coordinator */
-			skb->pkt_type = PACKET_OTHERHOST;
-		else
+		if (hdr->source.mode == IEEE802154_ADDR_NONE)
 			/* ACK comes with both addresses empty */
 			skb->pkt_type = PACKET_HOST;
+		else if (!wpan_dev->parent)
+			/* No dest means PAN coordinator is the recipient */
+			skb->pkt_type = PACKET_HOST;
+		else
+			/* We are not the PAN coordinator, just relaying */
+			skb->pkt_type = PACKET_OTHERHOST;
 		break;
 	case IEEE802154_ADDR_LONG:
 		if (mac_cb(skb)->dest.pan_id != span &&
-- 
2.34.1

