Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDA19CD1B;
	Tue, 16 Jul 2024 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140163; cv=none; b=f1513P+oHpr+PX/jW3pqcrlLvkfmGAC0rIblDlEAyjpI8viDw6BGMHn/qMr+GxdEnqCOyV4O+LdfcOaP+8IV5r/A50zDv56cL339x52GUz5aVCuBb4Z814I6wdysq3S4NZcs1riY0NElZDGAN4AZQ4jELUuZhvdLhIh61a2c72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140163; c=relaxed/simple;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5DVag0rwfIKlMp/qKnlEfydgjpWxNLPUvt1wnYkA6xGE9uSUYGnbHiZeBswInzZfSAc1fgrp1+67sDgOG0TqnLkC2v/4yAA3reXgZxoUsasMYmxfBbflUldB5tYt6A6e0bpBG/RJvsqocheM1V8kDcmc83ii9ms1sc4/U140yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtgGMztU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtgGMztU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09283C116B1;
	Tue, 16 Jul 2024 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140163;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:From;
	b=LtgGMztUGH0DroyiKWOQgekz71X/o/QfysT9NM23x9PviP/TV6iCph2n+/EdMBLog
	 2TbwOZ2PHR/0KpNlyQR+Cw7ULfcLAITmZkHzhNU2lBuSFdd16BkB5lXr1pyXrjV6Gu
	 Au3S4Tsi04cvXL97UNpIbAFM0iZQ06ug4k4DJirf5heWZ8yPLrU92wgOxglP7rTsh1
	 NsyKziaIyLXXV3+8VUVPKO5kX+p44TO0bfx0vuNYAPeNyE/ZVeE6fR7zoLKwBlGQmC
	 K58ufqd8/ByiY20ngQ2A81aTMRriv1D4OxZ9GKlK/wJwu8ANQj+dAN78nt4F7JiZKh
	 ZQjS0oHZGZHhg==
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
Subject: [PATCH AUTOSEL 5.15 1/9] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:29:03 -0400
Message-ID: <20240716142920.2713829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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

