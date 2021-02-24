Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A0EC433E0
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B1F64DAF
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 01:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBXBGP (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233253AbhBXAuJ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 23 Feb 2021 19:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC06614A7;
        Wed, 24 Feb 2021 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614127768;
        bh=wlubzpWgvnu0LkdUcpm43QontFBvWFgIA554YvBAuhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n8QTUWe5/IKXHhXC9FEXhIMP5ea1OS7j7IaW4acio6j7fXq7CV9vTFz+NYoD5A/WA
         EXKFIwwr/0t2Qjlletof3k87VvKt+lF5m2G2ypIlFlPswUDMe7japOfWhzq3qWRuX1
         jfRDgkCmU/PzJ2c5EHwLUAryVhj3pP3CF4jYRBPjguVI6lYzcdNw9tB9hNKw8d8dxK
         ty+KfAryWh4u/eNgFwpmkl7gyxkIRLQOvby/kbaBQB6Kz/eMOgRQcgvv5fRnMaaKeC
         6oONx2yiQmIuoPv0/7Sjo6CrcxvVBRZbe5f3HptRU+FMwJODTZ3JKBBHlvgiN3m8kD
         gL8TFcu07DXsA==
Date:   Tue, 23 Feb 2021 16:49:24 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     syzbot <syzbot+7bf7b22759195c9a21e9@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: UBSAN: shift-out-of-bounds in nl802154_new_interface
Message-ID: <20210223164924.080fa605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAB_54W6FL2vDto3_1=0kAa8qo_qTduCfULLCfvD_XbS4=+VZyw@mail.gmail.com>
References: <000000000000e37c9805bbe843c1@google.com>
        <20210223154855.669413bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAB_54W6FL2vDto3_1=0kAa8qo_qTduCfULLCfvD_XbS4=+VZyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Tue, 23 Feb 2021 19:26:26 -0500 Alexander Aring wrote:
> Hi,
> 
> On Tue, 23 Feb 2021 at 18:48, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Alex, there seems to be a few more syzbot reports for nl802154 beyond
> > what you posted fixes for. Are you looking at these?  
> 
> Yes, I have it on my list. I will try to fix them at the weekend.

Great, thank you!
