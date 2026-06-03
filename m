Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979473A3816
	for <linux-wpan@vger.kernel.org>; Wed,  3 Jun 2026 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471656; cv=none; b=Ruu7yCWWiCU1HOJqARJHUWbXbzQdWBoF9SGzr80uOz9xMsbf2LLus/UT+H27ATHUXkis6YX93Tepi4FLnjUyOO2qmy//M37OE8a14e8icNjQYOI65+ZSmaFl1HmyWOJn21iKAKVSOXEz17G/ynzX2pifUntr4RiYs0ippfRaX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471656; c=relaxed/simple;
	bh=iSImYBRI7UBlesDbd2QGdqtdS5zqWMc/RbpuZaikRF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iRaIxx5TqZntt8GwoZXiaW1XuUpqdYrkqX8J4wNeBHOrXhTlrDqMc+8Mg6lzhC0Vhl5zukqIrRvmT2wzpoXqQOd5MwRpZRdjdPscouVsutHFtLlKCLkTOsiQvmnlY/IkyyZkYZQZD3CpT96C9Tp29iaA4YIVbJ6Q7rEljqlkZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69e4dadd880so349642eaf.3
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2026 00:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471651; x=1781076451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtrFMzo+uNmFnPibicXyTEkj5A/kWJ433kEg8stsr6k=;
        b=Zi8imWTVIyBd+N6b6u46UIYu5W7li5YET3K+qa4jCweZqesJLD4+Cjp3ezccKURbFI
         Ju4369TPn8FL3+U0xQIwF+p40MLzE/l4quwVrKi4McNj8wzLMlJx0qvXUydaxqf/64Wm
         f4qazBJqoFAPxyDSwlz5HwB/WsMFj6VYlqJPj/jwhikGNt6HCwsSXvjWgmyfP7rNA2Hn
         pK6VGN2Ua2J78svJ/OW4+by6TD7gWoH1kHPxlgU1nE4+cHuXVfeRhZrfy9p6lTEKYgqY
         c2pVARtOCyW0tyUGslsh5SzjTL1ZwcE+ha617SEWfewO0BO7jgzZU3jDPMSc8Kmlsr6b
         a3tA==
X-Forwarded-Encrypted: i=1; AFNElJ+q3DCh3mbsIOHRndI0Gro6ff0zemuZcA/mEK+vHhK6dv2bJeQ+xkYrakgRji61wb+VgqxeEZ48BN7V@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJgRbtq3EETM1mVVUC3GupYIn+Go7Bk7YL6IX43Qc8gGz3GHX
	8OxHDb/3KXV4xBouZPQSqWtBKlSQW93RSArrfHNPpHpOIiHWL6ihM2fPo+jGXjAlSXyYudzkY17
	NKU4YPxXyYJYGWO2hxUFZeo9x7sngz9T6bCkvvTm4rXFodmO5W6ujXl3cN9I=
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2c03:b0:69d:7bdb:ade2 with SMTP id
 006d021491bc7-69e47f76495mr867512eaf.32.1780471651515; Wed, 03 Jun 2026
 00:27:31 -0700 (PDT)
Date: Wed, 03 Jun 2026 00:27:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1fd763.278b5b03.2bcf39.0049.GAE@google.com>
Subject: [syzbot] [wpan?] KMSAN: uninit-value in lowpan_xmit
From: syzbot <syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8c2f9fdadee Merge tag 'for-7.1/hpfs-fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10883b06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91978e795dcd971b
dashboard link: https://syzkaller.appspot.com/bug?extid=f13c19f75e1097abd116
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d28568f6ffa/disk-e8c2f9fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68a9eec5e7f1/vmlinux-e8c2f9fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6a7381a5e55/bzImage-e8c2f9fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com

 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 tx+0xb6/0x440 drivers/block/aoe/aoenet.c:62
 kthread+0x17d/0x370 drivers/block/aoe/aoecmd.c:1241
 kthread+0x53a/0x5f0 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: uninit-value in lowpan_header net/ieee802154/6lowpan/tx.c:240 [inline]
BUG: KMSAN: uninit-value in lowpan_xmit+0xa6b/0x1d00 net/ieee802154/6lowpan/tx.c:282
 lowpan_header net/ieee802154/6lowpan/tx.c:240 [inline]
 lowpan_xmit+0xa6b/0x1d00 net/ieee802154/6lowpan/tx.c:282
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x22f/0xa80 net/core/dev.c:3904
 __dev_queue_xmit+0x2990/0x5a00 net/core/dev.c:4870
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 tx+0xb6/0x440 drivers/block/aoe/aoenet.c:62
 kthread+0x17d/0x370 drivers/block/aoe/aoecmd.c:1241
 kthread+0x53a/0x5f0 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 lowpan_header net/ieee802154/6lowpan/tx.c:231 [inline]
 lowpan_xmit+0x68f/0x1d00 net/ieee802154/6lowpan/tx.c:282
 __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
 netdev_start_xmit include/linux/netdevice.h:5377 [inline]
 xmit_one net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0x22f/0xa80 net/core/dev.c:3904
 __dev_queue_xmit+0x2990/0x5a00 net/core/dev.c:4870
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 tx+0xb6/0x440 drivers/block/aoe/aoenet.c:62
 kthread+0x17d/0x370 drivers/block/aoe/aoecmd.c:1241
 kthread+0x53a/0x5f0 kernel/kthread.c:436
 ret_from_fork+0x20f/0x8d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4577 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_node_noprof+0x3cd/0x12c0 mm/slub.c:4951
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x855/0x1190 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1383 [inline]
 new_skb+0x4a/0x550 drivers/block/aoe/aoecmd.c:66
 aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:430 [inline]
 aoecmd_cfg+0x2c2/0xb70 drivers/block/aoe/aoecmd.c:1374
 discover_timer+0x64/0x80 drivers/block/aoe/aoemain.c:25
 call_timer_fn+0x4c/0x510 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x80a/0xdb0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x3a/0x70 kernel/time/timer.c:2405
 handle_softirqs+0x171/0x7b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x9a/0x1e0 kernel/softirq.c:735
 irq_exit_rcu+0x12/0x20 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x84/0x90 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697

CPU: 0 UID: 0 PID: 1310 Comm: aoe_tx0 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


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
