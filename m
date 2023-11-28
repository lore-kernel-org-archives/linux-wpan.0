Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G2Dxk8Qu"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4656109;
	Tue, 28 Nov 2023 03:17:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 819CCC0007;
	Tue, 28 Nov 2023 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+Ca0i6LS9EErxIJcnfDTMGUbmzhckltyA1nENhzjEE=;
	b=G2Dxk8Qur2PT0FS20ThRlbIYV8LVyg55LGKiLObgI6cZgEtEwHnNBMfrHkPS7YOq58W+UL
	zdWABnrVsoAuDYFlXZOi17fH+5iVeA/+NH9SEYu0ddDEVFhCYv8TaGnj2+lqDwXP3waPWH
	uEw1Qfe3uDTnmAewTRVr/wKGgTxFpoCqNTeC3cdP735QblUrilJPvuSp/mF1N7BJDmoUwH
	03TbgzXLs4z2d9qaRhHsrAzHL/ia8qBYSkVE1JLPLD5+42on8HRx7AOTqnnjop3XZep8s0
	C2HF8SlbXI6mj0bmpZSFPlPsHyN/0kTc6b0KN7IRU+Ji2QRmsoJ3TVJTaM9Rzg==
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
Subject: [PATCH wpan-next 4/5] ieee802154: Avoid confusing changes after associating
Date: Tue, 28 Nov 2023 12:16:54 +0100
Message-Id: <20231128111655.507479-5-miquel.raynal@bootlin.com>
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

Once associated with any device, we are part of a PAN (with a specific
PAN ID), and we are expected to be present on a particular
channel. Let's avoid confusing other devices by preventing any PAN
ID/channel change once associated.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/nl802154.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index e4d290d0e0a0..5c73b5fcadc0 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1087,6 +1087,15 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 
 	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
 
+	/* Only allow changing the PAN ID when the device has no more
+	 * associations ongoing to avoid confusing peers.
+	 */
+	if (cfg802154_device_is_associated(wpan_dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Existing associations, changing PAN ID forbidden");
+		return -EINVAL;
+	}
+
 	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
 }
 
@@ -1113,20 +1122,17 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 
 	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
 
-	/* TODO
-	 * I am not sure about to check here on broadcast short_addr.
-	 * Broadcast is a valid setting, comment from 802.15.4:
-	 * A value of 0xfffe indicates that the device has
-	 * associated but has not been allocated an address. A
-	 * value of 0xffff indicates that the device does not
-	 * have a short address.
-	 *
-	 * I think we should allow to set these settings but
-	 * don't allow to allow socket communication with it.
+	/* The short address only has a meaning when part of a PAN, after a
+	 * proper association procedure. However, we want to still offer the
+	 * possibility to create static networks so changing the short address
+	 * is only allowed when not already associated to other devices with
+	 * the official handshake.
 	 */
-	if (short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC) ||
-	    short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST))
+	if (cfg802154_device_is_associated(wpan_dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Existing associations, changing short address forbidden");
 		return -EINVAL;
+	}
 
 	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
 }
-- 
2.34.1

