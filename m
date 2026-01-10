Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEC1BF33
	for <linux-wpan@vger.kernel.org>; Sat, 10 Jan 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768031845; cv=none; b=h4gu73hUGuSs0lj8oo1wcwDUymj3sZAnjImjaohN83kOEKwD3Y6pnrZihuwaymk7JJrLgmsYACR3lSklfV51hmkLCvO/5e+gJoF+Liht9FYQBKwN84jmu9hHyC8N7O0CuUmT4CJHamEq7ZIYPFrvFj96fKU+rHYBL90dWlimuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768031845; c=relaxed/simple;
	bh=qT0nlE9tP6XTFN3uMUBBISQotht1yGyI09whZj5T12c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sk6j8uu3Q/Oe1JCHsiJcuDymo2RtLcpt9CJdjZVGegPU00wnb2LLL6cuKfUatgvsVt1pATytOC7F0R2X6FtWh/Koqm0FvrnMyTCe7B+jLNCCni7voz9VlNugqXolH8eX2+ntibJqJrVWlVrP5yuecTPCLphxt27r3/kJtY02X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656bc3a7ab3so7807158eaf.2
        for <linux-wpan@vger.kernel.org>; Fri, 09 Jan 2026 23:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768031843; x=1768636643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CKtBPBJN1VTx68R0gwqmuLhPZDrkNKJvv91rwrlpCo=;
        b=ZG3sRG139c0epBM4FpoHpRD9AAG4XpW6BDqH+S0cZKBijK1ZYzkU+cO7r6UD0SjgC9
         jmaI2sonD77d9hpG54PppkVtpueUxzpomNZIblfBHbftmZ/N0tfdt63t0ptk5xpnlx8n
         VNffFgLe8xqw7FCUkiingC9kM5RqTyivOLO5G8tJ0KjefdAuyyd3oG96CHVhFEMQBbjE
         YDlw2KITgcxkv2NgDZ1tjVEoGstvh6LfT3tpa2tmn9OkGJPNwoAMFKjcQLdAQ4jim6/S
         tfEAlAvfWjcHJFFQRZWr82vWJuNaMBk6ELuc5TEPbjErH73FrbHcxPzUONI3LJmj0had
         6qmg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Euk6kt/MRxG68Jva1hVt9dbJMVoARnFKt0KlAdkAYtaPk+27MSLpocCSwD4J9QmqgIex3z9z8PPy@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVwXtKavGplOa5xwIUZYBye2YAsV+SuTZXVYJNuWvIXuFCYl7
	ExOHu1GYHdND9EnovKCx1kyDKH+z/P46p6q4mzsM7wK5lq8U0kU5X1YAdA/0ORqmzA2HkeSRs0m
	yGFky2z9q+BqrG3rKZOl5fr4qAfm/g6SAPbBIG06+giSmSK51BJBaCBteFHo=
X-Google-Smtp-Source: AGHT+IFV6oKsA0A7FaYkdn6rV3ubNp1bX5cU2VXgLQFjSxzbv5Z6HCxOfk/kOVuBmtsmjglj1wTg9fXlG38rjl0dacUZT0U6Hlij
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6388:b0:65f:69f7:d0ed with SMTP id
 006d021491bc7-65f69f7d735mr1654899eaf.83.1768031842995; Fri, 09 Jan 2026
 23:57:22 -0800 (PST)
Date: Fri, 09 Jan 2026 23:57:22 -0800
In-Reply-To: <685b0ae5.a00a0220.2e5631.009a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69620662.050a0220.eaf7.0002.GAE@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in lowpan_xmit (2)
From: syzbot <syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    372800cb95a3 Merge tag 'for-6.19-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139e9922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bfa57a8c0ab3aa8
dashboard link: https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140649fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d4d19a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95aaef1a6aac/disk-372800cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b81de4f4247/vmlinux-372800cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98061453c05e/bzImage-372800cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
------------[ cut here ]------------
WARNING: ./include/linux/skbuff.h:3227 at skb_network_header_len include/linux/skbuff.h:3227 [inline], CPU#1: aoe_tx0/1301
WARNING: ./include/linux/skbuff.h:3227 at lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline], CPU#1: aoe_tx0/1301
WARNING: ./include/linux/skbuff.h:3227 at lowpan_xmit+0xea9/0x1210 net/ieee802154/6lowpan/tx.c:282, CPU#1: aoe_tx0/1301
Modules linked in:
CPU: 1 UID: 0 PID: 1301 Comm: aoe_tx0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:skb_network_header_len include/linux/skbuff.h:3227 [inline]
RIP: 0010:lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
RIP: 0010:lowpan_xmit+0xea9/0x1210 net/ieee802154/6lowpan/tx.c:282
Code: ff ff 4c 89 ff 48 01 81 38 02 00 00 e8 30 d8 0f fe e9 e6 fb ff ff e8 46 a3 8f f6 90 0f 0b 90 e9 a3 f5 ff ff e8 38 a3 8f f6 90 <0f> 0b 90 e9 86 f6 ff ff e8 2a a3 8f f6 0f b7 8d e0 fe ff ff 44 8b
RSP: 0018:ffffc9000476f860 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000476f8e0 RCX: ffffffff8b2ebe6c
RDX: ffff888028a3bd00 RSI: ffffffff8b2ec7e8 RDI: 0000000000000003
RBP: ffffc9000476f9f0 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000000 R12: ffff88801d79a476
R13: 000000000000ffff R14: ffff888028234d90 R15: ffff88801d79a3c0
FS:  0000000000000000(0000) GS:ffff8881249fa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c007868000 CR3: 0000000071880000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5273 [inline]
 netdev_start_xmit include/linux/netdevice.h:5282 [inline]
 xmit_one net/core/dev.c:3853 [inline]
 dev_hard_start_xmit+0x97/0x6e0 net/core/dev.c:3869
 __dev_queue_xmit+0x6d7/0x46b0 net/core/dev.c:4819
 dev_queue_xmit include/linux/netdevice.h:3381 [inline]
 tx+0xcc/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1e4/0x3e0 drivers/block/aoe/aoecmd.c:1241
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
