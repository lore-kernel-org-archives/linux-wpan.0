Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F42E62C;
	Sun,  6 Apr 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743973347; cv=none; b=RJjpGQwitUwLNH+C7uNyQg8aPQ4tA5VsIa/GgCoI3aghcxWTXpeX0pHxlBIVSgrX813mYx05/OzeCVNbDjKugpe22oN4DTEC7zy1JN6jiTwEvTdcz5mb0NGQhzDlQfYnAOUOZHaJ3DZPHMCZENFIlPCgVer6A3/MNjotALPf9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743973347; c=relaxed/simple;
	bh=hgbsDOhjw3V037U3V+mAfnetYxi0YWfG7CG2z5z52y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpPw2UXA6ZA6MhzWSx6S8Whgqpo/dUJ5vUEOyvGtO4CzVLfs3pyC/joip0ZAW6/uk9Zr/Lf+sIqH6friCSPYOFPyEfXV9s3PmtkbXye+cdwIa9MlqM7w8hYDShvqHaJz7/rfNdIF51VuQ0VA7pqpRrxekWhtmEPD3f/8jrHs5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 24ACEC06A3;
	Sun,  6 Apr 2025 22:56:30 +0200 (CEST)
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
Date: Sun,  6 Apr 2025 22:56:06 +0200
Message-ID: <174397292971.730911.915730343205428534.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.1
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
      https://git.kernel.org/wpan/wpan-next/c/32d90bcea6c3
[2/3] ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      https://git.kernel.org/wpan/wpan-next/c/44dcb0bbc4a4
[3/3] ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()
      https://git.kernel.org/wpan/wpan-next/c/1dd9291eb903

regards,
Stefan Schmidt
