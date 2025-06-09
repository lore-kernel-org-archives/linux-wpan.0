Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AE1519BA;
	Mon,  9 Jun 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462401; cv=none; b=sr7wA2b6Argwc6U5Nd9rqaHbYnzWZa6+2522uWRXO0BbZpMsw82YAcLt9IPN8ArZqfB51Xa/no5YNybdkGaeB+yugB7sClJwMkg0BQhEFdwHgVHlL2gZ4k/CGRXpiLvTx9nu7z9/Vp74+KJx2rWtUHqEI3ku34cpDjb4Wa5c6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462401; c=relaxed/simple;
	bh=T5+i/IXY5HMlgi5Xmm4N9FOVecSlPeCMn41asEZv3qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc8EEzQ7dTU7PIhNJf5iOBBnB9LTP8aJma9ljFAM9ARSkPZHBPWemzpZ3TkU6Nz2rzMoncF1NTtdPGTWOblElTznRELiEpUAW9vcpmmfWDex/gaZNADE9ajnqzXnL6hhSuOgz+Vr2KVoZtlr19npn5Q+Ez+UkXh4qwuUb8pKEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi+9m5/Z; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi+9m5/Z"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e75abe99b7so1352258137.3;
        Mon, 09 Jun 2025 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749462398; x=1750067198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovdMc1FQ82CEzYnflp6frUiKJPTgmoVtQzARQA5rIDA=;
        b=Qi+9m5/ZZw9giEoy95IIBQd1jzMjBBmvgrpZojmJ/vKe5cUhkBh9BS+QrRkCZWH8fJ
         BQnNaN8bRZUSsUuMM8lHE9/Yrpnw0+NEJt8iUV9nBlUmgZoRBSv5KIAqNxe+7Ksnyun4
         NyEc9gWsNo2oKbTaBCSVYDpy+RNgdRA6R9AeYZ3GbOagBCvOwdrPhGt4a1Y0//TglTm8
         /vO/HQMel4+wDACt8+yvGr3kpzBAwswyumcZaU6IwjiyBqPLp48mVmtMlhlexHlyPTL6
         4J6A+P2bwexSQgEaJublTseOS1T7207YARu1n8vy5tXChmfOpfEIoyIaFtsj2ieZZLYb
         kPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462398; x=1750067198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovdMc1FQ82CEzYnflp6frUiKJPTgmoVtQzARQA5rIDA=;
        b=bubwer+4mjZOH0kIsoregwNz1IclfPmoy/PW1I6hjZdIrDFy05SASrG7CndPPVLI4M
         8s3U32uh7GwQtFEmNiTHAwYw4Z2hUMCVSsjthhPFbcoyyupADJ44+YtuHt2/G29VRHvd
         BxP1cQr7qgCNBjpQeRnjKhsmKtlzilXoPMGF56J70hNP0dSgdPhEYZ9C+J6LN0F5CzvG
         DfAk/t2Qtjxk9B8kSGUdXLD/WxAA816ASQ4wClf7N+425AFj90cP+0ZhUrtkYxKsN+Fp
         YxYyss1Tv/TNG7kvGCfgCtxnryW7i1h5CR78SXvNRU9tHvfiDwqbgW+9R+PVNuR8Bt/7
         qjXg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnLrl9PtBKJm5HgUX8lSgxAuUevismiCTCTT9bszhl1O03j9CoBIkY2xQlXSGIBXiAZSOuqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UrtdepDXj1Z7xDX/LdRDRBFwaqbBGzsLV9Sz/k6J785QacB9
	EtK7ibnfscffYg/VH/+2TEB1WdLEBZO86WlvrVLRSsCwDX0fx5f1v6ew
X-Gm-Gg: ASbGncsLNVRE0KRRKi8yrlWIrxN4t4ZR9wMjCJdLAe22TFdvDCsGS5cyvojYScfa8V5
	6sSTD6EpRKeJcC2Zk8AYH+ejU7CFVAc35TuvxGcKYjid2Ra/W84XjO32a4YF00ssWvX+FZdzriE
	PwX/ug+AkrdMfVl4Xz1pep4dT/Tueo4aS5xHZWsYZ8IhA9exAYa8KM/eLDaZ3YSqG7LprYKM+2V
	wtjOEkgHozytYdY6ker97UYVjZ3ohKQHaz1q8J7rwxpLnu3I61naG2tuhXeh/UcyUxvzvPgER8v
	UlhT6h35Uz1m8+Vf+aJP7F4AD5xKcMg0foIn+BbQ+EEe+QiHF9+wzTDfwPBbyBjyGFq2E3qeNBc
	R4rd+rg==
X-Google-Smtp-Source: AGHT+IHhBQtxj0UI8XNLr0PrzKwYEnZsOFMk+fBH0dYUOlF7WlJj1nnDuG+YS4QLGaBftztpRKN4aw==
X-Received: by 2002:a05:6102:c0c:b0:4e5:a9b7:df with SMTP id ada2fe7eead31-4e7728f71c8mr9600540137.13.1749462398515;
        Mon, 09 Jun 2025 02:46:38 -0700 (PDT)
Received: from localhost.localdomain ([187.61.150.61])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ed07c0abasm1964643241.20.2025.06.09.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:38 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] mac802154_hwsim: allow users to specify the number of  simulated radios dynamically instead of the previously hardcoded value of 2
Date: Mon,  9 Jun 2025 06:46:28 -0300
Message-ID: <20250609094628.6929-1-ramonreisfontes@gmail.com>
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
 drivers/net/ieee802154/mac802154_hwsim.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1cab20b5a..1740abe1a 100644
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
+	dev_info(&pdev->dev, "Added %u mac802154 hwsim hardware radios\n", radios);
 	return 0;
 
 err_slave:
-- 
2.43.0

