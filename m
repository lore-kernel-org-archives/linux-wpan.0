Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA054758;
	Fri, 28 Mar 2025 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124166; cv=none; b=LhXZLEbyfZDtWISMozcwn6ffaw2kAuAW+/Tdhjsqj7WEllTa2ncpLAhzgWGsY6jjK+COIUDjelwiOwUgucg9edjj0rlHlAQ626i7NOxXKCT7BUuV90BrHIvluWWJxI912P9CpEJZ0gAMRYkl/dfs7OOkA1N2SI3p1XPHxR0yoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124166; c=relaxed/simple;
	bh=lUmtNN4Xbc9FXQ8lB7kqKNvdaxWn0Ab8lVVB2gtxW3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPYU4RZP0rEKV5evJhK2VRThaWGX7PrAC3XV/JjWTRcRe5GmOEJDUEi8hFlRMTd4pnzQKQSxFBOisKmSpYnjTiUfJYRImCKeO7/ygE5bTugakXZXxRMcMXLWoh14eKizcWNYhOyQMPWK/e23dtUDi60hpb1nXHKqHkesCf4RxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=ntHoxMXX; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="ntHoxMXX"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 9F8B5C0005;
	Fri, 28 Mar 2025 04:09:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 9F8B5C0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743124160; bh=9VtDpmZq4850n5tz/kyiK6Ik4S1tbrtyNLdWaX+KVIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ntHoxMXXX+a3PTlueIsAAa7JLwmuthnUAqnG92Jfy9CPN/Cygv/7KFuvxROf/06BZ
	 HjRNri7A7DudRCX6jiYKNrV6cnl9lDLZfnyyB/A+rvEgRrG7UUqG8Ot9qAo2xnrhq0
	 OEYFbm+jJoKFAFV9/CKRi5iJ5cbDl9MF2XPA1ru10Gkfh9V3DOgyO3J93N7S9cYklg
	 RJCLya7bx34UxCmHQyttyNvnbiGDzZllocmMu2/a3exC7LneAxVZrMCBuYmSQx6H02
	 EjmNXb2xO2kpY4DnFFeJmVi54KlSPaE91hwQb9jodY3NdJUSFJ7tjAOP9UpumPfjvn
	 hl1euQxyI5Fxw==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 04:09:20 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Mar 2025 04:09:19 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 1/3] ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
Date: Fri, 28 Mar 2025 04:04:25 +0300
Message-ID: <20250328010427.735657-2-i.abramov@mt-integration.ru>
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

Currently, the return value of device_rename() is not acted upon.

To avoid an inconsistent state in case of failure, roll back the changes
made before the device_rename() call.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 net/ieee802154/core.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 88adb04e4072..ddde594513a0 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -233,31 +233,36 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		wpan_dev->netdev->netns_local = true;
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
-			wpan_dev->netdev->netns_local = false;
-			err = dev_change_net_namespace(wpan_dev->netdev, net,
-						       "wpan%d");
-			WARN_ON(err);
-			wpan_dev->netdev->netns_local = true;
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
+		wpan_dev->netdev->netns_local = false;
+		err = dev_change_net_namespace(wpan_dev->netdev, net,
+					       "wpan%d");
+		WARN_ON(err);
+		wpan_dev->netdev->netns_local = true;
+	}
+
+	return err;
 }
 
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
-- 
2.39.5

