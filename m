Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF6C433B4
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0756139E
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 11:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbhDELux (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Apr 2021 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhDELuw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Apr 2021 07:50:52 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79FC061756;
        Mon,  5 Apr 2021 04:50:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so11065889oty.12;
        Mon, 05 Apr 2021 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWteiHZtrUno6X6os1U76+wkkRAl/xzMSSbf80HUN3o=;
        b=chMtSJKK4QzcthDEZT/oE2HcxxHsDP69hWOs5XpqiJ6RgRiIbMDCnOh+GBMqgXmJLT
         VpLKasaxNkRIkIu+F2nj/IhQoB8UAdFq1EIGWAly0oL4KME151nZIZ9AGLqvBqtGW1yV
         51jp4qbflYHNiNerNaDkpXXtSD9P6UHwvsgz8yDwhw3I7Bt3mUbhMHryh1YZIB+Kfymu
         mTMO5DdZIrW+Scc++a9clpNA32WKfKvNIFiRswazth7o1hjjbXSSMRCeOtwD7nyPlb7l
         4naDbMaz1Ovg4TN2fUPW7VsXLfRoiCvhnuOMW8A7ZvZ02BzRoMu3nifvJD946wU0K/Nk
         +UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWteiHZtrUno6X6os1U76+wkkRAl/xzMSSbf80HUN3o=;
        b=N+4Ejzyjj37rxdNwN/ySIZTzUAwkJtJEjGUlOLA9LPzmLDDQxM36fLn1Qf4h7wJGqN
         ydu0XUnftGrqX+k7AIsDFUf4fBDvWEvVRu77jvW64zRYtH2otmS5VK8l0QJ87fZVeFuV
         GqxmaxPyM9gqbOwA+OQ1S2aQLsX+cQlCnTxVx/QbNe1ankCsWv6ib71lcQQ/ujRDZLb+
         3TGgF9nUxw2Ev1XHt4swi6gUU0N0irHdHUbAJZQ2USGP81FNjhbIu2s8a+Pj3/Oh8dnI
         sb6/XUJD7gIA5hslvGdzTYqyGzEaSJ9DSrHoX4MEdPyvKIG8C6mkjIjr1KL76EhPrGlx
         3Rmw==
X-Gm-Message-State: AOAM531mx87wiFd0GLxs4Otda8HPm7mMqMdwIA+YJC22vI9vTv+JozP4
        CQ1PBzUq38iZf6tjTKcKqQxJkc2mGMlwqTYBBwp94i8BgoQ=
X-Google-Smtp-Source: ABdhPJwTMv0tbz+E32QvtOZh6h3/zaul7Pv/Zexs/cB2hInJG+660p280Oak3WYKiw5n1qVb63PUlLbIDls78SU2uRA=
X-Received: by 2002:a05:6830:111a:: with SMTP id w26mr15061495otq.329.1617623446602;
 Mon, 05 Apr 2021 04:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAB_54W7v1Dk9KjytfO8hAGfiqPJ6qO0SdgwDQ-s4ybA2yvuoCg@mail.gmail.com>
 <20210304152125.1052825-1-paskripkin@gmail.com> <CAB_54W6BmSuRo5pwGEH_Xug3Fo5cBMjmMAGjd3aaWJaGZpSsHQ@mail.gmail.com>
 <9435f1052a2c785b49757a1d3713733c7e9cee0e.camel@gmail.com>
In-Reply-To: <9435f1052a2c785b49757a1d3713733c7e9cee0e.camel@gmail.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Mon, 5 Apr 2021 07:50:35 -0400
Message-ID: <CAB_54W6Js5JD126Bduf1FjDLpOiCYmLX+MZzqP9dVupSUDO8tw@mail.gmail.com>
Subject: Re: [PATCH v2] net: mac802154: Fix general protection fault
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, 5 Apr 2021 at 01:45, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi!
>
...
> >
>
> I forgot to check the patch with ./scripts/checkpatch.pl :(
>
> > Dumb question: What is the meaning of it?
>
> This is for gerrit code review. This is required to push changes to
> gerrit public mirror. I'm using it to check patches with syzbot. Change
> ids are useless outside gerrit, so it shouldn't be here.
>
> Btw, should I sent v2 or this is already fixed?

Otherwise the patch looks good. May Stefan can fix this.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex
