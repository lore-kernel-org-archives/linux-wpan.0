Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C319B595;
	Tue, 16 Jul 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139925; cv=none; b=LWFVXhClsibV6ziI1NFDkIZ3Owh5BW4GWgfxUjs+ZYvEbEuWlwJ/NBVg4bIRdrPVbMwTQKZAqITuffxKqaG+4f4/3e5tqM7RBs9MTp3ajTaUFBdZqfwyRFqVUgVxxljUtI4ppAhymfuZ1ORxNxDRL/3SeNCNK8eTXcsplKfpxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139925; c=relaxed/simple;
	bh=IwPgkvY2m+q5f9imFvwGMMVKPQwpfkYkVnnvHiRV964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQE0/EUWmMZs59Pi6N04BZEnwMLXe3dyHansCqqwOEMHvoFqkzegNha7mFqjS4MCT4wc9X0uNs89TtbrqSo0rtL/sNMT9HRlq84fO+T/Npas+7LMawBnAnI4s4W9Dyu7qHidxQZ2kvet81AnbV6VmJMFoVFvg5LIoh/6e+F/UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjdcqR0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjdcqR0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB6DC4AF0E;
	Tue, 16 Jul 2024 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139925;
	bh=IwPgkvY2m+q5f9imFvwGMMVKPQwpfkYkVnnvHiRV964=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjdcqR0f9h5q7Cj2XZ0TMSn9t9KWE43VRf2DPF5fAVR0BNxm2Qt6+W6zSUgjihpHq
	 XSEs7k7Ji4lkRLivXHLOy3QIHMAS1N+CESJLKA3Ai5et/vrPQpBjzD8qXH9T6mHfbQ
	 t1GrOk93SMw8y2f3QWBk2nnN+o+0s5TUd6mYDMLj8wRYF0nMYGm7rFtdBe8KXqa73c
	 XXlp0f3rhNnkJeqJLRH8YUXyH4zCA+QN8fAASe7XKb/C2hTBWtmAdtnrefchUtg/+L
	 8lTeYSKZ+t2R3aUAMdj965iDmmUR0saCJyQ7DgIWDTm1J0vlPfZGZ8yvHu9bL5sTsn
	 DxzRd5lzi8tMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunshui Jiang <jiangyunshui@kylinos.cn>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 02/22] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:24:09 -0400
Message-ID: <20240716142519.2712487-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Yunshui Jiang <jiangyunshui@kylinos.cn>

[ Upstream commit b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728 ]

mac802154 devices update their dev->stats fields locklessly. Therefore
these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC()
and DEV_STATS_ADD() to achieve this.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
Message-ID: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac802154/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 2a6f1ed763c9b..6fbed5bb5c3e0 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 
 	ieee802154_xmit_complete(&local->hw, skb, false);
 
@@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		if (ret)
 			goto err_wake_netif_queue;
 
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes += len;
+		DEV_STATS_INC(dev, tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
 	} else {
 		local->tx_skb = skb;
 		queue_work(local->workqueue, &local->sync_tx_work);
-- 
2.43.0

