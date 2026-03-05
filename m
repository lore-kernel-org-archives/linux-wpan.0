Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164738422C
	for <linux-wpan@vger.kernel.org>; Thu,  5 Mar 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709020; cv=none; b=QXZi057yiP2pm1Yp80GJUFCzq9M1ZOUi8XG8TBKamo2UVza7/OD7i/YTMkImgFa1kTSndxLd4PDsLzgI63HlVNx63jJbCFqHRtBA0si7rXoLY1WYIqPoDBIjLC3+Xz5yoVokgTmsusCsjE4j8tOUC2seVMuLPI1E6G239tHvODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709020; c=relaxed/simple;
	bh=iILJccyDyJaNfe5/O36ZoRk8XcC4XvtVI+KNgSJv2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMt6td1zkBg404Jt7Ynrc6+0TUvkA02YbcFPHEPvWdtxbZkb32JGnJpOVuO840wYcqiqlhsI3C4n0GahMDsP7bL3rpPr3dzehwsutdQ2YnHTpGZm2EoAy145fDWfyso5lyAjWEa0ps7ljQM1QWJZP5Qxki2reSoP5NS7tN3LbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=DVW6TfxG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="DVW6TfxG"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7377119453so794665a12.1
        for <linux-wpan@vger.kernel.org>; Thu, 05 Mar 2026 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772709018; x=1773313818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Uah3KJlZJ0YDkhXOPrfMLRnjC77tql+fRjEzdTgsKU=;
        b=DVW6TfxGI3iG/7wYkWj8BG2PVC1BcETzqH1s2iQr/tDZ0XYDtmlfMnGCr1bUq5UxGJ
         8dCfYy8Rc9qhoX55TBHO3FUL/prPI4EKzu5ukTCNUSAGzMlrc/346feltegVNMo41GM5
         fVLJk4K6SjwqvgyRg8TYOWQbtPdgbnMn1xtguH9Vfpkg61dV6HovyVllwVppzg6HC8VP
         GMY+YYcUfH1bSDQT11RBwQh0/BOVnBbvMfbD2jC2c5i3irw0YJTetfLFoTPd2wJgXimb
         Xoq21EK7vHaOKPMpecQIjigkrdL5hR2fIYYszktzGTOsy7ZRc0a8fVBMYzPEOqxvGS9Q
         D0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709018; x=1773313818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Uah3KJlZJ0YDkhXOPrfMLRnjC77tql+fRjEzdTgsKU=;
        b=NWgJb7FHZKWKaPzJ9X9PsFp1CWARGq/9r/Veh/4blkERqtZa5iwPaDZ+QxK8wEZ2qs
         6BZgIS1+mFpeCwY/mIhTaW1859qFLNORAcCSTQC/ZetBo3tL427CMmL/uIJa0Dk5JkbP
         DngK+0PL1vK+nxuKsWY8FKLDhtC67WAIg7P9ZLSF4c2guLU1xbkDEFhTv+BQ71hmC9O+
         XOyIUw/sqhpRhugVYx+oULcZUBo1rzbB10Ew8fzTtRokvhsGFXbFc+qhXsW/ee38n/aZ
         qc9KIhBat2PxIevssWvlDUKVJNo9DNiKNhj14cWNzC1hE02JQZHwAkqb6YyZHCRyELFk
         DB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVKdbmCLOawl6M5OKWO1cz5dmMqMWqb3R5AT1zz4AK7ThxJtcwqn8OWgp4Yl2pgWOMI4YdU5zyOsIVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gIqixlOYAkRubVyVXCT7a6n2ckWAUKpKvq7V2bOx9EUfrEag
	HRe/8LhpP1nsDX0ZpPX0DIiFKLGDlCXN37XgJ2mqbhxjmmZc4zpwliQzaw6UFRf/tDI=
X-Gm-Gg: ATEYQzyHIc1vsP7JxN82aSruj69SPo8dYUBzcfQQ87PqCL4iEkGZIO67jBan4kiU5ir
	h6biZPoW47fq4XTMutjGfjDe2RcG2q9oFSogVhPbWnqL4X10h8UR0M4ZzNqeTYq5biEKWbKfLkv
	WFMmqeyKERAmMIHZnOXCHOQvGJMEytyBiLyM2NjuQRsB+kNa4uHkZP0UghR90QxwKBqBnwHmYLf
	Lp2NlJsZROXJ4HTPSrpHcl+uhmazgTtkpb6OEoPsa4E4guIV/bjo13RL79xv5CMyzNz8C0s2ZlN
	C/jpDFEAA10EhozoYG4sjuPCu0nlpBbTc8RJWI0b7SRSv4KkftzIDHrC/wDdYu5TXuucfGI4bX4
	0TZVewgne1KwAmnIIyMtPSHmznaTVmOeLgVa4Yk1H2k3c8+wCo84q0PB/9cpwkcr5CuKxj1SK+b
	LsRCVeoiyk9CdUWU5NsQCT1tutjMukFW3pKApZuh2F6sZoq0JxQjEDA8VmvJtqTORugCskbWBms
	UgbyMWGpCZwMcycLhAVANg=
X-Received: by 2002:a17:902:db0f:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ae6ab9ecd3mr48315825ad.54.1772709018409;
        Thu, 05 Mar 2026 03:10:18 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm153501155ad.28.2026.03.05.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:10:18 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Jeff Garzik <jeff@garzik.org>,
	Jay Vosburgh <fubar@us.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>,
	linux-wpan@vger.kernel.org
Subject: [PATCH v4 2/2] net: read header_ops callbacks with READ_ONCE()
Date: Thu,  5 Mar 2026 20:07:49 +0900
Message-ID: <20260305110751.167489-3-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bonding now updates its header_ops callbacks at runtime, so lockless
readers can observe concurrent callback updates.

This patch loads header_ops callbacks with READ_ONCE() and 
call the loaded function pointer, instead of 
re-reading through dev->header_ops.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 include/linux/netdevice.h | 41 +++++++++++++++++++++++++++------------
 include/net/cfg802154.h   |  2 +-
 net/core/neighbour.c      |  6 +++---
 net/ipv4/arp.c            |  2 +-
 net/ipv6/ndisc.c          |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 77a99c8ab..79fb0864a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3150,35 +3150,50 @@ static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 				  const void *daddr, const void *saddr,
 				  unsigned int len)
 {
-	if (!dev->header_ops || !dev->header_ops->create)
-		return 0;
+	int (*create)(struct sk_buff *skb, struct net_device *dev,
+		      unsigned short type, const void *daddr,
+		      const void *saddr, unsigned int len);
 
-	return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
+	if (!dev->header_ops)
+		return 0;
+	create = READ_ONCE(dev->header_ops->create);
+	if (!create)
+		return 0;
+	return create(skb, dev, type, daddr, saddr, len);
 }
 
 static inline int dev_parse_header(const struct sk_buff *skb,
 				   unsigned char *haddr)
 {
+	int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
 	const struct net_device *dev = skb->dev;
 
-	if (!dev->header_ops || !dev->header_ops->parse)
+	if (!dev->header_ops)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	parse = READ_ONCE(dev->header_ops->parse);
+	if (!parse)
+		return 0;
+	return parse(skb, haddr);
 }
 
 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
 {
+	__be16	(*parse_protocol)(const struct sk_buff *skb);
 	const struct net_device *dev = skb->dev;
 
-	if (!dev->header_ops || !dev->header_ops->parse_protocol)
+	if (!dev->header_ops)
+		return 0;
+	parse_protocol = READ_ONCE(dev->header_ops->parse_protocol);
+	if (!parse_protocol)
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
@@ -3189,15 +3204,17 @@ static inline bool dev_validate_header(const struct net_device *dev,
 		return true;
 	}
 
-	if (dev->header_ops && dev->header_ops->validate)
-		return dev->header_ops->validate(ll_header, len);
-
-	return false;
+	if (!dev->header_ops)
+		return false;
+	validate = READ_ONCE(dev->header_ops->validate);
+	if (!validate)
+		return false;
+	return validate(ll_header, len);
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

