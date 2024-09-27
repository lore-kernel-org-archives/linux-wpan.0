Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393D1BBBE2;
	Fri, 27 Sep 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430255; cv=none; b=p9SfhlK+x2WwULFl0AaeGrl2q88dK1RD+KLsGpF+W36GFNSpVEDPwlCn3J8Y0dfljHW6CMgm36abA/hQY5VRobtTZ93ei+kShO/E9L6TxV89nrzdTXXGW9ki6Oeeah8Gt/nHSa+mWrJsK3TqUhC9FGBAiA6BVb/FvyOKyxpHEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430255; c=relaxed/simple;
	bh=4oubqbC46XZYnbDAUUzSV0iYkWYlssZD9j9hxvrmKag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU3zjnBHFEEemjScOkg+96aL2AGecboInsWD6uEH2oN1HN/Hho8mxvcvEG7V+c2RZMJ4i4SCbOIB+J2EYjlR2LayDxAVJASb/4PbqsE3kLBon7NxUYy1IyZupWJ+tCZYEStcfJWTGqyqDp0GR/thvipABleTSOwWJriTHW3Hz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 8E594C058B;
	Fri, 27 Sep 2024 11:44:02 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2024-09-27
Date: Fri, 27 Sep 2024 11:43:50 +0200
Message-ID: <20240927094351.3865511-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Jinjie Ruan added the use of IRQF_NO_AUTOEN in the mcr20a driver and fixed and
addiotinal build dependency problem while doing so.

Jiawei Ye, ensured a correct RCU handling in mac802154_scan_worker.

regards
Stefan Schmidt


The following changes since commit b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728:

  net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD() (2024-06-03 11:20:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2024-09-27

for you to fetch changes up to 09573b1cc76e7ff8f056ab29ea1cdc152ec8c653:

  net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq() (2024-09-27 10:47:53 +0200)

----------------------------------------------------------------
Jiawei Ye (1):
      mac802154: Fix potential RCU dereference issue in mac802154_scan_worker

Jinjie Ruan (2):
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()

 drivers/net/ieee802154/Kconfig  | 1 +
 drivers/net/ieee802154/mcr20a.c | 5 +----
 net/mac802154/scan.c            | 4 +++-
 3 files changed, 5 insertions(+), 5 deletions(-)
