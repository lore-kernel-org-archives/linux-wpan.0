Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A619F469;
	Tue, 16 Jul 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140227; cv=none; b=aY6ZgKWe0z3h0awQRoFplAfM30GFR75NR3BD9SEL40JOmqEnbZS+53wiafN3pSeAOZk2B+Lkl4ubMUQSoszm24R0A2q9aCixUfNIlP7t9HYsOb9hrocsLYUgZJ50h0yz2ENkM1EpxfJqMIavkWNuAxfpce559M7JhuDzu8r/45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140227; c=relaxed/simple;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsdWTkXwIOd4hEBcLXhkaROZv8DdcP+zxTnKQ0kJprzamOagBsXayk9uLyRApxjHgdh2CllII2rlGMXuXO5VJF/s2X2HzWdRZzzM7iQEs9WOSJ/hkWl8F3J49UWWSmSTWEDgfmrjgdJbvpLg/3RDE3Mj5T5bwnppBONwx7nmmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR9YO/bT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR9YO/bT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134C7C4AF0E;
	Tue, 16 Jul 2024 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140224;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:From;
	b=CR9YO/bTdVrhB6dRmW2zE/NlnerYb/D7dOgI8x5le58g7Ja1W1LJtyH/cpXShOpds
	 o+AH0sNk+3cEMYC6/pQ6ysdOM69/MP9xUequKRpDdTBSlIx353d6Ii3j2KSIMsTD+n
	 SVTegg6/rGfYEq3ECW+LUs4VwKUqm6xwklbFLdsp4ftG8TyLbrTOfBmMY6YF3pfrva
	 +sNlLu9czSn1Dn7KEPYi4bKNBbcHcLNn2hbZpF0X+5hxunH7t36PLvxZGL5HclF6ox
	 J1R1hBsCv4ZYjOVZnd0QhA2gJVwJwePl2asRVUv05sIgoHkWe8qeB9udlLE9JOT5BX
	 +DrCQPbunFbLg==
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
Subject: [PATCH AUTOSEL 5.4 1/7] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:30:09 -0400
Message-ID: <20240716143021.2714348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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
index c829e4a753256..7cea95d0b78f9 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,8 @@ void ieee802154_xmit_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 
 	ieee802154_xmit_complete(&local->hw, skb, false);
 
@@ -86,8 +86,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
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

