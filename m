Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504055;
	b=M/cjS5aMulh57zY0Y46bbbzp+ldA5lel9TmuDmT074SSekj1JKQ8OdSCEKVOTxU60pCR
	 rNPPweB0p+Z2zy3IDYBwfOFVJiqjSTwAesCzl6pynTPhvrpANW/kLFydP3rX654TTa7Im
	 kE/JyraATdfTup+6bwGV8cRYhOJuzU+99w4U6Kx37cE6JI1yk/CAIQtXmfpbPuxc7GOCc
	 ZUu42y7j6RskKg1yRLTAn+vwb4njJvJ/D+mYyqgbRJLpF0mXAd8Mf1940nCb03TgwmJwF
	 IE5kfJZTZUG9SvZKCEXSmfLmB0st02yPGUbZFlANFtnMPESO9WMWoiQu610pYhwQ1mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504055;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=Uk6HeYEyo2FP7r6+k7lA8Af1r3w/MyfSTl61Tnmm320=;
	b=UErJAA15VULEBHfkByk+tm6/R9fTBe8IVhVm+xMZX8GPfgwVAtR9eKrk+u7ZPSwAMZ8v
	 B+AEBXZ3rgSH5tfbdtzx1M4u8n+dKmqxSfDikK8GBk4tZKeibyoX13ucGw3kG02YtJZVn
	 WiGQ2Bb/NFNhTdtRrXC5d/knyD/zkIOHPAjz7xt+WJHhIs4w4YxehFJD1dnAN5alfyTNP
	 4nfoOyxt/DNo+fwk91adgIuELMqpmIcr8TKKdLl3A1QCIM07tW0KWVEyCyOiCpgrYm0UH
	 kAC6SqkjlMdZgH/fAM1eD67AQIHCvJnrgCG2Q/7b0oUXXx/7ZguJ5DMJrDzCR8gMuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A99606A331
	for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2026 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A99606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-851f7cdfaefso3995530a34.3
        for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2026 09:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504054; x=1795108854;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uk6HeYEyo2FP7r6+k7lA8Af1r3w/MyfSTl61Tnmm320=;
        b=balHMOH8T35adGnYnFzOdL2kaI7mp48UoOXtjcl1Uz/Y47S9AErD5woigOLUAAdccu
         Jn3ULFxK9uA6EeLhOY7mlhLNJVhPPRvwsyqwemKkMi3Z7M/tzHfBeM1vHL8QareNgjyY
         Iw2/GvRE+yYAuR9Tn7kSKc8JxNskTIdz3/4xcCNDyKF3K6ppL5cBdMjvuAyS0UGc5y1G
         ZAL3hsB+iDc+dhABu5or1m2WZeyBkjwKYU4CuZUhmLpv6xzpWQDl49tD1/p8eLb2ghRX
         LAk1QDw0kPqjyQTwjsxhH/w+bzI5SAX+QOXj7Luud/6JSlKa8+DGgClxNe2dZ2Sw3psI
         TcpQ==
X-Forwarded-Encrypted: i=1; AL+hErF71PZld9+XFEmVm8gBJ11bpHxNWJ9oNdbSWaVXGW6l/Al53jOgMQoWaW9Lnbk3k+YLUi2mogukO+nn@vger.kernel.org
X-Gm-Message-State: APuU4Z8AWQbSmu32/3sM4qbWNkswv2JIP5HAOZItuRZhmMNj0x/eA/eq
	mEpgjIdfGUI181+WMzuSXXj202KOltGTX2l2GVg20jiiofBvxhUQq0jNPbYbUWyyN2Hd8kDFgkc
	O6xFnPKTcur+wNuY5Tf5Bi5lLIhlR9fWIuDzgS9+TC2oPsjcOwfXUie3irig=
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3c47:b0:4c4:a240:9c3a with SMTP id
 5614622812f47-56b9325040amr5327684b6e.4.1794504054006; Thu, 12 Nov 2026
 09:20:54 -0800 (PST)
Date: Thu, 12 Nov 2026 09:20:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af5f575.b350cda4.2b6a63.0000.GAE@google.com>
Subject: [syzbot] [wpan?] KASAN: invalid-free in hwsim_update_pib
From: syzbot <syzbot+8a8482d4c33cc58babb4@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    793807ca13bf Add linux-next specific files for 20261110
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13724cad580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8005ef7c0a8a924b
dashboard link: https://syzkaller.appspot.com/bug?extid=8a8482d4c33cc58babb4
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b01a4e580000

AI-generated root cause summary:
In drivers/net/ieee802154/mac802154_hwsim.c, hwsim_del() frees the simulated
hardware's physical layer information base (phy->pib) via kfree_rcu() prior to
unregistering the hardware via ieee802154_unregister_hw(). During
ieee802154_unregister_hw(), slave network interfaces are closed, and an ongoing
scan is aborted through mac802154_slave_close() -> mac802154_abort_scan_locked()
-> drv_set_channel() -> hwsim_hw_channel(). hwsim_hw_channel() accesses the
already-queued phy->pib and calls hwsim_update_pib(), which invokes kfree_rcu()
on the exact same PIB object a second time, causing a double-free and
use-after-free.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=8a8482d4c33cc58babb4

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a8482d4c33cc58babb4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in kfree_rcu_sheaf mm/slab_common.c:1693 [inline]
BUG: KASAN: double-free in kvfree_call_rcu+0x9c/0x440 mm/slab_common.c:2056
Free of addr ffff888077e0ab80 by task syz-executor416/6057

CPU: 1 UID: 0 PID: 6057 Comm: syz-executor416 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation+0xbc/0xe0 mm/kasan/common.c:-1
 kasan_slab_pre_free include/linux/kasan.h:202 [inline]
 __kfree_rcu_sheaf+0x126/0x690 mm/slub.c:6299
 kfree_rcu_sheaf mm/slab_common.c:1693 [inline]
 kvfree_call_rcu+0x9c/0x440 mm/slab_common.c:2056
 hwsim_update_pib+0x276/0x400 drivers/net/ieee802154/mac802154_hwsim.c:119
 hwsim_hw_channel+0x178/0x2b0 drivers/net/ieee802154/mac802154_hwsim.c:131
 drv_set_channel+0xfe/0x280 net/mac802154/driver-ops.h:240
 mac802154_scan_cleanup_locked+0x116/0x280 net/mac802154/scan.c:72
 mac802154_abort_scan_locked+0xa3/0xe0 net/mac802154/scan.c:92
 mac802154_slave_close+0xc9/0x2e0 net/mac802154/iface.c:306
 __dev_close_many+0x361/0x6e0 net/core/dev.c:1836
 netif_close_many+0x249/0x660 net/core/dev.c:1862
 unregister_netdevice_many_notify+0x7aa/0x1dc0 net/core/dev.c:12729
 unregister_netdevice_many net/core/dev.c:12831 [inline]
 unregister_netdevice_queue+0x2f5/0x340 net/core/dev.c:12627
 unregister_netdevice include/linux/netdevice.h:3511 [inline]
 ieee802154_remove_interfaces+0x162/0x1a0 net/mac802154/iface.c:714
 ieee802154_unregister_hw+0x62/0xe0 net/mac802154/main.c:284
 hwsim_del+0x49c/0x500 drivers/net/ieee802154/mac802154_hwsim.c:1016
 hwsim_del_radio_nl+0x110/0x150 drivers/net/ieee802154/mac802154_hwsim.c:361
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2585
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1336 [inline]
 netlink_unicast+0x8ef/0xa80 net/netlink/af_netlink.c:1362
 netlink_sendmsg+0x7f0/0xb20 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2283
 __do_sys_sendto net/socket.c:2290 [inline]
 __se_sys_sendto net/socket.c:2286 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2286
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007f8868cf0b77
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffeb08d8fe0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055555ef33400 RCX: 00007f8868cf0b77
RDX: 000000000000001c RSI: 00007ffeb08d91e0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000032
R13: 00007ffeb08d9040 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 13:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 poison_kmalloc_redzone mm/kasan/common.c:412 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:267 [inline]
 __kmalloc_cache_noprof+0x31c/0x600 mm/slub.c:5678
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 hwsim_update_pib+0x7e/0x400 drivers/net/ieee802154/mac802154_hwsim.c:103
 hwsim_set_promiscuous_mode+0x196/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:326
 drv_set_promiscuous_mode+0x154/0x2d0 net/mac802154/driver-ops.h:127
 drv_start+0x4db/0x1000 net/mac802154/driver-ops.h:167
 mac802154_scan_worker+0x8e6/0xe60 net/mac802154/scan.c:248
 process_one_work kernel/workqueue.c:3511 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3594
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3675
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 __kasan_record_aux_stack+0xc5/0xe0 mm/kasan/generic.c:561
 __kfree_rcu_sheaf+0x136/0x690 mm/slub.c:6304
 kfree_rcu_sheaf mm/slab_common.c:1693 [inline]
 kvfree_call_rcu+0x9c/0x440 mm/slab_common.c:2056
 hwsim_del+0x476/0x500 drivers/net/ieee802154/mac802154_hwsim.c:1014
 hwsim_del_radio_nl+0x110/0x150 drivers/net/ieee802154/mac802154_hwsim.c:361
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2585
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1336 [inline]
 netlink_unicast+0x8ef/0xa80 net/netlink/af_netlink.c:1362
 netlink_sendmsg+0x7f0/0xb20 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2283
 __do_sys_sendto net/socket.c:2290 [inline]
 __se_sys_sendto net/socket.c:2286 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2286
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077e0ab80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 56-byte region [ffff888077e0ab80, ffff888077e0abb8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888077e0a000 pfn:0x77e0a
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813ff308c0 ffffea0001ee43d0 ffffea000086b9d0
raw: ffff888077e0a000 0000000000200019 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5010, tgid 5010 (udevd), ts 50265114608
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1880
 prep_new_page+0x22/0xb0 mm/page_alloc.c:1888
 get_page_from_freelist+0x22a1/0x22e0 mm/page_alloc.c:3970
 __alloc_frozen_pages_noprof+0x211/0x450 mm/page_alloc.c:5512
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3499
 new_slab mm/slub.c:3550 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7524
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4809
 alloc_from_pcs mm/slub.c:4885 [inline]
 slab_alloc_node mm/slub.c:5019 [inline]
 __do_kmalloc_node mm/slub.c:5528 [inline]
 __kmalloc_noprof+0x476/0x710 mm/slub.c:5554
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x2ad/0x570 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x5fd/0x640 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x229/0x470 security/tomoyo/file.c:776
 security_file_open+0xa9/0x240 security/security.c:2761
 do_dentry_open+0x495/0x1360 fs/open.c:977
 vfs_open_consume+0x4a/0x350 fs/open.c:1131
 do_open fs/namei.c:4851 [inline]
 path_openat+0x16fc/0x20f0 fs/namei.c:5016
 do_file_open+0x23e/0x4a0 fs/namei.c:5045
page last free pid 16 tgid 16 ts 50082662316 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1422 [inline]
 __free_frozen_pages+0xd1a/0xe10 mm/page_alloc.c:2978
 rcu_do_batch kernel/rcu/tree.c:2651 [inline]
 rcu_core+0x92e/0x1230 kernel/rcu/tree.c:2920
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1133
 smpboot_thread_fn+0x5f8/0xb30 kernel/smpboot.c:162
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888077e0aa80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888077e0ab00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888077e0ab80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                   ^
 ffff888077e0ac00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff888077e0ac80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


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
