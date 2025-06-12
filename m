Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C3A94A;
	Thu, 12 Jun 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731437; cv=none; b=lOzHqteYB43DJTv4rsHRYosgxJpABhPdolxDUNSNnS3K2aVLrVQkCPRgYcBvD5Ws+7fqMnueupKU0Y1X2iMg8+MeYkUhB+6p/L2omRMpUbSGTCyR2q/WcKHzpxx/WidZk3LuGt1t0ZyqFWg3E9U9GAkwILyQNVGn8xoP0PS1sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731437; c=relaxed/simple;
	bh=Yrz6TyOo8nKCEZiIQ2jpMEfnpmPAF/N/ryT203SG17c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3v+lVk0KDmHG6ZqK9wFawiQu22WOeJTQTURp1/gUpKPtY0SucIaZsnPtuuV2xoBcATkBz2gh4DTS0XPjYbUyNa9Sd03yxMXKWv476PEvfB9/dLyltXSYqO+HPa/6WHoa34oFJrSkqoh2nmzddPJXOro5KsS/1DHP2C1Ce9BoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G27koCJN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G27koCJN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2352e3db62cso8092685ad.2;
        Thu, 12 Jun 2025 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749731435; x=1750336235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZIE9YmLXja9VZk1nQ6vkdefLSrYzZgXrGtKf4uYX2E=;
        b=G27koCJNLRf6ytil/rbv6s/6bKb1n0DEAchTVvgMO5ZRsS31TvHXFs2owuLAjHlqnN
         djM+AUKQ4AyYzotl1xz2/prpF7SmvU/NeWcKAlAbDJHErwkViZENVFBFy6UGRaeX1oHh
         adFknlzpJ4Pvvr8Hxl8/CWS0nKzQHXlcL2v3Tz1h8yciyQUZGWApTUPLzxE5Mq2VMFYm
         4iFuyCL8leseCy7k/1F52mlBvLpp+ZqwigbcN5jnf59T822P4aHgATKYh3dBMUO8V8OC
         jajuBL5NmT7lvTkR+rtyG3rg2dc9ENILnt1xVzDAG57zwiN2HXCwXKq3PoTTXYQWYdcW
         xeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749731435; x=1750336235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZIE9YmLXja9VZk1nQ6vkdefLSrYzZgXrGtKf4uYX2E=;
        b=dXe1DOMWBrg1U1hNz2w30fJRPveLx/9W+FgAgsVitoW2sciTWWOYpVEbs4Q4tucv0E
         JkcvbKFtH7N3vasqsBJe1Wn/gqfT92vF6p5yxmsCty6fGHZbGMY5s++xh11AOGLOMn/G
         287zMqoDXhck2UaDv2dAoFudQklPk/7ygXGbHYPk5y1FWuB6gtlhV9A0pFBZsQ5/16rq
         xKEmqFsthhXXYuyzJG7f7UQN+WLZ7DbH3KHD7JqUNHDgl8c0h0kSC6coAzhGzouo7pQt
         GDOsKn4Yz/1HRKo4p9SUrTYNWsCA78ZtkpSkb0xiWVbL4NyzxISXpvZdBmVQTKTRD2Fc
         L0cg==
X-Forwarded-Encrypted: i=1; AJvYcCWiXZXxtkMHyp0wBs41ROlxwrlmMHehDjcFz9fcMkeJGd9oh6sQZ1wB6uwiB2cUbf0uWcF2cPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqP+LHAbOsmAuQ9r25N/MWxg6Bms1hODBtc2D+Fj4qkSNmbJKd
	mJ6rMRPsuZBjWyMU573wurVebOcNe7MXjFXOD+zPakZPclR+6T0d9GkUF4O1RYms
X-Gm-Gg: ASbGnctDswtpAzgTR14Mkm7xUsMPQOYrthbH5G9zwg8ElatwW2uoEjlNz65UoMvQnqK
	FDAJD+OyXU/zyzN1Q/D6m7gRiie/5ig/ZmPpV6sFhnYFBvf+5P4HTs4p+CoQZYfXo3pZ/hpS9zv
	wbIdomBnLVevTv4HS9KIkKKhrfA2Hi4tK1divhV1ur/YwfRpNvcPDXKpe3NAFDAY2mXrmkAXThu
	FZh4PPr6SqhVIXuFhe1AhBqT9+qkZi/8S8KBeZKn/xWl6WINk9z9lT1zGulQaDaj5r8aD+mTeSE
	n6Bs8TWemVyOwlIeM5j8iH/lvgjh/jEkso07onpIxpItXgLZQ+WA2W9+QuNc+YqqpraSGAVGN6l
	+OPRHAg==
X-Google-Smtp-Source: AGHT+IGSd6ofzhZ5EyBTRFdJodgLBNIXLN7aXIfSsUFdOKT4yHa29oFRUlcxAun81CydPhQpJsDEkA==
X-Received: by 2002:a17:903:1b10:b0:234:d2fb:2d28 with SMTP id d9443c01a7336-23641aa2385mr97177435ad.2.1749731434861;
        Thu, 12 Jun 2025 05:30:34 -0700 (PDT)
Received: from localhost.localdomain ([187.61.150.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbc9bsm1325684a91.9.2025.06.12.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 05:30:34 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] mac802154_hwsim: allow users to specify the number of simulated radios dynamically instead of the previously hardcoded value of 2
Date: Thu, 12 Jun 2025 09:30:26 -0300
Message-ID: <20250612123026.15386-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module parameter radios to allow users to configure the number
of virtual radios created by mac802154_hwsim at module load time.
This replaces the previously hardcoded value of 2.

* Added a new module parameter radios
* Modified the loop in hwsim_probe()
* Updated log message in hwsim_probe()

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1cab20b5a..113c8df78 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -27,6 +27,10 @@
 MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac802154");
 MODULE_LICENSE("GPL");
 
+static unsigned int radios = 2;
+module_param(radios, uint, 0444);
+MODULE_PARM_DESC(radios, "Number of simulated radios");
+
 static LIST_HEAD(hwsim_phys);
 static DEFINE_MUTEX(hwsim_phys_lock);
 
@@ -1016,15 +1020,16 @@ static void hwsim_del(struct hwsim_phy *phy)
 static int hwsim_probe(struct platform_device *pdev)
 {
 	struct hwsim_phy *phy, *tmp;
-	int err, i;
+	int err;
+	unsigned int i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < radios; i++) {
 		err = hwsim_add_one(NULL, &pdev->dev, true);
 		if (err < 0)
 			goto err_slave;
 	}
 
-	dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n");
+	dev_info(&pdev->dev, "Added %u mac802154 hwsim hardware radios\n", radios);
 	return 0;
 
 err_slave:
-- 
2.43.0

