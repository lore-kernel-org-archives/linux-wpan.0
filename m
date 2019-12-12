Return-Path: <SRS0=llAk=2C=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183FC43603
	for <linux-wpan@archiver.kernel.org>; Thu, 12 Dec 2019 11:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B159920663
	for <linux-wpan@archiver.kernel.org>; Thu, 12 Dec 2019 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfLLLfI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:35:08 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:37384 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfLLLfB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Dec 2019 06:35:01 -0500
Received: by mail-il1-f198.google.com with SMTP id t19so1396942ila.4
        for <linux-wpan@vger.kernel.org>; Thu, 12 Dec 2019 03:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zFl6E7DmT67W68XqVzR2aCsqjcFpWexNUq+6/CXmVUk=;
        b=KojX2UhOTXfuzUDCFXEvKcpJZOqZjO1p3XpEavgF7cHhvWluV4GuCgGW5Wj4tVM+7k
         saik7ocSwMVEakGLakOPq+np9QSewmyBeZeEIA3A0BGIxph97Rhr9tCPRUWvye99HyZU
         QKccVhl+o5bBciFt6HgdLAaJtfpgKGf3EfxCjPJEP6BLNjyalQjHLrF58UvI9E2sZfWo
         A4HvE0lLS1p9WIi+YAX7QUDJ+2j3yjraoKlzdByA6KrEpccGSMX3t5K603J19FsVfOzc
         B30HKUfDQDGV7w15yNvW22xHhVgLCcj2Xk4mG13wOREH+wu74+2yR5ZMD2O20md19SsR
         Jfrg==
X-Gm-Message-State: APjAAAV9JjSymNQJ9QXjj0mJNLE5LijAgyBQvavQaSxhz1Pv7vMSnxnh
        Gw3FIytgjAADPNyDnd4npEBNupxZde5z+DsoKuv+pvOs5QWJ
X-Google-Smtp-Source: APXvYqx7tAF42179GqyQGzxmn7mnoZxL7LgtxR3PNlsI/lOpd2FmYULEa+vakNib69tHnoQvSF7+iHISpB+uiby7hAsvBYRTiqDc
MIME-Version: 1.0
X-Received: by 2002:a92:3b19:: with SMTP id i25mr7844146ila.85.1576150500982;
 Thu, 12 Dec 2019 03:35:00 -0800 (PST)
Date:   Thu, 12 Dec 2019 03:35:00 -0800
In-Reply-To: <000000000000b6b03205997b71cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b949ee0599802274@google.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
From:   syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>
To:     a@unstable.cc, alex.aring@gmail.com, allison@lohutok.net,
        andrew@lunn.ch, andy@greyhouse.net, ap420073@gmail.com,
        ast@domdv.de, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        bpf@vger.kernel.org, bridge@lists.linux-foundation.org,
        cleech@redhat.com, daniel@iogearbox.net, davem@davemloft.net,
        dsa@cumulusnetworks.com, dsahern@gmail.com, dvyukov@google.com,
        f.fainelli@gmail.com, fw@strlen.de, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, hawk@kernel.org, hdanton@sina.com,
        idosch@mellanox.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi,
        jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@mellanox.com,
        jiri@resnulli.us, johan.hedberg@gmail.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, john.hurley@netronome.com,
        jwi@linux.ibm.com, kafai@fb.com, kstewart@linuxfoundation.org,
        kvalo@codeaurora.org, kys@microsoft.com,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        liuhangbin@gmail.com, marcel@holtmann.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d37cb6e00000
start commit:   938f49c8 Add linux-next specific files for 20191211
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11d37cb6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d37cb6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000

Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
