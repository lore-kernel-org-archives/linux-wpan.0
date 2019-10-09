Return-Path: <SRS0=upCO=YC=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA13C4360C
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 01:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280E820873
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 01:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfJIBYB (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:24:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40291 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbfJIBYB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Oct 2019 21:24:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r20so1776668ioh.7
        for <linux-wpan@vger.kernel.org>; Tue, 08 Oct 2019 18:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sTtRhHB+FIjWWxBw0tW/N10Uhy+DblHPCwc6eoAtz5k=;
        b=WrWDmY69aAXoDxW85jG4R5zQcR7pLG2ibBh22tAdUS9y6mddYkLlHkPfp2cYg/fWhn
         S+7BoZyXYjdEmQHu4q8RNm6/wPIHRHqZ2L59vE3f5lPCa25SI/WmXGeJqVTPPQZ6+8w1
         xrw0yUgRj64TY1nMPG7uA+NC/+69o7eISlEQ6dW9zPpr6Mk64bdvEbFGVwEXlnZt4VhM
         KuKiZt5wtEV1+T9fOhXMn4syZW0OYvRGheqiEfCScLQdd3+/c82OzEiuzbJv9Mxr9yts
         x5Qesz4qMYJbNpHRBmAzGAdn1EhJxBs/+vMzYILvtoMknwhYy2Ea1/iakkwv00tuTDsG
         PmLg==
X-Gm-Message-State: APjAAAXRVtJgVPkf9ymqkT092rBt2yGCqNMdUetvWhlP4BipGzsmV9I5
        uV3wOAuFcjxkDwucvqF0Cykonh5Ga3CRe8OJEP8zG6jLkTOI
X-Google-Smtp-Source: APXvYqyml+7hac2zw8kA+I+beki59R3+vmtmhi38APoNrgs+TwehFpFdJXlSQvQdoHGpVepARpzBN69101g2pAxrteTrw07JUTF4
MIME-Version: 1.0
X-Received: by 2002:a5e:d917:: with SMTP id n23mr1244594iop.28.1570584240714;
 Tue, 08 Oct 2019 18:24:00 -0700 (PDT)
Date:   Tue, 08 Oct 2019 18:24:00 -0700
In-Reply-To: <000000000000ba89a9059456a51f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1f845059470233a@google.com>
Subject: Re: KASAN: use-after-free Read in nl8NUM_dump_wpan_phy
From:   syzbot <syzbot+495688b736534bb6c6ad@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, jiri@mellanox.com,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

syzbot has bisected this bug to:

commit 75cdbdd089003cd53560ff87b690ae911fa7df8e
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Sat Oct 5 18:04:37 2019 +0000

     net: ieee802154: have genetlink code to parse the attrs during dumpit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14620210e00000
start commit:   056ddc38 Merge branch 'stmmac-next'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16620210e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12620210e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
dashboard link: https://syzkaller.appspot.com/bug?extid=495688b736534bb6c6ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e256c3600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175ecdfb600000

Reported-by: syzbot+495688b736534bb6c6ad@syzkaller.appspotmail.com
Fixes: 75cdbdd08900 ("net: ieee802154: have genetlink code to parse the  
attrs during dumpit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
