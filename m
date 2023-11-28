Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bMEbT6RH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524C51A5
	for <linux-wpan@vger.kernel.org>; Tue, 28 Nov 2023 03:29:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 489AE1BF209;
	Tue, 28 Nov 2023 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AieMMAAMvIPA9yTnSPTJY2WpYxdilRD1F1Iod7TcTuw=;
	b=bMEbT6RHtUpIGLEqk4uCYssUQzQBklvtVDSgFljrOENSlQl9yr6pLzLTWaTh98lp6eRTbE
	h7WDkbKRzH5ft2txwlhCARcQprzsXLENLSfj2h6UDdm9VdTRwAKodMXiuxyOY1NWvoH7Ox
	R0rPp35MYOvYdnz1wzwwYKzqFiD1BowdCR+3Ss62pZU3A9pd/h8LP1zFJDdKlzYDqs8iZx
	ZEWHDAJVai32OMGUWNrJ3Vf3vDjp+gPk1kwZ0sTEhMA4n3BVSuqxUmy0laef84TNuvdB4k
	pCM2AIJ1TN1Xvm/0y47ttL6qi0lSspSaqr1WR26+RZrEFTEFkrbm0bRNqQSzww==
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
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 1/2] iwpan: Synchronize nl802154.h with the latest association changes
Date: Tue, 28 Nov 2023 12:29:44 +0100
Message-Id: <20231128112945.509331-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128112945.509331-1-miquel.raynal@bootlin.com>
References: <20231128112945.509331-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Synchronize the header with Linux to get the new commands and attributes
in order to be able to interact about associations.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/nl802154.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index 410ee95..44706f0 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -64,6 +64,10 @@ enum nl802154_commands {
 	NL802154_CMD_SCAN_DONE,
 	NL802154_CMD_SEND_BEACONS,
 	NL802154_CMD_STOP_BEACONS,
+	NL802154_CMD_ASSOCIATE,
+	NL802154_CMD_DISASSOCIATE,
+	NL802154_CMD_SET_MAX_ASSOCIATIONS,
+	NL802154_CMD_LIST_ASSOCIATIONS,
 
 	/* add new commands above here */
 
@@ -133,6 +137,8 @@ enum nl802154_attrs {
 	NL802154_ATTR_SCAN_DURATION,
 	NL802154_ATTR_SCAN_DONE_REASON,
 	NL802154_ATTR_BEACON_INTERVAL,
+	NL802154_ATTR_MAX_ASSOCIATIONS,
+	NL802154_ATTR_PEER,
 
 	/* add attributes here, update the policy in nl802154.c */
 
@@ -372,8 +378,6 @@ enum nl802154_supported_bool_states {
 	NL802154_SUPPORTED_BOOL_MAX = __NL802154_SUPPORTED_BOOL_AFTER_LAST - 1
 };
 
-#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
-
 enum nl802154_dev_addr_modes {
 	NL802154_DEV_ADDR_NONE,
 	__NL802154_DEV_ADDR_INVALID,
@@ -393,12 +397,26 @@ enum nl802154_dev_addr_attrs {
 	NL802154_DEV_ADDR_ATTR_SHORT,
 	NL802154_DEV_ADDR_ATTR_EXTENDED,
 	NL802154_DEV_ADDR_ATTR_PAD,
+	NL802154_DEV_ADDR_ATTR_PEER_TYPE,
 
 	/* keep last */
 	__NL802154_DEV_ADDR_ATTR_AFTER_LAST,
 	NL802154_DEV_ADDR_ATTR_MAX = __NL802154_DEV_ADDR_ATTR_AFTER_LAST - 1
 };
 
+enum nl802154_peer_type {
+	NL802154_PEER_TYPE_UNSPEC,
+
+	NL802154_PEER_TYPE_PARENT,
+	NL802154_PEER_TYPE_CHILD,
+
+	/* keep last */
+	__NL802154_PEER_TYPE_AFTER_LAST,
+	NL802154_PEER_TYPE_MAX = __NL802154_PEER_TYPE_AFTER_LAST - 1
+};
+
+#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
+
 enum nl802154_key_id_modes {
 	NL802154_KEY_ID_MODE_IMPLICIT,
 	NL802154_KEY_ID_MODE_INDEX,
-- 
2.34.1

