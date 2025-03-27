Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8B7E105
	for <linux-wpan@vger.kernel.org>; Thu, 27 Mar 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743053494; cv=none; b=Mw59G93L6BFy4GE5cEUM0vY5UoXMHWx9jygkiBvyMatozSioRi0Wa/wQbLzEqx3RX1Ncxcnbya19HqWAHDNpF6lPCgZCMEswP+U1a/o80aSE5TuZBDu7o2phlUEN7DcTeTvs0vHx9YaKCN+bmfRV5sqknB3Mbjv8CyiBWuVqYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743053494; c=relaxed/simple;
	bh=cWKH2vFV0tX18Wz2aMHSdUvIAsgE6vzo8FOkAW8lLBg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AOFHczFoaHCAxVRfkldKQCnxBV2KObxnPieKow1lhS8KOjjXnfucEix/4BVELWHojy+Zc5t+LlrWnoLYYIDm+ZFYlMVR2AoLqOEenGmNoSvUKD3Z6yi7QFRJCR6aULBaWGHhrFRke7SE6ggRN8qEoIkLnYWctRxKIWkpfiDGh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so10668715ab.0
        for <linux-wpan@vger.kernel.org>; Wed, 26 Mar 2025 22:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743053492; x=1743658292;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+XI+Z+k/9cyGXpcpvELUu6pEI9pnj2OVm8/c+ZH5H8=;
        b=Kj0xx5h2ltbliBSV0xJe7goWSovjX5O1zkzh7uwKK1UDXJJ6USwOHkjatXfHN4oJnl
         qrRv15BbjmqeF4lGPq+aQs4Yo6cEDgKaTZMtwKosRx+cmuqrFY1GRxJ5IU5zSyDgPQ8U
         1+p2i/vmNi1WRlGw1qTE0iRUJ5ckUvAtiJQh/0pyBzh2MsfMMHzubHnoeo1uCFObohXN
         h/WU/anRr26meXkr2IQVaprKicTx7RkOp3xbRjTSDuqKNzA5j9BpGgay4lwvz5A1cM++
         r/rLJ6jMR+dwTrKGQy7OFKukKxB1RwYKAOgDOublTiaA9l8td3GPW5t5fwFWIY6luDJh
         dJmw==
X-Forwarded-Encrypted: i=1; AJvYcCWetz4ok6ZKkEsCXUFGmMNdE7O20IN/qoD3/U/vWd15ZGSdZbY90FToukyC8q4epPSdb8yIfNX6JE6f@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAunxKjzpcIdNHakPx8rTLPkvik6aAtCsz13+3wbvj0myoS6f
	F55OejpntJMVTtoXJiBwrw8xlv847KQan5JgvkwXBCyV0/1nrjbhw8SfNDodozoOq11+UCUnOJ0
	scrYdxprVj9onXaIgT488gockwv/HDy/rf+adBScUojT0b/G2yo1v/AU=
X-Google-Smtp-Source: AGHT+IGyvnT+vm84j7lLHRM+O4q8cSsIrX4kls8FwqiU9KsTBPDp+0QCIRr/j7JnOP0uOC25rpa/bVyBAH7/v/y+gIxoLH5zScLm
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe6:b0:3d4:3d63:e076 with SMTP id
 e9e14a558f8ab-3d5cce1d546mr27504645ab.18.1743053491885; Wed, 26 Mar 2025
 22:31:31 -0700 (PDT)
Date: Wed, 26 Mar 2025 22:31:31 -0700
In-Reply-To: <6749aac3.050a0220.253251.00b0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e4e2b3.050a0220.2f068f.0021.GAE@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (3)
From: syzbot <syzbot+3344d668bbbc12996d46@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10256198580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a07195688b794b
dashboard link: https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b2d804580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14256198580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmlinux-f6e0150b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d/bzImage-f6e0150b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3344d668bbbc12996d46@syzkaller.appspotmail.com

R10: 0000000000000002 R11: 0000000000000246 R12: 00007fca2f73a048
R13: 00007fca2f73fffc R14: 00007fca2f73a167 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5302 at net/core/dev.c:12104 __dev_change_net_namespace+0x16f9/0x1890 net/core/dev.c:12104
Modules linked in:
CPU: 0 UID: 0 PID: 5302 Comm: syz-executor142 Not tainted 6.14.0-syzkaller-03565-gf6e0150b2003 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_change_net_namespace+0x16f9/0x1890 net/core/dev.c:12104
Code: 01 90 48 c7 c7 80 88 2e 8d 48 c7 c6 60 88 2e 8d ba dd 2e 00 00 e8 47 60 a6 f7 90 0f 0b 90 90 e9 9d ea ff ff e8 b8 3b e7 f7 90 <0f> 0b 90 e9 06 fb ff ff e8 aa 3b e7 f7 90 0f 0b 90 e9 8b fe ff ff
RSP: 0018:ffffc9000d336fa0 EFLAGS: 00010293
RAX: ffffffff89dc3ad8 RBX: dffffc0000000000 RCX: ffff88800032c880
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc9000d3373b8 R08: ffffffff89dc35d9 R09: 1ffffffff2079d4e
R10: dffffc0000000000 R11: fffffbfff2079d4f R12: dffffc0000000000
R13: 1ffff92001a66e68 R14: ffff888043c7871c R15: 00000000fffffff4
FS:  0000555581f64380(0000) GS:ffff88808c824000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdafa37008 CR3: 0000000043cc2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_change_net_namespace include/linux/netdevice.h:4163 [inline]
 cfg802154_switch_netns+0xc5/0x3d0 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb38/0xf00 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8e8/0xce0 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53c/0x870 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca2f6f7e99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc5fcdf18 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fffc5fcdf30 RCX: 00007fca2f6f7e99
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000006
RBP: 0000000000000002 R08: 00007fffc5fcdcb6 R09: 0000555581f65610
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fca2f73a048
R13: 00007fca2f73fffc R14: 00007fca2f73a167 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
