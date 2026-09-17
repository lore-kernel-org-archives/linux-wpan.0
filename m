Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B73CFF53
	for <linux-wpan@vger.kernel.org>; Thu, 17 Sep 2026 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671932; cv=none; b=rg/uAigoXgmIEM2oF/pe1kkhdJmMsHtHwmo8x1cKss/GFEjz2qOwVpnkDfU4FjRtY2j1XzUZrlMxWbo5vdxj8n17V7DsqNAClI05MYs48z2oGD3eJCQv8a/zdnCuMId4PC7Zxk6brhRtQdn4wOaYAjYxbymrOwqxKjGJ8w+ni/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671932; c=relaxed/simple;
	bh=NFC6A1PqQ0KTK08j7X2WsHo8KiPkcsZRIJtjp7H7XGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gF/JAswYMkCyhsuwxBkNvIkHG61AGNOxB22VefTo3kJRrtR3thPoZYPHOcnT21/EXS3cCs5SZ8MxNpCvi7D/t/qdbgs2GvZNBFgH37lhqDKmOyPTTh4roQhzGT/FGnDrwec1TK3d9pabRerOv5w2F/HT+iMUh3W11llWBlqinQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b28dafb8e1so17953b6e.2
        for <linux-wpan@vger.kernel.org>; Thu, 17 Sep 2026 12:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671929; x=1790276729;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p5qDeDiQvi7JB3lCbbE8oeHw7QmOFls+FtasUuSp6mg=;
        b=GwTxHiSPmfZais8thAlqhPpzTolWgXz4nM4KfuhXNfTIW/bgh+wmH2k98Qem0jAjiP
         Z2bT3oqHZ1VVM6xd4T9pY/EQ0bPimVihFJrkUWRyA7XCo5wvfeyqULFPruas6o5jH8Ha
         DDdAASm4sK4rlhbYbhRF1R6z24H8+ZDKOIvq6jZYT3Vshtm9I7HYjA79V/5QQrwZUBct
         /Vhab7va9NeOXRB+c/AzkteQyRLGmXSbMFds0PizP0eVRZHm5uqqFNEnRO24L2GGIIYU
         /fD2aOZkxNroQJ+6gCOUfY4rsN03HnpTdGYhN3TMavnGnYfnqmOe6GnrDxF4RUrp5Ku8
         FdfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBsa0hmhmjHoRKyFSy3xX+K+OvbW6ZI6tt7fZVjHUN4s0Sba6LFH+ucYRWmlU1Pu1yEy66c8dDEpTB@vger.kernel.org
X-Gm-Message-State: AFuF++kqpp/3iyu+RJvHTx3FT2XBc5DucFY9ZLOd9/ddHE9CHYASOX+4
	s07piYoKwHuTMI8sLL9sbIaE/vMNxeglYOdJOASJ5rU166reVr4elsYLauYiupE53FJ8yMWWGyT
	Juvf9rYdRYbvqzK8n7j9R+kKg5UepJGsPP520UMa94k2PTUk6VgSMzW/8SxY=
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c18b:b0:4a3:3108:866a with SMTP id
 5614622812f47-4ccf6b742dbmr231447b6e.17.1789671929698; Thu, 17 Sep 2026
 12:05:29 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:05:29 -0700
In-Reply-To: <6aa7c510.4c28b7d0.c1bba.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aac39f9.71f81b7d.278072.0020.GAE@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in hwsim_hw_xmit
From: syzbot <syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4982d3552a3b Merge tag 'sound-7.3-rc4' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158afbf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=adb0bf16414b8bb2d799
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa7bf9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com

------------[ cut here ]------------
current_phy->suspended
WARNING: drivers/net/ieee802154/mac802154_hwsim.c:266 at hwsim_hw_xmit+0xcbf/0x1540 drivers/net/ieee802154/mac802154_hwsim.c:266, CPU#0: syz-executor682/6038
Modules linked in:
CPU: 0 UID: 0 PID: 6038 Comm: syz-executor682 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:hwsim_hw_xmit+0xcbf/0x1540 drivers/net/ieee802154/mac802154_hwsim.c:266
Code: 48 c7 c2 40 3f c0 8c be 52 03 00 00 48 c7 c7 a0 3f c0 8c c6 05 8f 23 c6 09 01 e8 7c 1b 80 fa e9 c6 f8 ff ff e8 52 5a a5 fa 90 <0f> 0b 90 e9 11 f4 ff ff e8 44 5a a5 fa e8 1f 0a 89 fa 31 ff 89 c5
RSP: 0018:ffffc90003a0f650 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802a808d20 RCX: 0000000000000202
RDX: ffff8880295e8000 RSI: ffffffff8766c55e RDI: ffff8880295e8000
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8766b8a0
R13: 1ffff92000741ed4 R14: ffff88802a808720 R15: 0000000000000053
FS:  00007f554300f6c0(0000) GS:ffff8880d5b59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f554300eff8 CR3: 0000000022b9e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drv_xmit_async net/mac802154/driver-ops.h:16 [inline]
 ieee802154_tx.isra.0+0x29f/0x570 net/mac802154/tx.c:89
 ieee802154_subif_start_xmit+0xc8/0xf0 net/mac802154/tx.c:239
 __netdev_start_xmit include/linux/netdevice.h:5429 [inline]
 netdev_start_xmit include/linux/netdevice.h:5438 [inline]
 xmit_one net/core/dev.c:3937 [inline]
 dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3953
 sch_direct_xmit+0x1b2/0xc70 net/sched/sch_generic.c:372
 qdisc_restart net/sched/sch_generic.c:437 [inline]
 __qdisc_run+0x52d/0x1b20 net/sched/sch_generic.c:445
 qdisc_run include/net/pkt_sched.h:121 [inline]
 qdisc_run include/net/pkt_sched.h:118 [inline]
 __dev_xmit_skb net/core/dev.c:4272 [inline]
 __dev_queue_xmit+0x18b9/0x4970 net/core/dev.c:4884
 dev_queue_xmit include/linux/netdevice.h:3461 [inline]
 dgram_sendmsg+0xa0d/0xf50 net/ieee802154/socket.c:689
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f554306749e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f554300f168 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f554300f6c0 RCX: 00007f554306749e
RDX: 0000000000000040 RSI: 00007f554300f1d0 RDI: 0000000000000004
RBP: 0000000000000021 R08: 00007f55430e5b10 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 000000000000000b R14: 00007ffdf0e50d30 R15: 00007ffdf0e50e18
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
