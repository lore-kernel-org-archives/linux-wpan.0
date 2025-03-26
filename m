Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BC19E7E2;
	Wed, 26 Mar 2025 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012591; cv=none; b=GOzhlBfPx92KoyzcbVdaXyol7fTcd4hKrVMlLJKNXaCLUitLDFhm3QzW/q8VabQrOeAXbodAma9NHAYEhdncS4r/nm/7aBNuTTL/9FacqaFL54XcyTmgQOGBNIX5WRWEo/n9cqsFtNlu/b3Xwdaq+CXuCdlTkPy7PIUyCs+dQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012591; c=relaxed/simple;
	bh=j/t5CN71+dxUmTY6J6d1qYJvYghkCC3IizfACA9XDe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4daLTd4NRLeAVH/2SERjQbyTlTUkhOBFiSblhk0qMDY3Bf+QJKI4r98/d+ex+qbQlXHFvGL82InFoCG1uotCNHOo6NCgPJOu3dDAKJjfZwIOJXgZN3PYgECxmSUuGpDxxURoHx7pgtFIdXzxRf09AVte+k3vlF72+x4XEt4o1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+P9K2n8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+P9K2n8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224191d92e4so3893945ad.3;
        Wed, 26 Mar 2025 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743012589; x=1743617389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ+IB9rjAt2gQIsRhdVsMj0KNUUyg8jdNCXdtQ8HIbk=;
        b=j+P9K2n8xcBQo5eZMeSB9FDtrM1y3Og07xbOIGWIhKYoCaTrgHqe5a9wDBxm81xHns
         3H/Zt5p66Hg0b1flsTPGJqZ5SnBb9lsHcAENjiedcLVnD/iVxx2t/tqRBdKQEvqKJfZE
         aWbDHbKScrzbu+PgbtWHgZH0xep/TdsBuo1iv0nNW0Xq+qTSQ1ue8vPiIZE/7c/m3i2L
         Zyky2fmL2ExgYy303wGe3hnTnb5jd44VnPg+xfC9vJh42EAlpGfu9i1ywvhIwqKkw2km
         qSIUSS4OgxdpBw0qnjCjOZKjebKvIag+uEm5VOSUKSI6Mrtv3yw8N5UiKX7bn6+jG4SV
         djPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012589; x=1743617389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ+IB9rjAt2gQIsRhdVsMj0KNUUyg8jdNCXdtQ8HIbk=;
        b=E/zrek3/FtINzS6/6pV/HZg7fsv6h9lGVc94yfmwEdrRjE4hNdHwdWu/quVJTWckyM
         C2k0ZknvHeD1iUKuBFYRRdw0dgu6cGy+TywsGUgN6VgmbhrGYDAoiiopOPGnlnZ3gOa0
         aqcj7Axx8CQdSyKKSX8uzJ6fpCAwbnAHWDS3rs4Vlv2uac5Ees0ezlpLUcKfs9Z3I0eo
         lT5jQlHozAk5Oa8iR+cO2Mj3W9QLKsHk5z+8hv/K4xd40r8YHRolKRcuaUYbLoXnNOde
         /4Jmbs+QOnCZcvjdMw04n5PH36mLotzBLUMjW/BH5IKyy/30FPTgXwSWTwkwnHp/IAkK
         M+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXwBT+mBGTfpS2Ptl0AJzxXzmBKpAorOS+/7X1zZGGlfIclwENv5I7D0QSHFkkcXXRZ4bUUcs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/sjVbjtZtJPHNMfueDsoxkcwUMT3SsS42hnwOG9A+vWHzpvG
	kdmDHy/YZXHsmuRnw7xgQw+PCapLk7yM0czRhiOYkVC2g8WAaiT8
X-Gm-Gg: ASbGnct7CrG8vuCCFiBcttPlHlQZEslgmRe7KoIYaKG73X4TcB8oKo6Nl3ug/LFE8gv
	Ic+AqdyxoW6SBBCS1mIGpCEiEUjmdYL03jvmavrgFl9mv+9lIxgV/495RszWLIxzONAMP7IkXvf
	32lO7umZFXFDWDiPJ1SRWhbcRO2FffOokj4WsX6ArIa4h8bSLY5b8/xoZ3NE/6gZ0PjeQaJkpsu
	Or0Ite+x3jpEZ4hHC6nPUSMKxVkc41K5Z1H3kMZMkw5c8NBsSywZFzBpDg+c/N0m4V2n6MvPzSR
	pn5eFZ5IXZERuNWOSe2mEm05bN0lMMKa/ftjFc3EnUrwYJW82c9jnBK3MSiwyHRw
X-Google-Smtp-Source: AGHT+IGIV/5RpyEFolfPNp6NtVC7IPlgGcgKn1BxA6Sqz74psmOuSJfhNw+6+wejp6T1ELtMWQjpEw==
X-Received: by 2002:a05:6a00:2e18:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-7396103a224mr644124b3a.12.1743012589314;
        Wed, 26 Mar 2025 11:09:49 -0700 (PDT)
Received: from localhost.localdomain ([187.60.93.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390615302csm12434067b3a.128.2025.03.26.11.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:09:49 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH v2 1/1] mac802154_hwsim: define perm_extended_addr initialization
Date: Wed, 26 Mar 2025 15:09:09 -0300
Message-ID: <20250326180909.10406-2-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326180909.10406-1-ramonreisfontes@gmail.com>
References: <20250326180909.10406-1-ramonreisfontes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This establishes an initialization method for perm_extended_addr,
aligning it with the approach used in mac80211_hwsim.

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

