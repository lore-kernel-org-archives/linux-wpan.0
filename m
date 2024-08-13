Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DC37E
	for <linux-wpan@vger.kernel.org>; Tue, 13 Aug 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570948; cv=none; b=SxyLwCFqRdciZh4ME1RBUzwqTwWfKdInsnIa8zvm6+2zJnHnPaEPuEym00u2VGIGrn3pbHi507ljc0E2DYLq9wgXEffWl2Kt+4nRT+pEzrEow9gOa0Lkx6fwdmjhPsVvOfjh8EXcM5XfoAnd/dcV2KYnw41w2vcAQB0TMWe82S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570948; c=relaxed/simple;
	bh=2d3VYw/1eOMTBjp7dH5IiNqY/jPTBNsR8t75kEEa7a4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cibDrOKkbSs0ZoL+yf/hq1LLu+OVbNrEgKxCHPJfUgIUZe47G0V1rUECqjATu5xHrLPfuSlKjYv7kZkhotT0tFE6It8TNPUWDpeYRRAyzvFA131R2LjaVfhIlxq+ucmSbDFgOhR+XKF33NRGv4l4U+NDrM+LmQ4v8YRUnxK/y9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9504974dso667131939f.2
        for <linux-wpan@vger.kernel.org>; Tue, 13 Aug 2024 10:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570946; x=1724175746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ngDN4+t5W8gLgpUeHVUEQJgpMaZ70F1wn8Uciag940=;
        b=VxJFMGn7/AH/npSN794bnnEdRd49315XqrWg4xnit9UjXqNavLeLDZTuKxqHa2ANXj
         JgoFLJ+LfFe1uwVJTXDDdpMN3hN0fLV9H5s74vLF/KgvDzFiA5eWux7rGfGfT2MWtJdq
         Y42uHgCmg4t48A4/4ahUs/yULKkWC7SUxjZnmtKrD0gteyTp0CCovI7HuZK+aPWbS53Q
         K7wCJ3vLART+Tipp8Xgc+gUEOmSTzGHJhFcg0OBKfQdDY8CKHQqHytqINXWT1NdgxQGt
         76Y3W8SfTRBGHaMvkOdihphmsdk2ZQE/cnsqSkrh2FJGePrEf3o/IQfwvXpAEAP8g63q
         5XLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRN5JTyIODvFYSbMAPfpBLP5aFs1MfBdu0EZ+0YYVFCLwYCmuc/GGkdlRGqPT7wiUHzYIaq/s1VXWtS9Tf5cRFD4KHYW/wODeMpw==
X-Gm-Message-State: AOJu0Yx86jYJhuoekWPB/caWsiCsOWIo8XdDbZ0SdIV0CnERjpTnTClE
	R2S9heArkqvyB1obs94ZRBSJmhE5tIvVb0OmivLV3O7TJNevphs1fmuO870IFuwi/4O5H19LB7M
	AB6f5c/9jws7vIS3CB3ey5LO8ohAzflFnexs1ZHToDo3qr62pVn3scz4=
X-Google-Smtp-Source: AGHT+IHVguG5xXxvhqwOBEihCFi7Yu1nqF/zF7J/rU/bN58IdxkAm0gjS95Q4OqkFr87+2m8AyyFaxmYqbY6T3Cw2GeppG0WdhSv
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d05:b0:824:d6b8:8844 with SMTP id
 ca18e2360f4ac-824dadff815mr966239f.3.1723570945558; Tue, 13 Aug 2024 10:42:25
 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4a1b7061f9421de@google.com>
Subject: [syzbot] [wpan?] WARNING in cfg802154_switch_netns (2)
From: syzbot <syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13da25d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=e0bd4e4815a910c0daa8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9227adf96f75/disk-ee9a43b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c65c46b78c57/vmlinux-ee9a43b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/467d374f18b9/bzImage-ee9a43b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0bd4e4815a910c0daa8@syzkaller.appspotmail.com

RBP: 00007f2c78995090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f2c77d05f80 R15: 00007fff6de33538
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8054 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x37f/0x390 net/ieee802154/core.c:258
Modules linked in:
CPU: 1 UID: 0 PID: 8054 Comm: syz.0.839 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:cfg802154_switch_netns+0x37f/0x390 net/ieee802154/core.c:258
Code: a3 2b f6 90 0f 0b 90 43 80 3c 3e 00 75 8d eb 93 e8 c6 a3 2b f6 e9 8b fe ff ff e8 bc a3 2b f6 e9 81 fe ff ff e8 b2 a3 2b f6 90 <0f> 0b 90 e9 73 fe ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000337f408 EFLAGS: 00010293
RAX: ffffffff8b67d3ce RBX: 00000000fffffff4 RCX: ffff8880215f3c00
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffff88802324e198 R08: ffffffff8b67d23d R09: 1ffff11004649c3a
R10: dffffc0000000000 R11: ffffed1004649c3b R12: 0000000000000000
R13: 0000000000000000 R14: ffff88802324e078 R15: dffffc0000000000
FS:  00007f2c789956c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff818548d58 CR3: 000000007f648000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c77b779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c78995038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2c77d05f80 RCX: 00007f2c77b779f9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 000000000000000e
RBP: 00007f2c78995090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f2c77d05f80 R15: 00007fff6de33538
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
