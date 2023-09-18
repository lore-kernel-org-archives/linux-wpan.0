Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D98CD3421
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 23:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjIRXCX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 19:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIRXCW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 19:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EA8F
        for <linux-wpan@vger.kernel.org>; Mon, 18 Sep 2023 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695078089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84tq1/HWKdqyn9xUbNRRu/FsaxXpGe6unkYsbFc8YX4=;
        b=BCRuWQc8BQFnPVDMQ394FXqfMD5KYrV4rMEjwmBaEQur0efqn4at7oPBA9V0rO1Zb/9M1Q
        KWDbZZ93c10ScbBZe8t+6cfsXK+E0jcJ01CRD2/B08eMVSFrsC/nnHDKrBnWNPgH3ZGYad
        30xnAH/EgATzXhDKES1EO9fIZEAIyU0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-f3ivlwZcP1u75b0-9IPt1Q-1; Mon, 18 Sep 2023 19:01:26 -0400
X-MC-Unique: f3ivlwZcP1u75b0-9IPt1Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9adc78b386cso255900866b.0
        for <linux-wpan@vger.kernel.org>; Mon, 18 Sep 2023 16:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695078086; x=1695682886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84tq1/HWKdqyn9xUbNRRu/FsaxXpGe6unkYsbFc8YX4=;
        b=r0lECTFng/2lUp6/fS74amKC34HN/zB/IKULr2ipUIkUISQ+Aec726FmkyD/5ivbjQ
         /rykjQpiDZp2iN9Y/MqotNJQYYS+Q0Hp37f3XIsSIcute1q1/PMWiq4/zRnwstjyPuZq
         rLPeJ+4Y+ccXF+jOlhId114alxxUVg37mNnOaeVp4XZV31R/BhN9bwW9M4jKy2U/5GAA
         hrfU0WvZCYe45MrepoRqRigEhVfCPsDHy68I1rOkNNtm1bWfub+YOoBpAg9BIrlXpuAs
         9e1XC+JhumnExrqwQWx/RWWD5e+dbEK1Uzyd3CYilLLsT/A7ZIILsvdieDSMHe5eIZAR
         ZSkw==
X-Gm-Message-State: AOJu0YyUt3rclVPpphQLCnMqOagrLMG6iuUO41PYmzirJGmDSLR1VAyP
        zMoGC05xCGONHfXojFdalaxcs7wiiOcaO7iMqNocNYnteMHtZv7S3UybJJ+HzRhDJSeTao52c7N
        aYpnZuAi5fxusXLsvKYz1z5sxh3AwwWreMeAqOA==
X-Received: by 2002:a17:906:23f1:b0:9ad:e18a:734 with SMTP id j17-20020a17090623f100b009ade18a0734mr7659082ejg.26.1695078085932;
        Mon, 18 Sep 2023 16:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZb740y3CJWM79Ipv7jWnaLd2HvL5Ms/v2bRprk8HjmElljLYl0tycSr2t52+5ywuSL2GObd4afK6ypcux+7E=
X-Received: by 2002:a17:906:23f1:b0:9ad:e18a:734 with SMTP id
 j17-20020a17090623f100b009ade18a0734mr7659068ejg.26.1695078085662; Mon, 18
 Sep 2023 16:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
 <20230901170501.1066321-3-miquel.raynal@bootlin.com> <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
 <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
 <20230918110102.19a43db1@xps-13> <CAK-6q+gcqr=Sgswgzd1pzMQoPEV1jG=_0m51+HsKU_=1b7NYUg@mail.gmail.com>
 <20230918161502.69818794@xps-13>
In-Reply-To: <20230918161502.69818794@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 18 Sep 2023 19:01:14 -0400
Message-ID: <CAK-6q+g5d=LNfqTLpFTTPcscjHqoGGyUOtb+M9unTbE-Jpwxbg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 18, 2023 at 10:15=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
>
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * IEEE 802.15.4 PAN management
> > > > > > + *
> > > > > > + * Copyright (C) 2021 Qorvo US, Inc
> > > > > > + * Authors:
> > > > > > + *   - David Girault <david.girault@qorvo.com>
> > > > > > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <net/cfg802154.h>
> > > > > > +#include <net/af_ieee802154.h>
> > > > > > +
> > > > > > +static bool cfg802154_same_addr(struct ieee802154_pan_device *=
a,
> > > > > > +                             struct ieee802154_addr *b)
> > > > > > +{
> > > > > > +     if (!a || !b)
> > > > > > +             return false;
> > > > > > +
> > > > > > +     switch (b->mode) {
> > > > > > +     case IEEE802154_ADDR_SHORT:
> > > > > > +             return a->short_addr =3D=3D b->short_addr;
> > > > > > +     case IEEE802154_ADDR_LONG:
> > > > > > +             return a->extended_addr =3D=3D b->extended_addr;
> > > > > > +     default:
> > > > > > +             return false;
> > > > > > +     }
> > > > > > +}
> > > > >
> > > > > Don't we already have such a helper already?
> > > >
> > > > There must also be a check on (a->mode !=3D b->mode) because short_=
addr
> > > > and extended_addr share memory in this struct.
> > >
> > > True.
> > >
> > > Actually the ieee802154_addr structure uses an enum to store either
> > > the short address or the extended addres, while at the MAC level I'd
> > > like to compare with what I call a ieee802154_pan_device: the PAN
> > > device is part of a list defining the associated neighbors and contai=
ns
> > > both an extended address and a short address once associated.
> > >
> > > I do not want to compare the PAN ID here and I do not need to compare
> > > if the modes are different because the device the code is running on
> > > is known to have both an extended address and a short address field
> > > which have been initialized.
> > >
> >
> > I see, so it is guaranteed that the mode value is the same?
>
> I looked more carefully at the code of the association section,
> we will always know the extended address of the devices which are
> associated to us, however there may be situations where the second
> device to compare with this list only comes with a short address and pan
> ID, so your initial comment needs to be addressed.
>
> > > With all these constraints, I think it would require more code to
> > > re-use that small function than just writing a slightly different one
> > > here which fully covers the "under association/disassociation" case, =
no?
> > >
> >
> > I am questioning here currently myself if it's enough to uniquely
> > identify devices with only short or extended. For extended I would say
> > yes, for short I would say no.
>
> As long as we know the PAN ID, it should be fine.
>

yep, so you will add a check of panid when mode is short address type?

- Alex

