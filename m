Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EC17C990
	for <linux-wpan@vger.kernel.org>; Fri, 29 Nov 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881094; cv=none; b=CDSkHGUKBOfniV7YD10vPfylGVOBWedsz7AQkzujf4ZzstVNYJCYxTOFM6D58sQZcrg1m/jzfLmBzoMWDFakd7PZ9kECu0k0bwM1qC8ORtxFgRFrIiHEXoYsrkzTIVz5oxHVOF+IEa3mWn1UvrHK+URMhQFfRm7TL8A7sukBACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881094; c=relaxed/simple;
	bh=qXFczppavFoU+TdvIIVz1vt4umFSKooy9vTHjdfMqpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G7BOPdOrlj1KMSuBf0FYCAdJtZ4ZuiE08+S6V4ZL5Y7hHtyZ7BjMhssXOv1DGdOj3i71quOpJ7TsUX0XE0G9tX03c7MuGf2mwIJkxdjz9AEBFJvX9v5WZrAwEwqnSvTXxZ4LEraXjxNCSJVxkDHwzme8xtFJQTwVApMJbm3xY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-84386a9b7e2so297577839f.1
        for <linux-wpan@vger.kernel.org>; Fri, 29 Nov 2024 03:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732881092; x=1733485892;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/L696noJTLs7e4Z/ajrqUxPUHx/7g3Ur+MmtyQgO5w4=;
        b=oPoXh2A1a6ZLxhcIH4JmRzKqP4oBiA9M1JHkb5Gzz9DLArOIL+NnepFRog6QAnsIp2
         Wanq1Q5Yu87HE2xeAShTL1nW14/Y9cxFMBCHasugMR7K0Tv93TwVOUyuSH9QXCyko3O0
         RrHAIoZpGGJdyvuiUY0/hR3YYKOhSzezsfFjg/eLkfka+iGCBAlvuF96smL1PUhvSDv8
         8FxjBKFnfvfuKyz8IRMC5FfmjY5GaIkByLjp+bnYH2VhNMU38IfPFX5BgRR6SMUARpFb
         mvzOy0T9DBjg7E/YNsTI8GXWH0Dt5hyylk2CGy8DWbeHK6BaFq9WxU0VC8OtlPTe97HP
         Mpmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzxiptNvD+W11rjLvwILSGDaRNTBhQDyb+D9oOirjMfhfbzhX+Z8c+Rr+h/BOUXz7eRytJGR9JmWCd@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ3/k0/mxLv2pP1mwp0VobLpZQ8jaMkC2X/zC7xJLWXI2/RaZ
	snTtmxqgg7VWtHW3rk/0hf1NyKec+bzXnrHUeuVxuO9dlN2nHCGNFmBMOKVqa2TlzV4IvNy4y5w
	GOwD/ODZ8dt6xgqubGKwTRfN+5ihOhS+WMj/d5pk48UgZeQgXhhOD6/k=
X-Google-Smtp-Source: AGHT+IEwWGk72rKN+Gun0tjbX0pc2glLeaa+juovNZHhIkcsUsFFiRpx1nbKZyyGwlb5LRjYkdwJ/DiA3QqHvOp/Hx3fK2GexzJo
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a7:7ded:53b9 with SMTP id
 e9e14a558f8ab-3a7c55ea440mr88474525ab.20.1732881092009; Fri, 29 Nov 2024
 03:51:32 -0800 (PST)
Date: Fri, 29 Nov 2024 03:51:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749aac3.050a0220.253251.00b0.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (3)
From: syzbot <syzbot+3344d668bbbc12996d46@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e6775f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15be8a79f63a/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82d8dde32162/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3344d668bbbc12996d46@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 should_failslab+0xac/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4038 [inline]
 slab_alloc_node mm/slub.c:4114 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0xd8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:883 [inline]
 kobject_rename+0xf2/0x410 lib/kobject.c:495
 device_rename+0x16a/0x200 drivers/base/core.c:4577
 __dev_change_net_namespace+0x11fb/0x1820 net/core/dev.c:11736
 dev_change_net_namespace include/linux/netdevice.h:4018 [inline]
 cfg802154_switch_netns+0xc5/0x3d0 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd56a57e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd56b299038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd56a735fa0 RCX: 00007fd56a57e819
RDX: 0000000000000000 RSI: 0000000020000f40 RDI: 0000000000000004
RBP: 00007fd56b299090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007fd56a735fa0 R15: 00007ffe74561238
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5337 at net/core/dev.c:11738 __dev_change_net_namespace+0x16ed/0x1820 net/core/dev.c:11738
Modules linked in:
CPU: 0 UID: 0 PID: 5337 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_change_net_namespace+0x16ed/0x1820 net/core/dev.c:11738
Code: 01 90 48 c7 c7 a0 b6 0e 8d 48 c7 c6 80 b6 0e 8d ba 6f 2d 00 00 e8 33 28 b8 f7 90 0f 0b 90 90 e9 89 ea ff ff e8 14 82 f7 f7 90 <0f> 0b 90 e9 3a fb ff ff e8 06 82 f7 f7 90 0f 0b 90 e9 bc fe ff ff
RSP: 0018:ffffc9000d2fef80 EFLAGS: 00010293
RAX: ffffffff899e5dfc RBX: dffffc0000000000 RCX: ffff88801f1c2440
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc9000d2ff3b8 R08: ffffffff899e592c R09: 1ffffffff2863f12
R10: dffffc0000000000 R11: fffffbfff2863f13 R12: ffff888035e841a8
R13: 1ffff92001a5fe61 R14: ffff888035e84724 R15: 00000000fffffff4
FS:  00007fd56b2996c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056434e74f468 CR3: 0000000040842000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_change_net_namespace include/linux/netdevice.h:4018 [inline]
 cfg802154_switch_netns+0xc5/0x3d0 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd56a57e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd56b299038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd56a735fa0 RCX: 00007fd56a57e819
RDX: 0000000000000000 RSI: 0000000020000f40 RDI: 0000000000000004
RBP: 00007fd56b299090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007fd56a735fa0 R15: 00007ffe74561238
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
