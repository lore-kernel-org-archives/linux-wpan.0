Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186AC433FE
	for <linux-wpan@archiver.kernel.org>; Fri,  4 Nov 2022 00:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDA4q (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDA4q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Nov 2022 20:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E281C402
        for <linux-wpan@vger.kernel.org>; Thu,  3 Nov 2022 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667523351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bu70cyek0T6oUQkJvlNZ6y2ULUUanZ7+edNBuJSUrk=;
        b=OqRwraLN3Exh6fS6INrj7KziD66isGc9JungD8YbopXoPZ7GyTGAaCLT1/6wCIqfSmRqzE
        7K8l+bPqZdbcZB2fTey38vLz9aMXJo8nukgmzy9BbVMdp0Gs0/diOu+we2Or50+XClfuuB
        qTxVT7ituxITGl/T8DRtN8w9dkY9w0c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-yQUS7KBsPDO8O9m6tZt0Rw-1; Thu, 03 Nov 2022 20:55:50 -0400
X-MC-Unique: yQUS7KBsPDO8O9m6tZt0Rw-1
Received: by mail-ed1-f70.google.com with SMTP id c9-20020a05640227c900b00463de74bc15so2422368ede.13
        for <linux-wpan@vger.kernel.org>; Thu, 03 Nov 2022 17:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bu70cyek0T6oUQkJvlNZ6y2ULUUanZ7+edNBuJSUrk=;
        b=L4OvagEZHUrcbFghoHnJdcfVp2L5CBwVCvNyBotshKSnUntDFRQfiTNwDDgWQbOQS0
         KaKJGCjMyZg7xEPPMqdNReikbThrs+Kpo72qBhflIq7izrYzlsMuwL41W3rOULVeXA5Z
         +oU+AQf/qE7nbcvMgFx8Pbk+xJDLQREhMsGF7KWwS2ZBbwKCQBpsxQ+UBLAQw/1C4olo
         cJN4Att6v4JR7dYdFy2KiH0B+tu6af51EvXBiCL0VrYunUiqHw6ucGnfVQWyngdUDFNn
         MSiWHTlyeerrY83f+h6Ar62dotVIf0pbQ24y1EjDhWtNswiIZL0o+u34qJWEOytDVJiy
         uTxw==
X-Gm-Message-State: ACrzQf2PjBjd35NlhTDmA80zg3G84xQcEGJTLNG5Yw0rklyJz2bWHi+h
        /ozRVCfOLYZyj8v15jhf+J5llF2GRPi2B+ttBHBwoKiUqxDN65yRmTEc4Oxg1uiBmNM7KrjMYRd
        BDPpYNXalfmGLQeiGnS2UREfCMCuj4pXCMKochg==
X-Received: by 2002:aa7:dad9:0:b0:462:e628:185b with SMTP id x25-20020aa7dad9000000b00462e628185bmr33269895eds.33.1667523349435;
        Thu, 03 Nov 2022 17:55:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JBM5gBOz2wO5X4Ev6BkgDVLxPc5660eoJpGMo11FEdj4Hf8i2SAHcrGjmMv+l0Efq66jD/X2tRnVLmK/Tv9Q=
X-Received: by 2002:aa7:dad9:0:b0:462:e628:185b with SMTP id
 x25-20020aa7dad9000000b00462e628185bmr33269880eds.33.1667523349230; Thu, 03
 Nov 2022 17:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221026093502.602734-1-miquel.raynal@bootlin.com>
 <CAK-6q+jXPyruvdtS3jgzkuH=f599EiPk7vWTWLhREFCMj5ayNg@mail.gmail.com> <20221102155240.71a1d205@xps-13>
In-Reply-To: <20221102155240.71a1d205@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 3 Nov 2022 20:55:38 -0400
Message-ID: <CAK-6q+hi1dhyfoYAGET55Ku=_in7BbNNaqWQVX2Z_iOg1+0Nyg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/3] IEEE 802.15.4: Add coordinator interfaces
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Nov 2, 2022 at 10:52 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 30 Oct 2022 22:20:03 -0400:
>
> > Hi,
> >
> > On Wed, Oct 26, 2022 at 5:35 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hello,
> > > These three patches allow the creation of coordinator interfaces, which
> > > were already defined without being usable. The idea behind is to use
> > > them advertizing PANs through the beaconing feature.
> > >
> >
> > I still don't know how exactly those "leaves" and "non-leaves" are
> > acting here regarding the coordinator interfaces. If this is just a
> > bit here to set in the interface I am fine with it. But yea,
> > "relaying" feature is a project on its own, as we said previously.
> >
> > Another mail I was asking myself what a node interface is then,
> > currently it is a mesh interface with none of those 802.15.4 PAN
> > management functionality?
>
> Not "none", because I would expect a NODE to be able to perform minimal
> management operations, such as:
> - scanning
> - requesting an association
> But in no case it is supposed to:
> - send beacons
> - manage associations
> - be the PAN coordinator
> - act as a relay
>

perfect, thanks. But still there is something which I don't get.

The split you mentioned about the functionality is for me being a
coordinator (IEEE spec) or pan coordinator (IEEE spec) which has the
additional functionality of "send beacons, manage assocs, act as
relay".
So a coordinator (iftype) is a pan coordinator (IEEE spec) and a node
(iftype) is a coordinator (IEEE spec), but _only_ when it's
associated, before it is just a manually setup mesh node?

I hope it's clear when meaning iftype and when meaning IEEE spec, but
for the manual setup thing (node iftype) there is no IEEE spec,
although it is legal to do it in my opinion.

Thanks.

- Alex

