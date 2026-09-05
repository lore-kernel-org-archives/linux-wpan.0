Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDE248867
	for <linux-wpan@vger.kernel.org>; Sat,  5 Sep 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643220; cv=none; b=MPqj1xSLi0U8cxO7OgmjPlgye6VLYGx15X6RuUUFJeHroLWI+a45+OU5D0Mj61qtM3T5w7LmRTRhPkwYdyOo6JnMOEHL3nNJSTm+818tGEVLew9UsN4R6ODx02SEyWgK+rFGjvhCurletOxfcLQmg5KG8kBdgJRGah7lqODp9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643220; c=relaxed/simple;
	bh=jSGSOPGdun1O6fIxZYqKJoHEOv2B0LFaUlT1O3HCPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsubnv9lR6CmHcjgCd7Yy5TbVq71DRGO8wXm0wougbp3m3gdOU93ypLxPm1UTidtOfgQgUMNPFM9L48b534aLdWtUet47ZDneAGmygrevdME6NBMap6piL5YJ5vzcDiH6bIN+Ozg6AbF5sIzHKoZurHbUx/RR3OosE/WALPx040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egQQaQwL; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egQQaQwL"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso981659e0c.1
        for <linux-wpan@vger.kernel.org>; Sat, 05 Sep 2026 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643218; x=1789248018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fELFukRK3cLSjolaPX8uHr3nBn0dP4gV3YMVhWZLVs=;
        b=egQQaQwLKlI3dzc/cj938Z3m1oDHPiPC8maV2gkRslFEZ8COaNHxMhuE4aFLz0/+9/
         PtVWGykdIL/CJqfbzV/7F0AHJo6bn66+kpBUZ1lKK2nTff/yEuIQVE0RSbwuOzBfadnR
         TsOa5S/YmhLXwfdCK0y5LZGTn51uFCSADiSLWh0Ir6cKYQ5J69Onxb7aDcZqTUdjnrd6
         52EcmzN4m3XFQvNLZVv9QQe0t7ZYgR5yB4Sxrk/gUbi2pqNZ5vCmNS4sZ7mufApJMQW/
         93TJu7ZstPtaCL++eiDbn0ZLDdisBc2+2DoBmuSy4k8bo7sMO7kOWPvCWTo95fSALbPq
         LE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643218; x=1789248018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fELFukRK3cLSjolaPX8uHr3nBn0dP4gV3YMVhWZLVs=;
        b=RK1d5D0+/Vs/HonK1vVOO75OY3PjPES3+OOIbUn/y7crawhH0zq3TWju1ETbG4FXZl
         N3K5Vol3wnbvPDT6EKXGl8DGwPVVKVZtstgbHtOUYqCkxl8PXb6jrI1ZzxUTwONQc30B
         8OJzVEm2IWGtwB6UXjyY1J142EnfmdTZlV2FTwPQoN1FdwvHasU8snKIY+ZEOpF1H7kZ
         P0YVwxcmxze6hQZhYRslZD+Qk80NNZcHgtstzKVVllyfX9RwlHxkghyqUp6bPGUOXEGx
         zrF9lIGL/iNf1d0d1hwsW9CF7fXYarkF6ULWauICeNNPzE84zQ/0GPJFqPOz8lAa6RQN
         teTA==
X-Gm-Message-State: AFuF++n+DIkn0zRw4xSfBVUmtp3+kQ6DztH0W+3iDvcr3o8HHsH20A82
	ARVwTXdmQwmdJTyDksRrePc4XpgxYyFdRqMRbEBj63kLsyISrNJ2hdAD
X-Gm-Gg: AYBFou2Ez2UtusjH03E9dpzaLcTI9V4xg5biQAMheUGGeCO6f8FjzXlB3nMkD+3wVTS
	v5DezQ+H83WRzvH23dag0jvwCX8tusLbhmwX7c30czoUomEBJkv5NcUFHKnPz/alCdhDWkdmm1Q
	jZn/sIoD3CNnT7dzSO3L1KmQG62aw4and81ro5ggxxqXvoEZNkSqJg/cLJhxhgYgDbXnZrReTUi
	IGWKYq//4XroPjY/fMl4B8nvOQfKOVvDQUbb9kxo/3aJa2zD0XyzGcz1JvwAsrKxb/WFfMZ4VGg
	MgvhjlPHxBvVEmvTQpnQAKu2xpmPBVyWlklQmFCwAQu5MBKtNMojzQQSs+IjKRK+jTdGp+Y1NtL
	bclK3RvZ7sH6VeRqmjaihAVo/2bUbbLeUf9JU3bkiTEH+AUaJ3MKqJ5/c9iCBLBMB7Hqd5Xy/cR
	/ypnrRCCE2MVUAz+LfmTU+EKhwO4f3zKn8YUuFWewJfvM249WcsGs6fx4cEhV2p6s=
X-Received: by 2002:a05:6122:8f8d:b0:5c3:61c2:9ec6 with SMTP id 71dfb90a1353d-5c7ed456d8bmr6057176e0c.7.1788643217986;
        Sat, 05 Sep 2026 14:20:17 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1097e5sm4901956e0c.2.2026.09.05.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 14:20:17 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 2/2] ieee802154: warn on unspecific wpan interface type
Date: Sat,  5 Sep 2026 17:20:06 -0400
Message-ID: <20260905212007.304875-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260905212007.304875-1-adrianox@gmail.com>
References: <20260905212007.304875-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the unspec-iftype WARN_ON that cfg80211 has. The iftype is set to a
real value in ieee802154_setup_sdata(), so hitting the warning is a bug.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/ieee802154/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index c6213412d291..ec5bfdf6bd31 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -297,7 +297,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 
 	rdev = wpan_phy_to_rdev(wpan_dev->wpan_phy);
 
-	/* TODO WARN_ON unspec type */
+	WARN_ON(wpan_dev->iftype == NL802154_IFTYPE_UNSPEC);
 
 	switch (state) {
 	case NETDEV_POST_INIT:
-- 
2.51.0

