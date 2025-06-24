Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE32EBBBC
	for <linux-wpan@vger.kernel.org>; Tue, 24 Jun 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797031; cv=none; b=XiGDBt4cGAMGATIxZVdVYkBJgysWUnyANlMfGl54VNICIyp3GwMQLmho2WCzbqH/wkKxiysiGfmv6jZ2Wv17gwDNYbWG7ik5j5q2sSToqErh3z/vTLSr7iX3j1CSm+A9ZlCHQOzSl5+GbaR1KxLNnZVB40ryXnwsRgp3RZLyDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797031; c=relaxed/simple;
	bh=htQEQ/BzUbGDReOf5LAHoRmRPlTzuA///0KC3V4lOFc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aRmfWsJLOHzIR2Cn7b4UF533h9S0iKdqiAoe0XPUvOG52ogjugz4IkHDs3Tk36Z/hywO6kDs/+iORW0uLTGzJw9DCSu3Jf6vAMsSGx4yidyA8TK5kubL5+MrBEe7vs1WASXzX/UdH1LvBVVWad4dsixmnFiYLAUtMfpv3CZsDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso914397639f.1
        for <linux-wpan@vger.kernel.org>; Tue, 24 Jun 2025 13:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750797029; x=1751401829;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6knl0xaS3L51AM1ZsG9RmXp7O5QA7TblObdipk/GWaI=;
        b=E7uXTpw7lAQWzlpKe0wu11ot67UXG8WB/F7dBajBa8E20N9uKFFHFnvxuDmOrzwuiP
         T3QnOWBX+A0ebojzBxGpaNWxe5gbPzOW/hQLyfGHJOWohUdb+VWhRYKOZyZCE3FwiMiZ
         SRJU8b+fQvCQFWXxsoVublLk3dm/8Q58SfzQvHyDTkTbr1asG1ve8i7JgzcxFChITEkf
         IPPUJi6aRMJWl9yYSDhuyxs7GX2tnrED+7dMz2S67wR5I3iyckLDLbdIkmu/n1QLvBdA
         fTu9jYHwNlQ7dLYIVpvLP0FwBfoYpjBHXApSNr8s2bv9V2/9v/yFA4AMki6iaNA6wkA1
         2SaA==
X-Forwarded-Encrypted: i=1; AJvYcCW0uvsWpJIwZ1IDn8+XbdyLH15Btg0CUh1ByyUwvg21cuRnZgVHP7Z834PqgNZGHECsdpI4a8EctkwV@vger.kernel.org
X-Gm-Message-State: AOJu0YwAP60BDW9PKXl04KQkZuQ10C5D1wWV7lR+K3OzAboX9a32D7xK
	69Z2ah+Wf58B3BhBu+jXtUlKc4dBmyHGYk5f896prkfN28eXWo2J0ma8AhxsJkvXKeOZ3Zxddn2
	gfknX+tCrS8W5MjtiON2gkbvrIH+inyf4oAGl6D9245YirxGRkgz5R+yNmYk=
X-Google-Smtp-Source: AGHT+IH5de4d25y6CNlVfsK+tP43zSWrtYw23gCA5QZDONUigQy1STLCYjJtal9wLts9ebxBnXhWSL8kr7WxPmyE5pg4p7yHjyyC
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:3dc:87c7:a5b9 with SMTP id
 e9e14a558f8ab-3df329a5a46mr4971615ab.10.1750797029291; Tue, 24 Jun 2025
 13:30:29 -0700 (PDT)
Date: Tue, 24 Jun 2025 13:30:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685b0ae5.a00a0220.2e5631.009a.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING in lowpan_xmit (2)
From: syzbot <syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f4040ea5d3e net: ti: icssg-prueth: Add prp offload suppor..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11630dd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fab0bcec5be1995b
dashboard link: https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170cd370580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64e76754e788/disk-4f4040ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58f25c6cca53/vmlinux-4f4040ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f700f89884c1/bzImage-4f4040ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 skb_network_header_len include/linux/skbuff.h:3157 [inline]
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 lowpan_xmit+0xde9/0x1340 net/ieee802154/6lowpan/tx.c:282
Modules linked in:
CPU: 1 UID: 0 PID: 1302 Comm: aoe_tx0 Not tainted 6.16.0-rc2-syzkaller-00591-g4f4040ea5d3e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:skb_network_header_len include/linux/skbuff.h:3157 [inline]
RIP: 0010:lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
RIP: 0010:lowpan_xmit+0xde9/0x1340 net/ieee802154/6lowpan/tx.c:282
Code: 48 85 c0 0f 84 38 02 00 00 49 89 c6 e8 00 77 a0 f6 e9 69 f5 ff ff e8 f6 76 a0 f6 90 0f 0b 90 e9 5c f6 ff ff e8 e8 76 a0 f6 90 <0f> 0b 90 e9 2c f7 ff ff e8 da 76 a0 f6 e9 12 fc ff ff 90 0f 0b 90
RSP: 0018:ffffc9000437f640 EFLAGS: 00010293
RAX: ffffffff8b1fe568 RBX: ffff8880312e6140 RCX: ffff888027989e00
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: ffffc9000437f830 R08: 0000000000000003 R09: 0000000000000000
R10: ffffc9000437f4f0 R11: fffff5200086fea4 R12: 1ffff1100625cc36
R13: 0000000000000020 R14: ffff8880312e6140 R15: 000000000000ffff
FS:  0000000000000000(0000) GS:ffff888125d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe947dbbf98 CR3: 000000007a4dc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5225 [inline]
 netdev_start_xmit include/linux/netdevice.h:5234 [inline]
 xmit_one net/core/dev.c:3828 [inline]
 dev_hard_start_xmit+0x2d4/0x830 net/core/dev.c:3844
 __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4711
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 tx+0x6b/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1d0/0x3e0 drivers/block/aoe/aoecmd.c:1237
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
