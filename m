Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA122A4FD;
	Tue, 10 Jun 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552834; cv=none; b=uX4B+mvxc/Avb/O7v2H7Up21ikJ20TzJR/vjxvOS61BcIvqjsSL0fNZaHXv0T372lHw6LSmb1/mVn7d1F4IESWQ7QEtCDN9TZuxD5g61Kn1DOPHjPA2KkdjiaaujIGbmwv1u3Kzqo63u1xjTETcDRVhfWZh54N1DLxI3PtNxO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552834; c=relaxed/simple;
	bh=S1YirA4kIcKe2Wl/3PrArE737S3w6YTmkobFfeVUTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijBxtvWJXBMO4vpXm0xCOicxnaaoDkQXOX0X/twiwT/Vak/1CgfhyvwVMa7mYltoB/n2C5KVdo/t67T1VKpOj7RsPkz3drRvE/vvSQLOFUCM1BsDmEoPELhTlBdNJQNq3t8bXRHSVjQ91KmlLQ4QneosGYlHzHr5/rWuNeJMOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIN2zvYn; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIN2zvYn"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87ecc02528aso566946241.2;
        Tue, 10 Jun 2025 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749552832; x=1750157632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FH4GvVbyUlHA10D57+Ty9VpWk4o1BsCnblYFk2qPaQM=;
        b=MIN2zvYnaywd4/302NuM929c0LXp3qv89YwQXg5HmT55M5F8H8WoSekuK9lCKBJ5TK
         6CHfuqXgUQXwBZf4Cw9bKG7wR+mMNx4xJ/EayzgyqaaVteolHILOSSHF5YvEY9SlTPE2
         p1uVw1pCLfokkZhvuNzsKnFFfUD0cYl10o6jdvvaGPqew9cuVbDQW7OSnadJEtQoUg5S
         GR0U8N4OhIy1wpcGz5zvHeIZ2UKW/xSMXGeLRRY9OY6eFXjSqyyoiXfEiXdgX/0E23t6
         HUEqJ2OKKx80WnCtqZ6or8lub2MU17HsZ7X8yFwpHlqD6Qh7BVdUszW6IfGHB9JnQ0oR
         33uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552832; x=1750157632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH4GvVbyUlHA10D57+Ty9VpWk4o1BsCnblYFk2qPaQM=;
        b=HOdGha1XP5FbW6EmgWuCje2QtXk+G94ti7hxdQVrMK1b6SDyfjELW4KcS6/JVwS2m2
         ywCHNZWExR7Yk9GK6IxS+9HRWRvLLpf7TNkhpt6IPudUWlf3kWTQm1QHguRyaA4SoCCF
         l5aL116CToFvFL+Rhjtn8hg07MKvM86X7SXGbSVwKRrTPQ+vGaN0x96RZboY0M8kfQx6
         Dx/BJxrORvWQqK3/3mOViHsrbAs+WvtVJXyUsbtsiXsBDt80/gG1eJQXHkHYd0ekEqsy
         o5gxZ08xJs3alUMOG8VOO1SH9SyGb+vyh0AVeElkxy4kb/sEWs8Em7CyjgaLLlO+BsjN
         vxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/t9ZRWYInSffkZklKMFVHhC6vU3nMnIsb9t9xuge9ngU958plDE7uPpBk+WiKiZH9CZMQBUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQkjgjvorXv4vzPQEvPrVFmjfcOP9A21QlIMMawfZQcPqGDPx
	fTG7pimA9VGwBGtJIAZ+xtWl5tCdPoVLciUAJPU3Cc4mn65wFiYV4dVb
X-Gm-Gg: ASbGncv6aa+xbz9lCi34zv7dorB1Pl3ntofZ0vAsFSZmjeNbUzOCJUJDsOEWrkBYjhD
	6Yu+2UNqhGJ46caLLxMYHz8pJaKu3r1EL4zrHT4aHd1URNJ2+Bs019wDnjEcye5opSF69Sa5lkB
	UjfVHtBG3SJJviDIf73EuM9PD2LOzQdouiimcjK6DPKQdZIgtRWBShor9PDH7GDlw2Of1IMX9gI
	tDXxfaHqnjZwjfYaNlpMcf0JTXKQg2WhF6r9dHYhs+JvMDqPrLECQITwANeP1v+rY87dwxXql4q
	SixQg+Ur3d5tVemeNSoIJBq2XBKpNLG+XAgA1zUC4nufhHFvAsG6GfVp7FWJ1+oyBfugLR8oTtx
	HkMk80w==
X-Google-Smtp-Source: AGHT+IFrF56fBHz/gPElY/ZbhlNjRQirauXxcz8tlwIH/2HhSfoJEg0RF6iv3eRXKnqxpZr+fnoYfQ==
X-Received: by 2002:a05:6102:b0c:b0:4e5:a6ad:8fee with SMTP id ada2fe7eead31-4e7729d4c51mr13310248137.19.1749552831662;
        Tue, 10 Jun 2025 03:53:51 -0700 (PDT)
Received: from localhost.localdomain ([187.61.150.61])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e77391ee00sm6236070137.15.2025.06.10.03.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:53:50 -0700 (PDT)
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
Date: Tue, 10 Jun 2025 07:53:38 -0300
Message-ID: <20250610105338.8166-1-ramonreisfontes@gmail.com>
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
index 1cab20b5a..bf6554669 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -27,6 +27,10 @@
 MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac802154");
 MODULE_LICENSE("GPL");
 
+static unsigned int radios = 2;
+module_param(radios, int, 0444);
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

