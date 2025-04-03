Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FA24A062;
	Thu,  3 Apr 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675603; cv=none; b=UP7yuZbvsjlhj6ATq6yLxodQ/F5xvKDKcxmJJsOZhClmmTeWD/f+LrxIIXLPFPYc+NceqVr+2jQqSKtEnt9J9dUJDFXMmmHtGR6Q3ukwTjDNKaBepXgSYU9W5eZLnqxe9dZG9H1rczQbkMP5+XGQ/MRm/5bAuc8QBujnEoF3f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675603; c=relaxed/simple;
	bh=CN+4u5oaSieWiujChEGNUUr3/wFpxNLN6MOHqNup4hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0ZvDxWlBrOjrcqM+prpdy7BO8LzXltiDHXpoWEjEZ5Os/2xOWO6J6b8felrfKCZuWNHYZJ4OHbJ/Hus/NVHSx9qBEJM345QaaMRahq0SauJtiBNh0k9Cb6revSaaUxgwZqIjiw9ZOhtry+GjjqksfhNIqtFSa9A9NS2u86I9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=X+f0gCjT; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="X+f0gCjT"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 4F3C5C0019;
	Thu,  3 Apr 2025 13:19:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 4F3C5C0019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743675597; bh=J+0Urg1F3a3sSGeN7fIcxtanqSTTESu1GrZeOZUoO5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=X+f0gCjTnRxm/sAmglRytxLPKktbaPgXAhWdRQm7CCREtjIAQtVGF3Og18Mcv+QO8
	 paPBcsbnQHsMZ84aoHKOuS9mozjmle0ep84IEiinRucwIKdJkH06vtDWxm39mMJkz2
	 nzscN+oW0aNP9byx6XsPqOx2DyULy0ZeB1QmROsEUiidFREjyiVIBShhznQ3ww7zCB
	 o/ofyPEtxHlXv90/DdDYq/3am4siEp9lZbo7O2BcEUzZ+h2TpIhQlYaVDJQxPY0S2+
	 i/83g0IOV4OnWSyGAl5OaMPIsuBcmPRAiqYOswnwJ4/Yd6eMySZOb1jSoI4eHrrj74
	 yzrgl/88neDYg==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 13:19:57 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 13:19:56 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>,
	<syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v3 2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
Date: Thu, 3 Apr 2025 13:19:33 +0300
Message-ID: <20250403101935.991385-3-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403101935.991385-1-i.abramov@mt-integration.ru>
References: <20250403101935.991385-1-i.abramov@mt-integration.ru>
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
X-KSMG-AntiPhishing: NotDetected, bases: 2025/04/03 09:28:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;lore.kernel.org:7.1.1;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192331 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 07:23:00 #27851719
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/04/03 09:28:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

It's pointless to call WARN_ON() in case of an allocation failure in
dev_change_net_namespace() and device_rename(), since it only leads to
useless splats caused by deliberate fault injections, so avoid it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Reported-by: syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000f4a1b7061f9421de@google.com/#t
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v3: Add Reviewed-by tags.
v2: Add Reported-by and Closes tags as per Kuniyuki Iwashima's observation.
Make sure to commit against latest netdev/net.

 net/ieee802154/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 84d514430e45..987c633e2c54 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -228,8 +228,10 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 			continue;
 		wpan_dev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
-		if (err)
+		if (err) {
+			WARN_ON(err && err != -ENOMEM);
 			break;
+		}
 		wpan_dev->netdev->netns_immutable = true;
 	}
 
@@ -237,7 +239,7 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		goto errout;
 
 	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
-	WARN_ON(err);
+	WARN_ON(err && err != -ENOMEM);
 
 	if (err)
 		goto errout;
@@ -258,7 +260,7 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		wpan_dev->netdev->netns_immutable = false;
 		err = dev_change_net_namespace(wpan_dev->netdev, net,
 					       "wpan%d");
-		WARN_ON(err);
+		WARN_ON(err && err != -ENOMEM);
 		wpan_dev->netdev->netns_immutable = true;
 	}
 
-- 
2.39.5

