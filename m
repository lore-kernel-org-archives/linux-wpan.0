Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1BCC433FE
	for <linux-wpan@archiver.kernel.org>; Wed,  5 Oct 2022 01:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJEBtU (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 4 Oct 2022 21:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJEBtT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Oct 2022 21:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815541519
        for <linux-wpan@vger.kernel.org>; Tue,  4 Oct 2022 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664934557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLTJ61r8dkXDaTvWzIXpLlZQKa1MajTFnqO/8VKqnHg=;
        b=ANgBOv1GhZM0zu0Z8emwMNPc2REubidgkn2CcGMNoLHlilqOVUu3sd//3mNNkNm1yC8Qw+
        PHAoDxaxJBVa/4N3qMiyU4yDHxoRS8QrNzeJDoyIWsxudlXfaDVk2HK7J2lsEV+0IjqInC
        0NEJcsxisDAKjc2PIAsCtw4cag4iLdk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-uKJqM8yaPfegRSNGpvaUBQ-1; Tue, 04 Oct 2022 21:49:16 -0400
X-MC-Unique: uKJqM8yaPfegRSNGpvaUBQ-1
Received: by mail-wr1-f71.google.com with SMTP id e14-20020adf9bce000000b0022d18139c79so3724371wrc.5
        for <linux-wpan@vger.kernel.org>; Tue, 04 Oct 2022 18:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dLTJ61r8dkXDaTvWzIXpLlZQKa1MajTFnqO/8VKqnHg=;
        b=X4kxNAWAl7lXVvSEWmvt5cBtnZg7SR43JRUZNRhSkArXY3LPMpgkJqs9wTCcCmTNv2
         f8KV+aLJEvlQtZ1/YSWSOLSbcvn2LvWgnsBeZcZvheLXmFipazSjRB9ijbeXcc6W8SXB
         MfpMlloI/FsEwo+23RwVBCXIFU9K+kMWcZkNE5RJ4XN3s7UViPZvzn3l7s1XVLiYgX5L
         m0VzPKIrMwfegvYqoCwHQhmXG1lB+95PNMGWXTdqufGdQm0EwjY6rwdfEge7kz3YDLZU
         Mw4YaD7vyhrc0bWAV1WL2D334PChBEPOSJeCDPjy3h4LKm41wMIRnGq6+Y4R1sviAFeI
         7NSw==
X-Gm-Message-State: ACrzQf0lNy/WHEoBI35ZBvfj0t34jPdidBS8q9NX8ZfCyrUiKopLdMon
        Bknm3WVa/AovhpOFrPeb0hxbfov5kRJvliqNoHePKyH3IY2IRS17XTlXJdJff17f2o10+XdseKn
        vTivIOcQ3ZSTt0Xw9daznUt6yrKogjBlHkARohg==
X-Received: by 2002:a5d:4ec5:0:b0:22c:dca3:e84d with SMTP id s5-20020a5d4ec5000000b0022cdca3e84dmr15834675wrv.14.1664934554197;
        Tue, 04 Oct 2022 18:49:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JK1zsVfoyuyMRUvvxHLhWflIAu9gCaRBOuvZ9x90b9f30rXDBL32LJ24bXRf5pVn5+FsGD4k/6KDutA1+WdE=
X-Received: by 2002:a5d:4ec5:0:b0:22c:dca3:e84d with SMTP id
 s5-20020a5d4ec5000000b0022cdca3e84dmr15834664wrv.14.1664934553971; Tue, 04
 Oct 2022 18:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <5e89b653-3fc6-25c5-324b-1b15909c0183@I-love.SAKURA.ne.jp>
 <166480021535.14393.17575492399292423045.git-patchwork-notify@kernel.org>
 <4aae5e2b-f4d5-c260-5bf8-435c525f6c97@I-love.SAKURA.ne.jp>
 <CAK-6q+g7JQZkRJhp6qv_H9xGfD4DWnaChmQ7OaWJs3CAjfMnpA@mail.gmail.com> <1c374e71-f56e-540e-35d0-e6e82a4dc0e3@datenfreihafen.org>
In-Reply-To: <1c374e71-f56e-540e-35d0-e6e82a4dc0e3@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 4 Oct 2022 21:49:02 -0400
Message-ID: <CAK-6q+iqPFxrM7qdmi4xcF8e+2mgqXT9otEwRA+Vh-JfRQ18Wg@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: reject zero-sized raw_sendmsg()
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        patchwork-bot+netdevbpf@kernel.org,
        "David S. Miller" <davem@davemloft.net>, alex.aring@gmail.com,
        shaozhengchao@huawei.com, ast@kernel.org, sdf@google.com,
        linux-wpan@vger.kernel.org,
        syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Oct 4, 2022 at 1:59 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 04.10.22 00:29, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Oct 3, 2022 at 8:35 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2022/10/03 21:30, patchwork-bot+netdevbpf@kernel.org wrote:
> >>> Hello:
> >>>
> >>> This patch was applied to netdev/net.git (master)
> >>> by David S. Miller <davem@davemloft.net>:
> >>>
> >>> On Sun, 2 Oct 2022 01:43:44 +0900 you wrote:
> >>>> syzbot is hitting skb_assert_len() warning at raw_sendmsg() for ieee802154
> >>>> socket. What commit dc633700f00f726e ("net/af_packet: check len when
> >>>> min_header_len equals to 0") does also applies to ieee802154 socket.
> >>>>
> >>>> Link: https://syzkaller.appspot.com/bug?extid=5ea725c25d06fb9114c4
> >>>> Reported-by: syzbot <syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com>
> >>>> Fixes: fd1894224407c484 ("bpf: Don't redirect packets with invalid pkt_len")
> >>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>>>
> >>>> [...]
> >>>
> >>> Here is the summary with links:
> >>>    - net/ieee802154: reject zero-sized raw_sendmsg()
> >>>      https://git.kernel.org/netdev/net/c/3a4d061c699b
> >>
> >>
> >> Are you sure that returning -EINVAL is OK?
> >>
> >> In v2 patch, I changed to return 0, for PF_IEEE802154 socket's zero-sized
> >> raw_sendmsg() request was able to return 0.
> >
> > I currently try to get access to kernel.org wpan repositories and try
> > to rebase/apply your v2 on it.
>
> This will only work once I merged net into wpan. Which I normally do
> only after a pull request to avoid merge requests being created.
>

ok.

> We have two options here a) reverting this patch and applying v2 of it
> b) Tetsu sending an incremental patch on top of the applied one to come
> to the same state as after v2.
>
>
> Then it should be fixed in the next

ok.

> > pull request to net. For netdev maintainers, please don't apply wpan
> > patches. Stefan and I will care about it.
>
> Keep in mind that Dave and Jakub do this to help us out because we are
> sometimes slow on applying patches and getting them to net. Normally
> this is all fine for clear fixes.
>

If we move getting patches for wpan to net then we should move it
completely to that behaviour and not having a mixed setup which does
not work, or it works and hope we don't have conflicts and if we have
conflicts we need to fix them when doing the pull-request that the
next instance has no conflicts because they touched maybe the same
code area.

> For -next material I agree this should only go through the wpan-next
> tree for us to coordinate, but for the occasional fix its often faster
> if it hits net directly. Normally I don't mind that. In this case v2 was
> overlooked. But this is easily rectified with either of the two options
> mentioned above.
>

I think a) would be the fastest way here and I just sent something.

- Alex

