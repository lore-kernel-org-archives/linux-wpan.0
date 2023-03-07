Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4504C678D5
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Mar 2023 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjCGSwW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjCGSwG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Mar 2023 13:52:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC531ABB10
        for <linux-wpan@vger.kernel.org>; Tue,  7 Mar 2023 10:40:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f11so13122689wrv.8
        for <linux-wpan@vger.kernel.org>; Tue, 07 Mar 2023 10:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678214425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75Oc8UNwWD0jYPxP17Nj5SkV82ayeB1gYR6cINmhH1Q=;
        b=DzKJSGkIxNz2UWaUqVoky0eHIbRRra9KqHtCulCSFuXgxUYfaTzwqiGrtcbpFwJIGt
         vxgmD+FLpHhThGox88Vb5pCUA6OZ8/z+DVFeZKGf5j409W62I0y47v/r4EtOdBPFk9Tc
         RBlT1itiiJvSYuM3kHTwoNnIzYwQF41cRjJVyXQJ8vcZda8ExWHiKIcJUQTczhx2JVK/
         Fpwyy5wxw6t+Nf/bLnZc6v8PsnSAEfxSCCoJ0AtrRHqyzsoHqQLYAymn4gO4zONe2BGG
         cmCoSp2RCO5FLkxPK+IN0JbiM42w2p0JdfpSevuSd7a6iaLJs9egF6mWYjgndM86Fm7Y
         PYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75Oc8UNwWD0jYPxP17Nj5SkV82ayeB1gYR6cINmhH1Q=;
        b=mTZoRUG6pj6Ku7YDNgWLHo9kGVK/twPfxxLSCj0/ryc/3bd/RiVlWWXpRc1H0yQsQi
         vYaLeK6lex5rRpg2qDW4stZ2KmMAQRDhzO6q6Pxdz8cvdMDjdBLeWNnfufwqNgkID8qp
         uY0NwH5Hh2madzLHbBJPpkEXIM+Re2dpecB4vhqXJFTXzc0lcoeewnbIpxGaX1JHQB5B
         wbpTVNWy8ky9MBD62OwjjdRsz8ECQ3oUEtRa41UlnNeBcj8NOu2UowP1Y+bBK4ruMU5y
         2Msfgaj8mAjpM1hotMA7j+Ux75zd6tMEfdLF3w+PxaKrHDKNpJoitrJih52xuoS4y3lt
         /wYA==
X-Gm-Message-State: AO0yUKWphhdEJHF20Wcc5vRaOd636Am+cmI3w+TilJenaxeUoqp0L8K9
        0XziC952OQ8nDcye+6R2zQfig9nKpPEmWCaO76N0KQ==
X-Google-Smtp-Source: AK7set9m1/qqH/9wDnJJWnQBo3huOpkDQCzDLDY2kiKPKKPBTUgzIGrPEfB+knMs/ozNgdaTX7lwaIJXzVCMYFxj7qI=
X-Received: by 2002:a5d:4b03:0:b0:2c5:3fcb:682b with SMTP id
 v3-20020a5d4b03000000b002c53fcb682bmr2872897wrq.2.1678214425596; Tue, 07 Mar
 2023 10:40:25 -0800 (PST)
MIME-Version: 1.0
References: <000000000000adec0205f5ffcaf4@google.com> <ZAISIS/h9UV6Ox+r@corigine.com>
 <20230303164456.603c2ebd@xps-13>
In-Reply-To: <20230303164456.603c2ebd@xps-13>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 7 Mar 2023 19:40:13 +0100
Message-ID: <CANp29Y6aaCVVg+3ezNzaw1nqvMbZhHooZ_DQRvv5YPbOmeprag@mail.gmail.com>
Subject: Re: [syzbot] [wpan?] general protection fault in nl802154_trigger_scan
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        syzbot <syzbot+bd85b31816913a32e473@syzkaller.appspotmail.com>,
        alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Sat, Mar 4, 2023 at 9:16=E2=80=AFAM 'Miquel Raynal' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> > I believe this is fixed here:
> >
> > - [PATCH net] ieee802154: Prevent user from crashing the host
> >   https://lore.kernel.org/netdev/20230301154450.547716-1-miquel.raynal@=
bootlin.com/
> >
> > - pull-request: ieee802154 for net 2023-03-02
> >   https://lore.kernel.org/netdev/20230302153032.1312755-1-stefan@datenf=
reihafen.org/
>
> Hopefully, yes :)
>
> Thanks,
> Miqu=C3=A8l

Let's tell syzbot about the fix:

#syz fix: ieee802154: Prevent user from crashing the host
