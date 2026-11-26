Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693438;
	b=no8BdDhRJ0/AiciOEPw0e6MS+2CsiwXhU6ULIR3IfkHQKiKaXXZaU1Qy4cpXfdYGyej3
	 woHApCWwMoXi0Zbuqfv3T+kEQlTgB1qLTSLukNF2G/CmAdWpQbHujLGva9TkGzmhf8isg
	 K8Bdk81pH2VHCxHnDDrie0HEvPZ5jTG99rtG+lMqHJk9CvqCsFS6nJTXzgTZrBHdCqpLD
	 +SMUQvza2bxc0jQ6pg3+zni4IVZpPRyYpgNd14S7wFxWEMbMk+YPMrsSrbb2KHr0e+A2b
	 r5YPGPnBRgw17e5AOuP6kYSRvHJOnKpDekBb042P6czf8xUEp0Rva2pDHDjV2GNcXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693438;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iq7QWD1R6uTQhcWCLV3i7Z9S2aOBwDhRk26vX5a9zxE=;
	b=0rjG/4JqcMndr+Uzac2SFN3280hlOWo3iv9VsTAbq1INEBv6lv6AMvKkgAdyYcBnZgAI
	 cHi97ytPA6CG+jPu3k6M6uTXLssLXb8jOet6QzbFnb2aF0w4owhgJkSvJFjzoAYfyH4q2
	 ZNlDhW8nyT1ta1PZ5DpYgRaeuw6cL9jLHqa4+bZwcHvNKPU2Agtp9ABChoIuvgAVjm7EJ
	 DAnq70ZOIiCtxUiEZAwA+O7+7IfT3TXIqyE4jaV47bJrCBs2s1mWHXB6iMoS1utsDKBa3
	 ipdODhVGxWlUx4J1+lRaNVxDQ69Fh7WbsEFs6JR9Vy4fpaWifXcVAqdj9Nikg9mp7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C555606A31E;
	Thu, 26 Nov 2026 11:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C555606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 13EEBC0368;
	Thu, 26 Nov 2026 12:43:54 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2026-11-26
Date: Thu, 26 Nov 2026 12:43:49 +0100
Message-ID: <20261126114349.2003459-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jakub,Dave, Paolo.

An update from ieee802154 for your *net* tree:

A bigger than usual round of bug fixes for ieee802154.

Adi Prasan fixe a race in our async tx.

Adriano Cordova is making sure a wpan device type is registered.

Andrey Misiurov fixes the error propagation on netns rollback.

Aryan Arora ensures cancellation of in progress scans during teardown.

Lee Keon-Hyeong fixes up child handling and lookup.

Maoyi Xie ensure proper ifindex handling for netns.

Petr Vaganov ensures proper initialization of ieee802154 headers.

Roman Gushchin fixes a type confusion in 6lowpan.

Xuanqiang Luo fixes skb reference handling in the RX queues

Yifan Zhang fixes beacon transmissions to use the correct interface.

regards
Stefan Schmidt

The following changes since commit ef3e21c61baa74e39a49b75318bd4541562ec43f:

  net/tcp-ao: fix reset key lookup for IPv4 segments on IPv6 listeners (2026-11-25 21:10:35 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2026-11-26

for you to fetch changes up to b6148aaa5eb5b9f5471cc215f37eafb1299afe1c:

  mac802154: look up children by extended address (2026-11-26 10:45:19 +0100)

----------------------------------------------------------------
Adi Prasan (1):
      net: mac802154: fix race between slave_close() and in-flight async tx

Adriano Cordova (1):
      ieee802154: register a device type for the wpan dev

Andrey Misiurov (1):
      ieee802154: keep the original error after a netns rollback

Aryan Arora (1):
      mac802154: Cancel scan work synchronously during hardware teardown

Lee Keon-Hyeong (2):
      mac802154: free a replaced child
      mac802154: look up children by extended address

Maoyi Xie (1):
      ieee802154: look up the wpan_phy dump ifindex in the caller's netns

Petr Vaganov (1):
      mac802154: fix uninit-value in ieee802154_header_create()

Roman Gushchin (1):
      6lowpan: fix netdev_priv() type confusion in lowpan_event()

Xuanqiang Luo (1):
      mac802154: avoid extra skb references in RX queues

Yifan Zhang (1):
      mac802154: validate pinned interface before beacon transmission

 net/6lowpan/6lowpan_i.h   | 13 ++++++++++---
 net/6lowpan/core.c        |  2 +-
 net/ieee802154/core.c     | 10 +++++++++-
 net/ieee802154/nl802154.c |  2 +-
 net/mac802154/iface.c     | 11 +++++++----
 net/mac802154/main.c      |  2 ++
 net/mac802154/rx.c        |  4 ++--
 net/mac802154/scan.c      | 47 +++++++++++++++++++++++++++--------------------
 8 files changed, 59 insertions(+), 32 deletions(-)
