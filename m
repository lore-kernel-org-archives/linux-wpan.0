Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69468189F54
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jul 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627464; cv=none; b=uz+KDa3YJlpeItq9y/s/nwQGeJ03+Cz8x+HLsoYRMYtFKHsljLq6Yn0oD+3NcaGzhCE7kbjQ8pxY59dYtaRYbwUzcEfFtVDDeQy5JKFLUfEtlWTiQZ/sKwW6pjiVQQW+8jvURF82SsZAmusa8WoLXKHuNWBlDS/7tppdPQc52qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627464; c=relaxed/simple;
	bh=F5651wRk6JGF0y1/D2r4IFOQpy+68oVJLkzsrqiu3pQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W4N67u3D3Vh4ur3ZMMu5AagPKTPaG/hKV37OhKjaW8E/zc4ihTiqSFDC/L7mBU18MOyXRuoCCtPm12OUg48DmK0oLRM0YJ9KFcgjaypP2aORFnF4BTvoea7r4GXLKUWgEKc3pDBpNJXPTDaFQuwMMgIDtJMfWtbUIPEhT7Ex7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37613924eefso79633065ab.1
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jul 2024 09:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627461; x=1721232261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzNjvPXI0IhEylYxId6ygQqziXqhyGQIzw5DDUBKrc0=;
        b=aPmrWIdpRxaLqN84dkWJXEPpEjNPRnQp/gT0/AGI8OsrmawfOBCnEczeHiGFArqGWr
         ysdSzAqGCvIybdhbZnwB3Fwscf6B2mmPifhQy3oM7GQWJcVZSyZ5BdaIGzwHFS1s9tul
         8TSRj65VYL5Lu+HT/3Gq7nsDlf0/+S+//3vWiozfjd7soziPbvFsenFVebU6+5QveAGA
         dA9Ne1RgChr+MQkw+zkzMUIxZ68Rt5IcEvTyA3miHQYuzGYOsZM2vMG5RdVCzVs6dOKH
         DPwmg1xUNEAzsFJUFzFAcJL5Zo2QbOBIoiWF8/wWADYim/M6XNHbneyI9pjc5eg6DSA/
         biBg==
X-Forwarded-Encrypted: i=1; AJvYcCVcV6ZHuKH6EFnle25wPOKXTQHpmUFpYL2GCH9LMF3vMMFHfZEZbtJPCSIoGDv4hLoP1QnpM38Ph4ggclw3vjNCjxxy6Zm1uqMw+g==
X-Gm-Message-State: AOJu0YzSKKIf07Wc0RtyyNC6/ug9mWGq8Fb4HWtHA0JveLH7GSY3GWm9
	2UaxLhgRUzrdEelRgCW4Umem3Oq6ElpEiBWABVb/AFcLgO5miiLNjJMSVHXfYGrYYMpU9fbXhjh
	Vd8VtYe0KNJmffvW1U7CNHDrnKIBKBJMOaO8gyb7XtjQETBqfn5vkbn0=
X-Google-Smtp-Source: AGHT+IEutDHakATlVOtPiE8Ik2uYKyWC7dOcn56qCAeKI1rU5WxMfeIRBi8JIgoWERk9UZ+HdVkv7TgmxNo3xtJaJOWDYafW+uPc
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:870e:0:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-38a56c0a037mr954935ab.1.1720627461637; Wed, 10 Jul 2024
 09:04:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:04:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a45a92061ce6cc7d@google.com>
Subject: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (2)
From: syzbot <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f902dfc51e Merge tag 'i2c-for-6.10-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166ba6e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d29e97614bab40fc
dashboard link: https://syzkaller.appspot.com/bug?extid=1df6ffa7a6274ae264db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-22f902df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c0526babe49/vmlinux-22f902df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5ff57328e52/bzImage-22f902df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 3 PID: 14392 at net/core/dev.c:11431 __dev_change_net_namespace+0x1048/0x1290 net/core/dev.c:11431
Modules linked in:
CPU: 3 PID: 14392 Comm: syz.3.2718 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_change_net_namespace+0x1048/0x1290 net/core/dev.c:11431
Code: 50 d2 f8 31 f6 4c 89 e7 e8 85 2b fe ff 89 44 24 28 e9 69 f3 ff ff e8 37 50 d2 f8 90 0f 0b 90 e9 5b fe ff ff e8 29 50 d2 f8 90 <0f> 0b 90 e9 bc fa ff ff bd ea ff ff ff e9 71 f2 ff ff e8 31 78 2f
RSP: 0018:ffffc90022ef7380 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888019c58000 RCX: ffffffff88bc3923
RDX: ffff88801f6c2440 RSI: ffffffff88bc3e67 RDI: 0000000000000005
RBP: ffff888019c58734 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000003 R12: ffff888047041cc0
R13: 00000000fffffff4 R14: ffff888019c58bf0 R15: 1ffff920045dee7e
FS:  0000000000000000(0000) GS:ffff88802c300000(0063) knlGS:00000000f5d5ab40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f5d03da4 CR3: 000000002984a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_change_net_namespace include/linux/netdevice.h:3923 [inline]
 cfg802154_switch_netns+0xbf/0x450 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x134/0x2d0 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2585
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2668
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7442579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5d5a57c EFLAGS: 00000292 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000020000780
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
