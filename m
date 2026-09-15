Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE24334D9;
	Tue, 15 Sep 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506947; cv=none; b=udbCeL+yITuTL3aun80PfJdOMN7NYxKgnVXc1OocoHDQ+iaU9IZJ9a5xyddaRl19TIv8JNVpJUOgIrA6XBXh5F/pRb6Xu9C2q1NIxED3iA0TRr0aPkKxuuWk3bb0CVVLDd1Ii3NFv6oq63foFTlQ5gac3GPHLPGfyhPjWnnWXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506947; c=relaxed/simple;
	bh=ZWIPmxZIRPtAJUK64uNIOw84oWmTE0xtUx4xmXtLmPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pnz4HpDjSI85dRLN4NF++qlpsFbJkgJunk/7AovjIv9BHsDDcB6CKWDpMw0sTR6VSTa8+4KJZa7dmUhezfcaqO2n+gppQiQLXiI6qQbWk7b1ckI9rrd71KkiKQD1hANjfI6bRZw9/Zf72DWnr5GLgQxeiQB6l+C4FwefTJvz+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jALh3Yti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jALh3Yti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF541F000FF;
	Tue, 15 Sep 2026 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789506945;
	bh=ATzlIC5DGR/Ykzi6sMrsoydXianMMUqn5kUle+o93UI=;
	h=From:To:Cc:Subject:Date;
	b=jALh3YtiHPjSENN2sq2sh351puKQFiGci3dJCKlDuzVCilAqGXfyjZHUJ98V+Y692
	 FWQaccUjDmo4AHyCWZWvXEeZ9+S/tfIToyESmphOp5msz6tD8KnkIEDZ8+99NyK80q
	 XpaMQzjL8pBdXhePXIPd71SFE4FKzzNbsExqdM/jBuVw/40HPtRfuxUxyMWrL4NwUD
	 b8VzmxkBMx3WBxrVpk6MhEDhlIYF6i6FbzgM2n5MwmyY2e2scpUtUxc1nxo+GyBtcc
	 FBtRFxBTgf8w8Qfu2ql9BF6E68lUkWx8QWzecopxWWdowQuuwyeI+KLD6rEj0zePs9
	 UlMmJq8KRjM8w==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Ibrahim Hashimov <security@auditcode.ai>,
	Kees Cook <kees@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [net-next v3] ieee802154: avoid deprecated .ndo_do_ioctl callback
Date: Tue, 15 Sep 2026 23:14:03 +0200
Message-ID: <20260915211538.1519815-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The ieee802154 socket implementation is the last remaining caller of the
netdevice ioctl callback. In order to completely remove this, add a custom
pointer to the existing wpan_dev specific operations structure. Since that
structure is currently only used to wrap the 'create' header operation,
adjust the naming slightly to make this more generic.

It would be a good idea to adjust the calling conventions and split the
get/set operations into separate functions, but that can be a follow-up
cleanup. For the moment, I kept the actual changes to a minimum to
avoid regressions.

Link: https://lore.kernel.org/all/20231011140225.253106-2-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this one in my stack of old patches. It's been a while
since v2, but the patch is still valid.
---
 include/net/cfg802154.h | 9 +++++----
 net/ieee802154/socket.c | 5 +++--
 net/mac802154/iface.c   | 8 ++++----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 2e960441ea49..2c5dcf6a106f 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -458,15 +458,16 @@ struct ieee802154_llsec_device_key {
 	u32 frame_counter;
 };
 
-struct wpan_dev_header_ops {
+struct wpan_dev_ops {
 	/* TODO create callback currently assumes ieee802154_mac_cb inside
 	 * skb->cb. This should be changed to give these information as
 	 * parameter.
 	 */
-	int	(*create)(struct sk_buff *skb, struct net_device *dev,
+	int	(*header_create)(struct sk_buff *skb, struct net_device *dev,
 			  const struct ieee802154_addr *daddr,
 			  const struct ieee802154_addr *saddr,
 			  unsigned int len);
+	int	(*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
 };
 
 struct wpan_dev {
@@ -477,7 +478,7 @@ struct wpan_dev {
 	struct list_head list;
 	struct net_device *netdev;
 
-	const struct wpan_dev_header_ops *header_ops;
+	const struct wpan_dev_ops *ops;
 
 	/* lowpan interface, set when the wpan_dev belongs to one lowpan_dev */
 	struct net_device *lowpan_dev;
@@ -523,7 +524,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 {
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
 
-	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+	return wpan_dev->ops->header_create(skb, dev, daddr, saddr, len);
 }
 #endif
 
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 5a36e87893f6..be8ca1f053a2 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -139,8 +139,9 @@ static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->type == ARPHRD_IEEE802154 && dev->netdev_ops->ndo_do_ioctl)
-		ret = dev->netdev_ops->ndo_do_ioctl(dev, &ifr, cmd);
+	if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr &&
+	    dev->ieee802154_ptr->ops)
+		ret = dev->ieee802154_ptr->ops->ioctl(dev, &ifr, cmd);
 
 	if (!ret && put_user_ifreq(&ifr, arg))
 		ret = -EFAULT;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 799f94347667..f437b8daa00d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -406,8 +406,9 @@ static int ieee802154_header_create(struct sk_buff *skb,
 	return hlen;
 }
 
-static const struct wpan_dev_header_ops ieee802154_header_ops = {
-	.create		= ieee802154_header_create,
+static const struct wpan_dev_ops ieee802154_ops = {
+	.header_create	= ieee802154_header_create,
+	.ioctl		= mac802154_wpan_ioctl,
 };
 
 /* This header create functionality assumes a 8 byte array for
@@ -497,7 +498,6 @@ static const struct net_device_ops mac802154_wpan_ops = {
 	.ndo_open		= mac802154_wpan_open,
 	.ndo_stop		= mac802154_slave_close,
 	.ndo_start_xmit		= ieee802154_subif_start_xmit,
-	.ndo_do_ioctl		= mac802154_wpan_ioctl,
 	.ndo_set_mac_address	= mac802154_wpan_mac_addr,
 };
 
@@ -583,7 +583,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
 		sdata->iface_default_filtering = IEEE802154_FILTERING_4_FRAME_FIELDS;
-		wpan_dev->header_ops = &ieee802154_header_ops;
+		wpan_dev->ops = &ieee802154_ops;
 
 		mutex_init(&sdata->sec_mtx);
 
-- 
2.53.0

