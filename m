Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD213FF5;
	Sun,  8 Sep 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725764577; cv=none; b=Dtju6wb2L8SPNxPi6y60/pOkcHRUYEe/RK4BKUPhCNRBN2/omeYONXCN8Zf0FI30+kyxUI+C8LSaiyBVgoETc7iRE62iItqM3P6bYg4rLwZZUa4jp/LxwYCbgOvaJwBcUCSkNsNlwtSOls/M9MRTGSkLnwrhcCbiahQ4WKWJKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725764577; c=relaxed/simple;
	bh=Sxq9PM8jagvF0YAkcMJoop+0MLO5K1oCoDLRRpVRVgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IY1zVaWaN0stpt6RJ+eD+V5ZK1czcJan1KZyw/uXAL7FQM4hxG1SzYin9qRloHvs4np2Z166LXyyoWWkb3Rd3KKHAK0gfWj2n1ihC4pfYKyncbnP5TUO+5WL6cRQqQR7vCgYl/a5ut5AW0pqbYEOQjdrR1IDa7RLcg+6/ShuZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nt6CFL28; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nt6CFL28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725764575; x=1757300575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNPoQe4JrQrAblmOh7D//em+NnZ2+gy/yYHqhuBd4u4=;
  b=nt6CFL28Zc5jv8g64R+GiWSvq587svHitSdelgmhf6XoXVOpK9fU/X4A
   2f0tYt++OjlKfauG82XbRBGD00VcRE9RyBRebXDA8W4NvLmF72CPDiC+O
   ot7VvrXjGSpJG2oJZ9GFGmk9n9/CG6PYyDvIEHEMZl8LfvIuNc6eu7dhL
   0=;
X-IronPort-AV: E=Sophos;i="6.10,211,1719878400"; 
   d="scan'208";a="123719259"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 03:02:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:15312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.175:2525] with esmtp (Farcaster)
 id c20d6684-4524-48bc-948a-0341c94d8ee9; Sun, 8 Sep 2024 03:02:53 +0000 (UTC)
X-Farcaster-Flow-ID: c20d6684-4524-48bc-948a-0341c94d8ee9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 8 Sep 2024 03:02:53 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 8 Sep 2024 03:02:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stefan@datenfreihafen.org>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (2)
Date: Sat, 7 Sep 2024 20:02:42 -0700
Message-ID: <20240908030242.19836-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000a45a92061ce6cc7d@google.com>
References: <000000000000a45a92061ce6cc7d@google.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
Date: Wed, 10 Jul 2024 09:04:21 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    22f902dfc51e Merge tag 'i2c-for-6.10-rc7' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=166ba6e1980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d29e97614bab40fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=1df6ffa7a6274ae264db
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-22f902df.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4c0526babe49/vmlinux-22f902df.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a5ff57328e52/bzImage-22f902df.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 14392 at net/core/dev.c:11431 __dev_change_net_namespace+0x1048/0x1290 net/core/dev.c:11431
> Modules linked in:
> CPU: 3 PID: 14392 Comm: syz.3.2718 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__dev_change_net_namespace+0x1048/0x1290 net/core/dev.c:11431
> Code: 50 d2 f8 31 f6 4c 89 e7 e8 85 2b fe ff 89 44 24 28 e9 69 f3 ff ff e8 37 50 d2 f8 90 0f 0b 90 e9 5b fe ff ff e8 29 50 d2 f8 90 <0f> 0b 90 e9 bc fa ff ff bd ea ff ff ff e9 71 f2 ff ff e8 31 78 2f
> RSP: 0018:ffffc90022ef7380 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888019c58000 RCX: ffffffff88bc3923
> RDX: ffff88801f6c2440 RSI: ffffffff88bc3e67 RDI: 0000000000000005
> RBP: ffff888019c58734 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000fffffff4 R11: 0000000000000003 R12: ffff888047041cc0
> R13: 00000000fffffff4 R14: ffff888019c58bf0 R15: 1ffff920045dee7e
> FS:  0000000000000000(0000) GS:ffff88802c300000(0063) knlGS:00000000f5d5ab40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f5d03da4 CR3: 000000002984a000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  dev_change_net_namespace include/linux/netdevice.h:3923 [inline]
>  cfg802154_switch_netns+0xbf/0x450 net/ieee802154/core.c:230

#syz dup: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (2)

https://lore.kernel.org/netdev/000000000000f4a1b7061f9421de@google.com/
