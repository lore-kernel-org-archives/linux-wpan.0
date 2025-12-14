Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEF2940D
	for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765671423; cv=none; b=ft6ge3cnXEn7kO90u5zrmKsEgF8bU6VUVVEsso29RBni29SUG7a9ySaa6TvTZfW4nnNIeUGOPtqQ85ziAnCdi7o4Ay1NfxtibMH7MYOXZNPQMpZIpy6lf8FO+tnRwDaj6oD2dQBkYz6MQlW85SAODkh6k4mCTlyZybR9ZzM6UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765671423; c=relaxed/simple;
	bh=4YnEvx2T6wIO+k4WvLZdUk0ePYrHjCLTLqetUiCY3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA/D+cz4rgceVxDBUI6RwAUGmRMVDd33XH7vPhMmQzj/9dvHNKekP4Jft1Pl1ajlk2+GOeyKH8iSlse+7eJ+8qT012bCHg9MS2BOwPh9ZFk/97dhfnYddjCsZDZkHzGvmgU2vBQ1RYSItsGTjTf7dgCHUGydzAMEGm74eVSwAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdG15sA4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdG15sA4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso989945a91.1
        for <linux-wpan@vger.kernel.org>; Sat, 13 Dec 2025 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765671420; x=1766276220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXb+PpQxABhg5OSvFmLR0g0fj9WnLmBsWI+vQOQf3z8=;
        b=WdG15sA4A7A7aPrFFc3sLoB6Vmw+yYCy4U6Rv1dQvYwjYV54kKayP5jZfVnk7Xt6c7
         q01tcBcdUNnq4g616MTUFJL66uPDUYZhxzQyKb0z5D4n+NORMZGPCHmZVh+xmcKR6lhA
         vgbHJpf/QooXqSeXQl/GVPj4y4/MmxwoJe3vFoG48XswrpJjR7fNnnL+ty9v9iEmHeJ3
         Hku45/J7vU+bDZmKNxWWIjD4UCH1Akjg+42bUXRgmsMwT7wKUuHZLtOTdyZA6E16PLAg
         Ychf1QlT9c1fyp14Hnqjri7YeL/6YMSazJfP9vppf28W25NH3STFl6OHeHU2v6381B6H
         /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765671420; x=1766276220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXb+PpQxABhg5OSvFmLR0g0fj9WnLmBsWI+vQOQf3z8=;
        b=QBOlOPxaoqPz2gIknFkF5hBn2xSbt2Zb4nqYc1HIIWBpQzBksg/N2sRoMfLz1HkTeo
         VekXjSZq7SsOUk9Morwa3xCWCbnGPzlJ/hOZDjRFPZiwbgbUuNfaHEgJeeVkswwrsBxk
         exOj3vqFC40jtwEQul83D/8mYYIFDyZG89J41yzXDIryUsHcLAHZkyHELW/aF/kF5fwO
         zv0JXqG972WcAjpxQ9UndMxiJ7mb7uKvruE+S1X2vABvSZZSieujrHQLeq6AU9iIWrX0
         oQCRReRvKLnqogCxHAdTEia9ZwOSjdwvEmaVPlaAqUZ7GWLbtwxwRrsqEEa5VGDRrkEP
         l+oA==
X-Forwarded-Encrypted: i=1; AJvYcCVW1Wn/wgpTLjFpCKGemaXeeEEzYGt2adG5cF2jPpzU5CC+yc5s9n6TCehCIGIx+ZqLA6jnvQnSRQW1@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHlbWK/8p07DzjwCa3otqu8KtkBRAhddBUD4S75JyzBIuBZAd
	ZMixBvMsH3Mz/QDKisw+pOcSQrs8we4GVNR+rV/U4nlFfypqvaCgdFHS
X-Gm-Gg: AY/fxX592+uwHLJ5pdlnwmEKz5lzCRb2goAoE/eyjf/qtO5/xiQbZE5a9Gh4PzG/U41
	eBvawUh9NJCL+1AdMS5oTvIDRGNl4arDCEXKmQnSh4nh1++yjXaOX0a3Ex5FkMujgnEgwiYpbEw
	BDiyvdx23Z44MeqIrRjrkbDp+zR5ur+aDo4n7iylCtqAWKnv4jZCRE/1Ggr0ImIOo2Wsx7Ks8hF
	MWpr79CA24e+7XoLeediReaxoxid7B2yrHO3abJTrsQQ6ZboTPhl5q3/vzwoe/p06fgDBaVDX+3
	CzRXr/6ezhTs+rHN9DaxexiFZhExz8OrldkiFjDzMXFq5rbA3dsSeOInZlivJW/UssB1Azjh2be
	Vu94Q7m0lBuPe1mC55tn9JaQYKpxDWKFLBfw11Pt6LLzqu18Oig5ZzOQEniLuXUfbtucSHiL8Bz
	QOM03vqyKQp876AicyO6An7jgn4blcBI3ArO9WGNg=
X-Google-Smtp-Source: AGHT+IEkbvehZPfODyds5PjOrUhsAgbJg/nqkZZGsbOgiCeo9uXm0nw94C/8hUoQCovwSJ1Mg9OSIg==
X-Received: by 2002:a17:90b:2749:b0:33b:ba50:fccc with SMTP id 98e67ed59e1d1-34abe477fc1mr5621266a91.18.1765671420426;
        Sat, 13 Dec 2025 16:17:00 -0800 (PST)
Received: from localhost.localdomain ([202.164.139.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe216c54sm5212504a91.7.2025.12.13.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 16:17:00 -0800 (PST)
Received: (nullmailer pid 1127174 invoked by uid 1000);
	Sun, 14 Dec 2025 00:14:10 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, Kathara Sasikumar <katharasasikumar007@gmail.com>, syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Subject: [PATCH] mac802154: fix uninitialized security header fields
Date: Sun, 14 Dec 2025 00:13:39 +0000
Message-ID: <20251214001338.1127132-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized-value access in
ieee802154_hdr_push_sechdr(). This happened because
mac802154_set_header_security() allowed frames with cb->secen=1 but
LLSEC disabled when secen_override=0, leaving parts of the security
header uninitialized.

Fix the validation so security-enabled frames are rejected whenever
LLSEC is disabled, regardless of secen_override. Also clear the full
header struct in the header creation functions to avoid partial
initialization.

Reported-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 net/mac802154/iface.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9e4631fade90..a1222c1b62b3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -328,8 +328,14 @@ static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 
 	mac802154_llsec_get_params(&sdata->sec, &params);
 
-	if (!params.enabled && cb->secen_override && cb->secen)
-		return -EINVAL;
+	if (!cb->secen_override) {
+        	if (!params.enabled)
+                	return 0;
+	} else {
+        	if (cb->secen && !params.enabled)
+                	return -EINVAL;
+	}
+
 	if (!params.enabled ||
 	    (cb->secen_override && !cb->secen) ||
 	    !params.out_level)
@@ -366,7 +372,7 @@ static int ieee802154_header_create(struct sk_buff *skb,
 	if (!daddr)
 		return -EINVAL;
 
-	memset(&hdr.fc, 0, sizeof(hdr.fc));
+	memset(&hdr, 0, sizeof(hdr));
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
@@ -432,7 +438,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	if (!daddr)
 		return -EINVAL;
 
-	memset(&hdr.fc, 0, sizeof(hdr.fc));
+	memset(&hdr, 0, sizeof(hdr));
 	hdr.fc.type = IEEE802154_FC_TYPE_DATA;
 	hdr.fc.ack_request = wpan_dev->ackreq;
 	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
-- 
2.51.0

