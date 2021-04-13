Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7EC433ED
	for <linux-wpan@archiver.kernel.org>; Tue, 13 Apr 2021 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9954613DA
	for <linux-wpan@archiver.kernel.org>; Tue, 13 Apr 2021 08:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhDMIdW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhDMIdV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Apr 2021 04:33:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0BC061574
        for <linux-wpan@vger.kernel.org>; Tue, 13 Apr 2021 01:33:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q189so6624903qka.8
        for <linux-wpan@vger.kernel.org>; Tue, 13 Apr 2021 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nrqvVxvltpzH7RYZqpvLzY8XnwRwce2q6/g0kk8slc=;
        b=QAOG0RG8adp5ycX0lJkHwnEJPjkPyROHvocgANgIV0TKKHsqDrBvWVkwkq0BMm3fl0
         pREAlHcCXQ5OYela9E9tkJ+wZ2gDhE734EADbRRQ+Ag9u5PxdtAOEXpyaC8+pYFRDZmK
         l8brOtdr8mZdh2GQ+udPuWKEUwz5HbwWkfsBfEdZrslLlB+s3NDz+mf5B3Hx7cbqaBnj
         lA7G3VKGQUJ0eAyrGYvUHMDbMd0HEVuDJwjc4SxzCwXRuUZyClngI3BKmCWooSluJggB
         oq/VXu9s2qS04lfZtV1WOSmyn5+nDLEV3hZCamvFizFtXYnll6OekZ/41AIHgdRlRKlI
         sKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nrqvVxvltpzH7RYZqpvLzY8XnwRwce2q6/g0kk8slc=;
        b=PeP/TzugzXPxhkBPcSCcwLKQJZkZ8In3R6vXqv/YsujVrOh37/7stg7gOaYwYc3aKo
         dCrcZfAso3RDho464qthfMQYt36BePc49R9fSAFDk5OIW7U7Lddbz+tBpv1MtAzQ9aK9
         7J1HpXR3b3i1tAll+juukm058fsdQU8fWZI9LKHQI0btIy62ZjpazS7GGHslBumTn3Gy
         VTHPeP3wGFl9lzHzvD4dFIGCI43XrL2hNlwTIK70OPWHIH6IJ13fU0v4MRsvSbuFMJBh
         InsM92QBCjQhaCBgY/JZnD4ecuKJVETzgj7Ov2Oa9yuwTK23yUuGSsbzs+vRJMAQfTbW
         pnug==
X-Gm-Message-State: AOAM531bSbUhS6HU6AexlboseKghjrDKX6WV2vpp6Lni5VgCrBXoHtta
        mp+AgQ3hn3itutRO9mHL9xzRsInif9zY3cvh2+5SWQ==
X-Google-Smtp-Source: ABdhPJz+1ReMEouOSg1zddV3GpTwRAtGceqbdLT5e7gbK5z0KeIyb0y7vjOodqSziBb/LhSo5KaJKtJZG8vCt6jwMU4=
X-Received: by 2002:a05:620a:a47:: with SMTP id j7mr8648989qka.350.1618302780925;
 Tue, 13 Apr 2021 01:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000073afff05bbe9a54d@google.com> <00000000000020564605bedb716e@google.com>
 <20210401133037.GA1052133@rowland.harvard.edu>
In-Reply-To: <20210401133037.GA1052133@rowland.harvard.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 10:32:50 +0200
Message-ID: <CACT4Y+ZMFwTLrdK+8YZifJR_7V21gwOxbVKnbRP3Yj=YQ+k7xQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ieee802154_del_seclevel
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com>,
        a@unstable.cc, alex.aring@gmail.com,
        b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>, info@sophiescuban.com,
        Jiri Kosina <jkosina@suse.cz>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-wpan@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev <netdev@vger.kernel.org>,
        stefan@datenfreihafen.org, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Thu, Apr 1, 2021 at 3:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Mar 31, 2021 at 02:03:08PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 416dacb819f59180e4d86a5550052033ebb6d72c
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Wed Aug 21 17:27:12 2019 +0000
> >
> >     HID: hidraw: Fix invalid read in hidraw_ioctl
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000
> > start commit:   6e5a03bc ethernet/netronome/nfp: Fix a use after free in n..
> > git tree:       net
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117430fcd00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167430fcd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fbf4fc11a819824e027b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfe45ed00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e31ad00000
> >
> > Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com
> > Fixes: 416dacb819f5 ("HID: hidraw: Fix invalid read in hidraw_ioctl")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> It seems likely that the bisection ran off the rails here.  This commit
> could not have caused a problem, although it may have revealed a
> pre-existing problem that previously was hidden.

Hi Alan,

Yes, bisection log shows it was derailed by:
KASAN: use-after-free Read in batadv_iv_ogm_queue_add
and:
BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000


> By the way, what happened to the annotated stack dumps that syzkaller
> used to provide in its bug reports?

Nothing has changed in this respect, they are still in bug reports:
https://lore.kernel.org/lkml/00000000000073afff05bbe9a54d@google.com/
