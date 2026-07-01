Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CB2DB7BE
	for <linux-wpan@vger.kernel.org>; Wed,  1 Jul 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924152; cv=none; b=X8psNZQUOqUC13mevBz1eDxw/+IASzXvjbEvkQYHjmL4HiSkVcFv1z6oGI5IX94imsqQi8hw8F38wjvbl08n4IoHbJZ5qjC8pf1yMitwCijqZZQ+7bvccnoCJwEfozWS0H+byhtWBLoBaZH+8t1XXA+du8ynqnGN1png1myzLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924152; c=relaxed/simple;
	bh=d9ZiF7LjaiiY1OZofmWsgVZV2t94SKMbzoBzxGqUi88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBfrAaemc8p9ioTs95z99TgTRRMsSOJIIWPz75gtyuoBklCi7UJGBVLGqIYIK+/sPjwH0aCTdUlWmmtwQ12XmjOeRhHQzknlZBZX+CFXOrDjNe0IkNfqhvgVhd/24wzNj94K4wjqmfIQOEDjLY4lu1oE/9zpIKQBhYD/AJvDv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSTGIew2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSTGIew2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8051ad12d23so10075927b3.3
        for <linux-wpan@vger.kernel.org>; Wed, 01 Jul 2026 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924150; x=1783528950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUTIvVd7hXVFaVubObi/HnQ0CBjtLgoeqk9bLxy6OA4=;
        b=ZSTGIew275uqpmk0BEhIxaJsx7WtTwHZ7Ty+OwzZBbP0Bm6R4kc9d3qmUMdEDjP8s8
         5BuliDbXsffYVavapIaqoFTq72zweZw9RDwzH+ijFoU9ndBjQIxdNBemMlxCQwkfKrdn
         f3AxrXsqMm9Di0mT56nKEv/zm/yTy1e8tYeTxVx2T9xwRwvPtjehnJL4g0FiRVpC2Siq
         hlbGhxm39ETzbZxQIOIRYBXHXVGsGaMlOiUI+0x5094PQGAUReqqe0vnkgUyHZWKI1jx
         ApLlTLguAApRmNvyVz48bEpY3oBWQH6Lr9RAxGqPwmbyf48f3xVOn8bQERxcWFF3+yCm
         aS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924150; x=1783528950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUTIvVd7hXVFaVubObi/HnQ0CBjtLgoeqk9bLxy6OA4=;
        b=VfxLQXQ5xCwN7FsUbb+AwUsjjT+raIRcrBnSY3IsrM3LfvqzRrwyUFrxNSnu2yGx01
         vHPHYsNJKgkZAE7AIyv2Cannd4TWy/hpSM8iNl9tMvXgqWkEOugBMlOMdmc8byBXqYvA
         qHVFaaHIJ7spFzQZwohpdCmxEV8MLV+LGyx6qIUyEpMCu2fp/qYbahdgcNIJdSKAfs5S
         0f5jeA1OXchTLNoI4MXoXdUlgqI0SRQ55qx8tsoxNgGroCtJSn7AyhJhcp6igKVw3zhG
         b7QwVl9WWd8jUi/F98lBBWQgLi6JRg2ogKBTV8dDZ+8xURjmugKHGBXIW58BVfEw61KI
         PvLQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3/UNOr4bclW3qMJo0IbpNa8qBH2Fm2VFNePAvjqX60MaPL9mOq46YGLrAdsPMAAp54r2cnHO35Rsv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V7i5CeeaBKxm7/tDlY1a+o438FS3MDq/ehCGSx5JDdMnwctX
	1/R1EtW8WAuoP+fpd85hYYM1iw9oTXBZHtqsELm4fGvfbpTQ7CAltnNi
X-Gm-Gg: AfdE7cmDvVSrT9MSKXDCix1quMtezzBE61twy3taIBm1MJ7dAcwgDJbvWFHwkqMiZFq
	7XbMemr7uXrr5XJqcxXavqQSNX3FHD9bEXPlvwAhdOy2z7m4ypgQzrLqlGkxl5TJq7UWgXPRhaf
	UFerGk9Juoqhm1v5V0gmZkTBDHob5rUd/z7ya2RuAps9tCxQ/+X4cnbcRrU9/j+uoxvOvpwS2Hv
	YCrw2u5yvPRh3Lt14/Y8UKcOItXz4QB6P/XlrWJ8Nx5reZq2/8wVISQw5a6dhXsg5RdZv/3ZDNZ
	9zGeEtEwI6CI1apygzRrPKE7nbpIgsMUKV6d4FSQDMljd/0ncSukiKNCqVKnl8iSVr6JV7aKHZC
	z3x8qOfSUDK+jutXsrSdhB2SEmlpEyZizOwceAZPpfwzmrdab+UZHxK5gSBhkGsu3LjSYA/wprt
	sb137UO73VOTC25xdBv80JTBRAOA==
X-Received: by 2002:a05:690c:734a:b0:80c:85c6:8987 with SMTP id 00721157ae682-8138b95e350mr17913177b3.70.1782924149728;
        Wed, 01 Jul 2026 09:42:29 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448cd06a1sm2213857b3.21.2026.07.01.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:42:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	marcel@holtmann.org,
	kuniyu@google.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
Date: Wed,  1 Jul 2026 18:42:22 +0200
Message-ID: <20260701164222.9094-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630211808.50440-1-alhouseenyousef@gmail.com>
References: <20260630211808.50440-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue wake, stop, and disable paths walk local->interfaces under RCU.
The bulk hardware teardown path removes entries with list_del(), so an
asynchronous transmit completion can follow a poisoned list node in
ieee802154_wake_queue().

Use list_del_rcu() as in the single-interface removal path. The following
unregister_netdevice() waits for in-flight RCU readers before freeing the
netdevice, so no separate grace-period wait is needed.

Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Drop the redundant synchronize_rcu() noted by Kuniyuki Iwashima.
- Clarify that unregister_netdevice() supplies the required RCU wait.
- Narrow the subject and commit message to the list deletion bug.

 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..b823720630e7 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -703,7 +703,7 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+		list_del_rcu(&sdata->list);
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.55.0
