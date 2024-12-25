Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB0182;
	Wed, 25 Dec 2024 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735089885; cv=none; b=UPeLAhBX6vScYijX8gmOf3SG5buWfO5KxD+QAP3JR2qB1oX74qaEpPZ3rf+qeAMMTvFcTAeazEAUXTncj/zw7/x/xHvQLUKFSGPGFsP74c+EE1ixshTwc+7uj1KMBKX5+Vc4E8UU/TcAELoz08QqWXKsn/07wQ11KlyLvzyVl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735089885; c=relaxed/simple;
	bh=hKaf7lIuqNPc3ZB9WeQq9vNqcHXHsrVNlgn6L7OdGdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXz+/gHYk01Q+hvm2SZyVN0DndOe77/An/bLbM0uNYBs/zVAPknyANYuLF8Gg/L+o+A1PltVmfGkuZohPbk1XpQ0HrRq/yMPtfLkpotHo75+gaHaBVb31Pf/7queb8l7bRKiizFac/OyLFnkeh+n7VEhmEn4tPWalwWyyQDjurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bPCfM0oa; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bPCfM0oa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=MTGyQnrnGUuBrgjv5kbsHz5k8pWZRa+UBdMpaL41sqw=; b=bPCfM0oadqAG3mne
	kmXngdlKed61OG7qP9UWCRTebyYLZauJgqsFZ/IG432UuSfC2G3E3lZ3j3YJi9vfubNj9I19vGDwt
	+fGnYBgDAeHW9bWTF7rqSdKuPJ72TZJaW4Xlc7aNUlQS3dcajGBFnsH7CHF2x4aAgd5UkBlIYUzx9
	i2fDjlKHyWaLhrMwJ8Bl83QhaGe/GqHlh2M+H0/SIuBOIXHDXlym355seh+xmLc9T2Xh2bTxXhDa1
	17L/eLKwVabOOhaNzn240kWU1q0Kwrn83+hg3Trr3MgO5EmoL8KWErMilYlky0IGHl+buUYDwLZSQ
	Z8FRFPTZejw1lq4dYA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQG8N-0073eA-2t;
	Wed, 25 Dec 2024 01:24:23 +0000
From: linux@treblig.org
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next] net: mac802154: Remove unused ieee802154_mlme_tx_one
Date: Wed, 25 Dec 2024 01:24:23 +0000
Message-ID: <20241225012423.439229-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ieee802154_mlme_tx_one() was added in 2022 by
commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
commands") but has remained unused.

Remove it.

Note, there's still a ieee802154_mlme_tx_one_locked()
variant that is used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/mac802154/ieee802154_i.h |  3 ---
 net/mac802154/tx.c           | 13 -------------
 2 files changed, 16 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..8f2bff268392 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -194,9 +194,6 @@ int ieee802154_mlme_tx_locked(struct ieee802154_local *local,
 			      struct ieee802154_sub_if_data *sdata,
 			      struct sk_buff *skb);
 void ieee802154_mlme_op_post(struct ieee802154_local *local);
-int ieee802154_mlme_tx_one(struct ieee802154_local *local,
-			   struct ieee802154_sub_if_data *sdata,
-			   struct sk_buff *skb);
 int ieee802154_mlme_tx_one_locked(struct ieee802154_local *local,
 				  struct ieee802154_sub_if_data *sdata,
 				  struct sk_buff *skb);
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 337d6faf0d2a..4d13f18f6f2c 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -178,19 +178,6 @@ void ieee802154_mlme_op_post(struct ieee802154_local *local)
 	ieee802154_release_queue(local);
 }
 
-int ieee802154_mlme_tx_one(struct ieee802154_local *local,
-			   struct ieee802154_sub_if_data *sdata,
-			   struct sk_buff *skb)
-{
-	int ret;
-
-	ieee802154_mlme_op_pre(local);
-	ret = ieee802154_mlme_tx(local, sdata, skb);
-	ieee802154_mlme_op_post(local);
-
-	return ret;
-}
-
 int ieee802154_mlme_tx_one_locked(struct ieee802154_local *local,
 				  struct ieee802154_sub_if_data *sdata,
 				  struct sk_buff *skb)
-- 
2.47.1

