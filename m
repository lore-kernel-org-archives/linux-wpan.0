Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB82417DD;
	Thu,  3 Apr 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668448; cv=none; b=Jet538WVuGl9RgC3QiPbMmwMt0sOc/uB3mQH5xcEQwEwr17OxknpJtBq53dF4uxHpGV9wg05sxTHgMt1rd9QLknYc5x+oaq9wMOgSF9e6E8R6UerT6R2vdjNeBXiLt4bg87773lvtqyxSO0yEjq3/C06EMeL9o6Qe7LoVkq7YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668448; c=relaxed/simple;
	bh=WJ51JsD3b6s+V/hEkDAk9Rl8dDqfB+TKiwWItWIoBW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PHw0JaCPIHLRNOqjr5OEMaprO16EYazQqIKqSzt8IreBkQzXHV/fedyFHgUGAddVGi6NGCeHxE3YBXbPNhvYjVDWem6hCTvj63h7G6M8K/KYbTEzxEs2QeHWBrNBcjMzg3l0skiNZ4RsLUK3YX348RqnaUe4vNTnU4/Rkru3iHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=oGx6box0; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="oGx6box0"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 9712DC0004;
	Thu,  3 Apr 2025 11:20:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 9712DC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743668435; bh=TeptcISo66cYrwTbg5r7b9qgrP/6fr4eK+YncGTZQew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oGx6box0EsxyTa2CTS0I5fMPopASgvfJ2zBAM24edXWvrP/c9RlSS+QCOzFSrG+hG
	 eyoeiDZk5kNW5t+iqDN4hh966YbqsAooXGqUSvin+DWoZfQHH8fqyXZbwS+8iZqAfg
	 nBAOrKtS3qjg72+h29wfu3mR/6Dxc3pPPi0RM9SLjrTyd60WLwjLiOI9jB4vsHvDTr
	 NuXlf/jviSqGLZLJA1RrmQFI4tHcKqvzmr044VB8/8/kcSFWPqPSbDAsrvgSPXQetN
	 MPqz7VWAJ8chJyr7uCWjhCwJZq30ctnmWLUpuh1EViwkCN9CKLLBE2oljkD9dMKfI7
	 EOaxdd+ST/02Q==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 11:20:35 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 11:20:34 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2 0/3] Avoid calling WARN_ON() on allocation failure in cfg802154_switch_netns()
Date: Thu, 3 Apr 2025 11:20:18 +0300
Message-ID: <20250403082021.990667-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192326 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 03:59:00 #27851158
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

This series was inspired by Syzkaller report on warning in
cfg802154_switch_netns().

WARNING: CPU: 0 PID: 5837 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Modules linked in:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor125 Not tainted 6.13.0-rc6-syzkaller-00918-g7b24f164cf00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Call Trace:
 <TASK>
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
 ___sys_sendmsg net/socket.c:2648 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This warning is caused by Syzkaller's fault injection, which causes
kstrdup() in device_rename() to fail, so device_rename() returns -ENOMEM.

Since practically such failure is not possible, avoid it, additionally
fixing similar pointless allocation-related warnings.

v2: Add tags to patch 2. Also make sure to commit against latest
netdev/net.

Ivan Abramov (3):
  ieee802154: Restore initial state on failed device_rename() in
    cfg802154_switch_netns()
  ieee802154: Avoid calling WARN_ON() on -ENOMEM in
    cfg802154_switch_netns()
  ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

 net/ieee802154/core.c | 51 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

-- 
2.39.5

