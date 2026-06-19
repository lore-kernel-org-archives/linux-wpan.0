Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0735E1CD;
	Fri, 19 Jun 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901519; cv=none; b=bMw4R0uamoI1BxBKmc/vxUNRuxX8+e327MNhAVYtZ2L1LeXby/Xonhb3bfXETXLn7EVT1DotzhyHVJf2d/c5VDoISup9IPO8i4ROaKMnm9TfDBTQ8u8fC7NaEkmORfvNSaMQzO0sfxlQxDaMHjjKHl4ss9O/RwEI4uvmK3xO3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901519; c=relaxed/simple;
	bh=o7jmV4iDQaK5MXVWwfxyExXe9lJth6KbAlRciNgboJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr28aDcaDa1OQ6XA6yNmZynhSyJKGd7vA2kiDh2FzSK+OJBJwM9umPq4sutAu+cj5Nc+5qchRQbZhBTLizVbBRbyXpv+lTUwcPkopnbNDNSBr4fvd/63gZSwcdp3f2To2gJdxyBJE4ImRubcfwqWpw+h5ov+eoRr8L50WnigY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 0B1FDC0221;
	Fri, 19 Jun 2026 22:30:05 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net v3 0/3] Avoid calling WARN_ON() on allocation failure in cfg802154_switch_netns()
Date: Fri, 19 Jun 2026 22:29:41 +0200
Message-ID: <178190096342.793016.12409311921282832509.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250403101935.991385-1-i.abramov@mt-integration.ru>
References: <20250403101935.991385-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Ivan Abramov.

On Thu, 03 Apr 2025 13:19:31 +0300, Ivan Abramov wrote:
> This series was inspired by Syzkaller report on warning in
> cfg802154_switch_netns().
> 
> WARNING: CPU: 0 PID: 5837 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
> Modules linked in:
> CPU: 0 UID: 0 PID: 5837 Comm: syz-executor125 Not tainted 6.13.0-rc6-syzkaller-00918-g7b24f164cf00 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
> Call Trace:
>  <TASK>
>  nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:726
>  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2594
>  ___sys_sendmsg net/socket.c:2648 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/3] ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
      https://git.kernel.org/wpan/wpan-next/c/a2e06b4bef20
[2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      https://git.kernel.org/wpan/wpan-next/c/0569f67ed6a7
[3/3] ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()
      https://git.kernel.org/wpan/wpan-next/c/e69ed6fc9fb3

regards,
Stefan Schmidt
