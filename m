Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6832E728
	for <linux-wpan@vger.kernel.org>; Tue, 21 Apr 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756836; cv=none; b=cAVEP3aPCErvj28E+QdXIXS0nP3brdRSBFBbKSLASByx+SGWOmxKYHztiumbyi1Bd/Pt+HASuXNxfg6OturDWxsHzu6TWgxJ8yDRFypDDfZEm6BFNhAyFaGhvCFrDJOTWV4Lio98O7jvOzlMN5+mqcmLy2XJuLGSpO0ghrVXT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756836; c=relaxed/simple;
	bh=kacipmRh/ARA/yj251suNKvUgkiVHzItJyjKIF1jCv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pk2brE8xeu6T5JSTlMPsqqj4q0Xf5WPXJ6W/xqb5kCCjz6xTe9+Qf9wAl8FdbcM/wQ5MeY9UM2H2CwcipffJbJtRI0+i8WiyMrjtY1Kl8B5Hk3/bpRoQKRyKCjZzHIi14pKXEWYbIcIf2mE8kWwFJo/A5PSfMn0DBWCkKzxpNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvB2zik+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvB2zik+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so3773694a91.3
        for <linux-wpan@vger.kernel.org>; Tue, 21 Apr 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776756834; x=1777361634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=XvB2zik+You16ZAqXsdCCWXx9ivmehqG4NGlR1hGiIdeluO3DKYjN3qkYYmVvsBwmY
         ia6oqVGIdWrxxT2lmQ2XdbAXrEwnVvrd6mqNCA9m9+ppJUxS0qxkmRsGBcxkK9mfg7Us
         28Y26XviCjkbVV73NUsimZpofjkuaKNIqQ2Ddw1/jvG0nUceikMFUHTj5JUeGbh5aOH4
         cJ9xHok2gmQkCEYPEKDvgKZHVzsKsXAf9sGd5HviNASSqf2DTdCeP4ysicHQHRo3pNEo
         SH4Ae44vLrae0OTLGA5sWzPuzElh1NLH0OPDZpTvwksgpAEu91D0SAKK0ThdJfX2OSss
         4QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756834; x=1777361634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=cK81fZ90la0isVEv30VmW8XjAi/dX/92SwzedVKBboqwLhUZmm2XmC44Sbzy6+X4qS
         qez5zrv7yYx+XtpWEoNDqocQBJ+IXn1Rt86aNFpJfD5ZI6Mh/E2SR4sgeF0zOCIFncXO
         lNDF10O4F2ykNXUraEJx1nfsLxRrCv2ONdikuDE/kjTYkOGHDmOKIdgB9ypH2dd0HGo8
         iKh+/cxWNcjqh8H+PzQw+UukYM6W7PAhNKCicWPIf4X20ElOIEqDRc5H3ftBYCXe8/n6
         7OZl4FS7Fl2hZUdIGcIVHsxy0uYka9ROCbalqbC1dYg5ha22tdLiZfjNFD8BySc4Hj7S
         LsTA==
X-Forwarded-Encrypted: i=1; AFNElJ+0kPGWFrV5C7Xv2+ECbsm+g6b2ccF5sTipjeipjnylNAHMZ5wBamsDPLS0uSexTVIya+/EgCtPw0MP@vger.kernel.org
X-Gm-Message-State: AOJu0YyAY/m16ZP+MeJxyKdVktn0tevvXohcr75pQrIGBv6PsjHZHmBE
	CYtFZ/gdOd7Bee1YJWQt5dtqIsuRhCaDg8/8SCQYwfJ3TSp++pdsT/AF
X-Gm-Gg: AeBDieuz52uwnZJvM7W96YD/DFTKEAqO7ARzy3lb/XbaqfJGvrjIJKIDwWVOCE1NVkR
	PHg7xBkqiBEQTB+eUVFljuN/g6KPyfN6pXPe0zuZAIVe2mGzTXoGiIC+TkCBtgMtll3U2gF3/AQ
	xdpJVjtM/bHo1q7Wi7jl5ovltU8AniOec4vraZZKXnDjo3HWe0DVoArPg1vgnQ61vLGFDX4MGAE
	eyYv7shm6i5hMVdYeNDbp2jt+7DosgFJdXUB/3AN80V26bCNZdBcYsEagoj2xE/G+2VU6IIFncr
	kq4wazbVN/8/E3j560vzIxIye3OBPaGmHrLHacz5tr+oz79AVJLsn6vt6tDNn+OoHggwfyWq3nV
	xry0po8Ej2Q7KIqtsimnwEOURzs3obaQdr1d6eL4Y3BztKzvJHArYwuXzsmryWrr7Mv6TJNCQZc
	pShXYVTiSSxjdT+lQt8NGC3q+CSyy83G515+oYMxpSodnpZxWSxWO5GawNcof1JDpAj9E/F6O/K
	NabUlt0tJM=
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr18530382a91.23.1776756833615;
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12411902a91.12.2026.04.21.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Tue, 21 Apr 2026 13:02:59 +0530
Message-Id: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
and relies entirely on the SPI completion callback
ca8210_spi_transfer_complete() to free it.

The spi_async() API only invokes the completion callback on successful
submission.  On failure it returns a negative error code without ever
queuing the callback, which leaves cas_ctl and its embedded spi_message
and spi_transfer orphaned.  Every kfree(cas_ctl) in the driver is
inside the completion callback, so there is no other reclamation path.

ca8210_spi_transfer() is called from ca8210_spi_exchange(), the
interrupt handler ca8210_interrupt_handler(), and from the retry path
inside the completion callback itself.  The exchange and interrupt
handler paths loop on -EBUSY, so under sustained SPI bus contention
every retry iteration leaks a fresh cas_ctl (~600 bytes per
occurrence).

Fix it by freeing cas_ctl on the spi_async() error path.  While here,
correct the misleading error string: the function calls spi_async(),
not spi_sync().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index ed4178155a5d..bf837adfebb2 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -919,9 +919,10 @@ static int ca8210_spi_transfer(
 	if (status < 0) {
 		dev_crit(
 			&spi->dev,
-			"status %d from spi_sync in write\n",
+			"status %d from spi_async in write\n",
 			status
 		);
+		kfree(cas_ctl);
 	}
 
 	return status;
-- 
2.25.1

