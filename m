Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405717BA6;
	Sun,  1 Sep 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725216182; cv=none; b=BoWGAa4J0z9L7EPL6ACFOHeSvcEYkZfOfOjMeFcXbPjN+elX63lMkC9cbsBg95wL9t641UiT6NVNXYwvV8Z/o+7sz+rHQtr9VxQ8vZNNHg+gmfmFam1kgxBXzSrjqDS/LYEw3UpHtBpv97AdRamMyGTgYVV229/B57xH5rknu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725216182; c=relaxed/simple;
	bh=yJetYniCCBzh8NFaGtxXa67VcVv4GBJFb/s/2SY0p3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPGHGUZz/7Et1XGPmOg4wopqd858tz+4Zs2pUhQpq4RfVsNlcoD5Nn2yNQ4szrmpQPrvAHolWkx9kqRPA1axJa+mm+ur61uT7lxlrE6Jrzlw5HIiPxF0uPo/unGiX/9X/y4nEj7VxLLkwn/QF8ek0B2DNHNRooIq1IJaPruEPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 6E3BDC044D;
	Sun,  1 Sep 2024 20:42:48 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2024-09-01
Date: Sun,  1 Sep 2024 20:42:13 +0200
Message-ID: <20240901184213.2303047-1-stefan@datenfreihafen.org>
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

Simon Horman catched two typos in our headers. No functional change.

regards
Stefan Schmidt

The following changes since commit b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728:

  net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD() (2024-06-03 11:20:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2024-09-01

for you to fetch changes up to 3682c302e72d71abeb17a81a6d29f281b22928e2:

  ieee802154: Correct spelling in nl802154.h (2024-08-30 22:30:55 +0200)

----------------------------------------------------------------
Simon Horman (2):
      mac802154: Correct spelling in mac802154.h
      ieee802154: Correct spelling in nl802154.h

 include/net/mac802154.h | 4 ++--
 include/net/nl802154.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
