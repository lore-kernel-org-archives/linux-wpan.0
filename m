Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001625FA27;
	Tue, 25 Mar 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921605; cv=none; b=rzvl5XaAvn0SVUm5NI6Y+muLl4paE17yo5BqWnbm210ICETpVOmHqulFOZLp+paVGRgFhvZtSsUDdvIg6g2rz+re6KuJoeXpfTAerSiTlr2M3q2iO7VtuxuEUjDdVGu9dPeElTR5U1/l0UKjiS35BzegU64JjdCQmx1H5inY+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921605; c=relaxed/simple;
	bh=tiWILF/OpXk2QiaHA4iIDbpOS8cEKKKELeSYLgcn/cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inUt6gVpjGs7lqysB1vrsPB4bpiXIzZB8mBttvY+omiMBIv8mFadAZK0NZv6xvmzkQHv6Bm3lBhmPp/cfC3hHnSQKhJqqHuvV8k+pxh+BgKr2jQ9Ux3zOVTW90QaUm+u24S2yw70H9u9oaHePwSzCi/TOfM4W13CyU+XU6BNnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdI3sTPG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdI3sTPG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22438c356c8so121272295ad.1;
        Tue, 25 Mar 2025 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742921603; x=1743526403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KMrhQf56Ur1zbJmPs1F0PkNskXi6jKeP+tiiR6jEI8=;
        b=JdI3sTPGF8Bi9S5zvn+ZkRVZIQJ27PRsqi32IhPzaSS7vojy3qS1EkI6FMZY2cU49E
         oSHclkqluh9BOSMreAOv8wGOdv+0QevdI4z6rhXjhFXPwOlaxE4azhVZfBlIReeYdGcw
         koJYDC2OqJytcSirEsujQHmnDOylojf52d4kjbp8AJm7gyUY5rU7pW4n2vd5u4vAbhjg
         reQ5sU4o9+2MlJ/l9BTkbnpEulEQmp7ydLTdhmSlGBlzHJs+8LmGtETyj1EJKKDMVDxP
         a87+ipXPXM50VOjjIwFC7BsS9H44InBir354xZrc9Ir2vbGzT/A3CGZxukVZLG8z2eKT
         hQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921603; x=1743526403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KMrhQf56Ur1zbJmPs1F0PkNskXi6jKeP+tiiR6jEI8=;
        b=nFZXiIcPisoRQs7EYHINMWrCoHF0s8/Jzgz+fqRS4eHUc0FwG/MsF4HKjU4mU7SY6M
         MG2A4eHE61vvmmganvHDfXpFKr3HnwC3IxQ/GjAUHgRqO4NFUsHmm25q/rjtRxy5dKny
         SEyNE5uRocS6EWal6FXgUioUnL6/EkfiCoqqv0637wrsKmThJLML66kSdJbksLq4THIn
         3T5fk2XhddD4mDesQntQ6gghv7/3To1zle01jNWHO8RmyWKFzibSJf/4OIiEzQr9qsel
         9dbHdF7eJe1OA8yKDEM6G7I5uvu8XyvoryFQW844YkUNSml6R/gGYW28uvMAIfgjzxZC
         1mKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAyMrQlMEgJDrw4YvCcEf4S76fjKDcJHeKumFPaf0HaMfkrDZY0lw4c4exurD2o8Tw4isUIOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kEfCiPmhexbw8fBEU9uM+WWTorEp+ZUy/GuEcB1J0Iz8ncF+
	6YciLSK04dkHfdFl37UBz8XX8mxH/BLcaIGfE23yIzgxI/JiGvzO
X-Gm-Gg: ASbGnctvnYQtnzqOj/IoytNZcpdBALJfZbdUGbDgvU3ZXJaHjMMrdPqMMdNfsQLADrE
	vN15ZDzW7VcgLBAAybHG5KSboaDbueThLh7zK0c6AeNU9J9NkN5kQJW0xXYxiSg/TfcEqt+A6x2
	dISPSXVQh3+p9LCQxTtk06p8MRn0jHSBNjm7I/hhrfaNT61Gp386FdzPf5TdiP8/3wwkOu5qGfw
	Lusd06gTIjjb0D/RBAcwU9QFAWgtEp3frG6+ReFdUn/NLeFi6cAL08GtgtxvMhz1A+UgoLscehe
	mB8b7oukKxt6BAdSsnL/00gjlclSnsSjXrmGdziKkpxk5zgxvVHjGC2lRk2G9M84
X-Google-Smtp-Source: AGHT+IE60Dj5UjD96rO+/MjhtCi9kDjFzpSQXiIRIFKcnAzlMSzRY1l+k8BonS4Zc7VQq1XwGF5SBg==
X-Received: by 2002:a05:6a20:7f9f:b0:1f5:8655:3282 with SMTP id adf61e73a8af0-1fe4347eb93mr28880852637.42.1742921603350;
        Tue, 25 Mar 2025 09:53:23 -0700 (PDT)
Received: from localhost.localdomain ([187.60.93.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a23b2asm9376087a12.50.2025.03.25.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:53:23 -0700 (PDT)
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
Date: Tue, 25 Mar 2025 13:53:12 -0300
Message-ID: <20250325165312.26938-1-ramonreisfontes@gmail.com>
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

