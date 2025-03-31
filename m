Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BE1DF244;
	Mon, 31 Mar 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417578; cv=none; b=Lr8OF2JjcbY5cwTAARfzMkdxhGwRhlOx9UaziiYMK0leiBdF0Cd0URw1VFiyhl2LuRUpeh0e2gdmqWXCNYFr/JO7Abqm6h7HCSLhNbYa/N7qrd/m0waNAU275ZkrWmCtgeLRVYAu+JFeaIk1TNNTa1TcJzQVSqb1kOqpagft0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417578; c=relaxed/simple;
	bh=SbVxL37hTpZZJQwCWoGZsd5uDgWGt9zPQQhWwF9+SQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juhBXVhzgyj/Uo0LVXR9/PWAAL9BwK81xkoJURGg8EUwRSjc3Ly3uJE2XC9/sCGopvT8JFTFH9ruVqr/MUlp/2zSoLvsNPgrC/mhL4P66sRwSWrATMzWm5yLFjd5P+jvXzW6igUxzppoxJme0petz0h9tftqQw+mXEwTollBcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb1T73V8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb1T73V8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2254e0b4b79so111661515ad.2;
        Mon, 31 Mar 2025 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743417576; x=1744022376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxQQ0sWmsf4MOVzjdoqBgrpQlQTXaeSyUJ30E02i+Fw=;
        b=hb1T73V8b+DlMkxio0C11EZN+qAX5o3jTqKmyk4cKL2ycyrfJSLcRlM5Z2mxkuonj2
         hciMBslL5zqaoggTR/zlcykHd4mxmk6BYmyL5xQUTCpwS+WhLrnY6g/dAcvh7ogEUV7T
         Sv52sfpDGlv2XnduyxhxcD3HQU63efhw4XuVanSzIXpI8jlq8tZDydxo4MUgCu41Bby0
         v57qohvofC8P7jdcB+7JknKAnhMrvGeXCskClqP1bqS4muBHENSS4u1wZK29+aczBmV4
         g49U/bs9SqoWvRCK8p2JE+ZvRXyOTHdUJOBsDShptHq3X81gNyf5zGIOTVYMJ/2VHf8q
         nbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743417576; x=1744022376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxQQ0sWmsf4MOVzjdoqBgrpQlQTXaeSyUJ30E02i+Fw=;
        b=F7ADYIMABxdzvIfVU+kMpHFJUjl0H+xW0JrbxgDoCMzmP61ldenJr3IPB1y8l990PJ
         lxS+G2iY9wFePfvbty6vzXppcv877ZZEHZXN6kb2x0xIjyYfGXzAIGu8S/fF3GrL2VAa
         AHjDoAHiJgpgUZIrqyDAnnh6AOYqem3x0/4lHc5VsCKS18AgwVBzKvbuUbBhMIHx0o/f
         wziUUt+wo3f7/nef9H3DD5EjSP0oiLSQhtPa1fETs9vUlTH4aylYAtmXnW3FALA0tv+M
         TKkW1ezK4sHCKU2BiOVteUWY/GbaRRvpI5iCGeJ/z4GJpoqwPCj+be5cbNyZlzLhD4rZ
         MJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCViE+NHcGZeMkfgastCv9glYyyI6a9kU5GQLGSKynBj29QnoGczZwg93Fx8osb6eLVJEfG9CbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDEHhe106GgEjPVP2irkPimC2uflJ6J6IqMGBCjS5g5uJC9A/
	8U932hwuZ77XaMIc4KQxgO5TAcXZSFNd+ZU8JdDAw2nmGpCeFNUzYjb2wzHB
X-Gm-Gg: ASbGnctJpzYY0nkBVFLDviw8wiI0idwbIDG/DBcs9EgwMpDlZ/UBqFEoCzBTgtqX6mb
	A2z+EHyayJkHyik2d/ZF55pIqTwwH3pps6lWeN3jM3BvID6suhokYNDXPivwktYWFwmb7yI05Lw
	ov9x0ZImBeiKzvd5bJ4r1W+wyG1icCS1nJu36tF2HVWSVLfuPSq5LY+hPVr7J1vkHWifvQR5Hst
	WFN9CVAbvv1bb0EAKqEsYHkAnE1YXFE3qLpA/XMJposR9a7aSMzNdQX3F/ykCFaet8wGBCtwg3R
	GvVvuaVJ3KvpxdOywVyWiDhKd+C8iN1HTfOSyw1UZxhi3RxFwl7Z6BKukjWBXNYr
X-Google-Smtp-Source: AGHT+IFM8/RIyeX8CJ+NUfY9Ck5fuq1eo+UmEGDBfqF2xqUeQxUOWuQUl9qXSroT5OrqMFqVnO/b/g==
X-Received: by 2002:a17:902:da88:b0:223:f408:c3f7 with SMTP id d9443c01a7336-2292f96232amr118083385ad.16.1743417575843;
        Mon, 31 Mar 2025 03:39:35 -0700 (PDT)
Received: from localhost.localdomain ([187.60.93.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3cd42sm6953865a91.3.2025.03.31.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:39:35 -0700 (PDT)
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
Date: Mon, 31 Mar 2025 07:39:24 -0300
Message-ID: <20250331103924.14909-1-ramonreisfontes@gmail.com>
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

