Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54C19D087;
	Tue, 16 Jul 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140036; cv=none; b=X5rkQfYNdmS5py+ozDXdyfn1+HMNPjBdLP6ARh8CryRDHc1KDc8sWY1H3zp+EcVrFLx2yGmg0Uh6x/JCEks9fs7oswvwFIGgsKxfSJoS13xjSWN4hx12u+IZ6t+OerAbyl6MG2iUnXcA1IVWXekuTgQFN5OKENavn4seYV5z/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140036; c=relaxed/simple;
	bh=IwPgkvY2m+q5f9imFvwGMMVKPQwpfkYkVnnvHiRV964=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/UNfvcJd6l2NpA2ymcXfFW2f+JebIuAEQ1OBtvFDoayF2VYvLrF2i12nWmyLxME8P5sb0GSziHOK2pUPRYpkQPdj/se7VQVtAEPMuapiQ99mEUyRmIYNx5uHh/+fM/MkBiG/4LtEx8tldf4Ecb6TkNZBVxYReJJTf18KcCJqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMdimC7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMdimC7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED561C4AF09;
	Tue, 16 Jul 2024 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140036;
	bh=IwPgkvY2m+q5f9imFvwGMMVKPQwpfkYkVnnvHiRV964=;
	h=From:To:Cc:Subject:Date:From;
	b=MMdimC7nrX5MDThdyDS8V2FbxJbKHEn52pJjWWXnvBcS3lShw8qyyxYDrv48mNfKx
	 bxfGAWT+1oM1uYLr4L0crZop6EHDjipmyKTIkVsr2KVTZEwSwbW1zSXkNu2aRoFDO/
	 vUV17R0LdzryF8QZHvhh2BAu0+CZszVZaPX78f3EjlHWPS7yjXf2TVIPMdQrIyMMeP
	 DM5SKXZWBCshzYSLgVx9ck/77m9jrdX3TgnXBmy4veBjY7Tspu01Yu3+COnDHGUsI9
	 3VvjdEgWvkdudRYAzIQKRgd6PObv6fCV58TtC76tTZ76imPy6li49XbTRX8fZTJtM4
	 Go3iIIqsxyTWg==
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
Subject: [PATCH AUTOSEL 6.6 01/18] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:26:36 -0400
Message-ID: <20240716142713.2712998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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

