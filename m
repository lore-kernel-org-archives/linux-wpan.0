Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0D3BAD84
	for <linux-wpan@vger.kernel.org>; Tue,  8 Sep 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899742; cv=none; b=PkndmogshQZtSoNVHlrxlrdlnjDT0JWZvQEE3ok+HlMJqfZfmizRv8KQR0KAtGPV9OWBLZUF+n9YtDXTGhVAuwvuA/Ze7B3YpYD50TgUzpOrq9dP6rhlKv9EEgAGRpJLUQNk+hLI0vwAOdPus2L3bvL53VSljBoPtVsq+5aixzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899742; c=relaxed/simple;
	bh=zS3hlDe8zdW+NniVS5ayneJKsmwbKLD+epFUF+wu3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9Q/qbKzyZxwDThz2x//phICGCA2UkkgE3aomUZImHxdyr6uvSnchh3Z+qzqh0eXtNgEpbmevK49YX0YPjuHezG+bjZk3lUHTSbQ5lp2HNNwyCM22XpKcTyL3itIaENmEMeijs4FWDupevrPXhrVkheDZnE+GUyeg5VuHZjjWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtaz/lC3; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtaz/lC3"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66e63c2c9e1so4796751d50.0
        for <linux-wpan@vger.kernel.org>; Tue, 08 Sep 2026 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788899740; x=1789504540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xQ0HwNDCfKaKji8f8/iqu0nYfYxv8RPQ9lEtsdIzJA=;
        b=Xtaz/lC3EaIKe2+lr3OZgb7Dor+WnEU1i1iX8a8CwRv9RTEJGvdaKrAwOmPh4DCZLA
         Ars8aVDGUvc2r1bEG+ZpXNl4FODUOfB0WJamiOTprKF6+6O2sXw6Kd2dZRxQi7IzeweX
         7A7rpZ/fXVZ2sroBFxmh/sxWCIJAeeDEAdqSsaAH2mSnCjkkyCSIrG56hbMhJCBed8Rp
         JsAbNLlE0MRBpYYNl4IGW5xhkmf4K/z5hflUbd83TekJa58AbhbeXs/7Qmyq3f0go7c7
         OeFiLLWa8xwREgFX80sXco+teEQZ90oKEQADdz5GeqNMUgw5O4VKJDilEhQNjGHRST+o
         Vgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788899740; x=1789504540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xQ0HwNDCfKaKji8f8/iqu0nYfYxv8RPQ9lEtsdIzJA=;
        b=WlegWhdbdR6CuQzXnOsaWUIes0HlwipjzMtsHaLvErOk7U3tfR+vRB+rbtDVdY12bL
         I9JxNmMpZVnPMfpr6D0P4y6Jo9HKWQemYgEBwn+JcL3E0g2EJ2HPhZwexrqS59Pk3Yom
         brHtlNC4i7hG5UJfb0ej67Kpgs+KkXm0jY0uZqAFUhSxm0SnQQxHNvj0NcNuRP0Whv0D
         EsDGYd6pAPNxN6M55aGSIzYniVa9mowSBoQIDldrkIc9QTH274v1PVvFRWokCEOGKebf
         8bLnriFr7BmmEUw30jnKZ6Y4bOURST0zD8td50LP+tW9JnMef65cCnHvrimnrWODWdWl
         vdvQ==
X-Gm-Message-State: AFuF++n9KaBkWnL0SsNqi1/FbJ4oe+ntpqgQqYXd+xRkqYPUZFuVG+QT
	HPXuGQeXCaJk4AR1y8LKEhxJBStYSFLP7GCMoQra7tTa3J4m84CoGNgR
X-Gm-Gg: AYBFou21JlxJakCNc7rejzIQlulo+W1MOjM5d+6nZf9zZoFn7znWEcKcBUln778YqAZ
	1UiOfnp9gy8S5Dm7EC9xKMPkZeUhcyDjeYK0aYcx6M5kXehLYhCPcRdIhiVbigQd+F8Q12vdZ5u
	Z+9QSuKNOVKbf1dcZ7Y5L6u5bKD3ZNbDzpZEUDptcz5nNLnykhOpakVgohs1rt7YTX0gKN3PuKR
	uq/yytPINeOuDkCjVrZmr4xuKOQVsKTKP/VKsF3pyNJJ2dxZOwNGMEiql1kGwTQQRr8awY9gUIx
	sKA4ich2vM30ddK3cjJTfzE2+Z+M6+38EZGz7BGuWD0k6KFzkzCyXt69WsG4dGOi4DConcFeVsH
	2pfIdzBLL8cX+VK8qsG3jKXzv7y5x4wqf/Sow/KPPd/9dcMuhFKRjQzjw5oF1NOr28Hp20+Yu3I
	h/jmG2D9XT//aRlpJBwI71rWfvaiG25+Vgk2e+QemqprlJGpF3q8BiFqs5uZhmjKw+PwZpUSrGg
	Q==
X-Received: by 2002:a53:d01c:0:b0:66f:c1bc:4054 with SMTP id 956f58d0204a3-66fc1bc4206mr3492966d50.28.1788899739983;
        Tue, 08 Sep 2026 13:35:39 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:9be0:137d:43c4:cc14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab6fabfsm98442907b3.30.2026.09.08.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:35:39 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] ieee802154: register a device type for the wpan dev
Date: Tue,  8 Sep 2026 17:35:33 -0300
Message-ID: <20260908203533.102378-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cfg802154 never assigns a device type to wpan interfaces, so their
netdev uevent carries no DEVTYPE key. Mirror cfg80211, which calls
SET_NETDEV_DEVTYPE() from a NETDEV_POST_INIT case, and set a new
wpan_dev_type so the device is typed DEVTYPE=wpan.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
v1: https://lore.kernel.org/linux-wpan/178889163770.219967.16467487407776248344@kernel.org/T/
Changes since v1:
		- Drop WARN_ON patch as it was a dead check.
 net/ieee802154/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index c0b8712018a1..c6213412d291 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -272,6 +272,10 @@ void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
 	kfree(rdev);
 }
 
+static const struct device_type wpan_dev_type = {
+	.name	= "wpan",
+};
+
 static void
 cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
 			   int iftype, int num)
@@ -296,7 +300,9 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	/* TODO WARN_ON unspec type */
 
 	switch (state) {
-		/* TODO NETDEV_DEVTYPE */
+	case NETDEV_POST_INIT:
+		SET_NETDEV_DEVTYPE(dev, &wpan_dev_type);
+		break;
 	case NETDEV_REGISTER:
 		dev->netns_immutable = true;
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
-- 
2.51.0

