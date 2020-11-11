Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6016C388F9
	for <linux-wpan@archiver.kernel.org>; Wed, 11 Nov 2020 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A00F20659
	for <linux-wpan@archiver.kernel.org>; Wed, 11 Nov 2020 11:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V784RG0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKKLYR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgKKLYM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Nov 2020 06:24:12 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6AAC0613D6
        for <linux-wpan@vger.kernel.org>; Wed, 11 Nov 2020 03:24:12 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so1290236qkb.2
        for <linux-wpan@vger.kernel.org>; Wed, 11 Nov 2020 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xuuackRiUtSlBLGiQKxEWTouJw8FNaN4sTCD1uCgDI=;
        b=V784RG0ZxTqWeGqccapJoQKyASlqnIeTcLEt2WHsTCnwpYl87gsvLifzB7MSEEeZXl
         GcSqETlsdOXus3WAznjJPOxZvxnMkDZPw6zqqE6Ux0TpGzhsZOk5InJ5xSdmaJyVPSTt
         OYSkEZ1lbSvh8tKeXmNU6lbcRJ2nqhyvqVb1Kf72ilGwhh9GnIfsjvzNV+PU+sImaJoa
         G58OsJ9a1YUmO5V0Tqtf3rJDRfF3OOv/ykSVKaHtBX8PHgMZ+RgiJOGz9v0jxdeUcBeu
         JwSxieds2pqwEe3Mznw7R/vQi5dEa6CxcUI/m24vJ0uZ6CmnJwsMLJrz7UdxbgQA8641
         u6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xuuackRiUtSlBLGiQKxEWTouJw8FNaN4sTCD1uCgDI=;
        b=SWyIbCBlxMSQ4MT7qSE88lZsEIFPUdLe2qOcQ3PYFGxMuWGd1cPW1z0bJI6tr3WqB4
         qUQnCRBw2PeVBV5+gw1yv7s41I/vLqOnfB2ahTP+uU7j7ZGb3BOC+PZY2Gn+7BohsmKd
         wsCkdy160om64aM0mLlttVnNpYUAVw1gAV652DV7nMmk/B69w9n1J8YszNkwVxaQ6Dm1
         KurpURQckNZlpN2CRGhGfaDTQ+1rEm62ti7+sl0XZWVq5Rk/QsbbICBM/mQELCGuughL
         Kk2rAkLWy+3Z6fOkmjOWOPcYZMYzE5STpPye0ire/XQaJyJNFB5ZXSZBhgMki8AEC4DT
         JJhw==
X-Gm-Message-State: AOAM532c1EZASzwxF436X5i+LrPrRJGoSOM9HpibA036aDzi3e1Sk7q1
        K4yZlDVVkgBPt0yFVizJSbc/yBEnAB0M+ziFXbkrqQ==
X-Google-Smtp-Source: ABdhPJxz85C1QiSraIe+0/ik6klqSjxR0dhVn3yUQJMS8OEiywLd9K3IYTCQYGHlsh9E1uvMS4jje7Dsi/of7RrzgOI=
X-Received: by 2002:a37:49d6:: with SMTP id w205mr24434650qka.501.1605093851351;
 Wed, 11 Nov 2020 03:24:11 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053e07805a9b61e09@google.com> <000000000000ba6a2d05ac300953@google.com>
In-Reply-To: <000000000000ba6a2d05ac300953@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:24:00 +0100
Message-ID: <CACT4Y+ZFqCBRhnJxv09QEZqm3eNym5vyLUHGpZfHY58DQ=YLKQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __cfg8NUM_wpan_dev_from_attrs (2)
To:     syzbot <syzbot+14e0e4960091ffae7cf7@syzkaller.appspotmail.com>
Cc:     alex.aring@gmail.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-wpan@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, stefan@datenfreihafen.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Thu, Aug 6, 2020 at 9:00 AM syzbot
<syzbot+14e0e4960091ffae7cf7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit bf64ff4c2aac65d680dc639a511c781cf6b6ec08
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Sat Jun 27 07:12:24 2020 +0000
>
>     genetlink: get rid of family->attrbuf
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12069494900000
> start commit:   e44f65fd xen-netfront: remove redundant assignment to vari..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
> dashboard link: https://syzkaller.appspot.com/bug?extid=14e0e4960091ffae7cf7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11818aa7100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f997d3100000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: genetlink: get rid of family->attrbuf
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: genetlink: get rid of family->attrbuf
