Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D6DC433F5
	for <linux-wpan@archiver.kernel.org>; Mon,  3 Oct 2022 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJCW3i (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJCW3V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Oct 2022 18:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F113EA9
        for <linux-wpan@vger.kernel.org>; Mon,  3 Oct 2022 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664836157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KloP+jS2Ou38p085MiqdGw+v9zYs5zl1rg3Sta17Wr0=;
        b=Ptn1HI1FzmkKqljp5cx/QUdQy8lwpPsMYCdVsO+imDWU2Nltobv2Gv7YKvwdzOfVtkSp0w
        t/K5uJT8oMMAV1X8tSg/u2QRGMz44iqGSOcx4c7YtkgpMwAgFmCBPFeXEe0hXyW8xO8cgu
        E+ajY/IDsEJNxRcHG1OH6x4eEomteTQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-x01g52PAPuCrV_C1EcsS2w-1; Mon, 03 Oct 2022 18:29:16 -0400
X-MC-Unique: x01g52PAPuCrV_C1EcsS2w-1
Received: by mail-wr1-f71.google.com with SMTP id s5-20020adfa285000000b0022ad5c2771cso3445921wra.18
        for <linux-wpan@vger.kernel.org>; Mon, 03 Oct 2022 15:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KloP+jS2Ou38p085MiqdGw+v9zYs5zl1rg3Sta17Wr0=;
        b=u3KkViQqXpVWbyngiQ5Ftj/g6wHpX9OGyI1hggnKQoQh5VQcVYiRPvyAPq02faMRdM
         tXCvRhcyHZJI3nAoMP19GJYkdd10aU16rxRemP5SWp7WzkQMTK/mYEOVNgWhgdafo4fj
         AgR0atx9w5hOWMLHOpuN8W2k2zSv8g0GBcahSbW51ufWOM4tJiQFBGdAzWAcn2jzzHNa
         7Yy2MYrWtrqyBLha5lXtaWpTxqFQ6gR47AHm/wz0ea52ctuAN6LAWg3ChWANmTs2AY+8
         dmCeh+pW5RoC9zPIvYT+3zT1jMpoRR1g+OJvyNIrf5BNeepvL8h36kqpfGHodFQEIkTf
         EYNw==
X-Gm-Message-State: ACrzQf3Fb6XePNSztZXb4wSl2MhKfiJRcjlUpHmSrv4kbCKJK7jpoVoi
        wd51XHN+e0woyzLxQ9yOgZhEb56oWeYpw5F9cCNjg8UWErPgr63GltL5n/TsjSdYtAb+A4vafr+
        TWpZoj2hYAPuq93xwtainrlCk49o/Sx6j/5/6UQ==
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id e11-20020a5d6d0b000000b0022aca5ba37emr14115706wrq.383.1664836153801;
        Mon, 03 Oct 2022 15:29:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Re+SW0nBPW1pAT37RKgPYOtNOxJuAVwHz58co/cIlEH1Oa9upJ4cl7K3c5MM5koSeqMJUjBX0ew2I02IX+GU=
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id
 e11-20020a5d6d0b000000b0022aca5ba37emr14115697wrq.383.1664836153606; Mon, 03
 Oct 2022 15:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <5e89b653-3fc6-25c5-324b-1b15909c0183@I-love.SAKURA.ne.jp>
 <166480021535.14393.17575492399292423045.git-patchwork-notify@kernel.org> <4aae5e2b-f4d5-c260-5bf8-435c525f6c97@I-love.SAKURA.ne.jp>
In-Reply-To: <4aae5e2b-f4d5-c260-5bf8-435c525f6c97@I-love.SAKURA.ne.jp>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 3 Oct 2022 18:29:02 -0400
Message-ID: <CAK-6q+g7JQZkRJhp6qv_H9xGfD4DWnaChmQ7OaWJs3CAjfMnpA@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: reject zero-sized raw_sendmsg()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     patchwork-bot+netdevbpf@kernel.org,
        "David S. Miller" <davem@davemloft.net>, alex.aring@gmail.com,
        stefan@datenfreihafen.org, shaozhengchao@huawei.com,
        ast@kernel.org, sdf@google.com, linux-wpan@vger.kernel.org,
        syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Oct 3, 2022 at 8:35 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/10/03 21:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >
> > This patch was applied to netdev/net.git (master)
> > by David S. Miller <davem@davemloft.net>:
> >
> > On Sun, 2 Oct 2022 01:43:44 +0900 you wrote:
> >> syzbot is hitting skb_assert_len() warning at raw_sendmsg() for ieee802154
> >> socket. What commit dc633700f00f726e ("net/af_packet: check len when
> >> min_header_len equals to 0") does also applies to ieee802154 socket.
> >>
> >> Link: https://syzkaller.appspot.com/bug?extid=5ea725c25d06fb9114c4
> >> Reported-by: syzbot <syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com>
> >> Fixes: fd1894224407c484 ("bpf: Don't redirect packets with invalid pkt_len")
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - net/ieee802154: reject zero-sized raw_sendmsg()
> >     https://git.kernel.org/netdev/net/c/3a4d061c699b
>
>
> Are you sure that returning -EINVAL is OK?
>
> In v2 patch, I changed to return 0, for PF_IEEE802154 socket's zero-sized
> raw_sendmsg() request was able to return 0.

I currently try to get access to kernel.org wpan repositories and try
to rebase/apply your v2 on it. Then it should be fixed in the next
pull request to net. For netdev maintainers, please don't apply wpan
patches. Stefan and I will care about it.

Thanks.

- Alex

