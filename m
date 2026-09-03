Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBE3D171B;
	Thu,  3 Sep 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427821; cv=none; b=T+qKDF6bqIJ48PweWXRyUBUblC6x3tT5Fm2cejHUWQ2sjM1Rnt/BH/TOGOEBKgbrBWDaqVgaPE5E4T8suPb/3DyyQcmaPm/BxprGhdmn/cxeYAAb6xFLrycuBUO8oQwhA8hHjRVRf0GqNxPt7vvzB/7SRXtrQa/tcaUfmdoFpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427821; c=relaxed/simple;
	bh=0J8GCLUm9ubOSjEaX1FKyqqJ3y70Otfc20i3wAD4Kpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfQQMPCNu1Z0tpxycaQnUcDTp5qymAGhJhibvC+rCPgXZLHdDTDANNd3t9Unf6uKeVmbO0QeyV03zIjZB10XkA9cjlB7Zl2weLwWYzBno19+8jhOf0JgBheVUp8wArtVOaW3ITNQGuCg6c7BgKLAaegiE199KcLdMvXZj18ByqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id D16C7C06F3;
	Thu,  3 Sep 2026 11:30:15 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2026-09-03
Date: Thu,  3 Sep 2026 11:30:12 +0200
Message-ID: <20260903093012.4032586-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Zhiling Zou fixed a NULL deref when coming from a TUN device.

Fan Wu fixed a UAF in the cc2520 driver.

Chenguang Zhao fixed up some out of date comments in 6lowpan.

David Carlier fixed a potential double free in the hwsim driver.

Ibrahim Hashimov reworked the queuing in the RX path to fix a UAF on beacon
and MAC frames.

regards
Stefan Schmidt

The following changes since commit 70f3995830d3f1e79faa14eb0605914f778feca9:

  bonding: alb: fix uninitialized transport header access in alb_determine_nd() (2026-09-01 16:59:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2026-09-03

for you to fetch changes up to 2f37fba846c9fdff5fc15b6d93656057ccd13031:

  mac802154: fix use-after-free of sdata via queued RX frames (2026-09-03 11:00:54 +0200)

----------------------------------------------------------------
Chenguang Zhao (1):
      net: 6lowpan: fix mismatched comments

David Carlier (1):
      ieee802154: hwsim: serialize pib updates to fix double-free

Fan Wu (1):
      ieee802154: cc2520: fix FIFOP work use-after-free

Ibrahim Hashimov (1):
      mac802154: fix use-after-free of sdata via queued RX frames

Zhiling Zou (1):
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink

 drivers/net/ieee802154/cc2520.c          |   5 +-
 drivers/net/ieee802154/mac802154_hwsim.c |  10 ++-
 include/net/cfg802154.h                  |   1 +
 net/6lowpan/nhc.h                        |   3 +-
 net/ieee802154/6lowpan/core.c            |   2 +-
 net/mac802154/ieee802154_i.h             |   8 +++
 net/mac802154/iface.c                    |   6 ++
 net/mac802154/main.c                     |   1 +
 net/mac802154/rx.c                       | 120 +++++++++++++++++++++++++------
 net/mac802154/scan.c                     |  10 +--
 10 files changed, 128 insertions(+), 38 deletions(-)
