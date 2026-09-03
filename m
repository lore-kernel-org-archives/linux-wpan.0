Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C784A3F37
	for <linux-wpan@vger.kernel.org>; Thu,  3 Sep 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438757; cv=none; b=rUe25PzsUu7nf54/IU+bCqqBPJxMDnJKuVl5GYExyVi8lo1OhL4c4katXWL381s6UKHYlfVVwIKO19QjRdZHC1k+Wls0+No2P3+VG2nALwjrbFIUPp9dtAQEp24st1Bdv1NEBr0SR2X39OlZ7ql/ufutVqUmo3SRxx982IocbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438757; c=relaxed/simple;
	bh=wT/Kh+SYC9N2PwFI4PChHwKHi3/2o0RhO4bSbbh0O1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZd2nS/IVckokLf1/bvhwq1k6xPSBRHVpaJFQIIrToDyjGJyqCKVpSKfkH3STclm2eMB3SbdU+Xw2YSxW1oXlC7NS40ADRWWL7YCeQVcwKINCC3m7SJVp6PJTmis6NDX8cHx0XQsYnzakqR+rMXN+ZJPCAXaQBTJk7HYr375ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gPfkr7XB; arc=none smtp.client-ip=95.215.58.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPfkr7XB"
X-Envelope-To: linux-wpan@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wT/Kh+SYC9N2PwFI4PChHwKHi3/2o0RhO4bSbbh0O1M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788438752; v=1; x=1789043552;
 b=gPfkr7XB9AEkCMHAymjKen1j0ePj5NHYvw9jslU0v82431WVwNQ3o8qzh8j2eFLcHzhtyjqC
 rfCl6wThIxIXzcwIc7Q03xF5Dj2dAbOVYDQ0Z2B375zVKZF+Iblexq6WvrEbUx/4hTABnPtUE2G
 6VZkKF+HyyFDv2TVzslOxsKw=
X-Envelope-To: linux-wpan@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 29adbccee56dd346;
	Thu, 03 Sep 2026 12:32:32 +0000
X-Mizu-Trace-ID: 29adbccee56dd346
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	david.girault@qorvo.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 0/2] mac802154: fix queued RX descriptor lifetime
Date: Thu,  3 Sep 2026 20:32:00 +0800
Message-ID: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

mac802154 queues one descriptor per received beacon or MAC command, but
each worker invocation dequeues only one. Since queue_work() coalesces
attempts to queue the same pending work item, a burst can add more
descriptors than scheduled invocations. A later frame may schedule another
invocation, but also adds a descriptor, so it does not necessarily reduce
the backlog. Descriptors can therefore remain queued indefinitely once
reception stops. The RX path, workers, and scan cleanup also access the
descriptor lists without common synchronization.

A queued descriptor carries its receiving interface beyond the RCU
read-side critical section without holding a netdev reference. If the
interface is removed first, the worker can dereference freed memory.

Protect the descriptor lists with a spinlock and keep the workers running
until the queues are empty. Then hold the netdev for the lifetime of each
queued descriptor to prevent it from being freed too early.

This ordering is required. Without the queue-draining fix, a descriptor
stranded by queue_work() coalescing would also strand its netdev reference,
as netdev_put() runs only when the descriptor is released, leaving the
netdev pinned indefinitely.

---
Changes:
v2:
  Patch 1 (new):
  - Serialize descriptor list access and requeue each worker while another
    descriptor remains.
  - Detach queued beacons under the same lock before scan cleanup frees
    them.

  Patch 2:
  - Replace the v1 drain_workqueue() approach, which does not cover work
    queued after the drain or the DEL_INTERFACE path, with a netdev
    reference held by each queued descriptor. (Sashiko.)

v1: https://lore.kernel.org/all/20260828101905.26865-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  mac802154: serialize and drain queued RX descriptors
  mac802154: pin netdevs for queued RX descriptors

 include/net/cfg802154.h      |  2 ++
 net/mac802154/ieee802154_i.h |  2 ++
 net/mac802154/main.c         |  1 +
 net/mac802154/rx.c           | 36 ++++++++++++++++++++++++++++++------
 net/mac802154/scan.c         |  8 +++++++-
 5 files changed, 42 insertions(+), 7 deletions(-)


base-commit: dc4b95b8fee95113587e93ca116356032d271371
-- 
2.43.0
