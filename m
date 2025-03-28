Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCC21364;
	Fri, 28 Mar 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124224; cv=none; b=okmpNcf2JrS/azeb8ZuasLiOxLVz0j4UK2a/oSV3fI+prJgAHEFLHChanCIqaPIfQuldbG7lDV7no9Vug3mdBjKKbDWNdfMEBkZKTP/gXtXK1pErCZmi9DGS8QKACzMkKYI+410PxiNaSaY6+olPbbOy8XEJbkygsJ4So1rkWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124224; c=relaxed/simple;
	bh=ZYDK33aHWQ+PXsPtPZFe7TwUWap15rqWdv95RjLqwdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeBHOsubqCF8FRO4ofwrxk2m8ZrOi5xrsYGJeRLRDeB3C6ac7AuAx+fnJ2W0p9Bs+YLeUjghKHOtzz30XEX6cgUIjJhUZmrpR5w3+k+H7PvKHDzPyPVdIUVy/aN1DGdnCZbmurDlCScq3l44byWtlNEzzqHF++ak0aSOi9TiOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=BP0t4sgK; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="BP0t4sgK"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 08EEBC0005;
	Fri, 28 Mar 2025 04:10:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 08EEBC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743124221; bh=vqFZhAA/2R7AhQtjel9kkyQ8fbZQ3Dq3TC6zai8BcTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BP0t4sgK7yHyBgIw9pI1eOuONE1Z/piFt6Ud9JEPvcC1px1iztb2mI8N9j7FkkB5t
	 VU/hygvPAMSwIx50q7iNqHMPqIXrzVVynC0gNux/HNf1OK6xnuXKgRMhoT6YI7KMnL
	 lL2gwlwRbEdAKVMcmpw9Xb79nUdgQ5Stv3P081mxyMQR966HSnfi3A6tWBC16vtd0w
	 WAcxh2yHCuRCJ+wqXuNxdtDLWbNT4DtUH5xJ9O3TmskYceaw+BwLy6a7P+qRAgBY0x
	 KWACyom2CzXpm7a62ICyHZkdrIY4CYL7eDsUNOGzTR+hA//kAoEey3QgZ0hqj9KsMx
	 2Y9EoTLUvcskQ==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 04:10:20 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Mar 2025 04:10:20 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 3/3] ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()
Date: Fri, 28 Mar 2025 04:04:27 +0300
Message-ID: <20250328010427.735657-4-i.abramov@mt-integration.ru>
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

There's no need to call WARN_ON() in cfg802154_pernet_exit(), since
every point of failure in cfg802154_switch_netns() is covered with
WARN_ON(), so remove it.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/ieee802154/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 8c47957f5df7..274112ff2955 100644
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

