Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436171A9B5D
	for <linux-wpan@vger.kernel.org>; Wed,  4 Dec 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304754; cv=none; b=mgiAA0UayHf+7nzoAnX9OXqyvyr6f7kthnCIHS1p/eYGPITT/EjyLBlzcT41svzEXHErUqTDVw0JHKlmir/GkOPbrWDHbP6+DrUkHrOYT1HNUp6ZHVNU0qY3QWSxyGkaAIhw7LF+upp1Ga/SQO5mu+JTFoeDfULDmxP+WcCtmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304754; c=relaxed/simple;
	bh=JrPxY6246hfsb6xDn3f0xR470U+27UJSIDIJf2VpfCQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AG/i2LuUyd+cRCJiKb7dMjdHO9O+ulyMX+zxOVG1gpchZEH38ATRIKXl7Jyh5tGP8MiTwlr74aiQ8hgY22+foObBlCweTBaLiRroOhCnfAR5QXP6nFAeDHyVaUvEMv/codcdtvO8Lf/pcDv/2DVl/v7R/kozCeCQmNjiOYfL0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so1080857839f.3
        for <linux-wpan@vger.kernel.org>; Wed, 04 Dec 2024 01:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304751; x=1733909551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skT9lAYd79bQf42/trX7AO1ZhAjaVgemtAGCwOzst60=;
        b=vkcrppYu5ZRT9//HsH6xH2RPb96bZGhpwzP+gJzx48GOfALyv4BTThmNqYBxZWB6ua
         fESFrgor+AoLJzH8niJ2NB7/Eb4Mdpw7c6WenDnFgRV1YpHg5jC51iNmCkld2qo6XI1W
         ukPU/qLuWW9g2YaiPZ4psi8vFlZ++UwuEb2dEXP0j14AHNugyz8YITEgf5LlIGB0USdK
         RjUY82mCKQVVu/bNqUzLKL8Cf7kEJvXPPpb7PF/Ze3n3eGGTehSRne5fErvLYcoWfeE+
         XgT7KpeI38Z5v0DRSxlPH2GL+LXlaKIiO0/dHgo+/ndVX8NxdWj6NkN0pNMyknvyyTeL
         RjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxv3YvicGs9skQ/9bXrsJn9w5f17iuiM6m/VdPypuBUW5oEf001B9EH0oFO5NpgNVI6X0bimUFQZUz@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiPW+twaBTAHSZcZJ6u08sOiMBW/4tY58UI5v7jecA+QdCjt9
	AdEgs2gKoc75G70HMY18TAsf/Y6KPJXPC18q2LKPmWgFY78u56Novwms3MkOB830Ofarc+wYZ+D
	v3Yn6Y3+OEc8hdzTDjFa2qd+M92MLG+3lEcAnasjmNVfkC6bD+5Dxpko=
X-Google-Smtp-Source: AGHT+IGuiLPY1XF4IM3hqm9K92Zyp7n7VoEb802vwOLn9x9TtBycJ7+oLqSpHaZLiMLrRbbOkGIjGZeIIWGW5kAR/xq2fCtrb4lH
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3a7fecc86f2mr40377725ab.8.1733304751329; Wed, 04 Dec 2024
 01:32:31 -0800 (PST)
Date: Wed, 04 Dec 2024 01:32:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675021af.050a0220.17bd51.0061.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (3)
From: syzbot <syzbot+bd5829ba3619f08e2341@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b7b9e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7903df3280dd39ea
dashboard link: https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b7b9e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2ba9f676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49a0011f6379/vmlinux-2ba9f676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac57640f6a59/bzImage-2ba9f676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd5829ba3619f08e2341@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f2cedb45fa0 R15: 00007ffcd711e1d8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 20692 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Modules linked in:
CPU: 0 UID: 0 PID: 20692 Comm: syz.3.7229 Not tainted 6.12.0-syzkaller-11677-g2ba9f676d0a2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:cfg802154_switch_netns+0x3c7/0x3d0 net/ieee802154/core.c:258
Code: e1 07 38 c1 7c 92 48 89 ef e8 c5 74 87 f6 eb 88 e8 7e 8d 1c f6 e9 66 fe ff ff e8 74 8d 1c f6 e9 5c fe ff ff e8 6a 8d 1c f6 90 <0f> 0b 90 e9 4e fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000dcff3c8 EFLAGS: 00010293
RAX: ffffffff8b795426 RBX: 00000000fffffff4 RCX: ffff888000342440
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88801f128198 R08: ffffffff8b795270 R09: 1ffffffff285fb12
R10: dffffc0000000000 R11: fffffbfff285fb13 R12: ffff888032cb4db0
R13: 0000000000000000 R14: ffff88801f128078 R15: dffffc0000000000
FS:  00007f2cee7af6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000120f6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
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
RIP: 0033:0x7f2ced980849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2cee7af058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2cedb45fa0 RCX: 00007f2ced980849
RDX: 0000000000000000 RSI: 0000000020000f40 RDI: 0000000000000004
RBP: 00007f2cee7af0a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f2cedb45fa0 R15: 00007ffcd711e1d8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
