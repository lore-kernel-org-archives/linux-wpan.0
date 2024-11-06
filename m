Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707D202640
	for <linux-wpan@vger.kernel.org>; Wed,  6 Nov 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912006; cv=none; b=s9iWHQ69yLTvwoOdq3zGeVcM7dru2DcI4A8kplrd5XCZW31uzCezdgcIX5Of4fEGMFc5jEcPeE3peWHCEqHmtOWwvDt2px13SpnK5Br4G3+NSU7bBgxpsHCB4N+B1HHCIyYdUJYr8lXO+IxEXQl6cwma+G5qQJBYICigPnIzE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912006; c=relaxed/simple;
	bh=xnQ4Y5OkLDw7+kpBIjjDpj/d4KDArPXb58DSwWlk9/c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nNTfUauG4fBvhp5t20ZnXo+clazsXjWapIzAnmUMJYoWwGJjzrNGdgTKKOIts041WelLOJV69wJSMsHvcP3qfyD1GN8v7RuEiZNgIi9dH0ZIUampDB/HEbZoDFN5+hBOG4Fyhr7giFxsJZR8Hz2XdnLkhL9CKebNGw4dPbzDd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so490345ab.3
        for <linux-wpan@vger.kernel.org>; Wed, 06 Nov 2024 08:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912003; x=1731516803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAuJyuZyW3fwlKbDhzM6Z2xlWYFISeiwXKrwvgPNhqc=;
        b=OPqGKf4CShaNHchY72CMR4llnvVzyje+/gsRE2Py2prDj7iY23TQHBk4kMui0JLb7O
         eEqcXjhtkdJLnx+PHIfFqalggzVInT3Yt2t7EejgKRFAGLz9bcFADiuWQF+nglQRkRwh
         bhzKvltk4bhO/h2m4K/rW9oZvyMlBSpqfS7ZrqW1H9f5UoH0RcfZ5aXNvkwzWVq5TV9l
         KYe5r9cURMrxrrhOgr4VKGLPaw91TPUkDbtyCzngfZkMRgOoxxIZb4mDdl3eI+WIvwEN
         TwnczQluOMpHTT7mbQ9cClpuP5owGSvpbKX23zgE13bk7vbvr9KtULxe3dY0OHNWWXoP
         C1eg==
X-Forwarded-Encrypted: i=1; AJvYcCXPY8+/n5TSu+aZKa85EBoGE3gaWC4R7FTZ/NMDzDbFIQ3zhGb44eJCwwUonVVahnFRJhYj7Fjyhf4I@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6STXu+YqkeskwyMz0XMAumKt4dOu6SvC3cU5WLy4LCexVo7p
	bLVclnTX/FNEQWjpO1zwx12Oij9V2gcb7M95R9BfVye3Zt4InWFChlCJlaLMV4wUSlSlUlM7YR9
	/DJEoZJCrTMrTq3n3wrUviWP5HGDISGIsG8meSxA+a4s+UKQ6vwMmTIc=
X-Google-Smtp-Source: AGHT+IHdPpKyWCNZXHoI1XBOWe8fIhCxF9cGjMgOMB/oUdi2ooOGWuK5QOMQ/He+FwMCTi3itzqPKo3pDdjNU1AKn8H67+g7mkQ1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr286814735ab.10.1730912003663; Wed, 06 Nov 2024
 08:53:23 -0800 (PST)
Date: Wed, 06 Nov 2024 08:53:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b9f03.050a0220.350062.0276.GAE@google.com>
Subject: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    557329bcecc2 Merge tag 'mmc-v6.12-rc3' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a9f740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d76d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a9f740580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b44e0081eb5/disk-557329bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15b6a52c8e11/vmlinux-557329bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab40912bec45/bzImage-557329bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6277 Comm: syz-executor157 Not tainted 6.12.0-rc6-syzkaller-00005-g557329bcecc2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 ieee802154_if_remove+0x86/0x1e0 net/mac802154/iface.c:687
 rdev_del_virtual_intf_deprecated net/ieee802154/rdev-ops.h:24 [inline]
 ieee802154_del_iface+0x2c0/0x5c0 net/ieee802154/nl-phy.c:323
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd094c32309
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec50063a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd094c32309
RDX: 0000000004000000 RSI: 0000000020000b00 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000161b7
R13: 00007ffec50063bc R14: 00007ffec50063d0 R15: 00007ffec50063c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 a1 7e 00 07 90 0f 0b 48 c7 c7 e0 37 60 8c 4c 89 fe e8 8f 7e 00 07 90 0f 0b 48 c7 c7 40 38 60 8c 4c 89 fe e8 7d 7e 00 07 90 <0f> 0b 48 c7 c7 a0 38 60 8c 4c 89 fe e8 6b 7e 00 07 90 0f 0b 48 c7
RSP: 0018:ffffc9000490f3d0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d211eee56bb28d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805b278dd8 R08: ffffffff8174a12c R09: 1ffffffff2852f0d
R10: dffffc0000000000 R11: fffffbfff2852f0e R12: dffffc0000000000
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88805b278cc0
FS:  0000555572f94380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056262e4a3000 CR3: 0000000078496000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
