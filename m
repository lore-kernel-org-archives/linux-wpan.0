Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B847D949
	for <linux-wpan@vger.kernel.org>; Wed, 13 May 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686506; cv=none; b=JKJqCfyysKY5tzhYaIZf3+hF0ezwPg2QZf4WR3d51uxAz1FtbRL9bOIjKYn7/KtuNphRu47MpcDaqjj1sls6AsrOjq4LtTbJjciz13ETa+YCJX8Ng0uhKx9oPlUc8yCLXs7yaJuKAtFuxkqU708o5KE8hvwAznkbC/+V1GvIgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686506; c=relaxed/simple;
	bh=380OIoxziQ8FlKx1mJdOpqZlW6QTVqBF+ru5RUN6Y8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak9DJKYNzHR7lgVkaatMHCEkq0QnnqrqcV+RSjqobfr3ZMg5KghcBO65vmNbgapdULtBR+OCD1n9De55mpEOvkdtmKvWw891USdLot5im78G2RHQuYeg53sTd24mRWdbhv1K150ddC2SHSCxW1wdShsR6nPanhLpq+B/yBASRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npRkMkoU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npRkMkoU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b45cb89f7eso44646635ad.0
        for <linux-wpan@vger.kernel.org>; Wed, 13 May 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686501; x=1779291301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=npRkMkoUGnX70IhNC8M/ofOyKtFVwAiVdmWCIefbzRBhb9ApUHkAZn/LSblKzBFCRA
         wlOTJp3WKEN6cxWpj32fSDOxvmJSFeTaxHXGELTCZkENr8/dsHQWW/BOJoD+RiPc4Wcn
         ZHiMizZfcam6yOMHqJjLkpz1EZFQxJlQNPObFaG3u+1Gc+WXSMhmbCySzPER2zv5gqNz
         0uWCMkz3b/u06VCJzxJY4G4G/nJghKTash9R/knJHy53JLg5TKFtcJ2Hdt+pZs+3b3bZ
         +pv541wOv/ki2bCzgMngHRTw55QDIm5EekSXN0fiV8dWHh5YU5mK2PsXZaii7QyhbjRg
         KZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686501; x=1779291301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=Qa8tOzpeYtuLXkTotMaTzB5QiaE93VGtSSik5/DLJgqVWUtCXbnktbKnKKBpV9zdtk
         svcDaCgzDl/YDWWNOAeATh01GSAJH6YlcjsZG4843pxzRGaDGFLt071qa/INL3s05pAG
         QeKQefnOGVk9XiuVlUxOMyoB1Gy7/HNYbfoBgj17NT9qEtTCNU9KGb/CU77iG+EfnjJL
         4hlUq+WX30xaNAI0q1Evz0Czeom2iUvDBkdC7Kfi227KFktG/H0HuDXQmuFzXXKUMoN/
         b7r3fscqQwXWGFpPoiY0dxs0A8YlHkg5xNkiuJKZMKvlBfKKQ4ScisVnmoJKH52DsuV/
         dU9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8lrSBb1Swqf2JdbJsuLJFuT19fAsY4+uyoyO253hucPJaM4tuYn0cX7oNU9d2LbnMByZCaxZrQ4UMu@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXFbxu3AYZ07N2lU93zKSYjvjp2AUNRmhEb9MPIrMduEb7GRm
	aSy1SKT6krjwivMT1lA/qcn+55lU1VF1awCcobJVaFwF1vhaM++8NUej
X-Gm-Gg: Acq92OFqzABnnHZPqakqRlpfMNwwoPU9vEB1v7sGJGBcSYU2P+U0M+lXprfdRjOaKwN
	jmvZZZs3nhtollx4d4+MKQP6J5HAESmxMVfrLygFjoFnVQKkMr+1Iqgym3pTyWihLndDWp9klKm
	lZx6GZpwIdL+679d37yuyVKhwT8ukXfKXLXgagu2J2y0gWWhzh/e+YQyEPAPY1FxZta4pto0Zon
	36gp1ypXoeDudmD7kdvQ8mBkZqzO3uaLoF6fWOuLucB4j/F3snOfT3Gttcu7yOxPHYpMDu6WIwm
	7UFkTW5DgMqIiFXXASJ9yAbTqN5o41Te0ZZdJLLb5v3OU6m5cUIvgjfLxYKkDlgdpsvE0KxDaCO
	LwpDF2aedty7qBS4SQcDzOze88+d7qywBb9uB7DDH2rI60vw1e+36RwY74rGCNw1tcchgzKipDU
	IrVKbNN17VAX/W3V9sKpx5cRtMrh1ctf+h3afg9nYgFl/acg5DWHuHLlsbU2rkOQ==
X-Received: by 2002:a17:903:f8c:b0:2bd:147d:c712 with SMTP id d9443c01a7336-2bd27133c75mr44261705ad.1.1778686500924;
        Wed, 13 May 2026 08:35:00 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm173821065ad.6.2026.05.13.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:58 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 13 May 2026 21:04:12 +0530
Message-Id: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
'4' as the byte count to kfifo_in()/kfifo_out().

This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
then reads back 4 bytes into an 8-byte local pointer variable, leaving
the upper 4 bytes uninitialized stack data. The first dereference of
the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
address and generally results in an oops.

Use sizeof(fifo_buffer) so the byte count matches pointer width on every
architecture.

The driver has no architecture restriction in Kconfig, so any 64-bit
build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
been latent since the driver was added in 2017 because it is most
commonly deployed on 32-bit MCUs.

Found via a custom Coccinelle semantic patch hunting for short-byte
kfifo I/O on byte-mode kfifos used to shuttle pointers.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..154af346c936 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -597,7 +597,7 @@ static int ca8210_test_int_driver_write(
 	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
+	kfifo_in(&test->up_fifo, &fifo_buffer, sizeof(fifo_buffer));
 	wake_up_interruptible(&priv->test.readq);
 
 	return 0;
@@ -2541,7 +2541,8 @@ static ssize_t ca8210_test_int_user_read(
 		);
 	}
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer))
+	    != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1

