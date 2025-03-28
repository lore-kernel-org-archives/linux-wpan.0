Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E2188734;
	Fri, 28 Mar 2025 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124193; cv=none; b=TakVobt1aJHP1zMP2q+OrrdUp0IKVSEbkazdiLfUvD0VH3pNCPoQr6WPNL7fBXJCzMiCVG58ZKWQAn//7+M5eSwjy6vmkWzZFrf2ZjUeX2cD+3Cpd0P7wVuovS3PK7tncPOFWkXXG16l/4PI9p5B254hpDU/Jkac57cEkRyzR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124193; c=relaxed/simple;
	bh=N3LsiZ6rZMjYDKL9cd58l4dwq+zYHI2jldOnnnoM3f8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyCH2fEglOXTQDCtax4zd7WNQEpKtEYDO+iQQlW9gNGxB9usC2poHohdr6x8DdzC7s6VKrR2P7zo4exbg5VhRd1JZ1L0GwGGqGxEIlQtJ9FkxRHwqi08ej6IMfrl0/DVoEEKPHv6GXDBNGQSacxuiUt/ABZr+3b2Gf0uUB3JTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=hvQ6qYRA; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="hvQ6qYRA"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id CB63DC0005;
	Fri, 28 Mar 2025 04:09:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru CB63DC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743124188; bh=yUwjDCkhQS0wr0Yeh0yG3iKfjMR+WuyzqozWpdMEFBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hvQ6qYRAovGKAklW2gKkmrhR5lfGkTnmkNLrCd7an4nUvzKCcBRxcniCZiSxxZwAl
	 LQ4M6P95vHwAMt5h2ROXRxOra2NxvsFfuaovsH+g/o7UJOShx1HmMQTdS86bhY7CoC
	 0A0APsPXzpmJiBzhX6J5D5NRHRQifCsi13BafIK+jnXussgCj3TFbkC9ECKbHoxFBz
	 LBONOrt0oLYEGdhuM9uGTHcXYAbMiLXrIGxF0jq56ubE3/phwTI3BK+J67eMXY6zv5
	 4zUIsq6P2emHPavrO6E6WWPL9AU8Dgjys+JZDZEyRZxEB24Ua7R+zrI+MUtf+9KwIH
	 etJMlB2GiXT6g==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 04:09:48 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Mar 2025 04:09:48 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
Date: Fri, 28 Mar 2025 04:04:26 +0300
Message-ID: <20250328010427.735657-3-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250328010427.735657-1-i.abramov@mt-integration.ru>
References: <20250328010427.735657-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192175 [Mar 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/27 22:37:00 #27871126
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
dev_change_net_namespace() and device_rename(), since it only leads to
useless splats caused by deliberate fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/ieee802154/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index ddde594513a0..8c47957f5df7 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -228,8 +228,10 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 			continue;
 		wpan_dev->netdev->netns_local = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
-		if (err)
+		if (err) {
+			WARN_ON(err && err != -ENOMEM);
 			break;
+		}
 		wpan_dev->netdev->netns_local = true;
 	}
 
@@ -237,7 +239,7 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		goto errout;
 
 	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	if (err)
 		goto errout;
@@ -258,7 +260,7 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		wpan_dev->netdev->netns_local = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net,
 					       "wpan%d");
-		WARN_ON(err);
+		WARN_ON(err && err != -ENOMEM);
 		wpan_dev->netdev->netns_local = true;
 	}
 
-- 
2.39.5

