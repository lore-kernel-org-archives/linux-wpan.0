Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54425A655
	for <linux-wpan@vger.kernel.org>; Sat,  5 Sep 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643216; cv=none; b=Fh8mxdRfbWb1enDj17gLZkO8iigNSiQ++OEZuxveHsKppCppRvwl0E7v6wtmCOs3RaejuQAawxgbKsV4uSqqPi9v5SW/mpeRspP1ccwh+D8/2pkz2c7XUq3+1B97PxFEIbRdhZrLOVXguVpLtqlNEjKg3Kdxbqqyq6fZlF9GnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643216; c=relaxed/simple;
	bh=+093/8nJcghhGC0+aQbMyB/IiX1dcEQCPmfynuD1PT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR8aHUKqeISlhpgOQg/NdAhRCzQs9Jvcamiil7NZR7ycL/vUeX5/pQqL9Q2RSMNWiuB4yNfL3rnD9SDRmzZxRkF7t+slt8L1+X36RdXxKjdx8sHWwDkCbnEVzrqSXMHrLUQIzk+Nj7kGVeDa9dTGVAM8pmt2OdqnV0uBFcyVFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj8/X2fF; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj8/X2fF"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c7c57e637eso1014263e0c.2
        for <linux-wpan@vger.kernel.org>; Sat, 05 Sep 2026 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643214; x=1789248014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7FSrd7fhnbDkTGOB44nrfKkV94WPiP6EXXWHoLjWLA=;
        b=Xj8/X2fFcebo2KtZXAV0JZLEygS4r3qRvEdEy6NIfLBaFDEYitP162XjAyXsp74rG8
         RtzBRrYRBJ1nIR/RvVGe2DdjagI6/SL/B/W2FQXy90a9DwsU5xO9Qjq6fRzeWHp4XrYJ
         T2Hch7vYhTqSb/PIFG7L0SKA7/9FmC/V5iaA/7fladLDnKyg0niU9cHkDDBOkYmLNNK4
         6L2mCodBfq1Sl4SHzfSKywn9kXjTRBKMB4VhaKh5PR1YWakMvn3/MwBF0lTvd1lqlEdC
         cbFAqy4nh/dzcg2QpJCcSY1qZpLX4HU50tgQ9sdT/++WpEP7VH2zA2izR5SqYufcCkLG
         DFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643214; x=1789248014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7FSrd7fhnbDkTGOB44nrfKkV94WPiP6EXXWHoLjWLA=;
        b=Y/HvVYiD1jTnoCFTWZ+AD2YxJ1xZB8p3K+/gcLzw0GH6PVEIpD9DRrQbfv2F9pZ82u
         o49FsUQ2/ISf/Jh7FocataUPZ4EsMYSghpZMwAUz50c0VSTgSNNjmKrJY8EAEIywpAda
         yUsltqr4hiAXcaTxDWM84MC6TakgJQiSrSu5ruV9Q/pkXiDE5DpOj5YFmYvBFXtSHEvk
         dUaMNPMRqdXEMc/J4cEKzmV8PKQ2rUC5yyvUcKgyjDfUXahK6uH8bhVw3WQfgdVN6L+v
         aIZTX6BO+jPyw69f/RD7B5W2bcY4IqHwkox4WNgXv9fqzowKvWxWbFJ8tOKP7TOvIcRm
         55Hw==
X-Gm-Message-State: AFuF++lz/8hfiKuzjhnIE9DYNJdcIxQ4y+5HjGJ+VaKslVccKfv15NlE
	3Z3d8MGoipsPpNsUuK+h7KqeI1xBQ2BuiWTvxx0Ktuyht3KqSuN6AjfZ
X-Gm-Gg: AYBFou3U8xJq4zF3Vo2l5u5iZ6lCISM76IVO3aXAICPY8EyPPE+w9/ZVy1c1IMaw++9
	Z0UmCX2MrnsN+pT69nvEHNYRoHqSF7B8bXH3XSm6v7LNLIKk4P2xhVhuvSqhJbpmkNJO9SWxc8U
	CDDJMeNl4sGY5B1TgMAqhP36cpuFnOEHroUFHkP9QoV2aeoRzp37wTj6/OFaxjRGUXmOBXO8F++
	6zobYNzZrt8mPP476keuWDuBZ+gy385RQF3WBInkrT09L40R4ebO6tNMu95EAghz8B/TMBhckIE
	Q3rDflzBgyXQKx+YSrj8mautj6p4G+ZS/Y4D7gWNmTuopX8Yk43skV5Cu8mkZ4orBVTDvxkQ+hO
	6IOT4pmiMaT/ZTMIFvvCzWp24UoroUrMg3ZROyhfO3ePWJZyvw0CljIEoQxD119rcaKoAhLBAIp
	TmxlU0QSkk0/uWON2M0mD7iC4fr2X8JY6aTaKzzH6Kf/7g6aA7+mmQ
X-Received: by 2002:a05:6122:8b03:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5c7ed38607amr5766684e0c.0.1788643214275;
        Sat, 05 Sep 2026 14:20:14 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec1097e5sm4901956e0c.2.2026.09.05.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 14:20:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/2] ieee802154: register a device type for the wpan netdev
Date: Sat,  5 Sep 2026 17:20:05 -0400
Message-ID: <20260905212007.304875-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cfg802154 netdev notifier never sets a device type, so wpan
interfaces lack a sysfs "type". Mirror cfg80211 by calling
SET_NETDEV_DEVTYPE() in a NETDEV_POST_INIT case with a new
wpan_dev_type.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
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

