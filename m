Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ho7KjvDe"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B519194;
	Tue, 28 Nov 2023 03:17:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B27ACC0002;
	Tue, 28 Nov 2023 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ys3ca1B1UbKD/hiXV7EsopdZfBXR8sughDSJmOeFnyk=;
	b=Ho7KjvDexQzSqAv63wwaQOpUvXBMFGvCJV0GOxTcyAtlOqVm3wiRSLCr4CM078PfqZzoD7
	Gb7gOOTH95wib/m5+LV2lEeakJ0TMqcoHV6u+C5ytFsHz3+T1uiEDuLmMr7UQXYsJUSx6r
	UVmSvwbMpb7sohIG0WUWE12nxLQU7WvMUA1JVY4Zb/MJxAytiuixUDLMgjyNsidzVwak7i
	fk+D9S2JjQeW9LHEs0N/DMs5bEC6NS97rbpM4eF33QwuHlp9k0HboLmEvz2vv1MrvorfHp
	w9l9DqrWceTH37ZsHmILT5nadyFHbkqF78Tb1DycptAsYsOwfebOeUBUu1nQag==
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
Subject: [PATCH wpan-next 5/5] mac802154: Avoid new associations while disassociating
Date: Tue, 28 Nov 2023 12:16:55 +0100
Message-Id: <20231128111655.507479-6-miquel.raynal@bootlin.com>
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

While disassociating from a PAN ourselves, let's set the maximum number
of associations temporarily to zero to be sure no new device tries to
associate with us.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h |  4 +++-
 net/ieee802154/pan.c    |  8 +++++++-
 net/mac802154/cfg.c     | 11 ++++++++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index a64bbcd71f10..cd95711b12b8 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -589,8 +589,10 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
  * cfg802154_set_max_associations - Limit the number of future associations
  * @wpan_dev: the wpan device
  * @max: the maximum number of devices we accept to associate
+ * @return: the old maximum value
  */
-void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max);
+unsigned int cfg802154_set_max_associations(struct wpan_dev *wpan_dev,
+					    unsigned int max);
 
 /**
  * cfg802154_get_free_short_addr - Get a free address among the known devices
diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
index fb5b0af2ef68..249df7364b3e 100644
--- a/net/ieee802154/pan.c
+++ b/net/ieee802154/pan.c
@@ -94,10 +94,16 @@ __le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
 }
 EXPORT_SYMBOL_GPL(cfg802154_get_free_short_addr);
 
-void cfg802154_set_max_associations(struct wpan_dev *wpan_dev, unsigned int max)
+unsigned int cfg802154_set_max_associations(struct wpan_dev *wpan_dev,
+					    unsigned int max)
 {
+	unsigned int old_max;
+
 	lockdep_assert_held(&wpan_dev->association_lock);
 
+	old_max = wpan_dev->max_associations;
 	wpan_dev->max_associations = max;
+
+	return old_max;
 }
 EXPORT_SYMBOL_GPL(cfg802154_set_max_associations);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 17e2032fac24..ef7f23af043f 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -389,6 +389,7 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 	struct ieee802154_pan_device *child, *tmp;
 	struct ieee802154_sub_if_data *sdata;
+	unsigned int max_assoc;
 	u64 eaddr;
 	int ret;
 
@@ -397,6 +398,7 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
 	/* Start by disassociating all the children and preventing new ones to
 	 * attempt associations.
 	 */
+	max_assoc = cfg802154_set_max_associations(wpan_dev, 0);
 	list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
 		ret = mac802154_send_disassociation_notif(sdata, child,
 							  IEEE802154_COORD_WISHES_DEVICE_TO_LEAVE);
@@ -429,14 +431,17 @@ static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_phy,
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
 		ret = drv_set_pan_id(local, wpan_dev->pan_id);
 		if (ret < 0)
-			return ret;
+			goto reset_mac_assoc;
 
 		ret = drv_set_short_addr(local, wpan_dev->short_addr);
 		if (ret < 0)
-			return ret;
+			goto reset_mac_assoc;
 	}
 
-	return 0;
+reset_mac_assoc:
+	cfg802154_set_max_associations(wpan_dev, max_assoc);
+
+	return ret;
 }
 
 static int mac802154_disassociate_child(struct wpan_phy *wpan_phy,
-- 
2.34.1

