Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1F1C1AAA;
	Sat, 29 Mar 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258023; cv=none; b=Rd6eLApMrwg0vafzRAMyKTQDJSzjfE3V57VOM+MtMnqBj1282zRtbDseowHhnNW1HhFuRad6LZ9ZGQKQQLypXgIoTVOUGXeY7iZ6F4I/jrnTVdoq3J3WRNIj8YAeDphazwSWSRJaBYeFZB2y/XJPnQxAt5nWiJPF45Q2XNfDu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258023; c=relaxed/simple;
	bh=H9PTlw3vyhvNuYd+tGVSYwbEzbV7+29R+TRqtXAmnGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdCJsicR9SIMo4ooaT1GjFUH6UnJaNh+0ln6eZoY1dFn6bKpc8ogBL9M/Ps0pJrXkYJ1LKKW/d2TofdC0wo1cilErjutFjmRzaiDbGFNA6C3mgz1yjEI+x3byyYUhZFGlluQrUnIddR5bBYmmlg175YnNYUKi4D8pLEuVIjitSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsRvviYf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsRvviYf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2279915e06eso67890405ad.1;
        Sat, 29 Mar 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743258021; x=1743862821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVVtkTC1MI66TMM37oz7HRYzPGqHnnLO5URO2Srg6yM=;
        b=CsRvviYf1JbvQSa1heN6UsXx5q5i1fEgStOaxgRTcJJOIM0EPCB+tT8EcSxJ5WUSfe
         0q9WiiXhFSAyqp0+ud4tD/2IAgMp0+zfxY+yBXlkMzfSefkwwP82Tp79K66aJt/5s2UH
         oj2oRPnYhg0mMNJaapuuUWd+mUeRUIdYhg/UdSDs+zz9LetE00u56vocTkTLIjXhu8+0
         t+jS4daCgvzIeiwjpW04kdWD/FhQIvxquzHYEymRDsHcV4FSqh76xr4HpTIjiJ6CQYt/
         kAITqESJ7LO8nHOwM+B9xFJpMcVFkAww3tqu6n2b8anY/uVNeQ3H/tu+9F1sev/DypI2
         WKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258021; x=1743862821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVVtkTC1MI66TMM37oz7HRYzPGqHnnLO5URO2Srg6yM=;
        b=DofdXPpL+OHBolAUaFX9LWRw+QawXbNv7mGQvGI1WwCIgrsaOP+Iu2y5kyCfPRsU2z
         YISzVICCaxJDju4g9xwNKvmNcTGELELFqYC6w2d1D1Q7oz+SJySTwZthzhLx9RYBCFsI
         pLFRFcLv0zm6ZhWtdlnKPoDUZRkxDeCYolbVtBUhS4d3nRwEBHG5ajsVF9W1L5RRQeqD
         CeXsJOMXSENkliR5MLYTx39IbKxIFGptaQfaJ7zgz3V/wwklnEWWXebNGXn84gLUC/AK
         gbPo+eT3RkgNcjP5l95ZbLiMTiPjX68JkODFW15LpnLICRF7xIXbDeLfjrcJ7mwC7R4D
         XRZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFVri7v+Yh1Kpe/nlo57ZHhwqWE1o2b/cyaoCaqMXTUlck/bfS8J/MLbY5rtFAdyFDw+6W4uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TJ5i2fe2qM2o2IJ98RdzYpyhytxv1OjU+SLbN+LBJy5xlBcz
	gTf1uq8JH/zq9q+fP9i2Dt0U6pPnmk4FxKv6ExVbFeWARy/Fr/bS
X-Gm-Gg: ASbGnct9bH8NTcWj53Vs40AEqFZiLsnbMa6EkPoc5U+zAYKCljpNucxPe81/jIwJH9g
	3Ycv5ZuXdsCc2VmKMnTjzc8LWel8X80f5GnZJXLHjvZ/6vBAlaGks+UNQgJ/7XUDgq8a6+e3yNB
	IeJ0/HFbGcfl6Iswiu34dVjKvA3l+7W2rNfPXNRKYuFaFTiBTV1FqLg7gJB+genE1dOoDEP4iv7
	pG7rfRueh+dCUjrPtskDNWlgI8MrtkpIA8lIobaAW3p+ewv3jGsB35oXITnMjgp5ZOUnkSB8/13
	WynzUsZiRcvqOi/+XoBhLbhmIump2sOBFEu7KPu1K3Z7Lqko53mDGdxTVVAXmCGm
X-Google-Smtp-Source: AGHT+IFla13a8toqBz/M5BUsxjLegdz207/3XxjaV8SKHSC15/QtO2M7wO4LxrN0VoxRRhs+xxuE1Q==
X-Received: by 2002:aa7:88c9:0:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-7398037e929mr4223900b3a.9.1743258020874;
        Sat, 29 Mar 2025 07:20:20 -0700 (PDT)
Received: from localhost.localdomain ([187.60.93.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e22433sm3729107b3a.52.2025.03.29.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:20:20 -0700 (PDT)
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
Date: Sat, 29 Mar 2025 11:20:10 -0300
Message-ID: <20250329142010.17389-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1cab20b5a..2f7520454 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -942,7 +942,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->supported.channels[6] |= 0x3ffc00;
 
-	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+	hw->phy->perm_extended_addr = cpu_to_le64(((u64)0x02 << 56) | ((u64)idx));
 
 	/* hwsim phy channel 13 as default */
 	hw->phy->current_channel = 13;
-- 
2.43.0

