Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AB1FAC4F;
	Fri,  3 Jan 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919191; cv=none; b=u/N8jGZrSOqS8PSHQa+5AQcDnYEbrnYK2fUu9NcSbyu8WCibUfylbAEwLffxV3gY1m9C4VovQleU8fRnpMciQwG6nHj13mrUQDUZdJCjvGis8A+/RuVngceUUu+bkL/7Iuo8sqAT28nig1KObRKcxzLgRWzBPN6rYpD1xrH5FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919191; c=relaxed/simple;
	bh=pg7KgkOX9D8kbqzJCYQ/rLNiXhVQN5YfHL6V0+NVB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSb65JS0vGPiLiO8HADY052QxkJoj1TNgdstJSFalYfLesOpZ0ZbdS3DOtTgiem0NgDfCYrnXXPwRGpJ6oVFNWjQqi0zFwGgo9vJvD1humcHTWscdhTj95Rd+TrDsb98P5i+MokYNk/vC+rv3sA4UxEu9KxK/mXb2UZk0b78ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id DC21EC07D3;
	Fri,  3 Jan 2025 16:46:15 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2025-01-03
Date: Fri,  3 Jan 2025 16:46:05 +0100
Message-ID: <20250103154605.440478-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net-next* tree:

Leo Stone provided a documatation fix to improve the grammar.

David Gilbert spotted a non-used fucntion we can safely remove.

regards
Stefan Schmidt

The following changes since commit b8ee7a11c75436b85fa1641aa5f970de0f8a575c:

  net: dsa: mv88e6xxx: fix unreleased fwnode_handle in setup_port() (2024-10-28 13:27:34 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-01-03

for you to fetch changes up to bddfe23be8f84e66b1920140a6e11400fae4f74a:

  net: mac802154: Remove unused ieee802154_mlme_tx_one (2024-12-30 16:40:38 +0100)

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      net: mac802154: Remove unused ieee802154_mlme_tx_one

Leo Stone (1):
      Documentation: ieee802154: fix grammar

 Documentation/networking/ieee802154.rst | 16 +++++++++-------
 net/mac802154/ieee802154_i.h            |  3 ---
 net/mac802154/tx.c                      | 13 -------------
 3 files changed, 9 insertions(+), 23 deletions(-)
