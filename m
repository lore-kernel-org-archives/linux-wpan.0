Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09D2F12AE
	for <linux-wpan@vger.kernel.org>; Thu,  5 Mar 2026 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702871; cv=none; b=WeR0cLwDcQhHHzA3pOa15G8TYeG/jKvWtWpzr9GBkMb4ZFafPRwKii+v46J/RG8Jk459b6751fXQMKqh9sZVu8D0tOe6FNFE5shvZ69XpBggCcptxBQyafDrY/EF44RrjX+QJQQUNMN81FzRb9cMbQzXjJKv75Xx9YKewGYS14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702871; c=relaxed/simple;
	bh=PvmK9cOjcXiTE+sYw8ns9MrJAVMaWeeyWvNTmOXTgX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJB+/JjcQcSuB2DfkGYSkE7o1GaifvJ81C76I7A89v+ArmRl0pCtBBwN8B8IPMeNmdtTXT/9NurZP2VSUPBjJT62mdmBG53h9R8WaxoX2a8tnYz8IDOoHKrFIWLCn7coCsOhQ3BOoC95AK+bCP6HoCo61c5odt1+Ib/pY06IREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=Mtw4Dvoe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="Mtw4Dvoe"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso5101167b3a.3
        for <linux-wpan@vger.kernel.org>; Thu, 05 Mar 2026 01:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772702869; x=1773307669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMOI/17+3RALblDHdAO/33R2niqItgZmhCfmqTfZ8wA=;
        b=Mtw4DvoegFdQwncOc4FmotZmRGrGJSWL81Nj9MxwCCo6pcuc5L9pzykof2u5GbA7Iq
         EINyIWNuEoD4aJzCw5VbSZFdnYbWvWKDDMr1+VPQRPbqUIoHkJqV3JupEBekZqAe7ycE
         FAbjM+q2usH34sXlCV148fBHpysXMhhSJHht8PnjmOvr4nXdzG/OCETgVE4sU86knJjg
         sDUi1vWiw5hGXXum8TyLjsKRaO8ItE5FlJLEfMFg6DBDnScUFb5SzDBZYjyF2J3lcfg+
         wIGghR9zX41pKT2omZRj+5B0zP0/tJcm1khzLwCrmGHRUBsvH82qLoAbxZrwGoiozRYI
         fyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702869; x=1773307669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMOI/17+3RALblDHdAO/33R2niqItgZmhCfmqTfZ8wA=;
        b=wqFxDlbm3X3RxpAunr+aeojWYuDW+ON347RJVp+dtAcQLu2L+CINcP+3uCD0r1yluG
         UUv/nZdS4CEFFdvRa4YGU7so2CsnEZFIJQc192pw4+B9NSvVQgTe4CkLTmCt/R5gCg4X
         l8YsCUqYExySDSmZetrzg5hTzhrkqpJWd282+1IbWOoG0DfZivzkiwTJCzNtaKyQniEW
         U2dwD8jA6SbX2nC2/AGHrSt96ieHJWjmiNTCTXbJyQl3aCdad3ntCuH7yGLFIkOpQNqo
         fQ21R5YJWTsOowydRVc8DCukuchDK2Lq1Lqesf5X2PYA2auhNWuo73Q59ED3X3L+4bB0
         lpTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZKHmJVvDE6/HJCfD3i4gthrIxpCqKDMgCJOIF4VtH/ENw/P5sUIZUl27RD0YR2JpVpSRyW9n2ZoSM@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyjKi3o2Upic/HWqWovdknHX+6dmqDXh8LeGahj6Q426Zfwt7
	k9Exagnee/LFPlR1vayaiFxE/9OmmheMPneft1mGQOZuWoJN4dhUldVHKfFRzQh6OIs=
X-Gm-Gg: ATEYQzzJZ9RsvXi5wpJSzBtFssTuiCzAzngl0wyI1qKfxr+two/CoIWXChGO7jJcolB
	WsQIryILN8G8Fnz8GZTq7U2rA/Yzpw1SEWnX+0+YNh34fYTV5bkGqx0+cr42pJFywOAb8+oD14L
	u52qCV/UkSdP3ZaRaj+QlQReUohtHtXtg4uUvDMTZLkQr9JgN8VhW7YWeOFHoQsgqmoCyfx3lZP
	z6fFL/oeXs+VZG9xSnR015LBRr/Q6sr/OIRevI2Ld2dWlYxU17Zd4TRU+UYGmBIHBFp52gH9swj
	V2HMviqoYLOpcB3xtYsSHRbYkq4PIilDVmSI0NjetlijJ8D32sHlH3IaNApd3cvR/V3A/ms2j3U
	ewftYKGh3g69D93ty3V6XhFKTPWLw3l/c4jRapWB7LMscOC2L41lw4Gd7f4rF9S9/lC+Yh6dObr
	T65Qvm8lhnGUZWz2fVhI41Rnzh5z9dEZk0D6E6DpZmhuIrkT+S7VOigtwkho8iI1FF/yaiEXfMg
	GNIAt1T2bYAFXIcoMXzZ+vRTF2rV+LK6g==
X-Received: by 2002:a05:6a21:4506:b0:35d:e4b2:b381 with SMTP id adf61e73a8af0-3982ded22b7mr5305867637.16.1772702869513;
        Thu, 05 Mar 2026 01:27:49 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82974e75a4csm3606530b3a.30.2026.03.05.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:27:49 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>,
	linux-wpan@vger.kernel.org
Subject: [PATCH 2/2] net: add READ_ONCE for header_ops callbacks
Date: Thu,  5 Mar 2026 18:27:04 +0900
Message-ID: <20260305092706.145085-3-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use READ_ONCE when loading header_ops callbacks
to avoid races with concurrent updates.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 include/linux/netdevice.h | 28 +++++++++++++++++++---------
 include/net/cfg802154.h   |  2 +-
 net/core/neighbour.c      |  6 +++---
 net/ipv4/arp.c            |  2 +-
 net/ipv6/ndisc.c          |  2 +-
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 77a99c8ab..f50b0a4e8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3150,35 +3150,44 @@ static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 				  const void *daddr, const void *saddr,
 				  unsigned int len)
 {
-	if (!dev->header_ops || !dev->header_ops->create)
+	int (*create)(struct sk_buff *skb, struct net_device *dev,
+		      unsigned short type, const void *daddr,
+		      const void *saddr, unsigned int len);
+	create = READ_ONCE(dev->header_ops->create);
+	if (!dev->header_ops || !create)
 		return 0;

-	return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
+	return create(skb, dev, type, daddr, saddr, len);
 }

 static inline int dev_parse_header(const struct sk_buff *skb,
 				   unsigned char *haddr)
 {
+	int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
 	const struct net_device *dev = skb->dev;

-	if (!dev->header_ops || !dev->header_ops->parse)
+	parse = READ_ONCE(dev->header_ops->parse);
+	if (!dev->header_ops || !parse)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	return parse(skb, haddr);
 }

 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
 {
+	__be16	(*parse_protocol)(const struct sk_buff *skb);
 	const struct net_device *dev = skb->dev;

-	if (!dev->header_ops || !dev->header_ops->parse_protocol)
+	parse_protocol = READ_ONCE(dev->header_ops->parse_protocol);
+	if (!dev->header_ops || !parse_protocol)
 		return 0;
-	return dev->header_ops->parse_protocol(skb);
+	return parse_protocol(skb);
 }

 /* ll_header must have at least hard_header_len allocated */
 static inline bool dev_validate_header(const struct net_device *dev,
 				       char *ll_header, int len)
 {
+	bool	(*validate)(const char *ll_header, unsigned int len);
 	if (likely(len >= dev->hard_header_len))
 		return true;
 	if (len < dev->min_header_len)
@@ -3189,15 +3198,16 @@ static inline bool dev_validate_header(const struct net_device *dev,
 		return true;
 	}

-	if (dev->header_ops && dev->header_ops->validate)
-		return dev->header_ops->validate(ll_header, len);
+	validate = READ_ONCE(dev->header_ops->validate);
+	if (dev->header_ops && validate)
+		return validate(ll_header, len);

 	return false;
 }

 static inline bool dev_has_header(const struct net_device *dev)
 {
-	return dev->header_ops && dev->header_ops->create;
+	return dev->header_ops && READ_ONCE(dev->header_ops->create);
 }

 /*
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76d2cd2e2..dec638763 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -522,7 +522,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 {
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;

-	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+	return READ_ONCE(wpan_dev->header_ops->create)(skb, dev, daddr, saddr, len);
 }
 #endif

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96786016d..ff948e35e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1270,7 +1270,7 @@ static void neigh_update_hhs(struct neighbour *neigh)
 		= NULL;

 	if (neigh->dev->header_ops)
-		update = neigh->dev->header_ops->cache_update;
+		update = READ_ONCE(neigh->dev->header_ops->cache_update);

 	if (update) {
 		hh = &neigh->hh;
@@ -1540,7 +1540,7 @@ static void neigh_hh_init(struct neighbour *n)
 	 * hh_cache entry.
 	 */
 	if (!hh->hh_len)
-		dev->header_ops->cache(n, hh, prot);
+		READ_ONCE(dev->header_ops->cache)(n, hh, prot);

 	write_unlock_bh(&n->lock);
 }
@@ -1556,7 +1556,7 @@ int neigh_resolve_output(struct neighbour *neigh, struct sk_buff *skb)
 		struct net_device *dev = neigh->dev;
 		unsigned int seq;

-		if (dev->header_ops->cache && !READ_ONCE(neigh->hh.hh_len))
+		if (READ_ONCE(dev->header_ops->cache) && !READ_ONCE(neigh->hh.hh_len))
 			neigh_hh_init(neigh);

 		do {
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7822b2144..421bea6eb 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -278,7 +278,7 @@ static int arp_constructor(struct neighbour *neigh)
 			memcpy(neigh->ha, dev->broadcast, dev->addr_len);
 		}

-		if (dev->header_ops->cache)
+		if (READ_ONCE(dev->header_ops->cache))
 			neigh->ops = &arp_hh_ops;
 		else
 			neigh->ops = &arp_generic_ops;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d961e6c2d..d81f509ec 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -361,7 +361,7 @@ static int ndisc_constructor(struct neighbour *neigh)
 			neigh->nud_state = NUD_NOARP;
 			memcpy(neigh->ha, dev->broadcast, dev->addr_len);
 		}
-		if (dev->header_ops->cache)
+		if (READ_ONCE(dev->header_ops->cache))
 			neigh->ops = &ndisc_hh_ops;
 		else
 			neigh->ops = &ndisc_generic_ops;
--
2.53.0

