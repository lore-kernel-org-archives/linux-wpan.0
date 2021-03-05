Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FFC433E9
	for <linux-wpan@archiver.kernel.org>; Fri,  5 Mar 2021 06:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF5C64FE9
	for <linux-wpan@archiver.kernel.org>; Fri,  5 Mar 2021 06:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEGhJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 5 Mar 2021 01:37:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46578 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCEGhG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Mar 2021 01:37:06 -0500
Received: by mail-io1-f72.google.com with SMTP id w8so1081333iox.13
        for <linux-wpan@vger.kernel.org>; Thu, 04 Mar 2021 22:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9eaCYfkOQuJEVGK3vD++ucoro9m1dub/WdBbvxw09lQ=;
        b=Bspgxp4LCxCEK0UQKn4MysEqjLlqAmAQMTf8KMyLhVs3pwC8yxvnCiIsHl6+5vryML
         gJq5Y+ftQeuIepSRPLtnNxXDJhOTaxiRcGngkFw8CnB7hgHSFlsyq5XKSkQ14Ov7TlVw
         P7BvIQoblFAsf/7jN8VThaj5t6yM2hRCtYOCsREJjoHLkouV5NLKqhDRDkFSgBrW3PJB
         wMrv1fru1UKP/mSh+fCz6ALdOrITtK79lMDC7DIA5EO56oZWyOCekD9c07zU8tdxNU7V
         5WU64b3k+621al1oOAAQK2umQLH7ksBvW6XBS8zkczrN05K+/1WvzWdhOb2pgn+KdsSS
         2mgw==
X-Gm-Message-State: AOAM532wMI+orMA/CWQIDPgV1o+x3tpTX7XzCoifCHVK7MAU3QD1ozlt
        E6/bUn+M28fagbEeIoA1WsmxvZxk2pnhXvhuXdIrQ+KfiSZz
X-Google-Smtp-Source: ABdhPJxi5FMb8Gtqz+q8eOcjlJ7eTcYMgt8xt0JDLdD5lcTHbZxuE/yqpKlOFPKmyN37WeK74E03P96+WJLIcvMieDoGzNTvO9hX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e5:: with SMTP id q5mr7133793ilv.131.1614926224754;
 Thu, 04 Mar 2021 22:37:04 -0800 (PST)
Date:   Thu, 04 Mar 2021 22:37:04 -0800
In-Reply-To: <0000000000009b387305bc00fda6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70f8f05bcc44f14@google.com>
Subject: Re: WARNING in ieee802154_get_llsec_params
From:   syzbot <syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

syzbot has bisected this issue to:

commit b60673c4c418bef7550d02faf53c34fbfeb366bf
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Mar 3 05:05:15 2020 +0000

    nl802154: add missing attribute validation for dev_type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100b11b0d00000
start commit:   f5427c24 Add linux-next specific files for 20210304
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=120b11b0d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=140b11b0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7876f68bf0bea99
dashboard link: https://syzkaller.appspot.com/bug?extid=cde43a581a8e5f317bc2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c7b46d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276f5b0d00000

Reported-by: syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Fixes: b60673c4c418 ("nl802154: add missing attribute validation for dev_type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
