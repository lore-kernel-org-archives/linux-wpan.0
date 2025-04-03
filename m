Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDD1EF092;
	Thu,  3 Apr 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668455; cv=none; b=XOFVyaohMQW+0o3XrBMgzPq096KSGI0G7sy74BanoGNMFcbWnwh9JFx7cyZjn1QJO7S9dIRkhUxx1S1uuxPOw3e6rlLysIUbVrHJfrNk/GUXXe2e0BQr6XNVPRaCzv4Pvsvfpef0eGRQZCoLpixWSRSoYV1MKsRB3tSfkycSSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668455; c=relaxed/simple;
	bh=hYguFZf3M2XdqtUWTyrLfBqwL6zkdSKwtDJgLxELEms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niJt4g4n5iPBFcNTUBs75WyKRE8fSOqkFo3s3DtzeZpUYnkEW+OzlPhrSwxjJApTPhqvBWdf9zH0Q8NbUqTkF/1ypy5zfxc4gZFf3vm//K/RTiER7UPimSV8MN2l8wFeXzix9AkAOeVXHYpBhkIjeAK0KoYOWRNAqS38V2eogiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=SE7G4reX; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="SE7G4reX"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id B1AACC0004;
	Thu,  3 Apr 2025 11:20:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru B1AACC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743668451; bh=0eT+To4WS8QTolUNabbkxlBAmdHPmc3Q+qNiBLxRA/g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SE7G4reX6EOLjSR20sYKhGdMnDrN3rSskQgAnzvbTu8/dr8RtGFvgV5vmj/1VOfm3
	 WNMHFwSY1HoxfkQATdTfOmAppZ4WHAZNm5MRvqUDCw+R3qLoUTkLJQrValQLzSE4NX
	 gnLSoobElCpoU4rNEDu1Q4rE8aa7U3TT1Ot677z8Uy73BYJg7giLzZwWopbUwGK7Lh
	 KZ9raGobo+bYRyp0ZbDtYXcIzeqPc1v99yLUNFwhi2Hv8BVqu/QQ/63TkU9VkqYuum
	 Abevqk69zjNjS7SQbn2948uKgPU2H/kKT2QJzdxHHonXyHH4b0zD4aL/wHlR3xV6pH
	 wtPpHVFNvt6IQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 11:20:51 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 11:20:50 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2 3/3] ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()
Date: Thu, 3 Apr 2025 11:20:21 +0300
Message-ID: <20250403082021.990667-4-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403082021.990667-1-i.abramov@mt-integration.ru>
References: <20250403082021.990667-1-i.abramov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192326 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 03:59:00 #27851158
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

There's no need to call WARN_ON() in cfg802154_pernet_exit(), since
every point of failure in cfg802154_switch_netns() is covered with
WARN_ON(), so remove it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v2: Make sure to commit against latest netdev/net.

 net/ieee802154/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 987c633e2c54..c0b8712018a1 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -358,7 +358,7 @@ static void __net_exit cfg802154_pernet_exit(struct net *net)
 	rtnl_lock();
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
 		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net))
-			WARN_ON(cfg802154_switch_netns(rdev, &init_net));
+			cfg802154_switch_netns(rdev, &init_net);
 	}
 	rtnl_unlock();
 }
-- 
2.39.5

