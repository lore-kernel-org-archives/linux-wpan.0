Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBA24DCEE;
	Tue,  3 Jun 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975616; cv=none; b=sHFKVbirHXlNRBqQGCiGbZsAsotF9tF+hyCaqJKfIEvf413EIdn63UeF44/R3L1uhu6DztQok5ikX0Q/boHw2fOKwMBATkTT/wyTSLcuRv+q8oRT48MeT52Sd2SFOsHCrHicWRFb4YyVtr8Hy/PaU6DQYEx0XspOhiiWzGya/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975616; c=relaxed/simple;
	bh=SbVxL37hTpZZJQwCWoGZsd5uDgWGt9zPQQhWwF9+SQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYkjQrzk2/oODpMcLrx9D5P0KdHsZ2/CamnQ+B3b9G9WmqlPJS1hSDcAediRPGU3EJDG3gpwtLB9tDZ+1uBKoEgV0NNNAzbkxSU4ZkM/MVGzT40QfJ/OGkrUU4vPuaLXyB3bL4Q3y7xxFy5f1QFPbLPkKovf/mTg1dNDc9uJTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zilf2ppC; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zilf2ppC"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52d9a275c27so3997339e0c.0;
        Tue, 03 Jun 2025 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748975613; x=1749580413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxQQ0sWmsf4MOVzjdoqBgrpQlQTXaeSyUJ30E02i+Fw=;
        b=Zilf2ppChnp95itA9O+JclCd9AUAOD729o6rBSCKN0AGU6GnsOm/xaK0AWlT4eAE0G
         byESDpqKKWfrBhNIQX5PsgtlTUUm7Zfi8zAbUSH4BW7zwkJsCZ0EBiR9j/SMMrilud6d
         Jd9tH9Et30umP8N1PGC3QkMrEKR7ENeWDnqYU395Wc/BRJGJoCHPHUoabomHXXtqCj7y
         ShxDRep5R4kJmdGlj+bb88x07UbobLEe/IDgwaPKkw3qbfW+/0j2V8fm8bSl5jBaTSq8
         xijqfmRezS3ptfQWDrjsMY3j0r2vbQfWc5Xs1O3mdCWuCbYyvJPJ+U7lMfLmqhBGT4eE
         FzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975613; x=1749580413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxQQ0sWmsf4MOVzjdoqBgrpQlQTXaeSyUJ30E02i+Fw=;
        b=sszd2BxnP5ZU7F+6Y3z7hc6HhWEi4DnFbYh8bgLo4r5TytY3y2Y5dktoqIk2WIc0gs
         N1Qk4hsEm2Nmnbd3jMjaOYlz5sMvbLZMX3RvFaAj5y1kziZPM+ZOj3s3AZSuIUbNbOkI
         kHChDK729Zp18KTJVj/fFmDat+3OgyBYmUFti9Jchvqbt0ICEG8PU+z6Wq+h7QK//+Gz
         KOE5PuSeTAmjpQ2YNh6EpY3xdLTbLg8W1lJIxPiK8JtnjTzM+pcCQiJ0MbBk/uLHa0pZ
         Xf64N0TfAzZl8g77LughLQ6rGCepjnJJJCo4b7YyfJaB+byPQVuuNwipsptAk1kTplZm
         o87A==
X-Forwarded-Encrypted: i=1; AJvYcCVzajA32ZuCAWlzvY1qNzj7oSguyl8aaCQTUyPSSKi4w8uaN6eBqvwwMxJTB/OhdD3F2zHQ7Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweYxa+AplwyKmCB+iDXTNeZ8L48IcPLftlwAeljwOVIBtxA+nR
	J2rmhriOzpRrTFQmT3mMc8h9tqedm1ZF16qaH0guvsFNtuykzHPypVaT
X-Gm-Gg: ASbGncvX90M7GbVuN2+WeOncmqfZBeKUvjtyZbaxzFQb4eB5y7QhsWUR0I7mY1Tiymp
	IWtHlg2jCDU7d8/rd78Q2OSRNiSfHqN1Latanw0nWnH2avOt9cIWPKcbVZpStRF87bkXtDnUpNC
	KCxZq6RZ+RLsSrM5slLQZiZBaS2XVkpru+hRUSvhcx0dIDo3u52QKo9bp/SxW+fLckzgy0EGXzk
	3v5sv6Dvq8Jux5qjvNcYrQgG3/P/Yg8I0pDA/jZzWvU5KARh/BQ0O5cDLKv70QuGsTrtxWwLtIK
	NiBw1s7j30MzezNtYFbeIGZbthFsmrHxT+4U4UyEVRyD9c/nuhpJSh9OyRC6HgsEAx9gWIs=
X-Google-Smtp-Source: AGHT+IHx+5qSMSfcrUaoTqZqfxugPU3f9II+et+C/as46fNkimrXOLRMiZp4kz1NF3Du9TpX5HSWPg==
X-Received: by 2002:a05:6122:469b:b0:52a:79fd:34bd with SMTP id 71dfb90a1353d-530c73031b5mr21533e0c.4.1748975613326;
        Tue, 03 Jun 2025 11:33:33 -0700 (PDT)
Received: from localhost.localdomain ([187.61.150.61])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074aaf305sm9609248e0c.4.2025.06.03.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:33:33 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] mac802154_hwsim: allow users to specify the number of simulated radios dinamically instead of the previously hardcoded value of 2
Date: Tue,  3 Jun 2025 15:33:21 -0300
Message-ID: <20250603183321.18151-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Added a new module parameter radios
* Modified the loop in hwsim_probe()
* Updated log message in hwsim_probe()

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 2f7520454..dadae6247 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -27,6 +27,10 @@
 MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac802154");
 MODULE_LICENSE("GPL");
 
+static int radios = 2;
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
+	dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\n", radios);
 	return 0;
 
 err_slave:
@@ -1057,6 +1061,9 @@ static __init int hwsim_init_module(void)
 {
 	int rc;
 
+	if (radios < 0)
+		return -EINVAL;
+
 	rc = genl_register_family(&hwsim_genl_family);
 	if (rc)
 		return rc;
-- 
2.43.0

