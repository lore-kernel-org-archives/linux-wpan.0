Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F121E32B6;
	Fri,  8 Nov 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070120; cv=none; b=BpshmlwcFlKMtEpbva287PFRZhnY1SgmCK5fensi5kCaauS7uv9le8IqJwoJeYKnNf7EuOXcKVClYMP19S2kl3EF4k5PqhGgFIoa8W41hkEa2roEpeOTNodnpdqBnsbLCvZAIeoo21O5fqdtTElQK1Yg8LkvLVWfECAA1O0LA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070120; c=relaxed/simple;
	bh=BrM+QekzMB2T8860EPHWnK0U+ToiG8m9uCbPJhCJYXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mupp99or/27a+/1U7i3mqONnLlnKLIr1DrBvL5MW1OQsxjkyQ7rShv1qa3nMPMKS8jzX0KwZj4F6RDCw9/XvT+33LQtSSe+3CptUmPfGr4CPOdmedpOfMPLzSL4dWHZ5AJWrSfSt0uOkZ9HTQUHno2S9EVrogJ4+gKToWO0oxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JSY1eLGR; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JSY1eLGR"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 04C256B738;
	Fri,  8 Nov 2024 15:42:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2d9f:0:640:f6ce:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id EF63B60AA0;
	Fri,  8 Nov 2024 15:42:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HgiwQ5RXpeA0-owJRxKUK;
	Fri, 08 Nov 2024 15:42:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731069738; bh=1DnT2TQayxFeydxyvNIUVRqNEl2DB4hWlBNBuik8Qns=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JSY1eLGR1rRtuO+2JScsHIjXXci90Rv07R4roaHf0fBhVUU/hbjRRQ7MYcFxBXwh2
	 LX5l3Wdl80h8Mh9nVcRkW/f9R1aX7txXA2Qs2tnK2vz94qqZ0TxNORmp96i5N7x2LX
	 cvTWFhoGMUbCRek2vIAYzAohe80MR1q71Y/4b39Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Subject: [PATCH] mac802154: fix interface deletion
Date: Fri,  8 Nov 2024 15:40:51 +0300
Message-ID: <20241108124051.415090-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following BUG:
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
RIP: 0033:0x7fd094c32309
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec50063a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd094c32309
RDX: 0000000004000000 RSI: 0000000020000b00 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000161b7
R13: 00007ffec50063bc R14: 00007ffec50063d0 R15: 00007ffec50063c0
 </TASK>

Since 'ieee802154_remove_interfaces()' and 'ieee802154_if_remove()' may try
to process the same 'struct ieee802154_sub_if_data' object concurrently,
there are two problems:

1) list of 'struct ieee802154_sub_if_data' objects linked via 'interfaces'
   field of 'struct ieee802154_local' should remain consistent;
2) 'unregister_netdevice()' should not be called for the same
   'struct net_device' concurrently.

IIUC RCU can guarantee 1) but not 2), so discard RCU quirks and prefer
explicit SDATA_STATE_REMOVED flag used via atomic and fully-ordered
'test_and_set_bit()' to mark 'struct ieee802154_sub_if_data' instance
which has entered the reclamation.

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
Fixes: b210b18747cb ("mac802154: move interface del handling in iface")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac802154/ieee802154_i.h |  6 +++---
 net/mac802154/iface.c        | 10 +++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..7afcea3447c1 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -40,9 +40,8 @@ struct ieee802154_local {
 	int open_count;
 
 	/* As in mac80211 slaves list is modified:
-	 * 1) under the RTNL
-	 * 2) protected by slaves_mtx;
-	 * 3) in an RCU manner
+	 * 1) under the RTNL;
+	 * 2) protected by iflist_mtx.
 	 *
 	 * So atomic readers can use any of this protection methods.
 	 */
@@ -101,6 +100,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_REMOVED,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..700c80e94bb2 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -669,7 +669,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		goto err;
 
 	mutex_lock(&local->iflist_mtx);
-	list_add_tail_rcu(&sdata->list, &local->interfaces);
+	list_add_tail(&sdata->list, &local->interfaces);
 	mutex_unlock(&local->iflist_mtx);
 
 	return ndev;
@@ -683,11 +683,13 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
-	list_del_rcu(&sdata->list);
+	list_del(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	synchronize_rcu();
 	unregister_netdevice(sdata->dev);
 }
 
@@ -697,6 +699,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
+		if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
+			continue;
 		list_del(&sdata->list);
 
 		unregister_netdevice(sdata->dev);
-- 
2.47.0

