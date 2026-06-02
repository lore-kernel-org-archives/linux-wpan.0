Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8C329C7B
	for <linux-wpan@vger.kernel.org>; Tue,  2 Jun 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378902; cv=none; b=F+ET1oyqpD8SN19EsaYAmRTNA0yo2lmFfDUDWCW8lIl6a8Pa9IWZQt6Rk5j4ZjxPXBQxj9MS+Pp/VlxIK/UVMbYLJra4CRSak0JTBxwtf8OZNByhk9sVzyjA6Z5tIWHHdbjc94TyGz8iZTedPi34Ds9jBZZgyQOAgt4LnRG0XAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378902; c=relaxed/simple;
	bh=n7V2vfC1JbI4WrA583Y6PpTcqWcjqmKB0sQIXUnDtEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiPaI/IdJTpZ2Hj/FdrnCGvZMoam1wniMiReRPw8eCnl3SxkYS9e4whAWS5GMZyK7vNXMNylOFPaQsuy39zYxgWK+H0Nr6UWIByUZaCfZxSXf/OuxD/BBzTE8LllXqTpwbtV+XBkNaHQXpfkyY+u+bFMKIkaTo+OmxmnC926xEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4kx/Yrz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4kx/Yrz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842319576d5so1089398b3a.1
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2026 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780378900; x=1780983700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b87cwHT2BrTigjVd+6bwq58aCoITji6mCL2XtGIvkXs=;
        b=F4kx/YrztuquMauH+60ndA5ypfuxlqfdZPjfAHjDcdCTIDEU60N1qzQPzbvihhxzl2
         Jl++Er5WItmtWxzcepURJgCn3GlDsh03IVMuSTd77kW8oYf6jLbLsCIqA9QqQ0MC1qLR
         C1nwYLnExPKOGLmYvyGMBuBxgM8EQXfvG5Xlcgaw8w0RoB37zc8V5ZNRefM6a7GlQDNh
         +gS2vqPa18d0riFTC3rGCmtiNlYqswVktX2b0NSrFyq73vrokmdU0+6U40JyjQpzWV82
         ptl8PdcWBrG6g72V+tklqOWkaZONIXYKy1C3dqCKvK+/Bz15r2pttNaOjkAx97vW7Tku
         0i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780378900; x=1780983700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b87cwHT2BrTigjVd+6bwq58aCoITji6mCL2XtGIvkXs=;
        b=CoPTE31VEnZq0cCW7y34745D8kvZrUAcPWDFSanPNUNTE/uC+0IVq+OwI8JVsr7vsq
         bZZ5UHHh2wPqZojjClbWPUW8nrlUyO29AP7uBznHwigjdgrVOLExFdUuJmo6Gt0lp6zH
         Na8qPsqdhZc8hr6gP0KyGQtNougnVK4arZaTqUvMyDfTCQRpiFkl5YmQrXuJEpbyjOjf
         n+4tbq/Viq9unxPbw64rwP/nZL8v2TxED1992GXm6uVNXHX35OGdjuB6BpD1xelKPqvx
         VIbMcgRsbKYN8xmxxmOMs6GcvNtwbP3CI3Wb5qNVzZmtL13NGWSXe8GXIUT9ZoqkPZnP
         s2Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8yEaG+1g16Kya/JXhOyER6SMsZZj7vzcJAGMyWBJhZCM626KySnnLF4hlJVewwjJQDuql6nKGTvgrl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JwcnW5Bfe2Sv6snLG87+j+brcrqrVLmlzng69PnfWqo1Kgo9
	0AJoHGwTXtjGdHhe40XRA+dosnZSL0K8/GKDetWdBUdoGO3gHfOb/wq5
X-Gm-Gg: Acq92OHWqyQBPyQ15UNNqUp86sDeEC7z9FHEsZrSLdXYqLKQtJXH1f2AJf/gnob5zqg
	ztnANzvlYjLkP8k1pSOnr8cawTL9q8g7yE9UmUZKWbBLQINKj0sEMH+tbcAOMQog5myU0aZ/ZjT
	Y6EBuUN4tlJYUgILBpgxMfvRh/yk7r8dgwARUXlZsmHFbZe37UYBhbXVNTGeit2iRGYzKDAucJH
	ab0KI3NpJG67ZN7NZFqVITcTVQW40sAqFI9dtSCseaV2yDfCaYafgqV0joDarHYwhD2GdkFXE2E
	FeRLsi5Nqj088Av0Q4tuks9SALBiKxSiFg4VGLJZKBHjXmSMQHtfPLTqdWnMiHXDQ9Y5gsm5Fkb
	7w9U/bId4xdWC6SReYhOJUWX7b0TB+Apc0kyS9jMtprrNsxZ4/fdjEtnZLytLIM99blBwfn53Fj
	MQ5EGpGcr8u7c5hauAP+4KIJAt1CdQ2Te5fEAXzA==
X-Received: by 2002:a05:6a00:301c:b0:842:6fce:6171 with SMTP id d2e1a72fcca58-8426fce6cadmr1818446b3a.3.1780378900295;
        Mon, 01 Jun 2026 22:41:40 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:19a3:f977:6a92:60c9:fc08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842596e63f4sm4020138b3a.29.2026.06.01.22.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:41:39 -0700 (PDT)
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com
Subject: [PATCH] mac802154: Prevent overwrite return code in mac802154_perform_association()
Date: Tue,  2 Jun 2026 12:41:33 +0700
Message-ID: <20260602054133.470293-1-robertusdchris@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
return value assigned to either "-ERANGE" or "-EPERM" but this return
value will be overwritten to 0 after exiting the conditional scope.
So, jump to clear_assoc label to preserve the return value when
assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.

This is reported by Coverity Scan as "Unused value".

Fixes: fefd19807fe9 ("mac802154: Handle associating")
Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
---
I am still not sure how to test this change. I look around the function
and use the previous error handler as a guidance to make this change,
like error handler for "No ASSOC REQ ACK received" and "No ASSOC RESP
received".

Thank you.

 net/mac802154/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 0a31ac8d8415..300d4584533e 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -594,6 +594,7 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
 			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
 			 "PAN at capacity" : "access denied");
+		goto clear_assoc;
 	}
 
 	ret = 0;

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

