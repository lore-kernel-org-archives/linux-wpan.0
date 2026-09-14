Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EC40DB33
	for <linux-wpan@vger.kernel.org>; Mon, 14 Sep 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379859; cv=none; b=Gvax+U8HI+Z6OWDxUL47S0lFxqynI22Nvg/vg8Bp4kGCpmEHkqBHvisG1Bewiz+W4737kzoDXGJ7PtAHs7CtOeK0ifu6ePhHnTTzdP2t4iURl1kaOv3uLnw0JEf+FlmE2hmDLYzVFB6dFCQ0A2AIStFCi46t8W7gBfZD+W35zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379859; c=relaxed/simple;
	bh=3qiAnH7OuYwzpG0yK4SgScObKktr+6Jrd70bQk5EbQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o/q1OgDU6BDYh2w27atpnIeqluB2U0/rfsaMhAsNwV99BrXRnUGbcfGboY57zKs6z3CNFfbjakHgbfhGdC7DN974L0WAWXg4WVjhqemKLhzRfiHfT/bpqpUt/uguIcQ/mGcb+frdXMliy485IJaQntngSqL3Gcg8vB9I0yK0mD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so1445667fac.1
        for <linux-wpan@vger.kernel.org>; Mon, 14 Sep 2026 02:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379857; x=1789984657;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6oIk7l4eRnUyhdSeBU9s1lynDeZBJ7umO0EhfBWYFk=;
        b=RV7iPgrPPbV85fXUWyu2BuTfFAbpqOAgj7b6DgBWJSWaCHOYLFRGT19kDRxBawPNoY
         BCqpzWp5N+59nLxjn3owpJhdJi8I/eP0jrN+lglOiVDLNBqS3jV6n0ExPSwybt6RidV9
         gz90D97wKk4i9mlNkLvMDlKa00xFmGKQutwV+Z5InacaCcqb6hx7RKHX44JY461v3Qpn
         wUn9B6BQrWWIX5RMRUU5KBB0ujfEFnE/6fJKTUuwj9EeOOhnYxDXJbBY9sACDHpC22xw
         FX/zCcdh6CMCALO3YIdUozpX9sT0HEEOc1eIt50fQv2HXKy71YuHYMZj77osOZ7NFJ4S
         uf2g==
X-Forwarded-Encrypted: i=1; AKwUvBx3Oe+LIOUvwR4r4G+CsG+RlWVMs97L/UacpntPtRVb8RVWomxbzC1qkMjTwpmJr4BqOMiSwEGTjhts@vger.kernel.org
X-Gm-Message-State: AFuF++mJk215FnfWXtHEQjpECRkC9fCVZ9odXBoLU3eSTyNzgAzDl4fO
	0yN7Bz++WsolDiBLiG5e5JoFgd8rtMRyJtgXJPn6UGMYWne4qTCXtdmTWGO9BfNQF0kGGe97is0
	ZU7u9OTUMo6ji651RDvprEJuRvAMLhmYuEFnuBSFYW8huJQ1Sso2uMdyGK4I=
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1988:b0:6c1:fd93:5292 with SMTP id
 006d021491bc7-6c541d3ff08mr1639726eaf.17.1789379856953; Mon, 14 Sep 2026
 02:57:36 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:57:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa7c510.4c28b7d0.c1bba.0017.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING in hwsim_hw_xmit
From: syzbot <syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd73f4a66598 Linux 7.3-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15319905580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=adb0bf16414b8bb2d799
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bdb0f533e9/disk-fd73f4a6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8afef97d54e/vmlinux-fd73f4a6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5ec38325318/bzImage-fd73f4a6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adb0bf16414b8bb2d799@syzkaller.appspotmail.com

------------[ cut here ]------------
current_phy->suspended
WARNING: drivers/net/ieee802154/mac802154_hwsim.c:266 at hwsim_hw_xmit+0x1606/0x1630 drivers/net/ieee802154/mac802154_hwsim.c:266, CPU#0: syz.5.2158/11621
Modules linked in:
CPU: 0 UID: 0 PID: 11621 Comm: syz.5.2158 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/08/2026
RIP: 0010:hwsim_hw_xmit+0x1606/0x1630 drivers/net/ieee802154/mac802154_hwsim.c:266
Code: c6 05 af 7a e6 08 01 48 c7 c7 a0 ae 0c 8c be 0d 01 00 00 48 c7 c2 40 af 0c 8c e8 15 fe ec fa e9 e8 eb ff ff e8 4b 78 11 fb 90 <0f> 0b 90 e9 d2 ea ff ff 89 d9 80 e1 07 38 c1 0f 8c b7 ea ff ff 48
RSP: 0018:ffffc90004a07280 EFLAGS: 00010283
RAX: ffffffff86b51de5 RBX: ffff88802592d018 RCX: 0000000000080000
RDX: ffffc9001660b000 RSI: 00000000000001b2 RDI: 00000000000001b3
RBP: ffffc90004a073f8 R08: ffff88802592c823 R09: 1ffff11004b25904
R10: dffffc0000000000 R11: ffffffff86b507e0 R12: dffffc0000000000
R13: ffff88802592c900 R14: ffff88802592cf80 R15: 1ffff11004b25920
FS:  00007f56c49766c0(0000) GS:ffff888125bcb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d91fff8 CR3: 000000004052a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 drv_xmit_async net/mac802154/driver-ops.h:16 [inline]
 ieee802154_tx+0x26d/0x510 net/mac802154/tx.c:89
 ieee802154_hot_tx net/mac802154/tx.c:207 [inline]
 ieee802154_subif_start_xmit+0x110/0x190 net/mac802154/tx.c:239
 __netdev_start_xmit include/linux/netdevice.h:5429 [inline]
 netdev_start_xmit include/linux/netdevice.h:5438 [inline]
 xmit_one net/core/dev.c:3937 [inline]
 dev_hard_start_xmit+0x2df/0x870 net/core/dev.c:3953
 sch_direct_xmit+0x257/0x4c0 net/sched/sch_generic.c:372
 __dev_xmit_skb net/core/dev.c:4262 [inline]
 __dev_queue_xmit+0x16ce/0x3880 net/core/dev.c:4884
 dev_queue_xmit include/linux/netdevice.h:3461 [inline]
 raw_sendmsg+0x4a2/0x9c0 net/ieee802154/socket.c:299
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x565/0x870 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56c671e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56c4976028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f56c69a5fa0 RCX: 00007f56c671e159
RDX: 0000000024004014 RSI: 0000200000000080 RDI: 0000000000000005
RBP: 00007f56c67b503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f56c69a6038 R14: 00007f56c69a5fa0 R15: 00007ffd99396d38
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
