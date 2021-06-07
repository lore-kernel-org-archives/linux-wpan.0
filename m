Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909AC47094
	for <linux-wpan@archiver.kernel.org>; Mon,  7 Jun 2021 15:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF29261029
	for <linux-wpan@archiver.kernel.org>; Mon,  7 Jun 2021 15:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFGPrM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:47:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34361 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFGPrM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Jun 2021 11:47:12 -0400
Received: by mail-io1-f70.google.com with SMTP id z8-20020a5e92480000b02904ae394676efso8727969iop.1
        for <linux-wpan@vger.kernel.org>; Mon, 07 Jun 2021 08:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vggOEuSYGh0DPtk53CZVVjPXOtkcKPmtX+CgwTmSW6g=;
        b=H6L4g5X7erLQENIiDhQ2Il50PqM4FQ88veKGMuoQPhuqj44r1QjavD8TAGtcZ8memV
         i/j6tFtBV8f46YFjUt44BVJE/zpL/TTqVHBU8r7XK8uHKrS3FBy6hOCZ17t8MOXGuRvc
         AwvyO2+37l5QMy9RVBz12NHu5GopMUOLZV1FAqlknfdr/P3UaCR5moUzLKGzT+uM6WRN
         h+/fsx0pz7WF0ZzqPytnyQ5pnpeEEaZs08de7eBXWeOLS0LK5NX3NsG905aor4Qo7cUp
         32iAAYeOJ7PUmj2DoXCC6yBV15B8r0Smt5WtekzLdhzNuMX0w2H8C/9AtpykglU7NzOk
         n/6g==
X-Gm-Message-State: AOAM531rKBMjFdrO2uS4cWcX4UxWG35Qjn1xS9En5rJUmTF7ghH/dCvc
        /OvxBs7uVNG/db7HjLyF5LOB8wY+mpKNI/rYTay071uOX2SD
X-Google-Smtp-Source: ABdhPJzBjp1H1H5Rcq6hgUBBT5DH5nKDd6JV1aYFnIgk0t8alMMGkJhQlDag1SIR/5qmGXs7eZADVee/XppNy+FXAoyfGGlKKyUW
MIME-Version: 1.0
X-Received: by 2002:a02:445:: with SMTP id 66mr16613269jab.11.1623080720530;
 Mon, 07 Jun 2021 08:45:20 -0700 (PDT)
Date:   Mon, 07 Jun 2021 08:45:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca047005c42eedaf@google.com>
Subject: [syzbot] memory leak in hwsim_add_one
From:   syzbot <syzbot+b80c9959009a9325cdff@syzkaller.appspotmail.com>
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

HEAD commit:    9d32fa5d Merge tag 'net-5.13-rc5' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dee1bbd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de8efb0998945e75
dashboard link: https://syzkaller.appspot.com/bug?extid=b80c9959009a9325cdff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706bbb5d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d708afd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b80c9959009a9325cdff@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.19' (ECDSA) to the list of known hosts.
executing program
BUG: memory leak
unreferenced object 0xffff8881020ec480 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937719 (age 53.000s)
  hex dump (first 32 bytes):
    60 5d 7c 06 81 88 ff ff c0 17 65 04 81 88 ff ff  `]|.......e.....
    80 35 12 42 81 88 ff ff 80 35 12 42 81 88 ff ff  .5.B.....5.B....
  backtrace:
    [<ffffffff82b09f12>] kmalloc include/linux/slab.h:556 [inline]
    [<ffffffff82b09f12>] kzalloc include/linux/slab.h:686 [inline]
    [<ffffffff82b09f12>] hwsim_alloc_edge.constprop.0+0x22/0x80 drivers/net/ieee802154/mac802154_hwsim.c:385
    [<ffffffff82b0b0f3>] hwsim_subscribe_all_others drivers/net/ieee802154/mac802154_hwsim.c:709 [inline]
    [<ffffffff82b0b0f3>] hwsim_add_one+0x3b3/0x640 drivers/net/ieee802154/mac802154_hwsim.c:802
    [<ffffffff82b0b3c4>] hwsim_probe+0x44/0xd0 drivers/net/ieee802154/mac802154_hwsim.c:848
    [<ffffffff82628bf1>] platform_probe+0x81/0x120 drivers/base/platform.c:1447
    [<ffffffff82625679>] really_probe+0x159/0x500 drivers/base/dd.c:576
    [<ffffffff82625aab>] driver_probe_device+0x8b/0x100 drivers/base/dd.c:763
    [<ffffffff82626325>] device_driver_attach+0x105/0x110 drivers/base/dd.c:1039
    [<ffffffff826263d1>] __driver_attach drivers/base/dd.c:1117 [inline]
    [<ffffffff826263d1>] __driver_attach+0xa1/0x140 drivers/base/dd.c:1070
    [<ffffffff82622459>] bus_for_each_dev+0xa9/0x100 drivers/base/bus.c:305
    [<ffffffff826244e0>] bus_add_driver+0x160/0x280 drivers/base/bus.c:622
    [<ffffffff82627233>] driver_register+0xc3/0x150 drivers/base/driver.c:171
    [<ffffffff874fa3dc>] hwsim_init_module+0xae/0x107 drivers/net/ieee802154/mac802154_hwsim.c:899
    [<ffffffff81001083>] do_one_initcall+0x63/0x2e0 init/main.c:1249
    [<ffffffff87489873>] do_initcall_level init/main.c:1322 [inline]
    [<ffffffff87489873>] do_initcalls init/main.c:1338 [inline]
    [<ffffffff87489873>] do_basic_setup init/main.c:1358 [inline]
    [<ffffffff87489873>] kernel_init_freeable+0x1f4/0x26e init/main.c:1560
    [<ffffffff84359255>] kernel_init+0xc/0x1a7 init/main.c:1447
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff8881046517c0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294937719 (age 53.000s)
  hex dump (first 32 bytes):
    ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82b09f35>] kmalloc include/linux/slab.h:556 [inline]
    [<ffffffff82b09f35>] kzalloc include/linux/slab.h:686 [inline]
    [<ffffffff82b09f35>] hwsim_alloc_edge.constprop.0+0x45/0x80 drivers/net/ieee802154/mac802154_hwsim.c:389
    [<ffffffff82b0b0f3>] hwsim_subscribe_all_others drivers/net/ieee802154/mac802154_hwsim.c:709 [inline]
    [<ffffffff82b0b0f3>] hwsim_add_one+0x3b3/0x640 drivers/net/ieee802154/mac802154_hwsim.c:802
    [<ffffffff82b0b3c4>] hwsim_probe+0x44/0xd0 drivers/net/ieee802154/mac802154_hwsim.c:848
    [<ffffffff82628bf1>] platform_probe+0x81/0x120 drivers/base/platform.c:1447
    [<ffffffff82625679>] really_probe+0x159/0x500 drivers/base/dd.c:576
    [<ffffffff82625aab>] driver_probe_device+0x8b/0x100 drivers/base/dd.c:763
    [<ffffffff82626325>] device_driver_attach+0x105/0x110 drivers/base/dd.c:1039
    [<ffffffff826263d1>] __driver_attach drivers/base/dd.c:1117 [inline]
    [<ffffffff826263d1>] __driver_attach+0xa1/0x140 drivers/base/dd.c:1070
    [<ffffffff82622459>] bus_for_each_dev+0xa9/0x100 drivers/base/bus.c:305
    [<ffffffff826244e0>] bus_add_driver+0x160/0x280 drivers/base/bus.c:622
    [<ffffffff82627233>] driver_register+0xc3/0x150 drivers/base/driver.c:171
    [<ffffffff874fa3dc>] hwsim_init_module+0xae/0x107 drivers/net/ieee802154/mac802154_hwsim.c:899
    [<ffffffff81001083>] do_one_initcall+0x63/0x2e0 init/main.c:1249
    [<ffffffff87489873>] do_initcall_level init/main.c:1322 [inline]
    [<ffffffff87489873>] do_initcalls init/main.c:1338 [inline]
    [<ffffffff87489873>] do_basic_setup init/main.c:1358 [inline]
    [<ffffffff87489873>] kernel_init_freeable+0x1f4/0x26e init/main.c:1560
    [<ffffffff84359255>] kernel_init+0xc/0x1a7 init/main.c:1447
    [<ffffffff810022ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
