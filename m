Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED0ECAAD1
	for <linux-wpan@archiver.kernel.org>; Thu,  1 Sep 2022 12:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIAMug (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiIAMuc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2022 08:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97822EE39
        for <linux-wpan@vger.kernel.org>; Thu,  1 Sep 2022 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662036628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVR8ZGAEIG6jlDjc/QlrwfVcZSi0Y+I1JEJbD87FRlM=;
        b=GWzmbg+WO85QlVaDNczXXRg+bY2F0HHRKt98YYJetLOIYI1hdpvv3BhIzrEyhGK/Nd8MKj
        RWJ7+1anh0BePk80bJth3fUdZcK9q6b+sg0asbHlOO7vFozAuTv6eBhRulcEzOIi6ne38x
        h4EZMgLtICxoxzccBQHZe76O3pflxzg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-CZDqqceUN6eJyp8YLTenuw-1; Thu, 01 Sep 2022 08:50:27 -0400
X-MC-Unique: CZDqqceUN6eJyp8YLTenuw-1
Received: by mail-qk1-f197.google.com with SMTP id br15-20020a05620a460f00b006bc58c26501so14114324qkb.0
        for <linux-wpan@vger.kernel.org>; Thu, 01 Sep 2022 05:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WVR8ZGAEIG6jlDjc/QlrwfVcZSi0Y+I1JEJbD87FRlM=;
        b=EfHS88ZeN0wD2X5XjRLtk49na7Imv4wuQmeNC1RtosKWXWT+Qd1Z8Nw4AX35jbJCgF
         WKpmuT0RzRmYcuSm9Bde+5fk3BZzltGPgIDkNmv4I6DvpSjEQ/UGh8Phw8IiVn7B1m9H
         fc+yiIO/MNFZtcaDjoOY948zzPMMHLbekfTTFtl6d7phQmd7NIhMQOJ7Gno6+gTm1Wze
         io/zi32WEn6094d40bspO2DHdw+Curc0KfRkFOL5pD9EfcC2HkFH34VVrDUYOUPhVzh5
         2okQymBxueSBmZ31axi47gfV8KPN2kuFtbo6JMkoKWu+Y1DnNCDY41B9cz0gdKZUhIBI
         0aug==
X-Gm-Message-State: ACgBeo2BwtUW1BXsF1t5E+Uu1tOHeTiP7P6hIr65h/CihIHgY+jfEaJp
        qJQmMeNMIKyomEmyZpmz87hKjqL9uwDFhRNOcyMZY1mmkJzz7Pg27+VraQJewI5XwizNWJ98lPs
        xpm4XqjjJsG3FzvckO3q2+hiiShd7pBZngE74Cw==
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id v2-20020a05622a130200b003448a9d817dmr23373424qtk.339.1662036627275;
        Thu, 01 Sep 2022 05:50:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kObCOgs/8rlva+gwEleVWuBVvZa2Nyj96/+b0fIJuQ008mmaRhNAh00YlyzT5ptnDqJFoMc9wUD036tD5Faw=
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id
 v2-20020a05622a130200b003448a9d817dmr23373413qtk.339.1662036627064; Thu, 01
 Sep 2022 05:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220830101237.22782-1-gal@nvidia.com> <20220830231330.1c618258@kernel.org>
 <4187e35d-0965-cf65-bff5-e4f71a04d272@nvidia.com> <20220830233124.2770ffc2@kernel.org>
 <20220831112150.36e503bd@kernel.org> <36f09967-b211-ef48-7360-b6dedfda73e3@datenfreihafen.org>
 <20220831140947.7e8d06ee@kernel.org> <YxBTaxMmHKiLjcCo@unreal>
In-Reply-To: <YxBTaxMmHKiLjcCo@unreal>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 1 Sep 2022 08:50:16 -0400
Message-ID: <CAK-6q+hdNJymhcuOp9OJVTgiO2MCqa_xUa_MZuQK3toDLMudhw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ieee802154: Fix compilation error when
 CONFIG_IEEE802154_NL802154_EXPERIMENTAL is disabled
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Gal Pressman <gal@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Sep 1, 2022 at 2:38 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 02:09:47PM -0700, Jakub Kicinski wrote:
> > On Wed, 31 Aug 2022 22:59:14 +0200 Stefan Schmidt wrote:
> > > I was swamped today and I am only now finding time to go through mail.
> > >
> > > Given the problem these ifdef are raising I am ok with having these
> > > commands exposed without them.
> > >
> > > Our main reason for having this feature marked as experimental is that
> > > it does not have much exposure and we fear that some of it needs rewrites.
> > >
> > > If that really is going to happen we will simply treat the current
> > > commands as reserved/burned and come up with other ones if needed. While
> > > I hope this will not be needed it is a fair plan for mitigating this.
> >
> > Thanks for the replies. I keep going back and forth in my head on
> > what's better - un-hiding or just using NL802154_CMD_SET_WPAN_PHY_NETNS + 1
> > as the start of validation, since it's okay to break experimental commands.
> >
> > Any preference?
>
> Jakub,
>
> There is no such thing like experimental UAPI. Once you put something
> in UAPI headers and/or allowed users to issue calls from userspace
> to kernel, they can use it. We don't control how users compile their
> kernels.
>
> So it is not break "experimental commands", but break commands that
> maybe shouldn't exist in first place.
>
> nl802154 code suffers from two basic mistakes:
> 1. User visible defines are not part of UAPI headers. For example,
> include/net/nl802154.h should be in include/uapi/net/....

yes, but no because then this will end in breaking UAPI because it
will be exported to uapi headers if we change them?
For now we say everybody needs to copy the header on their own into
their user space application if they want to use the API which means
it fits for the kernel that they copied from.

> 2. Used Kconfig option for pseudo-UAPI header.
>
> In this specific case, I checked that Fedora didn't enable this
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL knob, but someone needs
> to check debian and other distros too.
>

I would remove the CONFIG_IEEE802154_NL802154_EXPERIMENTAL config
option but don't move the header to "include/uapi/..." which means
that the whole nl802154 UAPI (and some others UAPIs) are still
experimental because it's not part of UAPI "directory".
btw: the whole subsystem is still experimental because f4671a90c418
("net/ieee802154: remove depends on CONFIG_EXPERIMENTAL") was never
acked by any maintainer... but indeed has other reasons why it got
removed.

- Alex

