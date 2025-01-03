Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9F1FAC58;
	Fri,  3 Jan 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920065; cv=none; b=HUvRAT60Bquszg3lHt46Izs+pcF4SP0e3AX4jOK9FWy7PwQjHjlBzX38NxROHt2yIrv7ASl8rX+qJ/E44WOD+lyqvH2Xc4AxpBD1my6FueaYMRZkwr57eLxU/MdHFwyqdkyvJ7nv5j4ng58PK4XRL2hdwnoGANxF7Y0kdp32Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920065; c=relaxed/simple;
	bh=RO1b86wjNFiGUM6WmNhgPpDkASh7S95QG/goixmSfhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7UytT9pLtTmiZbMJw8STi7CP6PV8R4hLXQejx6XqVDFKMe31KAb8vzDUsHs2gBx+gwCYPc2S/7/hLZYB8AwPZieXMw68ZssD7fGF3JikUXsyRmkJmDToS/8jgXpa15LyOCqBDvSK9yMpCAfUW+hWY/zIhD3klBzdTLlvgKXW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id D2F0CC07D3;
	Fri,  3 Jan 2025 17:01:00 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2025-01-03
Date: Fri,  3 Jan 2025 17:00:46 +0100
Message-ID: <20250103160046.469363-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Keisuke Nishimura provided a fix to check for kfifo_alloc() in the ca8210
driver.

Lizhi Xu provided a fix a corrupted list, found by syzkaller, by checking local
interfaces first.

regards
Stefan Schmidt

The following changes since commit 66418447d27b7f4c027587582a133dd0bc0a663b:

  Merge branch 'bpf-fix-recursive-lock-and-add-test' (2024-11-18 19:40:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2025-01-03

for you to fetch changes up to eb09fbeb48709fe66c0d708aed81e910a577a30a:

  mac802154: check local interfaces before deleting sdata list (2024-11-19 10:54:17 +0100)

----------------------------------------------------------------
Keisuke Nishimura (1):
      ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

 drivers/net/ieee802154/ca8210.c | 6 +++++-
 net/mac802154/iface.c           | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)
