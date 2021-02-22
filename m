Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC932C433E0
	for <linux-wpan@archiver.kernel.org>; Mon, 22 Feb 2021 09:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF4564E5F
	for <linux-wpan@archiver.kernel.org>; Mon, 22 Feb 2021 09:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBVJp4 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:45:56 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47860 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBVJpC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Feb 2021 04:45:02 -0500
Received: by mail-il1-f199.google.com with SMTP id y12so7235508ilu.14
        for <linux-wpan@vger.kernel.org>; Mon, 22 Feb 2021 01:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XCLqp0FZYYz6SZnHZ7vg7/2+XZHTd7UxQv+c9wa+DxE=;
        b=giuAecVzgGcGJ9XgzrKhmwMD8PZcMR73azlJU+O9Yx84wMefsXrUUNCOjVEW81LWVa
         Nv7q9P0wYu5+UkV7Y8FdB0QRqw8GJPrC/kJNwIUfUzSJVvWT7n+x6AZ+0MYRmOZQjXaP
         XZetpKF9sgvMIl4zarvI64AR7ZhAz+IJLQ20ZepGpTkPuN2C5dvO8ccCw79TmdI2FOCh
         SF3trIoiqj8FaKFLeDqIvrogG3feu8dB3Wt3XwwfFoKSWo1lQhUeq4RQLLH43zUgEMdy
         BIbpzg2nwTesGeS+FYXp6wF6z9PUo34e4a1wlGfg4JRlT8PclO3yiY7Ou0a1C5mzyabU
         rYnw==
X-Gm-Message-State: AOAM5312ybBdBsNWeH+RY1erN8doTpIHzzx5LNcQdGwxSKxCqPg7du2b
        dULdKOlfMi/xTWrWpj7mNc2x539d3U16y5PGlUx+1mMPSAb3
X-Google-Smtp-Source: ABdhPJzHQbci+nThI3zq4iMnVTUglKLg7dqCF3uQyy8p2h0rTEbWuOPBz+71xmzO6JaRiZcZxJIrQYROtHoKn1JAAawaG+Tlupfd
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3319:: with SMTP id b25mr7279174ioz.54.1613987061148;
 Mon, 22 Feb 2021 01:44:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:44:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073afff05bbe9a54d@google.com>
Subject: WARNING in ieee802154_del_seclevel
From:   syzbot <syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com>
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

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1032cfacd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67894355b1dbeb07
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf4fc11a819824e027b
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 18095 at kernel/locking/mutex.c:938 __mutex_lock_common kernel/locking/mutex.c:938 [inline]
WARNING: CPU: 0 PID: 18095 at kernel/locking/mutex.c:938 __mutex_lock+0x428/0x99c kernel/locking/mutex.c:1103
Modules linked in:
CPU: 0 PID: 18095 Comm: syz-executor.1 Not tainted 5.11.0-syzkaller #0
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : __mutex_lock_common kernel/locking/mutex.c:938 [inline]
pc : __mutex_lock+0x428/0x99c kernel/locking/mutex.c:1103
lr : __mutex_lock_common kernel/locking/mutex.c:938 [inline]
lr : __mutex_lock+0x428/0x99c kernel/locking/mutex.c:1103
sp : ffff00003ce07150
x29: ffff00003ce07150 x28: ffff80001aa29cc0 
x27: ffff80001ba7e000 x26: ffff800019180000 
x25: 0000000000000000 x24: 0000000000000000 
x23: ffff8000167ed574 x22: 0000000000000002 
x21: ffff800016b3d720 x20: 1fffe000079c0e3a 
x19: ffff000032e08c90 x18: 0000000000000001 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000000 x14: 0000000000000000 
x13: 0000000000000000 x12: ffff60000d44eb84 
x11: 1fffe0000d44eb83 x10: ffff60000d44eb83 
x9 : dfff800000000000 x8 : ffff00006a275c1b 
x7 : 0000000000000001 x6 : 00009ffff2bb147d 
x5 : ffff00006a275c18 x4 : 1fffe00001ec5001 
x3 : dfff800000000000 x2 : 0000000000000000 
x1 : 0000000000000000 x0 : ffff00000f628000 
Call trace:
 __mutex_lock_common kernel/locking/mutex.c:938 [inline]
 __mutex_lock+0x428/0x99c kernel/locking/mutex.c:1103
 mutex_lock_nested+0x78/0x100 kernel/locking/mutex.c:1118
 ieee802154_del_seclevel+0x44/0x84 net/mac802154/cfg.c:382
 rdev_del_seclevel net/ieee802154/rdev-ops.h:284 [inline]
 nl802154_del_llsec_seclevel+0x14c/0x200 net/ieee802154/nl802154.c:2093
 genl_family_rcv_msg_doit+0x1b8/0x2a0 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x24c/0x430 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x198/0x34c net/netlink/af_netlink.c:2494
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x3e0/0x670 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x610/0xa20 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xc0/0xf4 net/socket.c:672
 ____sys_sendmsg+0x548/0x6d0 net/socket.c:2345
 ___sys_sendmsg+0xf4/0x170 net/socket.c:2399
 __sys_sendmsg+0xbc/0x14c net/socket.c:2432
 __compat_sys_sendmsg net/compat.c:347 [inline]
 __do_compat_sys_sendmsg net/compat.c:354 [inline]
 __se_compat_sys_sendmsg net/compat.c:351 [inline]
 __arm64_compat_sys_sendmsg+0x74/0xac net/compat.c:351
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
