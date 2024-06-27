Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265A1CD31;
	Thu, 27 Jun 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512966; cv=none; b=kTpMFRDNbcLgXfAoGNC83eN92eJMqGJxnIGD3+pU4+0g4MOhu3NcFWw1h0ykgznn5ZccB8m0KXRMgmmScRBpx0uNJ5xq7poqCtVlfU71hiUcZW3v3sMlbQtFYZk0PvvC0XG24RNHM5+pYVdRwzsss7AVf4y3fFTe1V4BmtlJKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512966; c=relaxed/simple;
	bh=Xj65efAVVazTiFcuY0jQVubU/LBuNfZnPRXlBQitOo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqDiMDcuD1szpBTJFiXyzOWvLXyVTaxriUcJ+ztnm1DdKKn8lZjLs84MaalyNJ4M2oKK3N0E9qUhtzD0lnHm2m8TCY/TEyS9k10ynRUmLQXB7reruJ5QJcnYe7xEFn4K8XXaxUr2dSLurCOIlfRniFbfno60ro/tWr0mMc/5ILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain.datenfreihafen.local (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id BD97DC04A2;
	Thu, 27 Jun 2024 20:19:15 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2024-06-27
Date: Thu, 27 Jun 2024 20:19:12 +0200
Message-ID: <20240627181912.2359683-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Two small fixes this time around.

Dmitry Antipov corrected the time calculations for the lifs and sifs
periods in mac802154.

Yunshui Jiang introduced the safer use of DEV_STATS_* macros for
atomic updates. A good addition, even if not strictly necessary in
our code.

regards
Stefan Schmidt

The following changes since commit 4b377b4868ef17b040065bd468668c707d2477a5:

  kprobe/ftrace: fix build error due to bad function definition (2024-05-17 19:17:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2024-06-27

for you to fetch changes up to b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728:

  net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD() (2024-06-03 11:20:56 +0200)

----------------------------------------------------------------
Dmitry Antipov (1):
      mac802154: fix time calculation in ieee802154_configure_durations()

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

 net/mac802154/main.c | 14 ++++++++------
 net/mac802154/tx.c   |  8 ++++----
 2 files changed, 12 insertions(+), 10 deletions(-)
