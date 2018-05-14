Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:41548 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeENMQ1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 May 2018 08:16:27 -0400
Received: by mail-qk0-f176.google.com with SMTP id d125-v6so9727384qkb.8
        for <linux-wpan@vger.kernel.org>; Mon, 14 May 2018 05:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKyrCQUJWq8aOMskFkr3FJF3Kgt2mKz5tsMCYH7PKqNawybJnA@mail.gmail.com>
References: <CAKyrCQUJWq8aOMskFkr3FJF3Kgt2mKz5tsMCYH7PKqNawybJnA@mail.gmail.com>
From: Roman Makhov <roman.makhov@gmail.com>
Date: Mon, 14 May 2018 15:16:26 +0300
Message-ID: <CAKyrCQV5KQ2zCZUMdHbodfwR-cYyEkeDtZUSPf-B_p+DAEFdUA@mail.gmail.com>
Subject: Fwd: Kernel panic on kernel-3.10.0-693.21.1.el7 in ndisc.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello,

We have a problem with Kernel panic after upgrade from CentOS 7.3
(kernel-3.10.0-514.el7) to CentOS 7.4 (kernel-3.10.0-693.21.1.el7).
It occurs when we have the incoming traffic from other nodes and we
are performing the re-configuration of IPv6 interfaces.

It is high-availability system without 802.15.4 support.

The log of crash:
=========================================================
#10 [ffff88043fc03cf0] async_page_fault at ffffffff816b7798
    [exception RIP: ndisc_send_rs+238]
    RIP: ffffffff8166575e  RSP: ffff88043fc03da8  RFLAGS: 00010202
    RAX: 0000000000000002  RBX: ffff88042caa9000  RCX: 0000000000000001
    RDX: 0000000000000000  RSI: 0000000000000200  RDI: ffffffff816534f7
    RBP: ffff88043fc03dd0   R8: 0000000000000000   R9: ffffffff81e9f1c0
    R10: 0000000000000002  R11: ffff88043fc03da8  R12: 0000000000000008
    R13: 0000000000000006  R14: ffff88043fc03de0  R15: ffffffff81772410
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#11 [ffff88043fc03da0] ndisc_send_rs at ffffffff81665704
=========================================================

I see that crash points on ndisc.h, it is ndisc_ops_opt_addr_space()
in function:
=========================================================
crash> kmem ffffffff8166575e
ffffffff8166575e (T) ndisc_send_rs+238
/usr/src/debug/kernel-3.10.0-693.21.1.el7/linux-3.10.0-693.21.1.el7.x86_64/include/net/ndisc.h:
251

      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0000059940   1665000                0        0  1 1fffff00000400 reserved
crash>
=========================================================

I checked the difference between 514 and 693 kernels is in the patch
https://patchwork.kernel.org/patch/9179229/ .

Any suggesions about what I am doing wrong are welcome.

Thanks!
Roman Makhov
