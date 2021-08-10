Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53EFC432BE
	for <linux-wpan@archiver.kernel.org>; Tue, 10 Aug 2021 15:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999F861019
	for <linux-wpan@archiver.kernel.org>; Tue, 10 Aug 2021 15:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbhHJPfL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 10 Aug 2021 11:35:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38612 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbhHJPfA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Aug 2021 11:35:00 -0400
Received: by mail-il1-f198.google.com with SMTP id h27-20020a056e021d9bb02902021736bb95so7662507ila.5
        for <linux-wpan@vger.kernel.org>; Tue, 10 Aug 2021 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ezvPuPtMzOuRLqecX2VTZ2ztz0IyxYGYWNq3bM8LvCs=;
        b=ovAsTnQfb/S3t4WBhA+p/fXzekE664CsAs3mMdJnsx6jPqA9qxxvst/D/nNlmkiHIq
         A+7Wz3PO7LyRX4oAQW3RB1MTh2L8xw3lTJbU9Xr5YkvptTpz1U1KvYZedk9PGo+MzYsW
         3M4u6P9UZjHintr/i9JvHLK7aBl2KUOlYbcsmb9nzmkJqYdG+fvMGZpykYihtIwBBdIn
         KFf+Ae//N9+Ah8364zwv695tKleD36988byMWY5Oe9dXZa1mSv0ojWeAi8a12aovynuV
         WoFfiXVihYjumxRSjU6WwzWpMUqCdu6MEYn7CUCpRP6cOFR2Wsm4P2osJp6oQfKmz9fp
         5E5w==
X-Gm-Message-State: AOAM5312m9gx3faAH5dxIvMZJrSEquf6BaNBU9ykNijukT64ge5yuJkr
        hrcY0ObXT2emYNgngThlhdL2QzALJYxIsDnS6GyCiCLCXp4o
X-Google-Smtp-Source: ABdhPJxUNwqzmK5BP4xy5zYm2dHKjVhr9kXAul5tmQWBzbKn7f/vtTtKsjuaPj76egcfQsjLcONIB+8s6JEZ9u6yEHxs1CkpszEd
MIME-Version: 1.0
X-Received: by 2002:a5d:9ac1:: with SMTP id x1mr16641ion.191.1628609652476;
 Tue, 10 Aug 2021 08:34:12 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:34:12 -0700
In-Reply-To: <0000000000007faf7505c91bb19d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d04e9b05c9363bf1@google.com>
Subject: Re: [syzbot] general protection fault in hwsim_new_edge_nl
From:   syzbot <syzbot+fafb46da3f65fdbacd16@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alex.aring@gmail.com, bp@alien8.de,
        davem@davemloft.net, frederic@kernel.org, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kuba@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, mingo@redhat.com, mudongliangabcd@gmail.com,
        netdev@vger.kernel.org, npiggin@gmail.com, pbonzini@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        rostedt@goodmis.org, seanjc@google.com, sedat.dilek@gmail.com,
        stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vitor@massaru.org, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

syzbot has bisected this issue to:

commit 997acaf6b4b59c6a9c259740312a69ea549cc684
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Jan 11 15:37:07 2021 +0000

    lockdep: report broken irq restoration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13927981300000
start commit:   d09c548dbf3b net: sched: act_mirred: Reset ct info when mi..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10527981300000
console output: https://syzkaller.appspot.com/x/log.txt?x=17927981300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=343fd21f6f4da2d6
dashboard link: https://syzkaller.appspot.com/bug?extid=fafb46da3f65fdbacd16
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152ee39e300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15946ff1300000

Reported-by: syzbot+fafb46da3f65fdbacd16@syzkaller.appspotmail.com
Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
