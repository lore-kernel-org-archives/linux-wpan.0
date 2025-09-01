Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2E267AF1
	for <linux-wpan@vger.kernel.org>; Mon,  1 Sep 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712372; cv=none; b=lmoXuourYLeDeAeOnXlr9ofMHg38xk9wXak3IfrFkJEmXP9sN2L93GuvfnZjmZzZJauaZrTShRzePBHs4X/bK6OArg/0ysGzRVm5Z9vnNNXgEIRR/V5ibU+YlgB7jRBr4dBbBY8wBRKUZztf5fseBFwBiUOWt8UeMJKu9EMjBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712372; c=relaxed/simple;
	bh=FTzIgiP3NWc0dlW9Txm2qr8tfvqG8X7BrIPcMJvgcVU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I9qs0q+2PtKi8KechD65HfPRbZh9+IWJqxde3IZHGytsoBadKLS6QZeKNbKMSHceyFFN6GW71fmN9yn+C7o5eEFlDoDfC4UzfdGIQ1OTocQVziIbkIlSyotm+086Tnz1tMXF1R8nCpilUlh2+9NZGg3aPWUBDRGQSUiN7s0BlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f2a2b1357cso76811865ab.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Sep 2025 00:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712370; x=1757317170;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Cb5i58+NzZC4kRXSkAPN+GknIz6siHZM/xyBUa15eg=;
        b=njhEp5XIhFrIp3mcFS1+U0RF1ykZn77TunOjXUa2ub3kFdwkukdvLyirCfNCPvWdFG
         gsoHLlhYEsyZGUDCd02MNF3foK25Q1fsmrs5FP8oEykVj+ORZsoASgcOfZ5wUP+L93Fz
         7NfR0yw4oUn+y6xo8cKTw0gJ1C55oho/EKxPEwMzZUL+w4YV7ODWVXmBPsocyNHYpyX7
         mkP+HEjYyz701fQketcpbg3Nt/rK3qsTaABmnA4QMcMf5axTDd+C8+4V3e4RkbLaiRhm
         RKSNFknRKzSiPP3hUKW9wFG/GChjZzJgMz9zxw7j5tC6WDsCEIY3RCHCjtuIM/MxOGrE
         dbnw==
X-Forwarded-Encrypted: i=1; AJvYcCVYLurYZXAmUYZhsQ8/VCv4J/Tr3pJiaQsrWlphVNiq7KV4+oPV/wE4lBxv6sD8UM1S8Yk31v7yhTBq@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEjjfrIklQG1CW6kaOiBy8QoCyeOJqdaglkKnChp+mGN0ZWkI
	oTRkGOyQYAqT3yxh4HUBEwBgYy7Y59YfXDacBDuF5ByTb43zaCtNMFE7S9s4xL12bW0N+JigAJq
	We8sU4nTRLyaMQ0+otIhtOcE43il+6JHXCWEjpmjUHrAox2w+pZz0lhztP4A=
X-Google-Smtp-Source: AGHT+IGnwZ7A+54s0AbuKXUkUiusLI4q8Ihz8nytKAlR1VgZCVm4v+B+GP9UQOnsZ556EmINXg3OiivQGOjZ2U+9OYKFT163AB/1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:3e9:eec4:9af1 with SMTP id
 e9e14a558f8ab-3f4026c3079mr120619585ab.31.1756712369985; Mon, 01 Sep 2025
 00:39:29 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:39:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b54db1.a70a0220.1c57d1.0545.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING: ODEBUG bug in hwsim_update_pib
From: syzbot <syzbot+7932fb418f81bda3ad79@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd2902e0bcac Merge branch 'locking-fixes-for-fbnic-driver'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=117a1fbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=7932fb418f81bda3ad79
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/866cb9f09108/disk-bd2902e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05ea2ff5b4f0/vmlinux-bd2902e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b499ed83474/bzImage-bd2902e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7932fb418f81bda3ad79@syzkaller.appspotmail.com

bond2: left promiscuous mode
8021q: adding VLAN 0 to HW filter on device bond2
8021q: adding VLAN 0 to HW filter on device bond3
8021q: adding VLAN 0 to HW filter on device bond4
------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff8880294fa980 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 13092 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 13092 Comm: syz.2.2163 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 97 e8 52 fd 4d 8b 0f 48 c7 c7 20 40 e3 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 2a 1e b3 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 67 8a d3 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000e17e5f0 EFLAGS: 00010296
RAX: cf70889cbb35c600 RBX: dffffc0000000000 RCX: 0000000000080000
RDX: ffffc9000c66a000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: 0000000000000000
R13: ffffffff8be341a0 R14: ffff8880294fa980 R15: ffffffff8b8bd3a0
FS:  00007fa46bd396c0(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f25865f1f98 CR3: 0000000075ad6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 debug_object_activate+0x26a/0x420 lib/debugobjects.c:842
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4f/0x410 mm/slab_common.c:1953
 hwsim_update_pib+0x2d2/0x450 drivers/net/ieee802154/mac802154_hwsim.c:116
 hwsim_set_promiscuous_mode+0x196/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:323
 drv_set_promiscuous_mode+0x16a/0x2f0 net/mac802154/driver-ops.h:127
 drv_start net/mac802154/driver-ops.h:195 [inline]
 mac802154_slave_open net/mac802154/iface.c:196 [inline]
 mac802154_wpan_open+0x17e7/0x2a40 net/mac802154/iface.c:295
 __dev_open+0x470/0x880 net/core/dev.c:1682
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9549
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9612
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
 rtnl_group_changelink net/core/rtnetlink.c:3775 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3929 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa46af8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa46bd39038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa46b1b5fa0 RCX: 00007fa46af8ebe9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000006
RBP: 00007fa46b011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa46b1b6038 R14: 00007fa46b1b5fa0 R15: 00007ffcd9bf4da8
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
