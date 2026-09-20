Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD7470425
	for <linux-wpan@vger.kernel.org>; Sun, 20 Sep 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924181; cv=none; b=EelsIGJTXTPRDRDDNGq4QYoUS36+MmnlhyvNF1sEq5FV6HAEnnjAozF1YdOijp9FKt8hh4K1QR6rC4XjKgZVD/vbPBY+B7qmKzMYixFoR8YGdBlTVkhG0SXhvj2GeLFQRdivwBx4cFYnEIaoNTOL8gais0Ow7JSSsyHy9/4GrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924181; c=relaxed/simple;
	bh=3jDi5SqicaQDr/q+xtWz6hyHKp9Lb3qeMrWM9Ne+FyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkLiGhmPz8MW1DbpM5cDisqV6vf35n7Qj9k/GTdf93wxS0R1MGu40HjQ7EoCvXlEi4+ZwZh6LSL31hNAAp8AGO+Ia4Prvj/c1ZEIfz5jb7dU3lQlP/zmjBFu4Ze1Nn1Prr93gunWa4WJqBbNuRej6Ft3SO+KEK0YEHFLNqZRFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyfoIbQb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyfoIbQb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so15816905ad.1
        for <linux-wpan@vger.kernel.org>; Sun, 20 Sep 2026 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924179; x=1790528979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MS2QQz7WOWtVtAEmjB/fcwAovWl61kZVH7rm4ugI64=;
        b=jyfoIbQbk4C1UQXgNirez/xwnyzVuDa3YaDX+DP7+8j0IKFtIW41OPkjVUQq/Q+lJd
         /P+Lzsi7KCx14Ui2cgjcCMtMJYielYVq4mTtnFP6HdahFpUZQT+t0MgJECy3O4Wph5wS
         SW785vXSfbThwYwNg/600mIozcYAUUgXjnuRwFWpK7Y7R82fU9hFDV4Aj1cIHzbsoXL4
         7iNiPLLy1AV2QeDXOWhN23tYVUuaFdo8X9AQqDb5O3x6Sjqu/a3BuOamw0jSQPK5qDeA
         dXDDHJDGWZeBlbKLxhRbMkqVB26Fua5B4CyKwXSYtDiaZmxSNQIMwqbTg8VugDcP54ex
         NLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924179; x=1790528979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MS2QQz7WOWtVtAEmjB/fcwAovWl61kZVH7rm4ugI64=;
        b=nUPTc5zBu+TWSp1wxVHziZ7YCpPVit4RlEREBWtMWrv/fM23W8e86EKhDeu2azc8aE
         ikgkeC2cJBvxP/IrBrV0FkSMHWrn6XBMo2NMkn1YR+mVPpKtql5juo+C7z6V5iC3afop
         Va/dhUjI/mONl1fzd0j39n11FfF0zjDmpYt6sgHtEI7q3lpe+c9bLxQkXnprdxOuWfOi
         VxWyNWssPbCS5u3ueR9NSSYOQo/cvYkcBqAtHfe0EVEfqFWy8EJhTVdebKEkmcnsiyBh
         +0KZyF6jse8DI1LBB3ojy/PPsQhdfqvjtsun00n2pgD3JpQFp1rmicBcjaYtRfAkxBWy
         PTyQ==
X-Gm-Message-State: AFuF++k/GChYoTNR7LyvJ7zTaG6S3WMO8xq4gMe94bKGBhfu+eaiyavO
	TfF55uyKNgEcpSP+NOHqIzkcNWB104M57g71Xy+hx1FEAurcRH4wj/Z7
X-Gm-Gg: AYBFou0Cf/Tf5t3YxacPH7TpphgtM7lz2nuawF3EtwTgfRZM/NsCN6NwExoCQO1vVBQ
	srFxTpXNcMEEFv3wvG9Cr0N0TIZQaswaeuua2Aqa9HZxQxcripHu1btQa2x/BBv9MDSvSnw1rma
	qnNEKmukStakL9DYNVQBUk3tB23Gg7BqpD8+FhZ+9yaje7BxLTzErGYq9UkcrZsXf30v+jLfyS3
	bPSJmyZSn1W+0XVtK6ZwWmn7Wzie1HNK9D2H126+Md8f4RgOrVD/j7auov0rTsIBnzITlZfWtwp
	AJ4i6lqEAi3UQcKupWqI0GeJah4SNMVDv+hJF8ZCbT5Ml//UiZovfmN40sBW8Dk1DSX3sq6iPvy
	4h8KRiR6T1Hk7zl+n1YKJHIHAfPWNgGvSc2irsLuwyBLT+a38AFFw6pm7DnXDVaZ2Ehrzn1dKjP
	/lsdLEl2cJbEFgWdbk+Y5UmRKENQLIsxbQFvyoGUe5cSRL7o8SjfElOBWn7mNwNZA=
X-Received: by 2002:a17:903:3bc7:b0:2dd:ad7d:72e4 with SMTP id d9443c01a7336-2ddad7d74f2mr119017265ad.27.1789924178887;
        Sun, 20 Sep 2026 10:09:38 -0700 (PDT)
Received: from adi.. ([122.171.21.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a12bsm13146327eec.9.2026.09.20.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:09:38 -0700 (PDT)
From: Adi Prasan <itsadi2409@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adi <itsadi2409@gmail.com>,
	syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com
Subject: [PATCH] mac802154: synchronize pending transmissions before stopping the hardware
Date: Sun, 20 Sep 2026 17:06:55 +0000
Message-ID: <20260920170655.608419-1-itsadi2409@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adi <itsadi2409@gmail.com>

syzbot reports a WARN_ON(current_phy->suspended) splat in
mac80211_hwsim's mac802154 counterpart, hwsim_hw_xmit():

  WARNING: CPU: 0 PID: 6038 at drivers/net/ieee802154/mac802154_hwsim.c:266
  hwsim_hw_xmit+0xcbf/0x1540
  Call Trace:
   drv_xmit_async
   ieee802154_tx
   ieee802154_subif_start_xmit
   __netdev_start_xmit
   ...
   packet_sendmsg

mac802154_slave_close() only calls netif_stop_queue() on the closing
netdev before tearing the hardware down via ieee802154_stop_device(),
which calls straight into drv_stop(). netif_stop_queue() merely marks
the queue as stopped; it does not wait for a transmission that a
different CPU already passed the "is the queue stopped" check for and
is currently executing inside ndo_start_xmit(). That thread can still
be inside drv_xmit_async() -> hwsim_hw_xmit() by the time drv_stop()
runs and marks the phy suspended, which trips the WARN_ON() (and, on
real hardware, could still start a transmission after ->stop() has
torn down the transceiver).

ieee802154_suspend() already knows about this and synchronizes with
any in-flight transmission via ieee802154_sync_and_hold_queue() plus
synchronize_net() before calling ieee802154_stop_device(), releasing
the queue again afterwards. mac802154_slave_close() is missing the
same synchronization when the last open interface on a phy is closed.

Do the same hold/sync/release dance in mac802154_slave_close() so
drv_stop() cannot race with a transmission that is already in flight.

Reported-by: syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=adb0bf16414b8bb2d799
Signed-off-by: Adi <itsadi2409@gmail.com>
---
 net/mac802154/iface.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 31353795fa24..e29f225c0dd1 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -313,8 +313,19 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!local->open_count)
+	if (!local->open_count) {
+		/* Ensure any asynchronous transmission already accepted by
+		 * the driver (i.e. past the netif_stop_queue() above) has
+		 * fully completed before calling into ->stop(). Otherwise
+		 * drv_xmit_async() can race with drv_stop(), which some
+		 * drivers (e.g. mac802154_hwsim) do not expect. This mirrors
+		 * the synchronization already done in ieee802154_suspend().
+		 */
+		ieee802154_sync_and_hold_queue(local);
+		synchronize_net();
 		ieee802154_stop_device(local);
+		ieee802154_release_queue(local);
+	}
 
 	return 0;
 }
-- 
2.43.0

