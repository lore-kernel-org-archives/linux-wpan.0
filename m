Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF0137745;
	Wed, 23 Oct 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656776; cv=none; b=ZF9Bu71/gcSJqcyj+PVBazIoYiFr1LFu1R0PzhW6ixNSaOS4KIW+2aK4aOsN1EUR6/UGVh6ABKsXUXlS45hKoZG0JGWHV9uED7eKoQ+XZKfLWSAHauNYtYI4lTAZgs0+iqknwGawutXxE4MsJKsnYlPh4tKyDAvCK9nm9zJYC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656776; c=relaxed/simple;
	bh=vlx4D2ZVQr3/aVRPCIzNqn7qHorwJIyHhTrV5a87oCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bM5co1ghfFPdpst+tqsOaYCFVkiJD8xdeum9Ole2au76DhjgbsFGGX5A5l/Ebk7DgreQph2tb2p8NAetrvzSyHtRnqvw8ZRsNt21LpICZS46fEU07O/buzmAFFN1uxFJGjpJbLmRvDKsL3yazIu3nTAtzLNJqpBtOR1JJ6NgEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKln6K0x; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKln6K0x"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cbca51687so62845885ad.1;
        Tue, 22 Oct 2024 21:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729656774; x=1730261574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZnSh96Iu69rIUG8kQQpn2s5k1xoVcGpHLQvnGG4PPI=;
        b=TKln6K0xgHKuybq/HdgyDRUhijWVPrK45sBnjlIWcVQkJFos1PdnhTHvoaah3Y+PH6
         g763+bvSXbq/0JK1w+1f1K7i1exRcQVo+r4wAtJD1Wo04lSYL99h4UAsZQ8aB3q6EZ/W
         bbWSHldOWqjYbl2o9eptSZjLHtmJyLmzO/yqtuE77KmByQt+PAY1/5Bo5NCDOPRjH7Ac
         aiO4aVtxOSby0e2CSKJ5UUbmJQP8t9UKLrJ//2X7nrantPLIcYAICYOlT+jx80vsTW2L
         6L9dGjZLZRArWK2aqtBoZD/F/KYdFFLI/PgOWXjQCqIu0Ffcf1/sQQaDnI/63BcQN0BI
         T2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656774; x=1730261574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZnSh96Iu69rIUG8kQQpn2s5k1xoVcGpHLQvnGG4PPI=;
        b=RjKKjYoyrQ2W6Dx83TZpu/Gm5FoDxU02Jdc2OiOfFKTAmmhpKSAsVSizgHbQvXrLR+
         wN+Np4TMC7Obqiz7MWiHJvPqWgLyzYEzq4Tt6jGwCMC6nk9OmRkuQ+OmDl/B1aYs1lrW
         lfz/IZZZQIO8kXvJOcx5ch58q0E10kcfOf+E05mA+GdmY8f1eRrHbFuWi+PCDSjmoXwM
         ON+3O+sA7JnbrZyk9333Ze6O3jTrGmAd5cQ2nm9M4mJuqu/ooz+FRv/vCEcBVFsAh1qy
         oeT1XQypd0exEg1XCef5c97n6eM2KTBlh81Qp+J86q2Hxzw4H3wG60YBgjI8eaVT31Qo
         bCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUAuacXw3+D4UCHuNxtjSJiyhuB6Xz8xvaR/69JYTNEJUMp2nrM3To8YdL+iY2CQ0+bGrE8ssBUDQMiCSq5@vger.kernel.org, AJvYcCUgMgz+O+RFc1QmYGeU9Ch0AdmtiHYNkuc4hrd6e95xJkQ3GzWs9UOiSLXS4wztij5QS8HlF0V45AhtCQ==@vger.kernel.org, AJvYcCVfVuZeqYx+QnE/i5b6N7+qzA9QZhfFH5knMAQ/P/4iN6YJSnrUbTj8wdx/f77xheEFAy6N/Qnk4Xs=@vger.kernel.org, AJvYcCW9qzkYWBJQZJF8K9J06HsKIj9FLKQglI9G98EoJmPw1QnYDXktlCZook9iI+6qZHh9UcxNlOS2@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaGjesakXuHLsh6Uve4FklLeO2zKox52kVNj5haEWWU3EB8BI
	5Z1rP2ZQXmgpzSdGeA45RTCOfMnyfZ/9kqUtttAhHuzccYvMUrdb
X-Google-Smtp-Source: AGHT+IGFVDwK3sKSwg//qBWWkJaytMiJe6RPIuT2asWSGdf+7vKFuYWaitKI8a64jdiEFzrZhBOQeg==
X-Received: by 2002:a17:902:f785:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-20fa9e9f8c6mr13920565ad.37.1729656773187;
        Tue, 22 Oct 2024 21:12:53 -0700 (PDT)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:7ebc:c09d:6aea:1a0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f33basm49680215ad.257.2024.10.22.21.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:12:52 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net
Cc: Leo Stone <leocstone@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewmail@gmail.com
Subject: [PATCH net] Documentation: ieee802154: fix grammar
Date: Tue, 22 Oct 2024 21:12:01 -0700
Message-ID: <20241023041203.35313-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammar where it improves readability.

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 Documentation/networking/ieee802154.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ieee802154.rst b/Documentation/networking/ieee802154.rst
index c652d383fe10..743c0a80e309 100644
--- a/Documentation/networking/ieee802154.rst
+++ b/Documentation/networking/ieee802154.rst
@@ -72,7 +72,8 @@ exports a management (e.g. MLME) and data API.
 possibly with some kinds of acceleration like automatic CRC computation and
 comparison, automagic ACK handling, address matching, etc.
 
-Those types of devices require different approach to be hooked into Linux kernel.
+Each type of device requires a different approach to be hooked into the Linux
+kernel.
 
 HardMAC
 -------
@@ -81,10 +82,10 @@ See the header include/net/ieee802154_netdev.h. You have to implement Linux
 net_device, with .type = ARPHRD_IEEE802154. Data is exchanged with socket family
 code via plain sk_buffs. On skb reception skb->cb must contain additional
 info as described in the struct ieee802154_mac_cb. During packet transmission
-the skb->cb is used to provide additional data to device's header_ops->create
-function. Be aware that this data can be overridden later (when socket code
-submits skb to qdisc), so if you need something from that cb later, you should
-store info in the skb->data on your own.
+the skb->cb is used to provide additional data to the device's
+header_ops->create function. Be aware that this data can be overridden later
+(when socket code submits skb to qdisc), so if you need something from that cb
+later, you should store info in the skb->data on your own.
 
 To hook the MLME interface you have to populate the ml_priv field of your
 net_device with a pointer to struct ieee802154_mlme_ops instance. The fields
@@ -94,8 +95,9 @@ All other fields are required.
 SoftMAC
 -------
 
-The MAC is the middle layer in the IEEE 802.15.4 Linux stack. This moment it
-provides interface for drivers registration and management of slave interfaces.
+The MAC is the middle layer in the IEEE 802.15.4 Linux stack. At the moment, it
+provides an interface for driver registration and management of slave
+interfaces.
 
 NOTE: Currently the only monitor device type is supported - it's IEEE 802.15.4
 stack interface for network sniffers (e.g. WireShark).
-- 
2.43.0

