Return-Path: <SRS0=YPtx=AI=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDBC433DF
	for <linux-wpan@archiver.kernel.org>; Sat, 27 Jun 2020 07:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A767A2080C
	for <linux-wpan@archiver.kernel.org>; Sat, 27 Jun 2020 07:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgF0HRO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:17:14 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43106 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0HRN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 27 Jun 2020 03:17:13 -0400
Received: by mail-io1-f70.google.com with SMTP id f13so4889024iok.10
        for <linux-wpan@vger.kernel.org>; Sat, 27 Jun 2020 00:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IsMH+mXeozfn9dfFmwoLPcz9puu1DMjtE0f+O1IgldQ=;
        b=nvRrs+/S9zu5bcUMm6DUTdMv9c73e154L8aHzFRZNQw7CUQ5Po0zyUuSrAQ2O3LgOO
         LgC+K1pZUn+LIRzKpQlLYuJIEurL02Z9kP7MrWlfq0LLZ+tloEVDhw+EQCuM9ghhJgHr
         4E1ObHAKOVOEw3wUuJUgp2lyrWLnuSix8aK0/WW4SnA7PMPCfGSU7B5q528o3g5NDvTB
         eLIRqNQeDHFCPQMsrfLPNtFhSJe3PoCVZpiBawkf8i3BmY4mIyRR+J29I8VchGkAmBtR
         RBJTRWyoJrF9RcaJ71bfHqHXZHFodHCS5OzUlc9t1rfcMgY28c6u7RYu1/g0CBpXPml8
         Msog==
X-Gm-Message-State: AOAM531LSoScGUFdZnXnOh7zLL6SiNIqutn/KzdKnlzbfE+E1J7b+CWQ
        nxp00IPjLZEdXgH2MNb7tRahy82x9vHSL1f4+QbMY7A2PgID
X-Google-Smtp-Source: ABdhPJwKhI2xCErDjvcakGLd7G8m7X+MVGs3aP4wfTV4QSW0Zb2ZKsqysJOEwh4Ny9JtbJzQb/K8+ZiLzqGktDLG29BrbwbwWQG0
MIME-Version: 1.0
X-Received: by 2002:a5d:8516:: with SMTP id q22mr7332943ion.130.1593242232128;
 Sat, 27 Jun 2020 00:17:12 -0700 (PDT)
Date:   Sat, 27 Jun 2020 00:17:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000498aa905a90b9dd0@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in __cfg8NUM_wpan_dev_from_attrs
From:   syzbot <syzbot+b108a9b0cf438a20f4f8@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7a64135f libbpf: Adjust SEC short cut for expected attach ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1365a5c5100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc6334acae363d4
dashboard link: https://syzkaller.appspot.com/bug?extid=b108a9b0cf438a20f4f8
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b108a9b0cf438a20f4f8@syzkaller.appspotmail.com

netlink: 26 bytes leftover after parsing attributes in process `syz-executor.5'.
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in nla_get_u32 include/net/netlink.h:1541 [inline]
BUG: KASAN: vmalloc-out-of-bounds in __cfg802154_wpan_dev_from_attrs+0x4b4/0x510 net/ieee802154/nl802154.c:53
Read of size 4 at addr ffffc90001ad9018 by task syz-executor.5/31529

CPU: 1 PID: 31529 Comm: syz-executor.5 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 nla_get_u32 include/net/netlink.h:1541 [inline]
 __cfg802154_wpan_dev_from_attrs+0x4b4/0x510 net/ieee802154/nl802154.c:53
 nl802154_prepare_wpan_dev_dump.constprop.0+0xf9/0x490 net/ieee802154/nl802154.c:245
 nl802154_dump_llsec_dev+0xc0/0xb10 net/ieee802154/nl802154.c:1655
 genl_lock_dumpit+0x7f/0xb0 net/netlink/genetlink.c:575
 netlink_dump+0x4cd/0xf60 net/netlink/af_netlink.c:2245
 __netlink_dump_start+0x643/0x900 net/netlink/af_netlink.c:2353
 genl_family_rcv_msg_dumpit+0x2ac/0x310 net/netlink/genetlink.c:638
 genl_family_rcv_msg net/netlink/genetlink.c:733 [inline]
 genl_rcv_msg+0x797/0x9e0 net/netlink/genetlink.c:753
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:764
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb19
Code: Bad RIP value.
RSP: 002b:00007ff9558abc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000502400 RCX: 000000000045cb19
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a38 R14: 00000000004cd1fc R15: 00007ff9558ac6d4


Memory state around the buggy address:
 ffffc90001ad8f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90001ad8f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90001ad9000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                            ^
 ffffc90001ad9080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90001ad9100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
