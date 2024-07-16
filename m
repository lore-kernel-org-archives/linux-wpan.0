Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAC19EEAB;
	Tue, 16 Jul 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140197; cv=none; b=knJmRW1Bsp/DTMd5/NcUgYastiuKZw/fyDLfYL4Nzw8hjDYr0jjuYYfSj+8J/WiNF10jbR2/cPbNlfrHSGOsLjEx1DXlMTU+XjtKNJCGga2rav2nHZPiW0Ab7J3mgj+Sxc86cp8E8DS51Du2WB+k6PB4RvWv285GqJ10HYp4Myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140197; c=relaxed/simple;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3J1MJY1En+HYBwa6L2VO84rwucdOu69ZPDfuZRfQFbFmLlQ9iFx4FU4Aq4rsOmD8EpI8ugRyKFbGOmLtcIsR1zyP1IYKPIBkZdUjh7sJawCQxL/pyBPs+zDf14PDdc/xH+gh4ltfzpz4hzlQnJUkCXNgRYe24bRdi9x7ceGHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSw7GI+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSw7GI+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166AEC116B1;
	Tue, 16 Jul 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140196;
	bh=u3eDL3m89BqR3aZoF5Fzrc9E8G8z3esOlf2CP5TfC2s=;
	h=From:To:Cc:Subject:Date:From;
	b=kSw7GI+tuZyYQvCUDOlaOBg/5/U+HgAZnJY1ACxxbHnt9POsdXAAG7lz1Wfb407kb
	 Lmz0wzhXc77Ds721viODCX/rK26NX/2otCJ4DhcWc8QhJlMIsE/obP5yhH6fMjPk67
	 pAaTEh/F9/Vetfu3hceQ3J0ROLOf7q4n4kLOikxyMKBUAsDvTSTOGyH3lrm72UkwQU
	 Pz/KuOYkRfP6+cjU4Xroj0V6EBEHaHnZolElE5TIELHGyXMuwb9Ix+JCmVV+OkGtpO
	 I1zFmYw5xz/PFG11DL9ivG0GVwabmrkl0Es/NMh/BuyurMPwo+Ezd/l7EZSYN5CrgE
	 6PAqH0kH6V2BA==
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
Subject: [PATCH AUTOSEL 5.10 1/7] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Tue, 16 Jul 2024 10:29:41 -0400
Message-ID: <20240716142953.2714154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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

