Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3344C433E6
	for <linux-wpan@archiver.kernel.org>; Mon,  8 Mar 2021 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AEF6518A
	for <linux-wpan@archiver.kernel.org>; Mon,  8 Mar 2021 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCHSV1 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:21:27 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45644 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCHSVU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Mar 2021 13:21:20 -0500
Received: by mail-io1-f69.google.com with SMTP id u1so8247966ior.12
        for <linux-wpan@vger.kernel.org>; Mon, 08 Mar 2021 10:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hEl/gcxr+ooZyCOqOKEktEWndl9iI87D4ZPiueI+7DY=;
        b=f48HM0Xw03de6jWWCpNywLjvSYIVjLhol62b45AJe3P3FOabEiQKvpIGpp9eeDwL4e
         6hLb/C85olp3OVTFgtNHGm2NyY8uppaUs9yl7rXRfHgkV/7YyluDH3AgG8n28OsZyCcL
         m1Eh52w+oGX0eNu3dHimO4BFIUM4WtlHJbQ9VxoSLJDwNUfjtdYX+BRP1HiaTaRHhIJs
         Ulh2eezhqKMJJhFPJ4cBnFlV8/XruotdEnEY8H8kr60Jgo6OxHrizvDoJOWrDEw/qjup
         vQAhBc033Om44vbtYPHQBWmrOK2NwjjF6yixJCbp8xDA2KUalD6sUTwyCBsm13s0MRFK
         z0NA==
X-Gm-Message-State: AOAM532ctF3C11TO9GVTBkLzvsk9/efUAKlVU8AZkEkChzake/mBn8vN
        kVcloWATLmWrIIs7dcBUYQeYUAFuLlPict3p51AfJ+gI4DJT
X-Google-Smtp-Source: ABdhPJyMIuKYgOz8o5gvwVFLh1s4QvpJJOd25bzXwE5w+JHG85UOSreJuWpPaYynsoFzQMGQgLMrCCmQ7cRS/5EHR2E59CO5tqwP
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1154:: with SMTP id o20mr21655098ill.236.1615227679763;
 Mon, 08 Mar 2021 10:21:19 -0800 (PST)
Date:   Mon, 08 Mar 2021 10:21:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015720b05bd0a80d9@google.com>
Subject: [syzbot] WARNING in ieee802154_add_seclevel
From:   syzbot <syzbot+6630070762b727ca8ebb@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d310ec03 Merge tag 'perf-core-2021-02-17' of git://git.ker..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147866a2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e681d54870713a40
dashboard link: https://syzkaller.appspot.com/bug?extid=6630070762b727ca8ebb

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6630070762b727ca8ebb@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 14622 at kernel/locking/mutex.c:928 __mutex_lock_common kernel/locking/mutex.c:928 [inline]
WARNING: CPU: 1 PID: 14622 at kernel/locking/mutex.c:928 __mutex_lock+0xc0b/0x1120 kernel/locking/mutex.c:1093
Modules linked in:
CPU: 1 PID: 14622 Comm: syz-executor.2 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:928 [inline]
RIP: 0010:__mutex_lock+0xc0b/0x1120 kernel/locking/mutex.c:1093
Code: 08 84 d2 0f 85 a3 04 00 00 8b 05 c8 90 c2 04 85 c0 0f 85 12 f5 ff ff 48 c7 c6 40 9b 6b 89 48 c7 c7 00 99 6b 89 e8 17 2a bd ff <0f> 0b e9 f8 f4 ff ff 65 48 8b 1c 25 00 f0 01 00 be 08 00 00 00 48
RSP: 0018:ffffc9000940f400 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815b4c85 RDI: fffff52001281e72
RBP: ffff88807aa18c50 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ade9e R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc9000940f5b0 R15: 0000000000000000
FS:  00007f6893111700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005627d0936188 CR3: 000000007933e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ieee802154_add_seclevel+0x3f/0x70 net/mac802154/cfg.c:367
 rdev_add_seclevel net/ieee802154/rdev-ops.h:276 [inline]
 nl802154_add_llsec_seclevel+0x194/0x230 net/ieee802154/nl802154.c:2077
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2348
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2402
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2435
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6893111188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 0000000000465f69
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 000000000000000a
RBP: 00000000004bfa67 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffd15b1997f R14: 00007f6893111300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
