Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE53E123F
	for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912369; cv=none; b=TbCRQSpdsZVADHWd0JwKwAw9KET4JSg0l0a6vJAhNo9Z3TrNIfeDHzTF8Byrb4BQ5/fA3FAvOwGIDRSxTtkDeTM1syyJSCuPvgQHG8+XXl1ZCWc6j6zl9au6Hu4Zt1X9CG2O9FtVdB8mtUh15uQ7Qmk8UJ8AG3V9os+p9MjNcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912369; c=relaxed/simple;
	bh=dcvh64xiMdx1l/RtkRRE3Vf6WG1D3sWQ23X8c4vkx+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuL9wiPNawD4F+tozRmvIhzjXamQMS8om0kTkpmmposnLFvfceElprs+kEGBrbtJAm13HRn4LkwChrgViyMBjHvOMwNcz/AezKg724m6hlAR5tjnZOsxlMXmGKic+H+YexJpT3sKwEU5MUvt1UFcBkYWjiRU1zWQOHAC0gP3+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dd8b7UCV; arc=none smtp.client-ip=91.218.175.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dd8b7UCV"
X-Envelope-To: linux-wpan@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dcvh64xiMdx1l/RtkRRE3Vf6WG1D3sWQ23X8c4vkx+0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787912365; v=1; x=1788517165;
 b=dd8b7UCV5fWgJgYx+Hxp6wJ/WyWU2TJztmgkTE6B5xlR0MsWGM5CJVgHTLlrNICgj89auDXc
 FBAV5pEz9UyxwAf5+rkFn+7i4f/Ccs+84KbNry4OjtaAOrA3Fop53IIUpcCv95G3YYnXxOxxd7m
 jVxx41ZkPj+WdOPPb1Zg/cXI=
X-Envelope-To: linux-wpan@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bc9c8e38bcd6cf52;
	Fri, 28 Aug 2026 10:19:25 +0000
X-Mizu-Trace-ID: bc9c8e38bcd6cf52
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] mac802154: drain mac_wq before unregistering interfaces
Date: Fri, 28 Aug 2026 18:19:05 +0800
Message-ID: <20260828101905.26865-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ieee802154_unregister_hw() unregisters the wpan netdevs before
destroying mac_wq. The RX path stores the receiving sub-interface
(sdata) in the queued MAC command descriptor without taking a
reference to the netdev.

If mac802154_rx_mac_cmd_worker() runs after the netdev has been freed,
it dereferences the stale pointer and triggers a KASAN
slab-use-after-free:

  BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
  Read of size 8 at addr ffff0000c6db0ba8 by task kworker/u16:3/61
  ...
  Call trace:
   show_stack+0x20/0x38 (C)
   dump_stack_lvl+0x78/0x90
   print_address_description.constprop.0+0x88/0x398
   print_report+0xa8/0x278
   kasan_report+0xa8/0xf8
   __asan_load8+0x9c/0xc0
   mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
   process_one_work+0x334/0x8b8
  ...
  Allocated by task 630:
   kasan_save_stack+0x2c/0x58
   kasan_save_track+0x20/0x40
   kasan_save_alloc_info+0x40/0x58
   __kasan_kmalloc+0xa0/0xb8
   __kvmalloc_node_noprof+0x1e8/0x588
   alloc_netdev_mqs+0x74/0x7f0
   ieee802154_if_add+0xac/0x630 [mac802154]
   ieee802154_register_hw+0x31c/0x3d0 [mac802154]
   fakelb_add_one+0x250/0x318 [fakelb]
  ...
  Freed by task 652:
   kasan_save_stack+0x2c/0x58
   kasan_save_track+0x20/0x40
   kasan_save_free_info+0x4c/0x78
   __kasan_slab_free+0x60/0x90
   kfree+0x194/0x478
   kvfree+0x44/0x60
   netdev_release+0x4c/0x68
   device_release+0xac/0x130
   kobject_cleanup+0x84/0x248
   kobject_put+0x98/0xf8
   netdev_run_todo+0x3a0/0x5e0
   rtnl_unlock+0x18/0x30
   ieee802154_unregister_hw+0x48/0x90 [mac802154]
   fakelb_remove+0xe8/0x148 [fakelb]

After killing local->tasklet, drain mac_wq before calling
ieee802154_remove_interfaces() so pending work completes before the
interfaces are unregistered. Do this without holding rtnl because scan
and beacon workers acquire it themselves.

Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/mac802154/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572ae..dc80184d7d091 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -276,6 +276,11 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
+	/*
+	 * Drain mac_wq before unregistering interfaces; some workers access
+	 * sub-interface data and acquire rtnl themselves.
+	 */
+	drain_workqueue(local->mac_wq);
 
 	rtnl_lock();
 
-- 
2.43.0

