Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C3BC433E0
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 01:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907CA60231
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 01:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhBXBGF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBXAkf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Feb 2021 19:40:35 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F37C06178C;
        Tue, 23 Feb 2021 16:26:38 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id h38so96685ooi.8;
        Tue, 23 Feb 2021 16:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mshc79FXWLD6+BX5Ixyu8Wvz4uIGKF1xS+0L2eeJ0Gc=;
        b=RsjGITXEW5du7eTT9ZmrWvIOPnbG/xXMCmH17LiledWqsuFzxQAWFndXKErTllkdbN
         0wpP1Dzrj0+TmckhonJ/d6/1aQcC9fYg7oH82jXcyim0TxnFIxkDtqRwVMjzFi18C3xu
         +Sj8DkOfUNm3JUuEgQGSp/vQrZCDMGia5oMX1BpNLCwpz2HuTSLv2onS/qoIvm9SN2h5
         ukOcar7i1td17G101FYekIbtE7ttPnFjE9TKxHCg3yvGWE8Gm+53YFZbcBe5AHGnZaHA
         nLG054zMqVV/ZT0pcpEh2tOQ/RcUSwKAqS+UhUkmToagh8HMIMxbIgm1lIGC1Gxw/iWU
         sG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mshc79FXWLD6+BX5Ixyu8Wvz4uIGKF1xS+0L2eeJ0Gc=;
        b=e0EwVfA/MPTNqw1e9GM89GMotoXbYsWT2ma8vS2oko9XQd8XMOVg0wQmE25ALPTZ5b
         8nInAa0y7BzOX3WGy6O7ubkh+R33L2Uhthb3y4ntVE9Wiqf/c5POfZ/qmyZvdW81hlsM
         xjWbiNH0/O/3YZo3lkHOKwBEQFfF6atba8EX2KEOdJqJwW8y7aVLXOTe1GE+8x9k2PPC
         I/zsmYfKpIXwcoz1/joTclY69+0iB+N3XFrtQwB7d6cjXEmdYZEE2LSywYThgWLotJTv
         YCBs42UXkHSVWCOZutK7ftn0jisNZ4gGV7PREbPZYo+TsIAKQEUx97yaamb+GLf4TbDV
         xk9g==
X-Gm-Message-State: AOAM5314391g2P40bpNUTYcUmpz+1FIRnGLJB5w3VBURhO0mekM1RvW9
        Htfbtjt0zEVhrbevqZBa6dDBp0sCjRvKgAHJdLVB9b3/uuY=
X-Google-Smtp-Source: ABdhPJwMaLzjPvnhlo+HmntTBCnUxW5Pit1e5y0hbhp+2dQFap0jDmGidUpIHwBU5g71nbg3oTMP/UkR9Xnszw5z44M=
X-Received: by 2002:a4a:da04:: with SMTP id e4mr12600459oou.34.1614126397658;
 Tue, 23 Feb 2021 16:26:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e37c9805bbe843c1@google.com> <20210223154855.669413bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210223154855.669413bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Tue, 23 Feb 2021 19:26:26 -0500
Message-ID: <CAB_54W6FL2vDto3_1=0kAa8qo_qTduCfULLCfvD_XbS4=+VZyw@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in nl802154_new_interface
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     syzbot <syzbot+7bf7b22759195c9a21e9@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, 23 Feb 2021 at 18:48, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Alex, there seems to be a few more syzbot reports for nl802154 beyond
> what you posted fixes for. Are you looking at these?

Yes, I have it on my list. I will try to fix them at the weekend.

- Alex
