Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D292629C;
	Sun,  8 Jun 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401256; cv=none; b=PLeougpeq4NEkU/QU0sudxAIElGmJdPg6xKdYPJ/wwTVVDlI8nxJ6NZp1keg7qFsa1Yoz2G4yrb7Cplp30/wapFD38Qo7vkVlCEOIkRyVEaE6cG3TGL1QCDNpGdMntjjwSi6t4x2lxYxRJF4KbFNoU9J3M8/W/9N7cPZtsYL+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401256; c=relaxed/simple;
	bh=pznfatdaTME2rTmyt/8vtUl1sZZ4dvZcbWqjCTMljJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2a1KyUDH0t3LgGIAu4fX5AbSoA8xHo59I0K6cJTfiMcCBDY+fNoWUfQIjDr3dNHkKJKcyhrZL/sXidN4YqWX95JczAgBFzizVJSUn+yEDkqm5rM8XtGwak8w4wdDqfZWyplLbCYHDDAXztfRgwPh+GY1BtJDzbbX9IWmjexmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsVwCIYw; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsVwCIYw"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e771347693so1833553137.1;
        Sun, 08 Jun 2025 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401254; x=1750006054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KS9CP9/A/h3iEtm7CMIEpKMQqYwspFw8uVeTqe2WDug=;
        b=LsVwCIYw7jMcLg+uy7mFk+fO18uageWo/L+TGzL+EbB9nOQSu5uI35a9etQUehN1dw
         NQ9U0550SD26IcfNoALZFiw1qkv1ySHybkycd0HcAUMgNMKYeLjhe8hv8isMNaAr+QOk
         GlCMqJItyV2huJ2PniVS63h0gNZdN/JUxIXzwzulZOWl1zr0d2KQN/2BVwfeuIYiFY2l
         gLgKuoUO6eAiPKPYg3mXHUxLm1C7qsE434jGNgj54mCEKuYmVCTYrfmCjOVack++PFHT
         mmiysKv367QQoyRjoIZxKsAgqeGe1Zbn4adWAwtEfG1b9ovlb8OgqDO5EF1AZeDQoAg1
         gNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401254; x=1750006054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS9CP9/A/h3iEtm7CMIEpKMQqYwspFw8uVeTqe2WDug=;
        b=a2L+/kP6GNolqO3B2MYDmczG2A4H2VsY7dhJReVX/AxPC/UYhLCpqcNWFmLvMXnnxk
         6tKpBpo8TGsgCA0Y+oF593vKFb0fwhgn3GDe/IgsbV5Y4HmVc6ks7JNLFtf6KlOWr6mx
         SHqU6o9xzFufkOVHbgwjSCJqI7Sicd7xMO/SYawLWHvybloxbb3r80L74Dh+Z/SNIkqN
         4dP72WAIJErMlh4AOFyUbtYLoJniI16OLFz2TdUp59DGbaS2+kE0psSxCv+hRr+XUdCu
         /K4FbJ6Od8/8nSE9XPYtishoC1Q5/k2vrgYAfrxoHcJ8rNpDswAk2NwhjnvQ6FMcsOWy
         bj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlLi+NtgpYQFXaVaW6PLDYIXdgGwT0YzaSo+KWOu+PYBgsI2DyEu6lU1baj94i3Ao3jw/Pqn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtFk4aIZs5aQNUeZBP6Kg4TW3tAMilv40G2b8xDBHlEM3gPIQ
	Bx4VrVnf25S6IPYAcjMKqJM0wtKTNXfeGB3oeDN2J0ILh7/1J93QiNY6
X-Gm-Gg: ASbGncuxxsptoNCtYIZ/DKI+7sxcmElqL5z5LZuOI53mDYT2CFTQxuqEyGFdEa43Wsz
	dt9l1YHpx1LkEm9hdsnLwWcPvyx0F6RliILL3jsDCf1jtpy9k+zT/QiHjLm/7g+aKibgOKbXPZZ
	AYl+UENIbmBed7xIN+Odzcn6xrVmWYJovfuI0NwnIU2IMNfr6yRyZld8pdQuQesk+DOI8ufnB7a
	ArvqHa64tUAJm8AwtF4EA2j4rnvffMAbR29J8wA2V0uKmLSdPthPzCCAkY7gWRghgt/0j0+v0BV
	snRTBNQJ5xhoi99gJagrrWHkg9CTmNSx5j0TdtC5XY+NnA1ekwU4AOHfRjFdQ3Hwtk5ke2Y=
X-Google-Smtp-Source: AGHT+IHwEXbK7g307mf4AZt9BTqviVR2/Z9Oe2q7nsEnoGO5dQ8yPBphNtJtl8gS9zj7PoryG0DNIQ==
X-Received: by 2002:a05:6102:2912:b0:4e5:9138:29ab with SMTP id ada2fe7eead31-4e7729c4bc1mr8624088137.15.1749401253616;
        Sun, 08 Jun 2025 09:47:33 -0700 (PDT)
Received: from localhost.localdomain ([187.61.150.61])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ecda08c3asm1565215241.29.2025.06.08.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 09:47:33 -0700 (PDT)
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
Date: Sun,  8 Jun 2025 13:47:24 -0300
Message-ID: <20250608164724.6710-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module parameter `radios` to allow users to configure the number
of virtual radios created by mac802154_hwsim at module load time.
This replaces the previously hardcoded value of 2.

* Added a new module parameter `radios`
* Modified the loop in hwsim_probe()
* Updated log message in hwsim_probe()

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1cab20b5a..8fcf8a549 100644
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
 
@@ -1018,13 +1022,13 @@ static int hwsim_probe(struct platform_device *pdev)
 	struct hwsim_phy *phy, *tmp;
 	int err, i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < radios; i++) {
 		err = hwsim_add_one(NULL, &pdev->dev, true);
 		if (err < 0)
 			goto err_slave;
 	}
 
-	dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n");
+	dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\n", radios);
 	return 0;
 
 err_slave:
-- 
2.43.0

