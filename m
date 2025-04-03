Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7B24BC1A;
	Thu,  3 Apr 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675607; cv=none; b=DMuRj8ts327MvNeUurB42OEtBGIkE4L18f41E2zVJMGA3O89HAFMknh8tRhOTPPr5cd9fP8zRpXQ+NAUhj2cQQIbKFDRiN4NYU6Mt4SG2QYPbWYjIzEtz3f1W7dOm0sHUoAuWsh1x7wHtO0HiPMWVufmU/6l9qfPknxlPnZXZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675607; c=relaxed/simple;
	bh=ZH7Mtjj1ggJj5jnb35am/azc74GJhaWDqKuPUJKl0o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUMDFIFnKuBfAZPjaqyaxEa9WXjbSYcb3b3A8hoLjIMeY8pYZkCLkIBVqYJvCBF9fVms0Fp8/G58h1C/bSP2FwwHsxoH4hq3lzg7QeCy5zUPwDc/UBkQeRpnnrv+8jKzeZCSBSYc0G7DJpGKahft/fdC5sVmgzRqgnZm8EhYmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=O9AhvuB4; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="O9AhvuB4"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 2E233C0016;
	Thu,  3 Apr 2025 13:19:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 2E233C0016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743675595; bh=mc5hecyNwgfepkhkE786/9n2mN+1R1/mTWRWxmAD3/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=O9AhvuB4GNYnfx9i8i7mHeb+JZPe7G4o/xR3Q3HDyQVRRMnaMTtImm7BzxGJz9Bkz
	 BP/E+wVj3dDWilMKAMcjI4AXBJkNUDLvBiT67AcJ5xnaHAYO7LBsNn/K9bLbjGCH6+
	 jK/t8RZsyQ/a+A7+LR4nNy7Jmx8SBGgmFcY0JhCnOz51FJ785BpxcrRhpc+hUZnYrv
	 SLjIfx6a84QIFXzwrVt189tJhcDaQuWq+xJLz7wlLydKXnc2j4ZpRY9CPgPopJZgMG
	 Cs5dH/K93NvwbRjXC0jMCqWd00Os8lexgp56pFP/SBfytBVrb/wwFN8MprHT71xeWY
	 TBqJAMkg8uALQ==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 13:19:55 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 13:19:54 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v3 1/3] ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
Date: Thu, 3 Apr 2025 13:19:32 +0300
Message-ID: <20250403101935.991385-2-i.abramov@mt-integration.ru>
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192331 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 07:23:00 #27851719
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Currently, the return value of device_rename() is not acted upon.

To avoid an inconsistent state in case of failure, roll back the changes
made before the device_rename() call.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v3: Add Reviewed-by tag.
v2: Make sure to commit against latest netdev/net.

 net/ieee802154/core.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 89b671b12600..84d514430e45 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -233,31 +233,36 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		wpan_dev->netdev->netns_immutable = true;
 	}
 
-	if (err) {
-		/* failed -- clean up to old netns */
-		net = wpan_phy_net(&rdev->wpan_phy);
-
-		list_for_each_entry_continue_reverse(wpan_dev,
-						     &rdev->wpan_dev_list,
-						     list) {
-			if (!wpan_dev->netdev)
-				continue;
-			wpan_dev->netdev->netns_immutable = false;
-			err = dev_change_net_namespace(wpan_dev->netdev, net,
-						       "wpan%d");
-			WARN_ON(err);
-			wpan_dev->netdev->netns_immutable = true;
-		}
-
-		return err;
-	}
-
-	wpan_phy_net_set(&rdev->wpan_phy, net);
+	if (err)
+		goto errout;
 
 	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
 	WARN_ON(err);
 
+	if (err)
+		goto errout;
+
+	wpan_phy_net_set(&rdev->wpan_phy, net);
+
 	return 0;
+
+errout:
+	/* failed -- clean up to old netns */
+	net = wpan_phy_net(&rdev->wpan_phy);
+
+	list_for_each_entry_continue_reverse(wpan_dev,
+					     &rdev->wpan_dev_list,
+					     list) {
+		if (!wpan_dev->netdev)
+			continue;
+		wpan_dev->netdev->netns_immutable = false;
+		err = dev_change_net_namespace(wpan_dev->netdev, net,
+					       "wpan%d");
+		WARN_ON(err);
+		wpan_dev->netdev->netns_immutable = true;
+	}
+
+	return err;
 }
 
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
-- 
2.39.5

