Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F018C43334
	for <linux-wpan@archiver.kernel.org>; Tue, 28 Jun 2022 01:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiF1BcY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 27 Jun 2022 21:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiF1BcY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jun 2022 21:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 178D7766D
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jun 2022 18:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656379942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcYVHXxGBnOYEGhzCHF8lo04nDB7g96tSHfI/rswQ9M=;
        b=GbyNA6rwQVSD60mYWR2U7JRNxStPVdnD6Hn++9D2ic5elZSGa7Wgucf0snVeNiJyT6QOpi
        HJPO0fIgPO2dvkxBk89ZvPD0lXhs8WeaPpibBA0Fw1WOdUgTiQUjV5666iUWYretHMVFXi
        WEV72SpfX3j8izXtSYDPvdcQlogtJ3w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-6SQT6mVHPZOBSviClRBkWA-1; Mon, 27 Jun 2022 21:32:20 -0400
X-MC-Unique: 6SQT6mVHPZOBSviClRBkWA-1
Received: by mail-qv1-f71.google.com with SMTP id jv13-20020a05621429ed00b0047048fce5bdso10903847qvb.5
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jun 2022 18:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcYVHXxGBnOYEGhzCHF8lo04nDB7g96tSHfI/rswQ9M=;
        b=haJ7OXyJyE4dGQ4ran3Xl2ihEbq6ZY3wfALaRVY//AgiFFcqKznwsYB4V1UY4JpOmc
         uC1JSsbxLkf48/mRW3+TDXKs2uw/6MHkES0vlYDfJy4qFL9q5UMu/T2Ce4Bx+xPFIXrQ
         aby8b5mFj+0bREYAb6v9PzmtDqERwoyymFQJ5pigfZ7uOQgjbMOrM8xgnopRxvy+gtED
         PqqtfAdGXR3NHEP4s+8yzxkRRd9tVvZiEW4h5QXDMPbv9xdhRa3RiGQ6uB3w5q9ulWaY
         bwuE5DE4DpNYZrySEwm92hPjubCp0tL5vJiHOGBiGuxmzck7eweNlwbs7a0SvS1PJztn
         FYmw==
X-Gm-Message-State: AJIora/n83Bnhl1WbR7TkOkkNgXOjiyqatVSoghFXB7UW2LcIKEi1n8Z
        n+yBuXzACnfRhoO+QmmZZMhIc9Le4/ERVZGR2Dy1ZJP8iDiV/UihThX8sS4Ybq1MWyDfqOvwV6i
        ZXgPIX0Xczgq5G41HozYLgu2kFxU842UlWKubNw==
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id 9-20020ac85749000000b003051ea504a7mr11206472qtx.291.1656379940178;
        Mon, 27 Jun 2022 18:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tknq14nu9SqF1/lvxL3/3rsikrCHJ960wI3YRH5SNDdeG8n4vmCKNgmAmCUC//GAUz8Gv7iUPmFFibAXHmH6c=
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id
 9-20020ac85749000000b003051ea504a7mr11206453qtx.291.1656379939963; Mon, 27
 Jun 2022 18:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134018.62414-1-miquel.raynal@bootlin.com>
 <20220620134018.62414-3-miquel.raynal@bootlin.com> <CAK-6q+jAhikJq5tp-DRx1C_7ka5M4w6EKUB_cUdagSSwP5Tk_A@mail.gmail.com>
 <20220627104303.5392c7f6@xps-13>
In-Reply-To: <20220627104303.5392c7f6@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 21:32:08 -0400
Message-ID: <CAK-6q+jYFeOyP_bvTd31av=ntJA=Qpas+v+xRDQuMNb74io2Xw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 2/4] net: ieee802154: Add support for inter
 PAN management
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
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

On Mon, Jun 27, 2022 at 4:43 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sat, 25 Jun 2022 22:29:08 -0400:
>
> > Hi,
> >
> > On Mon, Jun 20, 2022 at 10:26 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Let's introduce the basics for defining PANs:
> > > - structures defining a PAN
> > > - helpers for PAN registration
> > > - helpers discarding old PANs
> > >
> >
> > I think the whole pan management can/should be stored in user space by
> > a daemon running in background.
>
> We need both, and currently:
> - while the scan is happening, the kernel saves all the discovered PANs
> - the kernel PAN list can be dumped (and also flushed) asynchronously by
>   the userspace
>
> IOW the userspace is responsible of keeping its own list of PANs in
> sync with what the kernel discovers, so at any moment it can ask the
> kernel what it has in memory, it can be done during a scan or after. It
> can request a new scan to update the entries, or flush the kernel list.
> The scan operation is always requested by the user anyway, it's not
> something happening in the background.
>

I don't see what advantage it has to keep the discovered pan in the
kernel. You can do everything with a start/stop/pan discovered event.
It also has more advantages as you can look for a specific pan and
stop afterwards.
At the end the daemon has everything that the kernel also has, as you
said it's in sync.

> > This can be a network manager as it
> > listens to netlink events as "detect PAN xy" and stores it and offers
> > it in their list to associate with it.
>
> There are events produced, yes. But really, this is not something we
> actually need. The user requests a scan over a given range, when the
> scan is over it looks at the list and decides which PAN it
> wants to associate with, and through which coordinator (95% of the
> scenarii).
>

This isn't either a kernel job to decide which pan it will be associated with.

> > We need somewhere to draw a line and I guess the line is "Is this
> > information used e.g. as any lookup or something in the hot path", I
> > don't see this currently...
>
> Each PAN descriptor is like 20 bytes, so that's why I don't feel back
> keeping them, I think it's easier to be able to serve the list of PANs
> upon request rather than only forwarding events and not being able to
> retrieve the list a second time (at least during the development).
>

This has nothing to do with memory.

> Overall I feel like this part is still a little bit blurry because it
> has currently no user, perhaps I should send the next series which
> actually makes the current series useful.
>

Will it get more used than caching entries in the kernel for user
space? Please also no in-kernel association feature.

We can maybe agree to that point to put it under
IEEE802154_NL802154_EXPERIMENTAL config, as soon as we have some
_open_ user space program ready we will drop this feature again...
this program will show that there is no magic about it.

- Alex

