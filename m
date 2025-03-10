Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBD22FF4E;
	Mon, 10 Mar 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633090; cv=none; b=bzWHPZDc5GWykK7diGImqtqaT0tmSoA5kCrmqtYpJKCbJxvbe0UdwyHwqlSRerLa4H6IPk6I7v8oIK9pcEVrdf6H3U3EAR+onnSfq+6UZjn2vabMzD9Ik2yGpji3wsJOqwkkWCLwq/rR88upb6yjvhPs8iZD7DwFlSNzhBuosOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633090; c=relaxed/simple;
	bh=B+48GwdBOXPRVv9kursNWW0WZXU1iDwHixJiC0xREMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UExXrxT/4uShPhGZoXuwYUpzi3mgHyfs0AuJj9+u6feSmFiHAPEwBb0ekJmWmlSQIwDM58yWc2grGQ/RQFyz2gVbG4lICA2M8O3IMRbrBZR1Ukz2Dr6tPBCi5VpYaNdanv4364zuv8CvQc5gQYArEg8+QXHlqLxQ1BsHwnhBlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 1B247C0871;
	Mon, 10 Mar 2025 19:57:57 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2025-03-10
Date: Mon, 10 Mar 2025 19:57:52 +0100
Message-ID: <20250310185752.2683890-1-stefan@datenfreihafen.org>
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

Andy Shevchenko reworked the ca8210 driver to use the gpiod API and fixed
a few problems of the driver along the way.

regards
Stefan Schmidt

The following changes since commit f130a0cc1b4ff1ef28a307428d40436032e2b66e:

  inet: fix lwtunnel_valid_encap_type() lock imbalance (2025-03-05 19:16:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-03-10

for you to fetch changes up to a5d4d993fac4925410991eac3b427ea6b86e4872:

  dt-bindings: ieee802154: ca8210: Update polarity of the reset pin (2025-03-06 21:55:18 +0100)

----------------------------------------------------------------
Andy Shevchenko (4):
      ieee802154: ca8210: Use proper setters and getters for bitwise types
      ieee802154: ca8210: Get platform data via dev_get_platdata()
      ieee802154: ca8210: Switch to using gpiod API
      dt-bindings: ieee802154: ca8210: Update polarity of the reset pin

 .../devicetree/bindings/net/ieee802154/ca8210.txt  |  2 +-
 drivers/gpio/gpiolib-of.c                          |  9 +++
 drivers/net/ieee802154/ca8210.c                    | 78 +++++++++-------------
 3 files changed, 41 insertions(+), 48 deletions(-)
