Return-Path: <SRS0=JWnU=22=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D20C33C8C
	for <linux-wpan@archiver.kernel.org>; Sun,  5 Jan 2020 22:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C050020801
	for <linux-wpan@archiver.kernel.org>; Sun,  5 Jan 2020 22:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAEW6C (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:58:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40382 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgAEW6B (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Jan 2020 17:58:01 -0500
Received: by mail-il1-f198.google.com with SMTP id e4so29832364ilm.7
        for <linux-wpan@vger.kernel.org>; Sun, 05 Jan 2020 14:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MybccZLowdSuY610EZVsc1I89suuz7NXH7uvIv0mFvY=;
        b=uiVSl6smvM/nwXc3J/vLiG+9UDT61MTqVojYpafOB5oXLxu1VxmzY0aisuv8AiENoW
         5ozUywuo4tEE+8VU6FTRmv0JUS0GWuziLxVG0y5JOYR+ydGtWjvuILzHRBeK1CPvGQ+4
         DBOjILdJiJUfjmAsf/I0d5+zRElFSVTTNiDCAfcqsNWCnTn3CHBvE21a9d2+BLw1HAW9
         E9YsLYWttv0+VaARTMwJ9F7Q6iwUmkCzeOHbD/AGzvdat/IhQ7HVy0yLeYKXoYy2rQ5j
         gfNCG2wG08VTeuRI33yRrAaFx7Lknjocu2+Xs4OIwZY3b8B0TtwMH+aEISb7MvIiNNIu
         HH4w==
X-Gm-Message-State: APjAAAVo7LyikZwQIt3zyKhm7ymUuiI0BMhY59UyxaY6pSn3XmkhZyu5
        9UZUjdtLorj2eYOsvwAEcux38xS8Ic+dMU/XuI9lWTFgTHZE
X-Google-Smtp-Source: APXvYqwI1kaOaU+6OhN9mHkSBgJLPiiG9E2oMRL3MMauj8xdpOQ/nYJTOKJNppAbqi17MDpHQfb0GrThss7Ve4NxONRpCk4GrB8O
MIME-Version: 1.0
X-Received: by 2002:a92:3996:: with SMTP id h22mr81182568ilf.129.1578265080765;
 Sun, 05 Jan 2020 14:58:00 -0800 (PST)
Date:   Sun, 05 Jan 2020 14:58:00 -0800
In-Reply-To: <000000000000ab3f800598cec624@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000802598059b6c7989@google.com>
Subject: Re: WARNING: bad unlock balance in sch_direct_xmit
From:   syzbot <syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com>
To:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, cleech@redhat.com,
        daniel@iogearbox.net, davem@davemloft.net, dsa@cumulusnetworks.com,
        f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, haiyangz@microsoft.com, info@metux.net,
        j.vosburgh@gmail.com, j@w1.fi, jakub.kicinski@netronome.com,
        jhs@mojatatu.com, jiri@resnulli.us, johan.hedberg@gmail.com,
        johannes.berg@intel.com, jwi@linux.ibm.com,
        kstewart@linuxfoundation.org, kvalo@codeaurora.org,
        kys@microsoft.com, linmiaohe@huawei.com,
        linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ppp@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-wpan@vger.kernel.org, liuhangbin@gmail.com,
        marcel@holtmann.org, mareklindner@neomailbox.ch, mkubecek@suse.cz,
        mmanning@vyatta.att-mail.com, netdev@vger.kernel.org,
        nikolay@cumulusnetworks.com, oss-drivers@netronome.com,
        paulus@samba.org, ralf@linux-mips.org, roopa@cumulusnetworks.com,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e88ec6e00000
start commit:   36487907 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e88ec6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e88ec6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f3ef188b7e16cf
dashboard link: https://syzkaller.appspot.com/bug?extid=4ec99438ed7450da6272
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1722c5c1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167aee3ee00000

Reported-by: syzbot+4ec99438ed7450da6272@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
