Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EE27E045
	for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253657; cv=none; b=TmwLoOoGGmvkPjFI7QCw+8VFRNaFo3rgGkEDyNoWxK8nzfo1ncBojWaTEpLdur7xQe2cTDyme+mNSsKo1ce45D/3ZsUVpG4+1ACuZKJCrFCg27weP+Fxyq0I9ULQVkYWcTm7CHzvV+HFJaqwpgMlSyArOvS0aHdHMrn8yMgNRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253657; c=relaxed/simple;
	bh=5VTmq0pQUVhJbzGCPIsAQcdY2+RM/h7nWn5604rVx4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MxeqeUccNqMWswjiDqSfxD0RXz/k/Q+1DErKZlUqY1+mKJxMsZqW9Xep4aze1HDfvS34akTgZU9lTCLqksikGm0BTVLGaJ0L/GMxyP/RR+mt7+mEO3mbsBaAoz7xsG91FoGOEXbFnQyM5JqqqH0QfKS/i1+/Cs8I++iwj3ozy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5sokyBb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5sokyBb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so1337405b3a.2
        for <linux-wpan@vger.kernel.org>; Tue, 19 May 2026 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253656; x=1779858456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=b5sokyBbd16H5karwnkOcrZNoFc4nw1dcw0I45h/IaiU+3O6/KgXM/ZVWaEfftI3EC
         5xgDwWOrH1cKIWn7rFXQeyLA2JI6FqSo0eNYeJzt88tvOo5YPI7gB0NN+QevlM2YWmKY
         cT6I2HwWkoJMKtLWY5fG/tvhEs7cUMNFdbjYVi4lSzJYM9RzKp2/Rjv5JRw9uo2+GD8o
         S/201oNDtPnih2zN/N8dviTsCOHYCspw09IfBVBlXdPlVdA/K2VGWwug0YDMIqvO8QxX
         xxgduQOohRmZjaU67coIPo2VZ1xJ/4BPfUX2vWIiyDfai3L38VLWcRhdgu+WWhjjnSwo
         65pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253656; x=1779858456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=qkwlYWAgU9JJ5ZULPC66rJEvODUvm9tEIj05mTX1qSH/cazUvl2XY8MS7PASNJfCuL
         arzdsmqvhN3gg2iYTevjiqjrOyI/bHKWZoZ/93Tezu3bvVf0WpifhltY+TjLkKP4GO7s
         MjASET5FRANeLSC9rYv5ZXovzyBO3ecXtL/JSPJai72GKOS8cx2cC1OwxPsThUs7ztOp
         agbD6w4soI70ruVAxfHWfTmy8a7JKtJSHgMbCH3NnvcfLO3ak8nWHLO5zFQKbOj2kqH2
         xiWeIU1tK0ZJW5mA2YnrHLYY7JaR+VNtBtX7a4+o2R/fa7lue5oIrT0/ENUjgrvrqfjB
         9M1A==
X-Forwarded-Encrypted: i=1; AFNElJ+hfoQY+KHiFVclX0hC8UQFvPGUQ/zQlhVYNC/DfXU0pMM0Jk4xXt1190j0Rt/XywkldWM8Zc2JunLz@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0CcXuwwvENZVIcysgthQdWQVkDAdvG0NRQ0PoIoIRgXhPira
	Q8oyM+/uUMfDt3IDSNFaK05SDQGGZ61YuoYQaextKSLMJxkwuj+Jtlso
X-Gm-Gg: Acq92OHkFq3oR8cjxBlbNec/+bhRQTawgGvAxuyDujPNYoyCmUB7ZBfobxqdFtO4D3H
	ZnH+RnyZaeljwJ5+9n9GlxFmw3hggbs70lpHnNG41jVqK7GfeyEdV+vR1GEqK0wtqC3A+YljpRX
	Dh2NARyG8xyNRNO4XZrgI4Ff6jr2Xh6gFWGNnRIu9LRgQFqq3s5LdE7Hc3pss8NAVeiYBW0+R4H
	iHB1tcO+0UYU9HX/TYBjRoeUNTi4XvtefHT111oyYJcwpgtAKz6XXY7wDc8gWhgu9n9a83VI+xy
	r8t0dXnS7ZEQEy/OIOH7XgpRlB81pibZy9A6UCdu5bl/MznlBMUElBOvbnVhPrgndSYed0q5FY3
	rc8LpONxqzYD/vUB6uVmVPN7+toWwjuhBD5s24/CXlfM7C+fWneRRgUE0bRvzr9FfgU7FBT8Wg2
	f28aLJl4qET8Kx3WULbfqkRt8aY7QNfBSOCEaou+dFFa26hPxovFwhyYlvci/QZw==
X-Received: by 2002:a05:6a00:3e1f:b0:83d:43be:d537 with SMTP id d2e1a72fcca58-83f33cc3782mr21034334b3a.17.1779253655686;
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ce1fsm19786672b3a.35.2026.05.19.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 20 May 2026 10:37:07 +0530
Message-Id: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Use intermediate variable for kfifo_out() return value (Miquèl)
- Add Cc: stable@vger.kernel.org (Miquèl)
- Add Reviewed-by from Simon Horman (v1)

Link to v1: https://lore.kernel.org/linux-wpan/20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ieee802154/ca8210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..828cee8a6101 100644
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
@@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
 			!kfifo_is_empty(&priv->test.up_fifo)
 		);
 	}
+	unsigned int copied;
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	copied = kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer));
+	if (copied != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1

