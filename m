Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA42222AA
	for <linux-wpan@vger.kernel.org>; Fri,  5 Dec 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957369; cv=none; b=l2ybqfcJmZF+jg+DzPOU3vhGCAN5Mt9eAQ2zOt3y052m8hXPHat+bbCVvLKxI5q67PHUqq2e3zgoYfjKs+2Q+ow/zAQu6d/1rDWHncvBBdzhPAHXeZX+p5RMKo0Xo9o8FZ9mPiewnC9Oak5uknMtCCZBVLT1LMLwl7wxI2s3Tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957369; c=relaxed/simple;
	bh=cT+okyoUrHTXA45Is0Pw9F6TxfbUti+FzziBF41Y2dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTZd9Bda9vkGx9i8yanA308GpgsEOxfCwJvpUAxtSqRNGH02U3bKkRcQDKiFG1dCFFib/VPx5ZmCG9sZGx56PVJDJmwtyK1ZRkDeyX/AKw41qacoX3FJWuh8ZxBZK90vax9pZrfqicFxCd+qHV0S/bnVBY/3xTExhqhwx7mSW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9aV+sGc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9aV+sGc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-299d40b0845so40507345ad.3
        for <linux-wpan@vger.kernel.org>; Fri, 05 Dec 2025 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957367; x=1765562167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=W9aV+sGczy519i1x2Pwh62V+43tJ1dPNrr0llLdd8N2KFtACMUBmtfjrvhqw/F/5be
         l3PczTqWnkxVvE21OjNXE3GqjeNgNm4fryvqdlyxQsnXmh91vfJxiZ0+Ogz8q4W2fWTC
         iINph9TUWa6QExTgIMDd8AO9oLDjwE5hU0Mk0WZoI7o9revZO6MBWkz+mjSTm5jyT+yf
         DTPA6jtiNwHPyqBX7kVvLqO6ezSIQE58VBMHu8r97OQxyuJH503MkYvEAF5PDUicQz+y
         Q5tCp0eyDGjTUdoTpVIFMWCY1NYyljUVBi9r0qVGTW+MEpg11n1p1QGA0MnnUFn/nM5Y
         T/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957367; x=1765562167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZlkRLK2kR7jmdSrjUTkpoX3kF+r/9UBuu/w/fSD0EY=;
        b=PjDgDX1+y6RZS/MLSu1IzOWYmTeTUlqmRLj9kYibPZ1XRu+kuUHbRifU8rG1k0cdOr
         /MO2xyulLQemzDuY4g8kxL19bFVsq/c8ta6nSWMdeMEv76SmEOCwOkeNx3Zmc+WpTB3U
         sqE6oYDPCaxMcmnrv26goYbX0pSIWa3YdXY6g+MMED1Uus79AA5+xKefOPUN1wQC1MnJ
         /TluMUYq1rYTWv9tFznJd7KKbI/kD13lkYwEMl7cAWo4BHe3ejU4Haspv5ETHzc+TS5v
         RWJEsXlmcAmYOmEyNH6ieq5Q7UWbKkEY+FjdZ+hZFHXBQKaA3w2/BZfvmBAr2wyyDrBt
         PwRA==
X-Forwarded-Encrypted: i=1; AJvYcCUCtjZAgGzwH3Tqz8i+rShtfFIKkggoyefspdER2+NQDVJyJzu8za5unJ4Sh5pdLMIZ3ryhrESCEYcK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mJoZsQAYitok2z7z4axmOPZtO4bIc+yk8YvH/TO4VSqlS1nw
	VbbDZScU+ixeQkRk75PS/kowBT2BduEq5kbVu/uIBFIw6Tt0nLqipNM4
X-Gm-Gg: ASbGncsjtTQaMVceG6Bub7gwPWwkVctebl4WifOrvi0EyKvn/ntM4mYlLOhM2msA25o
	NmvLHrcbt8vNPifccgxbMJ3CdBG26590yJZgr2YUgFHbavUfIanOOJTDZat0DxqJcpnv6QAmuRZ
	rRgm34ZwOdMfbdkaX8jrJ5UOnv1BuYAiecgub9wcd/S8b+8idW0lvYIZ0xUFDNZ903ZBxy4lydh
	Rat3M2ZLJA1Z12KptU4KQQOCNUeao8Fm3sQe8PSe8TawIOBylosZf/6K74rbkhsJzjlKaiYys6/
	RC57CSXf45UqESEwL0gLoykT5jDW6/+Rbhx8aFXk/2uLBRm0VjkjKLdI0aQX4hLL4dmNBeNeX//
	4YN84Rd3MTufmmvwRjA7+QrKxaFJmX9vqwo6aACNj4CqkLUcVavtMcwJgV+M/w32oFpdSsgnIr0
	6MxiMgI1OhZBmmB88sSJifb70SwCWzSv+WmOraHopd9w==
X-Google-Smtp-Source: AGHT+IEMZtS5OhVis+tAJNWxbgTpnD1LDhwjU9539YkWmdypSP2a1B96Klyjr09ref54U4oS9Qg8wA==
X-Received: by 2002:a17:902:f790:b0:295:596f:8507 with SMTP id d9443c01a7336-29d9f51abe1mr89758185ad.0.1764957367074;
        Fri, 05 Dec 2025 09:56:07 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8839:f626:f539:b6d1:1913:1426])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3b5dsm54459245ad.40.2025.12.05.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:56:06 -0800 (PST)
Received: (nullmailer pid 619889 invoked by uid 1000);
	Fri, 05 Dec 2025 17:53:27 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, david.hunter.linux@gmail.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, katharasasikumar007@gmail.com
Subject: [PATCH] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Fri,  5 Dec 2025 17:53:24 +0000
Message-ID: <20251205175324.619870-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer and
is deprecated in the kernel as documented in
Documentation/process/deprecated.rst.

Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d45ace484143 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -173,7 +173,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
 		return;
 
-	sprintf(buf, "%d", id);
+	scnprintf(buf, sizeof(buf), "%d", id);
 
 	root = debugfs_create_dir(buf, ctx);
 
-- 
2.51.0

