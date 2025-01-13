Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368A1D417B;
	Mon, 13 Jan 2025 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793399; cv=none; b=HBxqigzd20F8Tfn1G50f5w/ZnJ+QS9euCky4eeqibk7W8rQ6OG4OF2M34ZKcyURJ6DToU3dQ9MoIKUWyn+2xVldZon9vDeugJclFY8fkqGXTrAhkIyT4mpYEiSjIeEBZV2AWydi5532KG++i2O3aM3Y59IIqUkNG8L9zCIN9wuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793399; c=relaxed/simple;
	bh=u1P41QJuzQbMJl1DNKfanFr1JkI8JdcxmczMYl5SzOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J3XHUYg4rZau7SvbbgBaH6KlYBFiJJ6WJNvB4O5CuEkW+jYkPIlie7P3ylrfWzSei9HT+wwmwope6jgGsb+IBkhBKPC+Lqe1fiU+NTZlnoF7DRKdoEdbov7ByF+0w8rdfSaLPKrYozgK1ymb66aBi9C/Y8U9IQt9Xntxqe94HII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXP3Qm/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXP3Qm/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A687FC4CED6;
	Mon, 13 Jan 2025 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793399;
	bh=u1P41QJuzQbMJl1DNKfanFr1JkI8JdcxmczMYl5SzOk=;
	h=From:To:Cc:Subject:Date:From;
	b=VXP3Qm/dxMmf5yu+FJGcF6PglDj1jL+47RX1Gg6FCEZtXu4CTrAODjXA7guCE0Vg3
	 Rjp86qjg4fMO9u6cWMl2dyn2vusLBQDWkPh6EE6dR0w7Z8dGA3FqGdNcOXNZSJOHSP
	 o+wYVvPLu00U6WdDI9d2+WODAa5fUZ3l1JknY955Fgn7qtKRZb4Yw+G/zyDm7L6dGs
	 Uo4SuaH8SDJJtwxysCyy991BykwulstHKg7sg+ag1zmktF9mYCzt4WielA3azy25HA
	 HghcVvgDddlYWrvgqSFbKE8oweXekzNwHelzhd1MyfcluwXPVxE/OVmQ0l7C/QndSj
	 AAN2q/95Virqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/4] mac802154: check local interfaces before deleting sdata list
Date: Mon, 13 Jan 2025 13:36:30 -0500
Message-Id: <20250113183633.1784590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit eb09fbeb48709fe66c0d708aed81e910a577a30a ]

syzkaller reported a corrupted list in ieee802154_if_remove. [1]

Remove an IEEE 802.15.4 network interface after unregister an IEEE 802.15.4
hardware device from the system.

CPU0					CPU1
====					====
genl_family_rcv_msg_doit		ieee802154_unregister_hw
ieee802154_del_iface			ieee802154_remove_interfaces
rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
ieee802154_if_remove
list_del_rcu

The net device has been unregistered, since the rcu grace period,
unregistration must be run before ieee802154_if_remove.

To avoid this issue, add a check for local->interfaces before deleting
sdata list.

[1]
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 ieee802154_if_remove+0x86/0x1e0 net/mac802154/iface.c:687
 rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
 ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-and-tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/20241113095129.1457225-1-lizhi.xu@windriver.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac802154/iface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index a08240fe68a7..22514ab060f8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -688,6 +688,10 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	ASSERT_RTNL();
 
 	mutex_lock(&sdata->local->iflist_mtx);
+	if (list_empty(&sdata->local->interfaces)) {
+		mutex_unlock(&sdata->local->iflist_mtx);
+		return;
+	}
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-- 
2.39.5

