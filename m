Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15524B22C
	for <linux-wpan@vger.kernel.org>; Sat, 11 Jan 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736581046; cv=none; b=OwcKDAzqHWKMrTTCTVs//LMLc/eeoYE9sXsvOzBcYX3keK8rJsfsO7Sy1MV3TJyw2cCRtnlOj9CU9TzypdTqrfuSGDbNxGU2UZhVwV1oku7qA10eRDjvaq+6pOdgzH8sKqZQKWowRO9nStgK7W70KDbk1f/gXXj3LBmv7omevKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736581046; c=relaxed/simple;
	bh=uWLwMe3jqvdDdW77L2W6yrwWc8KABM0SMkwPyStqy/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g3IUDgKiZFInsY3df50wWOGrz01IqCOjO0WHHG2N8MGwBiImCcm7pfI02kBP9977LoGR5OqwJ9AlQkNdJoNF1f6vJ41vQtlb5kl4AgxTfK/kt4vfdt+Ayg7XLe/CfnAlXdrqS/dyzQMbwkXls86lWgTpy94ts6HR1z+JvEBh9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so22718985ab.1
        for <linux-wpan@vger.kernel.org>; Fri, 10 Jan 2025 23:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736581044; x=1737185844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVOH7tDTP8ZL++lwFRoxsPgQDJutOGJQ9WtGPMYZmxQ=;
        b=VELw4G4ewEWSfcMrMC9b151IPK9QjXiPXN+5C3hB8o/NLtFR1lOa0/QrZM4swLtCRp
         vNlevBz5nhv/lOt54Qidnq949Lac6t4kxcorjh1U5OuqRz+S02py2YzgMWM+Zi/pjksL
         D6ZhRh2D+aDDSRDN3gVyVDU6aIvwJ09ngLU8YRddxIA1EDpqHaZ+jGHxNOoO5zHIXGTp
         GfqxklfJCxVf/ASjd5NZCDu+hzLJqdO6Y/gF9TLWAJFz3c7r0N0oJJ1g9SFAznj1KY8n
         EdOvGl5DDGCwuI/YmDU4QLe1FpqYgELIVq0defe6sfuZ5YAisM+9/2+7N8u24TvXdbo3
         sTPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+0NOIIwAIEZz9lV5qKkKOCm0gaCWsXupZlpfg4nRXRWRP+HQkVVlojsZGmAyKIb/sp4otvcXMwRyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1z0OYh3PFs8I0uZNetZvQ3bNOPxSbQDpdKB73H5MITOa5/c1K
	PDTkgv+b/yFaxAyF4tqsrjzkqkik/TuiU1XTL3nvSiWovqRPjCFNRGRFlUr1W1vdc+1OKNR83Iu
	7ECRsOh4vhV4fQfbEUAk7lSQouMMYnbqlknrbzJFkN610y3WuxK3mQEs=
X-Google-Smtp-Source: AGHT+IE9P1EFBLnetNXAkGjLXG316YIdDLRM4OvcX9DSgGuwLL7Vfci+bWxKezN+MnEDDPhfWuQHYn1b0qd2XssrjwP3lCS62DMa
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3cd:d02b:d1f3 with SMTP id
 e9e14a558f8ab-3ce3aa5af2fmr86195905ab.17.1736581043908; Fri, 10 Jan 2025
 23:37:23 -0800 (PST)
Date: Fri, 10 Jan 2025 23:37:23 -0800
In-Reply-To: <675021af.050a0220.17bd51.0061.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67821fb3.050a0220.216c54.001a.GAE@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (3)
From: syzbot <syzbot+bd5829ba3619f08e2341@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7b24f164cf00 Merge tag 'ipsec-next-2025-01-09' of git://gi..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=168791df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28dc37e0ec0dfc41
dashboard link: https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122fef0f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c9ccb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73892b055b77/disk-7b24f164.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6a3f606bee9/vmlinux-7b24f164.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d3108a02573/bzImage-7b24f164.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd5829ba3619f08e2341@syzkaller.appspotmail.com

RSP: 002b:00007ffe8eee9248 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffe8eee9260 RCX: 00007f255ac67da9
RDX: 000000000004c084 RSI: 0000000020000100 RDI: 0000000000000006
RBP: 0000000000000001 R08: 00007ffe8eee8fe7 R09: 000055556b883610
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f255acafe7c
R13: 00007f255acaa10f R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5837 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Modules linked in:
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor125 Not tainted 6.13.0-rc6-syzkaller-00918-g7b24f164cf00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Code: e1 07 38 c1 7c 92 48 89 ef e8 35 dd 86 f6 eb 88 e8 9e 79 20 f6 e9 66 fe ff ff e8 94 79 20 f6 e9 5c fe ff ff e8 8a 79 20 f6 90 <0f> 0b 90 e9 4e fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000406f3c8 EFLAGS: 00010293
RAX: ffffffff8b7f0a96 RBX: 00000000fffffff4 RCX: ffff88802e890000
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88814479e198 R08: ffffffff8b7f08e0 R09: 1ffffffff2858111
R10: dffffc0000000000 R11: fffffbfff2858112 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88814479e078 R15: dffffc0000000000
FS:  000055556b882380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f255acbe5e7 CR3: 000000007e970000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
RIP: 0033:0x7f255ac67da9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8eee9248 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffe8eee9260 RCX: 00007f255ac67da9
RDX: 000000000004c084 RSI: 0000000020000100 RDI: 0000000000000006
RBP: 0000000000000001 R08: 00007ffe8eee8fe7 R09: 000055556b883610
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f255acafe7c
R13: 00007f255acaa10f R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
