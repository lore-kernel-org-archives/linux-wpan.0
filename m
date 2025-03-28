Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB014F70;
	Fri, 28 Mar 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743124136; cv=none; b=WSL4A9HP/4AGzODvyt1OohtuY9G+iV+TnAsnhnnRKz3j75raHZm58fOEY8nBL0mtRMt5LnFRt1eVLHJr+2FJmjJCdp9fCFxxexgHG01Tcn+Rh1zSllM1ChnwyqsB9b6AOqTXBHDxEqibRqxdePHMl0OGwx52Jk+GEFRmIa8F2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743124136; c=relaxed/simple;
	bh=LUHJHhnqVBiwHBE5eSLmgxG3OCJV2W+nHjSRfGSeZ8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kl1rjdDxop8CM+J5G051WW4PWGX14qeNIQxnvuAfUk68tKAuSkM5ayz1mp2IGvYfBlDE6FY4CQTLdi3wdoJh1aXNk9drPXe38fFsNaOz1G6JvrFILu1jTDPjFQW7uqbF2WibD5Ap2L7bcGfrCt4ZzIVYlR7D2MCLhhh6PrI1Mck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=Unlyh/aj; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="Unlyh/aj"
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 314DAC0005;
	Fri, 28 Mar 2025 04:08:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 314DAC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743124121; bh=x1a84lhOoPi7swJh4YdTyk1IokBrEf8C3V5kv5KxOwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Unlyh/ajz2Lr8bPXMpARp2I6qOa8XzquX1Tl4zVvlD4ASdsSgUKyNF2AIcDFs59R6
	 Fz0p9zR/O4NoNCubcbMG6HsNXePjOCgmIH5jiVxwanEVFy1GZBaAmG17U3S2LpAIV4
	 YnXnrwRfmvRqNbVWp40gK1P0bG1pu1H+GtFINmiO7QksWGnV1SKdxhZcSoBYiIAwmt
	 z0d/hTiygulmyfSIPBeWu52rXsS6nEcGH5OgoPMImYk4YDzN2kbzbDj2Wxcoq8F8fa
	 9CNtyFzHA/4vlxHu5Tm91ujKskprKL9wLT8ktbO7j25ySfh9QCvCH38sN1BdaSl+KT
	 j8Dzsj6WYBmhA==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 28 Mar 2025 04:08:41 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Mar 2025 04:08:40 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 0/3] Avoid calling WARN_ON() on allocation failure in cfg802154_switch_netns()
Date: Fri, 28 Mar 2025 04:04:24 +0300
Message-ID: <20250328010427.735657-1-i.abramov@mt-integration.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192175 [Mar 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/27 22:37:00 #27871126
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

