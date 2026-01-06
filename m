Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B834B41C
	for <linux-wpan@vger.kernel.org>; Tue,  6 Jan 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719970; cv=none; b=HiG/PAwB1DNIXHEeWbRGZGON4AltznyYICkzoSjk6MqkoTJbyyGyt2CI+v0ZLvlWK5AhdWDNmgq6hkDvA7UCyqACd0dF7nsKIDaqIb+tg2HC8djqDVhWWiPlVSIgvHvmYujFTZwZkjUTapj5ZW/q+Lh4uIVgbGWmdK9P4a6Ge74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719970; c=relaxed/simple;
	bh=XCtkft8bohaeimnq+lp2cMogo+aH8B2GI3J6/21tYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvnH1w9pP3gZHiE/Z47ghfX9tBCDX4rqejgV7DMXdfaiYIPSQGVdeXjb5tfUhNRvdGLes4aoH+T4qu3mdpxiwj8ezrdj/X8Vn1EtREoVpAp/Yz5e3KoTRS7BHc4L3K40iaJYNvBb4GxaiHMT4Jceos6hmOXHXoXv18ypxh7P8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwe4Tu9b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwe4Tu9b"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7e2762ad850so1221432b3a.3
        for <linux-wpan@vger.kernel.org>; Tue, 06 Jan 2026 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767719968; x=1768324768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=Pwe4Tu9b0OaLmgLmvZmaVKTP0GmkRSi2lgsvI92d9NCFsr2H7z5Q+T6Oy28n24qt43
         xsxW3qoSb0kUbT8oxK4rXLWgk9L+HdARJ8ddjxiUFv8ilBF29NYLgKlbX3kHDaiZpQ+e
         jM3g+03FP4bC3FYW5IZgHzkLztw5t5OCWgw4L66hF3huiCI9pq2ZuwqSemhdCpX9wLdU
         g1CWdjFmpqOcNFFMmNXalXkF7t+1Vb5Ul5K7sgFrsyjZ2zrqfQNEoRoCuUQJI0Ks5Qzk
         IKlk5OR/vVeQ46/7IGrqQ/WOU/4OQwz9z3sH7tVX4Fidfk9cwr+pEJppDGJ7byI5E+Xx
         njpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719968; x=1768324768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+OyAyzrGoNWAXYfPY2DX52zu0b6XYq9idfXYiJBSBM=;
        b=PBQIy43YNB/kKXDIGTfrYo4l7VBPXjEXV6qXIwFUQLYNk0Q4pEH0y+XSMV0+gY56Hs
         R4sFcqdSQ2t7hPIWJr6SyvRBGCRxohl2Vv4T+W2fvUXCuqTTEqWH3KzQyQFonmMCskOF
         XY/Y/tbeP5acJrCWdqCamBqlSv4hDKI1bmDzx4Bis+JsBg3OTP9ojyS0QR5i4XSGSPbp
         nkMS1/jvq6ih91QllV4JM3DQy1di7WH/aECSSCxYuXTi9GcYVcA1KdaAb3esXOgU1C/Y
         3Ck7ub+V24mKS+/bPpJJ9eLzfFAwhFy3HiN5Tp/+o8y80FdMC3yIz4AshGrKxTOjY3NZ
         y+1g==
X-Forwarded-Encrypted: i=1; AJvYcCX0G6EX5ppI9deo9vtGQ/vN1NKbHTTezYt5BThERNMmEQ5EYVLWVK0yTX8CXbrl0XW9qlV6mDTpt5Fi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2EjYijhF+X6aqcyjZ7KR5FbdTltBKo87bXt8S38orgadUfS8
	Gz2fpZUxxEgcOFfPexSRYuGOgqrXsDwMXGuYdR6iArwSAA+2+/gfMAcA
X-Gm-Gg: AY/fxX65g6CpKRA16L8SlsiWw/ioUN9OakqeuNj/2IkFoUn7zhaVnW4rB2Zd9dLI6b3
	faRTcZB9ztsKpkA8acXKbRaVd4Fl0FG3vWodQuG0U3aruWeLsKVeZzzV8iFfMvjH351gadP+6n9
	pxT5QD4QsNa07jfdSjrWsZNgDpYkNnSUBDy+HbJ9QzvtuGM9eHe2AeozaS733V2x/LyAoufDb4c
	rpbVbw7PSfIsJJDSLtwQ5IDPFN2ZkMmoE5dBq4w4xsLQx/XP2BQFvFXQGTszgFT5ejDlkRGXffL
	vUauW00UiL0QaBghTr7PCusXXcXYOS0jRkZTabU1K5guw2vVQJ6YQDxrzUYvOE+57zUoxOZQ0Zv
	nWIJvwZXxiTeUIuL4x5VEq5usB/2B/L8QM91PniiqJuMLPOXDovHdtB3a64SFJ5fP9W7+JT0aia
	INHbEAVhpyKVa+4nVOwRy3LNnRqxQRrLwI6LQ7JRm2nQ==
X-Google-Smtp-Source: AGHT+IGYSvTn1Ci9vinRdw7r0xeSkSd2eacLOLCfjsA7K6i+z4Vc1na+KoVQcKiKdfAdirkFse65rg==
X-Received: by 2002:a05:6a20:9183:b0:363:e391:38a2 with SMTP id adf61e73a8af0-389823a7fa6mr3325497637.46.1767719968136;
        Tue, 06 Jan 2026 09:19:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8838:65fe:636c:fbb8:d9e1:61f2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2875157a12.10.2026.01.06.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:19:27 -0800 (PST)
Received: (nullmailer pid 124163 invoked by uid 1000);
	Tue, 06 Jan 2026 17:16:29 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com, horms@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH v2 net-next] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
Date: Tue,  6 Jan 2026 17:16:11 +0000
Message-ID: <20260106171610.124138-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprintf() does not perform bounds checking on the destination buffer.
Replace it with scnprintf() to ensure the write stays within bounds.

No functional change intended.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
v2:
 - Updated commit message wording
 - Targeted the patch to net-next
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

