Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4310F2
	for <linux-wpan@vger.kernel.org>; Fri,  2 Oct 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952519; cv=none; b=qxka5aWn80XiCPsUE1GVe1MUE3ZrS9D4UfnT1UMTIVA5QHvEuS8w1120pRRTofj/V3jWGhrfjIwq119Lw7KrZNGo29ce9RpjlWhghE0HFW+5joXjCmEjHlHaU3C0j9ZbTBX7kJfvGnUOaP88ROrE7FUPZhpFYIf2AgdjHJaD2l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952519; c=relaxed/simple;
	bh=3HRpLaud5Q175KJrOtLopzDWyHQITkJEPRA0KEMmP1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF4ldrJDLvjGMb0QzWqoO7gHgdw+YEUh/gE8U9CF+JudckL98go4/YjrBhEDNF0/R50r8/92uEuiHkXTzlyjSV+472dPi1rOLIYg1fVyYVWbCFoBfcdGLoaGgxHxcWapwi1X3jxZa++1zvoCFHgyc76lKDXXJM21VZLNFJ50jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHe3ttcx; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHe3ttcx"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso7558503eec.2
        for <linux-wpan@vger.kernel.org>; Fri, 02 Oct 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790952516; x=1791557316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qR2bmFpfj/mXdNscyHuDilv95LRNDcT/+z66Xstgtw=;
        b=PHe3ttcx2R3gN2wdaNQFUBeLOPHTyusHy6/dMr9dLy4qH+K3tKkQzx9G/ndBBmgtui
         g9LTjjGt728G+YyyaK7WqSDKrMZxkNjq7isNVX0tVazJm10hYyICayRkyy7YqGuUrLer
         OJxkwlb7zZWu/bbIK/wTZAqlWEN1PuZPDAyLFXK1/ELWd90jf7mM1zG7cXVP0OsEbj6Q
         mmwfP4MhLkNPpr55FWZ2BlqH4r80WSByDKM6xFiT0/Ax36VZTpZ89bD20bw9c4//oMwf
         K4jk0iK7ZhbK75Ar6tHoGA+bUALZnWCDPX+JYGAXbS5HhGZQt5TpypC1sqANxtiGBDlS
         8l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790952516; x=1791557316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qR2bmFpfj/mXdNscyHuDilv95LRNDcT/+z66Xstgtw=;
        b=Ynt4ZhA5hE9f40unetvupvh/NTCLWwlSL9KvxmmgHtIfx/Ry2hL94WihJt+vwpJ68a
         ObWvE+Tgbl90HQH64mtUp00kX1PHL7nvWgTq7moI7OdZHxwos8G83MboFsLFzjoidZkr
         QzSuTGfHNqcVY9PEaPI/lDo6jqG9oxRPb99pcXVH+QD9XhQVrA3ah1xgRK9vYXLxn3pD
         2Pa/9Lciyu6hDy5XXDmdxhTsLeWSWoAVOJG0H9miiCExKv4Rytc10W9doP2lgndt446L
         Qm8FLTbWmXXa+djGKE2sz+3+m52X42k2BU0uRNG/SCnTMyd0lcQR3kZCg3EbQJfS+gi7
         URwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYAvUj9Gdinx8xAlhXOXgP+buyEksMihK1V9khpibSMtiJd2WuuBVI6mIBCu8oLhYyG33Y5gDC/dno@vger.kernel.org
X-Gm-Message-State: AFq9FYKp4+Ya2na6Ai5V9zqTOE1o0HePNkTFPoQ91r6dxMwIRhtQ4q41
	tVkdCbUMm72louaYnM7Pkywk2Rou2SDL0YFEqLzwUwIU901gSaDHss8c
X-Gm-Gg: AYBFou1HMV/2rXF3PW7gRi35dVCvbB2zlQdIu+AymCRFICx2NQTvZfgDueXTI/w4ogX
	NHc7ROmLm+/byHyeIT21XglDXxCvuGtjVKQwxuQ4/WLoCKfTbuGnZPVT++1wDYxBJKMbYuabVgG
	IPQle+PDWGnD+qzqDPyyYoUypMKfnrX0Eh1KiBtxWzSZmdeV/X4ugLkMUcDnTPsLinfaDIGms5H
	an1cV6jUVRqYZIjMOU3h7cpygj7tjbIbw1V2QuT7/elQgPomKEzi3lzCAn0eqVle+W8sZyoOvsH
	uZP3XI+d+IS09TTNV807kSOAUa4wk+ePDldHHVU28UvWZPFLr9wwEYYIrWEJcUsYHPKVHM3EOVm
	q/gpjDETktnbPWXkm6cyMkpxgIKsk/SgZeW7a5PUGql1oSkBBAn3E+kluqzNajHfhkhamveX30I
	lk3oBADq7HyveH2uzJZoR5Q2L8Bq6mzuBua+eOYHtj1E/F1FHzpSxHnn6vw/e9
X-Received: by 2002:a05:693c:41d6:20b0:34e:f5f1:2f46 with SMTP id 5a478bee46e88-34f150ab8a3mr3318591eec.6.1790952515558;
        Fri, 02 Oct 2026 07:48:35 -0700 (PDT)
Received: from adi.. ([122.171.22.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f9f2afsm16747476eec.18.2026.10.02.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:48:35 -0700 (PDT)
From: Adi Prasan <itsadi2409@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adi Prasan <itsadi2409@gmail.com>
Subject: [PATCH v2] net: mac802154: fix race between slave_close() and in-flight async tx
Date: Fri,  2 Oct 2026 14:48:27 +0000
Message-ID: <20261002144827.3479-1-itsadi2409@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ik3tn1nn.fsf@bootlin.com>
References: <87ik3tn1nn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_stop_queue() prevents new packets from being sent to the driver,
but it does not wait for a transmission that is already in progress.

drv_xmit_async() can still be running on another CPU when
mac802154_slave_close() calls drv_stop(). Stopping the queue only
prevents new transmissions; it does not synchronize with an already
running tx operation.

This was checked against mac802154_hwsim as well. hwsim_hw_xmit() is
synchronous, while hwsim_hw_stop() only sets a flag, so there is no
pending work or locking in the driver that needs to be synchronized.

The race is in the core between stopping the queue and an in-flight
tx operation. The fix therefore belongs in the common mac802154 code,
using the same handling already used by ieee802154_suspend(): hold and
synchronize the queue around ieee802154_stop_device().

Signed-off-by: Adi Prasan <itsadi2409@gmail.com>
---
v2: Dropped the explanatory code comment per review feedback; expanded
    the commit message to explain why the fix stays in
    net/mac802154/iface.c rather than mac802154_hwsim. Fixed the
    Author/Signed-off-by name.
 net/mac802154/iface.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 31353795fa24..929ccd464772 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -313,8 +313,12 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!local->open_count)
+	if (!local->open_count) {
+		ieee802154_sync_and_hold_queue(local);
+		synchronize_net();
 		ieee802154_stop_device(local);
+		ieee802154_release_queue(local);
+	}
 
 	return 0;
 }
-- 
2.43.0

