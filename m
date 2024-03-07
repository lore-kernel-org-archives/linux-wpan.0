Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D095137C39;
	Thu,  7 Mar 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841092; cv=none; b=bByI9k6A/CBG6KO200GOB/SKwjkyNOxrJJyBdo7VwZ0SXNTTsb4KIulq1+7zGy2IKZRDDoLwGr2+BV6QQ9RgkoDT2p/+CERf/Zme7AldrY42eIbYLt5T+5MlRN+DXDD56AsD3O7/f9lvFcFNH0quw8Va+3bery4sjPhkrK1v7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841092; c=relaxed/simple;
	bh=a1xb1mMQy8YqL8oScQ6h8lSK/elVzB3caUVbGFJlCSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfDljUVKDbuDiyydz7Dp6egD6gDJnjHMjE4fDI2TnjyGEpeF+7+qK/T7NECooWSlNKdD/eQuh83v+C9WhYwxV5MQMs72V3xKfTMVYBG5keOxZwsy4HTRtZgPBm/srFwa1gHbFNuI7TVsa0c+qJTmX48/ti8L5J3mkcFm6fmCk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 37CC3C08B2;
	Thu,  7 Mar 2024 20:51:25 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2024-03-07
Date: Thu,  7 Mar 2024 20:51:05 +0100
Message-ID: <20240307195105.292085-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

A little late, but hopefully still in time.

An update from ieee802154 for your *net-next* tree:

Various cross tree patches for ieee802154v drivers and a resource leak
fix for ieee802154 llsec.

Andy Shevchenko changed GPIO header usage for at86rf230 and mcr20a to
only include needed headers.

Bo Liu converted the at86rf230, mcr20a and mrf24j40 driver regmap
support to use the maple tree register cache.

Fedor Pchelkin fixed a resource leak in the llsec key deletion path.

Ricardo B. Marliere made wpan_phy_class const.

Tejun Heo removed WQ_UNBOUND from a workqueue call in ca8210.

regards
Stefan Schmidt

The following changes since commit 2373699560a754079579b7722b50d1d38de1960e:

  mac802154: Avoid new associations while disassociating (2023-12-15 11:14:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2024-03-07

for you to fetch changes up to b2d23256615c8f8b3215f0155b0234f0e310dfde:

  ieee802154: cfg802154: make wpan_phy_class constant (2024-03-06 21:23:10 +0100)

----------------------------------------------------------------
Andy Shevchenko (2):
      ieee802154: at86rf230: Replace of_gpio.h by proper one
      ieee802154: mcr20a: Remove unused of_gpio.h

Bo Liu (3):
      net: ieee802154: at86rf230: convert to use maple tree register cache
      net: ieee802154: mcr20a: convert to use maple tree register cache
      net: ieee802154: mrf24j40: convert to use maple tree register cache

Fedor Pchelkin (1):
      mac802154: fix llsec key resources release in mac802154_llsec_key_del

Ricardo B. Marliere (1):
      ieee802154: cfg802154: make wpan_phy_class constant

Tejun Heo (1):
      ieee802154: ca8210: Drop spurious WQ_UNBOUND from alloc_ordered_workqueue() call

 drivers/net/ieee802154/at86rf230.c |  5 ++---
 drivers/net/ieee802154/ca8210.c    | 10 ++--------
 drivers/net/ieee802154/mcr20a.c    |  5 ++---
 drivers/net/ieee802154/mrf24j40.c  |  4 ++--
 include/net/cfg802154.h            |  1 +
 net/ieee802154/sysfs.c             |  2 +-
 net/ieee802154/sysfs.h             |  2 +-
 net/mac802154/llsec.c              | 18 +++++++++++++-----
 8 files changed, 24 insertions(+), 23 deletions(-)
