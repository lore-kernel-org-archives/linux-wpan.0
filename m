Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE11C433B4
	for <linux-wpan@archiver.kernel.org>; Thu,  1 Apr 2021 19:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061136100A
	for <linux-wpan@archiver.kernel.org>; Thu,  1 Apr 2021 19:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhDATD2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:03:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33157 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235720AbhDAS5U (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Apr 2021 14:57:20 -0400
Received: (qmail 1052805 invoked by uid 1000); 1 Apr 2021 09:30:37 -0400
Date:   Thu, 1 Apr 2021 09:30:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com>
Cc:     a@unstable.cc, alex.aring@gmail.com,
        b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
        info@sophiescuban.com, jkosina@suse.cz, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        stefan@datenfreihafen.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in ieee802154_del_seclevel
Message-ID: <20210401133037.GA1052133@rowland.harvard.edu>
References: <00000000000073afff05bbe9a54d@google.com>
 <00000000000020564605bedb716e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020564605bedb716e@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, Mar 31, 2021 at 02:03:08PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 416dacb819f59180e4d86a5550052033ebb6d72c
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Aug 21 17:27:12 2019 +0000
> 
>     HID: hidraw: Fix invalid read in hidraw_ioctl
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127430fcd00000
> start commit:   6e5a03bc ethernet/netronome/nfp: Fix a use after free in n..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=117430fcd00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167430fcd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> dashboard link: https://syzkaller.appspot.com/bug?extid=fbf4fc11a819824e027b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bfe45ed00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1188e31ad00000
> 
> Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com
> Fixes: 416dacb819f5 ("HID: hidraw: Fix invalid read in hidraw_ioctl")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

It seems likely that the bisection ran off the rails here.  This commit 
could not have caused a problem, although it may have revealed a 
pre-existing problem that previously was hidden.

By the way, what happened to the annotated stack dumps that syzkaller 
used to provide in its bug reports?

Alan Stern
