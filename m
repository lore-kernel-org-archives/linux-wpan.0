Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C603D9DA1
	for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274701; cv=none; b=CUqf/XQ78ReTq4tyQZyFWlA7IE7XZwTi4Hj1u0HSjtvMuIlsT7PJugx5qtWHiOiWO0zCHUYoKnB5bKmEBYARB5Wptypasz8ab99uVPQ+tHH9+8HxqrxGINhqCo+cAdqWcVENOmEs+9D2TZUzDIgC+vmSvjLLEu0B9ilbgLOvR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274701; c=relaxed/simple;
	bh=17v94OCKGdEk/7VAXlR2xnD/Jsvb9yNV4bAK1pD/z7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YvKilODKhj0cGd8R9nA7BUOBS4EP7mH/JcpqWVdE09mzdEZ5oV3DF5bx8eFjXfe6XWnyR66EI4mTQxe0xJUAnog0okMxdjKMTvrrUDvQAlhiM20T6qS/cjgOheCRXJqvT3rZYhMAmnl2I+0cvWs+3SSREAPN370SGvbRtsGQvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU75cP9o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU75cP9o"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4583f0a1aso30040005ad.3
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779274699; x=1779879499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQTw9IpMpA0HZfgbqByauqmXOHYN5iiaZ7k3HZ+l4=;
        b=AU75cP9o4yu9681zxC564p/rf2xgJzOQX2d+vir2g5jLoUQBj2eEJGkvJt40mPW8RP
         SV5hZAsvpjARtxB1bBHmRro5P4F/OTncmwUs6QtBGRfE3pB7L6XnLGG3cHYNFVJSW/K4
         VxRXvw9s+E3ceycy07R6Cs5aVh/vxchmvlrfumacUQcXWB0W4Ih33grmeG5e2KBKje7d
         D3fM4StOLfeplf0Sl8/+bm2yTdJ+Uv2lMAhTA2uznbiPjVMEyDLvRL2d6rhVpO8d/x/z
         O4D8OX1WSo5J9VhP9CtptHhrs0yH4rGIulR0pU4ATOl04BEDPUy35J0LLfX3RoBgOZlq
         pFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274699; x=1779879499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpaQTw9IpMpA0HZfgbqByauqmXOHYN5iiaZ7k3HZ+l4=;
        b=GVxeJXHge4aqtldWeg1wCqgzAvzzL0IZ4eT3F7VZgX/MMaHB5p7mGnN0zRgxDnZ6RK
         /kwL+0CEfeA9t93e23qWoy2Q4WTSYDI11s0G5OGqCGzx2/DKPR2XGG2EFnDZuUHiJFga
         gyTRAZ1OwasKfoltLBxC8BhDtJPWNTPFFF8U7zGVNYn2Ht6CfC/50w8iRc6iHT18w136
         NOPfJEPexKNy7umK2EyH2Afm/X+hJC19qrBgbibsvlI5RS3nTFF0YndZuYvLnZmlPV2Q
         s1rx2JnYokDw1/gsrD6CTH1d9Co1V4u+/3TVon+JHmoEz+ZOY+uNxt4hz3AF/hHgHGGN
         r/zw==
X-Forwarded-Encrypted: i=1; AFNElJ9ziB915CueBe3BmBJKrZ65tXRG58Frw5rsSrfrw4731noV6qEUErV3R6eROFfDUk0ggmQ1sF7H7Nt8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UnA0d9lp6hCJbeDekY6chzN/cGMkbSbEFuDeuQrTI4oMJi8L
	LVyhhPHrr0BHenTPfsY6a4DG2GknQMJTSq5ps/KI6FltjF+orLdeQNUu
X-Gm-Gg: Acq92OF8y3Qw3R6xGkeImDQV1FaJMAz9N3UG6xAFz9omu8bi67YLhIQZQp8PqOFI8SN
	c7tzzBtf8w3I8b+hnnbdJzdhWfILA0mXSFSENPoL6FUsKD9wsZgzrumVg1ppVTSEjcPZWQz9gV9
	Cl7EdrBmiAF3CGhKz0NF97pCEsWtuZs3ehsLzA7tyacf1pNIFPAgF1N37JYyHFhh3iLPD4d1i7N
	ooaVKyuO064ws1+bgaZYTHdVObJFV/QtcAzHflv5SCgtuQ0iT7fO7Q8Ndt/fGP9Lj6s+TCoiDmv
	8yX5PZ2SayFMi/uXIPY0Vk2jDdPpYmvOqHDcVKvYxy7t4uysvTQY1d5dRXMRQo4pXzuLVLmUqXo
	56GJPkGpVitzmUINAWmsc5nDrF+FjtXsx6Nj/7fHpyW1ksl4E1TFpHjkd+OSGxVWU7oL76C5Rue
	pWCrQIvpNqtgAvNuUdPxWFFo1vpGJOcxmYHMXm4VepFx/T2RldD8HkxBAWKBVKPQ==
X-Received: by 2002:a17:903:2f47:b0:2b9:ecb4:a3dd with SMTP id d9443c01a7336-2bd7e8f2641mr252178805ad.34.1779274699367;
        Wed, 20 May 2026 03:58:19 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm220266615ad.49.2026.05.20.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:58:19 -0700 (PDT)
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
Subject: [PATCH wpan v3] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 20 May 2026 16:27:50 +0530
Message-Id: <20260520105750.30144-1-shitalkumar.gandhi@cambiumnetworks.com>
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
Changes in v3:
- Move declaration of `copied` to the top of the function (Miquèl)

Changes in v2:
- Use intermediate variable for kfifo_out() return value (Miquèl)
- Add Cc: stable@vger.kernel.org (Miquèl)
- Add Reviewed-by from Simon Horman (v1)

Link to v1: https://lore.kernel.org/linux-wpan/20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com/
Link to v2: https://lore.kernel.org/all/20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ieee802154/ca8210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..1f1dafc5c5f6 100644
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
@@ -2528,6 +2528,7 @@ static ssize_t ca8210_test_int_user_read(
 	struct ca8210_priv *priv = filp->private_data;
 	unsigned char *fifo_buffer;
 	unsigned long bytes_not_copied;
+	unsigned int copied;
 
 	if (filp->f_flags & O_NONBLOCK) {
 		/* Non-blocking mode */
@@ -2541,7 +2542,8 @@ static ssize_t ca8210_test_int_user_read(
 		);
 	}
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	copied = kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer));
+	if (copied != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1

