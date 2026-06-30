Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0C2D3ECF
	for <linux-wpan@vger.kernel.org>; Tue, 30 Jun 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854302; cv=none; b=d179fSiy/a12ZkpccF9f2ka1RaA3k8elQ7nx5yGOC5VNe1cmJUTSWDgjLsFEc8awsvXZjS7EkMrc1Bsx/7FdsauTZDEF+fdubvUqE/uB2U6SDRUtOtgvLfdkwjaxOCj7kU6PA4GsqgZ/xwdzb4WffHbkZ0VyrekNy1V0ivSgiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854302; c=relaxed/simple;
	bh=blmSz0ucFYiG8IMVfZLdaXb020QBlMaQczvCK7E15mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uriLH0jw+bepYY2ukUN2a5/DUYcPbdngFUq6v6AO020gUE9RCYsIk/gXkPqPeOW7rXmUnqEf9LNgqLwLwJCOMwOFxd5qLLkixQiAQcPI0DDRUYObM5+7uWrr+KZDaWX9jbNAF1XJvZE+v5G7n++44Ky/dyg37zFy3cCdnxo/ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbxG12rr; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbxG12rr"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66493875766so5591476d50.0
        for <linux-wpan@vger.kernel.org>; Tue, 30 Jun 2026 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854300; x=1783459100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=LbxG12rr4PsUtTJ6Ojiajta+pwvBJYbTxn7OUS/ZnAF+3aw79w81fUp0c2Pmv6BofN
         vJrBYwYW393ImQXBwlfR42xMIi6RGxiwwJdR7ePdAtZrp+ewE7nFlSZ5T8LJpSpx3Z5f
         ZVuNS4IhUtS3bVUlENg+aw0AgSLfJgGxEwARhJBg8EX+JWG66/qxe2xZCdtkrw+Uh3ek
         pd1qbAWTaCOIQii9kPB/yHuVp2fxfrRw3jaoGPPBhB2Okn2zamhXL0cPlD583OGq3K4d
         CyFnSuK6BkA4kRJadHNKh2SZhwJytLcVwh8tRcJBCNMUlK3NCn/yU9kKWB1qvUWk0UyC
         kqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854300; x=1783459100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=VJH5BckM0W7mUcybudcd3T9rYZYfVQR7/PYHoohgiCTpNX4fK7mOxPH/1ZwuWBHp5U
         u4qlCz2XQa1SRlScZZmWSWsQu8pVsASy/IqDXqGpUxkfogt0P/ud4jEl61X5Syg7qGge
         cr17/4R4Pt1/aCW4PkmNi066Jmx/D5pVXYtrMk4WgXHGYF59GD9Eh2LB/4oWtssyvTeq
         +eUXLhJaOJ1uYsarHI/Xpm4pULJZS3Ls54t+I9mzb1iJEGowI8VWlKgZbW59fUuTs4vI
         JnMkX/Hqjdsq3HWUQP5/UdMJyrDu/52ttx97tQHA8hVEmbr8iNWdJ1OAR6SxQm2dXLYA
         6aig==
X-Forwarded-Encrypted: i=1; AHgh+Rp+82SuE9eWOv58hcqinDKsveprBU2xXzOoNiw3TMdgGlw3HO60ubmLhhWfFEiLEGbPz5+EkgMmA7xv@vger.kernel.org
X-Gm-Message-State: AOJu0YxtATIcW5s/XiC+bi7C/4LgrP25aF5U4ejTOpsty2H2oESQLnu+
	/SC7j33rMEEKGvz7SzFcdmyK7vHtUK6QpGzRJQ3mzv0WqX8eVnhhMmfz
X-Gm-Gg: AfdE7cmWpTzN4j0dk4DBc/TFWp6pjYH6frB9oxLzsK07Ol+yRhf2SZLuQK3iPTz4c4E
	nmjr3Nh0MUJCviJTbafsd5Oe0HjdT+M3vFgupNlzx6Vp8cDfnPF75Ebj51CuG9Q4M4SZjLceMXK
	lCuWg3MictRMy9D02U8w6iKMW8ALHuKlqYcZCgPndE004uQgMHkEBqB83Ng/6yYq3aBm+qw2JEl
	pAr3MunhXS4t16BWGa7rVVf7o3dU2v/b02LO8+6Zv1wwyASHjnAmxV3NmqOJSLGEEeh/PJUlQyE
	AquVi6wXiwxd0RdIAvCkQOIJTSgxhLInALMwUiQP2GBXRTtSEk42UKJOZ5GfrV4pJzM+169CeHn
	GarmXDmUiKbpj5bITYNc1bHxcaZsX6NMoWTsXydnbYU3IawCQshqeFCzYHKafZVHSEz5t4nkrSm
	WLxvUmmPqQtNhNKbdzPCA1vMprXg==
X-Received: by 2002:a05:690c:9c09:b0:80c:85c6:898f with SMTP id 00721157ae682-81204145786mr20454527b3.62.1782854300375;
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ce56f3fsm29517b3.27.2026.06.30.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] mac802154: wait for RCU readers when removing interfaces
Date: Tue, 30 Jun 2026 23:18:08 +0200
Message-ID: <20260630211808.50440-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue wake, stop, and disable paths walk local->interfaces under RCU.
The bulk hardware teardown path removes entries with list_del() and
immediately unregisters their netdevices, so an asynchronous transmit
completion can follow a poisoned list node in ieee802154_wake_queue().

Match ieee802154_if_remove(): use list_del_rcu() and wait for existing
readers before unregistering each interface.

Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/mac802154/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..73d82a015184 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -703,7 +703,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+		list_del_rcu(&sdata->list);
+		synchronize_rcu();
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.55.0

