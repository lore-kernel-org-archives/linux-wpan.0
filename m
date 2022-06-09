Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0391C43334
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Jun 2022 01:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiFIB5K (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 8 Jun 2022 21:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFIB5K (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Jun 2022 21:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B667D1E4BD3
        for <linux-wpan@vger.kernel.org>; Wed,  8 Jun 2022 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654739826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXhU2yLuFUW+Y1jzIoJ7mNQGYBtFKdFOGgD8xlAg/uA=;
        b=XgYcm01DiT0gZV4HJ4FqfN7Dcg9voipgWZh3G9xJk+oRAZCJiej8yvwvo84u0wv4O56/7/
        emp3JiTUzEZFfn2lS7eLUcLjqfvtg9gEAhbfSPZL4lyRugKqIB/UqJ8HgS0c89KOyHYNZd
        IvuOxdfUgzT4PiY26mQ3RJGXeeh77Ek=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-EQAdpVpaMMmeBHxTP1D3ag-1; Wed, 08 Jun 2022 21:57:05 -0400
X-MC-Unique: EQAdpVpaMMmeBHxTP1D3ag-1
Received: by mail-qv1-f70.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so14050368qvb.21
        for <linux-wpan@vger.kernel.org>; Wed, 08 Jun 2022 18:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXhU2yLuFUW+Y1jzIoJ7mNQGYBtFKdFOGgD8xlAg/uA=;
        b=lx6u7nADlOpE2jLfWBx01P07gKf+/YXWBuN2FH0B1cWQxftx5ekGRTn5/im7025JcI
         qeWX+ksvsVGAkKgpxiKcSxquug5lt/JvPaS035+iSU+i/SuyH/+62qMEZKQRxiEVJq9x
         2NGstS0eIOADhP0pt62vvSAokrdnijLjihF3UUArakazqWwwadEjvbIr5SCRyI6H39S3
         aB8Z1KIJge+EkL7EiMq4xpcvvBR0ESjHQR+7CY5b6OvQNWw7XSWf4bus9KRPBPLz7NPB
         IsZO98RnJQHcR5e01QSpvAqYiqBiz1Mde9UIuF8k87kGPBcMHY5tj42ayx1vW+mdQ2pl
         yW4w==
X-Gm-Message-State: AOAM533hvdlGM/nb56QDSjVvG4L6fkcs2V5GZRvfYUxKnTyUAASiHzEs
        9jJz0uZqJlDVzzWIVDktQod0q/Y4S3vGlsA5/NFJqDTKyrp/x4fcXgLWMvh5CJHQ1cZt6wGWgSG
        W4VBAYlSFKkGgu6w4nmmXyXncRQIwr+0ug2jshA==
X-Received: by 2002:a37:7d0:0:b0:6a6:ad21:b4f9 with SMTP id 199-20020a3707d0000000b006a6ad21b4f9mr16720139qkh.27.1654739824978;
        Wed, 08 Jun 2022 18:57:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ3FDiDrng3dXxlEpQneMbqEZ8Fn3z9JSzzkcYRNM2DqT9jrzecgyqsxFC1I7ZF4+/QM4y5dNW//vv2wRBrkU=
X-Received: by 2002:a37:7d0:0:b0:6a6:ad21:b4f9 with SMTP id
 199-20020a3707d0000000b006a6ad21b4f9mr16720116qkh.27.1654739824699; Wed, 08
 Jun 2022 18:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220603182143.692576-1-miquel.raynal@bootlin.com>
 <20220603182143.692576-2-miquel.raynal@bootlin.com> <CAK-6q+hAZMqsN=S9uWAm4rTN+uZwz7_L42=emPHz7+MvfW6ZpQ@mail.gmail.com>
 <20220606174319.0924f80d@xps-13> <CAK-6q+itswJrmy-AhZ5DpnHH0UsfAeTPQTmX8WfG8=PteumVLg@mail.gmail.com>
 <20220607181608.609429cb@xps-13> <20220608154749.06b62d59@xps-13>
In-Reply-To: <20220608154749.06b62d59@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 8 Jun 2022 21:56:53 -0400
Message-ID: <CAK-6q+iOG+r8fFa6_x4egHBUxxGLE+sYf2fKvPkY5T-MvvGiCQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] net: ieee802154: Drop coordinator interface type
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Jun 8, 2022 at 9:47 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alex,
>
> > > 3. coordinator (any $TYPE specific) userspace software
> > >
> > > May the main argument. Some coordinator specific user space daemon
> > > does specific type handling (e.g. hostapd) maybe because some library
> > > is required. It is a pain to deal with changing roles during the
> > > lifetime of an interface and synchronize user space software with it.
> > > We should keep in mind that some of those handlings will maybe be
> > > moved to user space instead of doing it in the kernel. I am fine with
> > > the solution now, but keep in mind to offer such a possibility.
> > >
> > > I think the above arguments are probably the same why wireless is
> > > doing something similar and I would avoid running into issues or it's
> > > really difficult to handle because you need to solve other Linux net
> > > architecture handling at first.
> >
> > Yep.
>
> The spec makes a difference between "coordinator" and "PAN
> coordinator", which one is the "coordinator" interface type supposed to
> picture? I believe we are talking about being a "PAN coordinator", but
> I want to be sure that we are aligned on the terms.
>

I think it depends what exactly the difference is. So far I see for
address filtering it should be the same. Maybe this is an interface
option then?

> > > > > You are mixing things here with "role in the network" and what
> > > > > the transceiver capability (RFD, FFD) is, which are two
> > > > > different things.
> > > >
> > > > I don't think I am, however maybe our vision differ on what an
> > > > interface should be.
> > > >
> > > > > You should use those defines and the user needs to create a new
> > > > > interface type and probably have a different extended address
> > > > > to act as a coordinator.
> > > >
> > > > Can't we just simply switch from coordinator to !coordinator
> > > > (that's what I currently implemented)? Why would we need the user
> > > > to create a new interface type *and* to provide a new address?
> > > >
> > > > Note that these are real questions that I am asking myself. I'm
> > > > fine adapting my implementation, as long as I get the main idea.
> > > >
> > >
> > > See above.
> >
> > That's okay for me. I will adapt my implementation to use the
> > interface thing. In the mean time additional details about what a
> > coordinator interface should do differently (above question) is
> > welcome because this is not something I am really comfortable with.
>
> I've updated the implementation to use the IFACE_COORD interface and it
> works fine, besides one question below.
>
> Also, I read the spec once again (soon I'll sleep with it) and
> actually what I extracted is that:
>
> * A FFD, when turned on, will perform a scan, then associate to any PAN
>   it found (algorithm is beyond the spec) or otherwise create a PAN ID
>   and start its own PAN. In both cases, it finishes its setup by
>   starting to send beacons.
>

What does it mean "algorithm is beyond the spec" - build your own?

> * A RFD will behave more or less the same, without the PAN creation
>   possibility of course. RFD-RX and RFD-TX are not required to support
>   any of that, I'll assume none of the scanning features is suitable
>   for them.
>
> I have a couple of questions however:
>
> - Creating an interface (let's call it wpancoord) out of wpan0 means
>   that two interfaces can be used in different ways and one can use
>   wpan0 as a node while using wpancoord as a PAN coordinator. Is that
>   really allowed? How should we prevent this from happening?
>

When the hardware does not support it, it should be forbidden. As most
transceivers have only one address filter it should be forbidden
then... but there exists a way to indeed have such a setup (which you
probably don't need to think about). It's better to forbid something
now, with the possibility later allowing it. So it should not break
any existing behaviour.

> - Should the device always wait for the user(space) to provide the PAN
>   to associate to after the scan procedure right after the
>   add_interface()? (like an information that must be provided prior to
>   set the interface up?)
>
> - How does an orphan FFD should pick the PAN ID for a PAN creation?
>   Should we use a random number? Start from 0 upwards? Start from
>   0xfffd downwards? Should the user always provide it?
>

I think this can be done all with some "fallback strategies" (build
your own) if it's not given as a parameter.

> - Should an FFD be able to create its own PAN on demand? Shall we
>   allow to do that at the creation of the new interface?
>

I thought the spec said "or otherwise"? That means if nothing can be
found, create one?

- Alex

