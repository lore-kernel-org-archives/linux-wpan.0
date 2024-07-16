Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593319F49D;
	Tue, 16 Jul 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140246; cv=none; b=XzdgbNhSovKu6243SDDKhCNL/1NSqQKQHUU1lnU9+yRe1EISuZHKTUuS1TKqLlKiaH4HzyQodOyI5wNwlJaz6ad4lwB6LzY7WCcqEo5ZBdtIHI9u3KVvzO5HYw+ZHYuAbHSbcn5fD3SDfXz1JcK9ePpwJ13jH/tjC2Wq+r9jnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140246; c=relaxed/simple;
	bh=infPNRYxoLPc5eWpdtLidjjuX1l7hIz+KV93qOtV7KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3bPhUw+SWvLyQO/omxyDm6t5rEw0aVhj9SqTwTr3i0Qrim7ydK0pCiXAqcU8cgflcVAO1qpAFu0blGY8VUzCcp+Sh0hoxB2GWGKvZyKII5C1Fah4b6Jx/3b03S7ldbpeDuhQhLvwrGhRzQv7LbkRUQvRYtOiXlXkXI/HBZ+uWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfxUVsWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfxUVsWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB04C4AF09;
	Tue, 16 Jul 2024 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140246;
	bh=infPNRYxoLPc5eWpdtLidjjuX1l7hIz+KV93qOtV7KE=;
	h=From:To:Cc:Subject:Date:From;
	b=bfxUVsWKzf+zUEwe4hOYe2QsGni1al7htISLwPu4Wc9eFUGMw1Q4gT1182r0RbSVV
	 lSRXp6Ud7jpTO8h7E+YYCgJ9DLKJDShNDGMnmEHCYopqQLS4GoJPOxCFmmwZYjkV/D
	 BaQ54L6N/KMopHr6D3UR1K8EZnuani6Ipk2XU/eM0wl7IMC2rfhjL25bhVVYG7g9YC
	 aKPk/bAKkBDrE1wY56vvrlZhMGNfsPJfDh1WeWhRJYwi0/F82Jsh+h4nUP3mbl1qWD
	 wY6q3+lwK/OiX0HnWfRpAiu9ft+z4mqg1XNOSEpa/Vn87uz3ZojpOVS2vIfzL0sR4H
	 I/JKG1BYJI5Fw==
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
Subject: [PATCH AUTOSEL 4.19 1/3] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:30:40 -0400
Message-ID: <20240716143043.2714553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.317
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
index 2f873a0dc5836..0f192174a5693 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -42,8 +42,8 @@ void ieee802154_xmit_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 
 	ieee802154_xmit_complete(&local->hw, skb, false);
 
@@ -94,8 +94,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 			goto err_tx;
 		}
 
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes += len;
+		DEV_STATS_INC(dev, tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
 	} else {
 		local->tx_skb = skb;
 		queue_work(local->workqueue, &local->tx_work);
-- 
2.43.0

