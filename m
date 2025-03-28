Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E7126C02;
	Fri, 28 Mar 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743129326; cv=none; b=h9Ujm4o7YdzPrvOXU5WaflSLDhUdQuMEG4tQvzCRgLpxxjYKXNTOouNXD9w8y277tRF0UN00mssahCtJW0SVzN8+vdD6bqLx9g9CoS4q20e1uSS+t7i1MEk0xw0ol/wAQTaGYqxDumOe6mRA5hn12J4U0Uyp9DB4qvi++AyURFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743129326; c=relaxed/simple;
	bh=iFvRia4aaKZCH3o10Z6PVTfzPzogLvwk1HTVm4uekUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLyE5ELkC0sRH5BmWozNdYlMcG7duJ6kXkw3RwNeHjeKluETxqvNAIdTpA7B9/nFOJcWo3qvOFTs4zV3sWHtI8UHFGvGKboQt5iZl9T70obkihPMc6sriyftzLzM2cviqAVPoYg4rLFrgTrvOKNgO62uLnCX/b9C6Eq4mSJVoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AaY2swOe; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AaY2swOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743129324; x=1774665324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjIWyMoCN11bp6A0HB51G4mZ/1JeYJHAdSLyacO6ID0=;
  b=AaY2swOewaPtiZW2w5vLhkwSA1nknfotgTmkUPMm+sXEAE8jESP8i86b
   9Fiz9joJZJDzmVz/XMJmulctrw+WF+cWsugOE47ed2Uo1Lfw0n7MDrGa2
   kGXTrZxKMO6LU50zX98Vtd4a2AHJPKkIVkiXL6aAPHObHNAMgxlwAHihs
   w=;
X-IronPort-AV: E=Sophos;i="6.14,282,1736812800"; 
   d="scan'208";a="708865696"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 02:35:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:20585]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.16:2525] with esmtp (Farcaster)
 id c6d5e644-2b7b-4bbd-b0b3-7ab7e10b7c6c; Fri, 28 Mar 2025 02:35:22 +0000 (UTC)
X-Farcaster-Flow-ID: c6d5e644-2b7b-4bbd-b0b3-7ab7e10b7c6c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:35:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 02:35:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <i.abramov@mt-integration.ru>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stefan@datenfreihafen.org>
Subject: Re: [PATCH 0/3] Avoid calling WARN_ON() on allocation failure in cfg802154_switch_netns()
Date: Thu, 27 Mar 2025 19:35:03 -0700
Message-ID: <20250328023511.14859-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328010427.735657-1-i.abramov@mt-integration.ru>
References: <20250328010427.735657-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ivan Abramov <i.abramov@mt-integration.ru>
Date: Fri, 28 Mar 2025 04:04:24 +0300
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
> This warning is caused by Syzkaller's fault injection, which causes
> kstrdup() in device_rename() to fail, so device_rename() returns -ENOMEM.
> 
> Since practically such failure is not possible, avoid it, additionally
> fixing similar pointless allocation-related warnings.
> 
> Ivan Abramov (3):
>   ieee802154: Restore initial state on failed device_rename() in
>     cfg802154_switch_netns()
>   ieee802154: Avoid calling WARN_ON() on -ENOMEM in
>     cfg802154_switch_netns()
>   ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

While at it, apply the same change to cfg80211_switch_netns() and
cfg80211_pernet_exit().

Thanks!


> 
>  net/ieee802154/core.c | 51 ++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
> 
> -- 
