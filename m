Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DED19E7E2;
	Wed, 26 Mar 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012575; cv=none; b=bvwiZR5Nwe7QY98HQfTGQNrF4N8Bvj3lBXhwOhzwuzeXOgiXm92l+YQDpnQWtiZDUppIbYcY/9lnkpmGk41ZZXs/aU7ovQevuSwjk0DPV49sBz54sHNUibym0NN7bnHmy6HNhPMeHHRo+j8TbwNRmLhzFEXB5eRA3Lgnya6n9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012575; c=relaxed/simple;
	bh=tiWILF/OpXk2QiaHA4iIDbpOS8cEKKKELeSYLgcn/cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7+iDYwyU12hx+ViBlrWbpSe1rv87OnQS5qwawDUF1Aw5FKOz8zFWEet8gcdBXcLXG7y7WWUlOyrw/jrYJuZIkaTCcUosRpO2Ob97M+hsHifwLJdJ52JWziIehLpx3QRUr+5+pZaVJbH6ZEamtTdxzlFqbsnXSueEhesLq6Olsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhNacgcv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhNacgcv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso3989665ad.2;
        Wed, 26 Mar 2025 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743012573; x=1743617373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KMrhQf56Ur1zbJmPs1F0PkNskXi6jKeP+tiiR6jEI8=;
        b=WhNacgcvg8wHNFDAWMvrCsluQ+/ck9tbCuOXgeWJJNYsfGnKlcWpSAZ0/URQZyNAuM
         LxevYfAVN2REPanG1qY2upbrVJhycsP9FRcYYxptLONkTMa0kQUYenCWI0DJTBZIS7UG
         jKlbQZ0py+BmFEZ9ceBnV0yhEFY8GG0iTKqIVPjdniYtehIzj/2EWjwbvJmiZ2C/hkg3
         wC80ahh0nlIuuG93J72wpYGkCJIOlxFR1SeBUs7Ukx1C49cZUuT72Gqq8ag9qWT/PJpw
         KJxQu9qOAuNKJHZRdMb0N4vWjHOPHUaVIq95VFSE3CLH3L85ON3NMf2bft5I2ys2hcRN
         m4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012573; x=1743617373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KMrhQf56Ur1zbJmPs1F0PkNskXi6jKeP+tiiR6jEI8=;
        b=oclbBBnTBa7uNo9+9lUFxlDi8u6Bvor0+Lfl91jfZ9MdtRM0x3eH9pejH1hxDgEk51
         Iy4SgoNXmghkp/c2d8zCZjer+JlcMzWnizgKK8g910l4P7l1LOxJhVm+PNqw7Dk4cFoZ
         qSG88tX1olFAhOShxpAF7e3dOEYij+5s7lbXhParlFE1WFkasdf8IRR2wMxNt5Zgdjvz
         5PR9EBsCgsvYKg5dpz1WT4CJjsRZzs0oH+7j9gIgN/euz+ScGdVBDFyuqiCgrr+iWJIi
         PP8snVsOMoqMJ9gp3rOQLJ7z6zaE05yrqQh7ZM3emMJHbpcELqoYz/h9aeQxEK03a3Ku
         I++w==
X-Forwarded-Encrypted: i=1; AJvYcCX5s6gio1vnNBiqd5NeqCOgUGYNmUXCQaSlsYHRQfKIbfYTSqetXPfD1nMV5J0hsCu2c/HyMB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uoBgDS+BpxFVaMRxqwk5rs7Qbo+FDD2WqyDSASH266YU4HTb
	BBmEPWgjQsOIFfoY5gR7HKDhW8PHrA5s87qAUW5F1dOBqvYNXERE
X-Gm-Gg: ASbGncv6BUy2/PdCugHpa9UqbQFuMFyZQtBv2oZEdf8niPjekAqpG5AkYdB8sKz+wb9
	I/5G6vB02TyFiiT4eZ9joN1oAFoUgwgqEOPtQZgtIJCTk5PQ6ROLTWozZ6ETWtK/fIQ8KTdGWF2
	1HXjP4HG5DmLL95Sv2dI6on/B+2/f5vJrwFHhRoWP/d1cRyOZNxFoLCiSUDjeZmP/poR0fVM91T
	R7QbgOZ5D0aCtK843OGC/JTwBudHXXIQDvZrHQZApHLUCQuKgN8NJr/DcK1JxISF6n9wvjUbf0l
	LAUj6L7ePnGMji51IAcAF1Qsxmvb06QQH412rRVZDPSN7yQkwveHAGjioWAtpsMN
X-Google-Smtp-Source: AGHT+IGCM7WayWgf2oiCYK5Za4POdAbBFQp4hvRXHayA7+gtCHdNFuJLeA1B3v1OBaXhifzNaI5c8Q==
X-Received: by 2002:a17:902:c94d:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-228048794b3mr6093655ad.23.1743012572677;
        Wed, 26 Mar 2025 11:09:32 -0700 (PDT)
Received: from localhost.localdomain ([187.60.93.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390615302csm12434067b3a.128.2025.03.26.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:09:32 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
Date: Wed, 26 Mar 2025 15:09:08 -0300
Message-ID: <20250326180909.10406-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This establishes an initialization method for perm_extended_addr, aligning it with the approach used in mac80211_hwsim.

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 18 +++++++++++++++++-
 drivers/net/ieee802154/mac802154_hwsim.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1cab20b5a..400cdac1f 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -41,6 +41,17 @@ enum hwsim_multicast_groups {
 	HWSIM_MCGRP_CONFIG,
 };
 
+__le64 addr_to_le64(u8 *addr) {
+    return cpu_to_le64(((u64)addr[0] << 56) |
+                        ((u64)addr[1] << 48) |
+                        ((u64)addr[2] << 40) |
+                        ((u64)addr[3] << 32) |
+                        ((u64)addr[4] << 24) |
+                        ((u64)addr[5] << 16) |
+                        ((u64)addr[6] << 8)  |
+                        ((u64)addr[7]));
+}
+
 static const struct genl_multicast_group hwsim_mcgrps[] = {
 	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
 };
@@ -896,6 +907,7 @@ static int hwsim_subscribe_all_others(struct hwsim_phy *phy)
 static int hwsim_add_one(struct genl_info *info, struct device *dev,
 			 bool init)
 {
+	u8 addr[8];
 	struct ieee802154_hw *hw;
 	struct hwsim_phy *phy;
 	struct hwsim_pib *pib;
@@ -942,7 +954,11 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->supported.channels[6] |= 0x3ffc00;
 
-	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+	memset(addr, 0, sizeof(addr));
+	/* give a specific prefix to the address */
+	addr[0] = 0x02;
+	addr[7] = idx;
+	hw->phy->perm_extended_addr = addr_to_le64(addr);
 
 	/* hwsim phy channel 13 as default */
 	hw->phy->current_channel = 13;
diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/ieee802154/mac802154_hwsim.h
index 6c6e30e38..536d95eb1 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.h
+++ b/drivers/net/ieee802154/mac802154_hwsim.h
@@ -1,6 +1,8 @@
 #ifndef __MAC802154_HWSIM_H
 #define __MAC802154_HWSIM_H
 
+__le64 addr_to_le64(u8 *addr);
+
 /* mac802154 hwsim netlink commands
  *
  * @MAC802154_HWSIM_CMD_UNSPEC: unspecified command to catch error
-- 
2.43.0

