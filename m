Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F0331A63;
	Sat, 20 Jun 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977753; cv=none; b=j5xdZwX7EJNxeFyFeU+HbWpzNk3+CQtM96+gDeKs56LwEx3xp1ejS0IJPnL/R02tU0HryUzkD8FMu5NQ5RCsAm7Q7YeMxa2B1dEoZLCsKv8jaGK2dzIpREt6kA2jYjmpeq/KuM7eo8KWs0mHKfEcQvZlS61MqyM/MgueRJWK7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977753; c=relaxed/simple;
	bh=KAPoBf9BExen4IaZoij6WCkOt/dAfiQP4OlXnivQIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dilg1D1Rb7SUhiRY9TjQUSr2ZXS4BDM2l3R5ztSDG2KCMZvXLPhNV2NL5gOMUlBEpRzM63r2lOY4BQO7MYa3OHyXdXrR6ddAyGkxiOLWVnARj7V/5C/q698a9fy44O0E6w5XwP5H4i9smwn8ngG0z/Iw5ZGpLKEPRml34cCtG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work-wifi.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 97159C018D;
	Sat, 20 Jun 2026 19:49:07 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2026-06-20
Date: Sat, 20 Jun 2026 19:49:03 +0200
Message-ID: <20260620174903.1010671-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An overdue pull request for ieee802154, catching up on all the AI found issues
at last.

Shitalkumar Gandhi fixed problems in the ca8210 driver for cases where we could
have a leak or a pointer truncation.

Robertus Diawan Chris made sure we do not overwrite the return code when
associating.

Michael Bommarito worked on properly gating our netlink API use in the llsec
security context.

Ivan Abramov cleaned up the netns cases as he did in other subsystems.

Doruk Tan Ozturk ensures we have the correct skn ready in cryptoo operation (to
avoid a  silent overwrite).

Aleksandr Nogikh fixed a kernel-infoleak detected by syzbot.

regards
Stefan Schmidt

The following changes since commit b85966adbf5de0668a815c6e3527f87e0c387fb4:

  Merge tag 'net-next-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-06-17 08:17:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2026-06-20

for you to fetch changes up to a6bfdfcc6711d1d5a92e98644359dedc67c0c858:

  ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation (2026-06-19 23:02:42 +0200)

----------------------------------------------------------------
Aleksandr Nogikh (1):
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Doruk Tan Ozturk (1):
      mac802154: llsec: add skb_cow_data() before in-place crypto

Ivan Abramov (3):
      ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

Michael Bommarito (2):
      ieee802154: admin-gate legacy LLSEC dump operations
      ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation

Robertus Diawan Chris (1):
      mac802154: Prevent overwrite return code in mac802154_perform_association()

Shitalkumar Gandhi (2):
      ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit

 drivers/net/ieee802154/ca8210.c |  9 +++++---
 net/ieee802154/core.c           | 51 +++++++++++++++++++++++------------------
 net/ieee802154/header_ops.c     |  9 +++++---
 net/ieee802154/ieee802154.h     | 17 ++++++++++++++
 net/ieee802154/netlink.c        | 36 ++++++++++++++---------------
 net/mac802154/llsec.c           | 14 +++++++++++
 net/mac802154/scan.c            |  1 +
 7 files changed, 91 insertions(+), 46 deletions(-)
