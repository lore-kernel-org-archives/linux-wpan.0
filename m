Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355077F10;
	Fri, 31 May 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142874; cv=none; b=UW4EXn/RzCYNhlP2Ne5qTFg7GNmKVatzCsc7BtMm1qE3vUbg9NN78MNXdyE+3n3ryH//tK5/1ctPLlYRHxCmswfrLClLmcsgDiylhDs1DRlqaziWzvboeKC7vyz0mjTL/pjG6nzeu0CLculI9FjHw06LRBxv8ebq8ti0EMEp5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142874; c=relaxed/simple;
	bh=vsNgwHvZRQwmQctv8l3O/7QfMvyCgHzZeFs9HeynMFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jt3oAybZAH5k0j6a8phv5qjQlF6bFAFR8m8TV+WVovneb1iQnuSt5sYAe+YSuLkSw3Qc8sNTBHgCnMTHMomTkdMxPa0K5zUYlZPtaIHOT3u5OJ8i7YDqhmDlZsprdRFn8Ukh9A6q7fyqRd5wM+JH4Q9eQNzuuw6EDt3py9fFTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc4ececc1f2411ef9305a59a3cc225df-20240531
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:71caded7-58ec-4b1f-8584-4f013905d8e5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:71caded7-58ec-4b1f-8584-4f013905d8e5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:d5a16ab178cbfb61a30cf038e50e53f0,BulkI
	D:2405311607473M99V4K1,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dc4ececc1f2411ef9305a59a3cc225df-20240531
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 558551494; Fri, 31 May 2024 16:07:44 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 78DF3E000EB9;
	Fri, 31 May 2024 16:07:44 +0800 (CST)
X-ns-mid: postfix-66598550-342445703
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4CDE2E000EB9;
	Fri, 31 May 2024 16:07:42 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	Yunshui Jiang <jiangyunshui@kylinos.cn>
Subject: [PATCH] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Fri, 31 May 2024 16:07:39 +0800
Message-Id: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mac802154 devices update their dev->stats fields locklessly. Therefore
these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC=
()
and DEV_STATS_ADD() to achieve this.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 net/mac802154/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 2a6f1ed763c9..6fbed5bb5c3e 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *wo=
rk)
 	if (res)
 		goto err_tx;
=20
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes +=3D skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
=20
 	ieee802154_xmit_complete(&local->hw, skb, false);
=20
@@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk=
_buff *skb)
 		if (ret)
 			goto err_wake_netif_queue;
=20
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes +=3D len;
+		DEV_STATS_INC(dev, tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
 	} else {
 		local->tx_skb =3D skb;
 		queue_work(local->workqueue, &local->sync_tx_work);
--=20
2.34.1

