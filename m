Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA39E743D3
	for <linux-wpan@archiver.kernel.org>; Fri, 29 Sep 2023 00:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjI2AUp (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2AUo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 28 Sep 2023 20:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE11180
        for <linux-wpan@vger.kernel.org>; Thu, 28 Sep 2023 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695946798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfVWLVBAfMWK9MpxlC2iz+amb1udFc1jlzh2Yg5zYa8=;
        b=TeuRIIv7rllm9EthPJ4yTQAPzkusvgrU6x8uoZuPORKSA1prKpZxhFeKtgh/pBRgE3CJcg
        XtihbHNZTHpmB0BM759od/xJtx6B4jmu/CFObXjTxGutgchR9GDY9KeGVodxkVFREXJ52i
        zZnTQJcHtnRzCfpgmaap77QbEcLEc+A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-hVoeKDtfMeWqccBNpdGKEA-1; Thu, 28 Sep 2023 20:19:55 -0400
X-MC-Unique: hVoeKDtfMeWqccBNpdGKEA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae686dafedso1150170066b.3
        for <linux-wpan@vger.kernel.org>; Thu, 28 Sep 2023 17:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946794; x=1696551594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfVWLVBAfMWK9MpxlC2iz+amb1udFc1jlzh2Yg5zYa8=;
        b=LAY8oYM8lfEkLcFXNID+1lPEYWllnYckCNw/UOyxm8WEGIk58LtMT2bI1HErAZGwQ3
         bSXD/88vli2svg9N9fA5+xI8dImhL2SRopcweTbEo8mkUYSCbzyyt1MTPXLDCQzQrzHK
         YsSmE4SswCAGJHhpgcv3sy9CAx6RyyJQ01wZSXLjuKSFcyaIZ7aFaiby69npdqdFv2GL
         fDJCFUy41wgVeGGthBpzMphLkPg/tJH/a6edKtiLJ6V6hCyr5IaL/s59iTuGMMz3CvVN
         HLjZBIZ2kUzFRqR8VEyQgOBWOYVbC8zAHsxbEjRC2qv/O5FrDTKuw3tbnLAZl8oNsJbY
         tr8w==
X-Gm-Message-State: AOJu0YxdnTiO3t5io1rgIrQ6mS9iaQrLKc5Q7HOa+1BxpY8g8uxvqKul
        knaOLPqr2IfcwGPRZ2OONJJy2VGNshkadABWIxcKvLcrJMsKto7+ix4I8jLMTl3RETRhZy9lvoc
        7dXgMP2T41XLFfyysvBLUAWZGSXWt6a+glC2elQ==
X-Received: by 2002:a17:906:3019:b0:9ae:5db5:13d with SMTP id 25-20020a170906301900b009ae5db5013dmr2530175ejz.72.1695946794039;
        Thu, 28 Sep 2023 17:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVdSF5Bg0XljEguOqIP7X4cy9GMK7y9bWjc4k0+15mUmzGbWDpl5XS2/sMXIom9F8+mqIaTFWXIM9I4/Y6Q0=
X-Received: by 2002:a17:906:3019:b0:9ae:5db5:13d with SMTP id
 25-20020a170906301900b009ae5db5013dmr2530159ejz.72.1695946793700; Thu, 28 Sep
 2023 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-8-miquel.raynal@bootlin.com> <CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
 <20230927174037.25708dec@xps-13>
In-Reply-To: <20230927174037.25708dec@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 28 Sep 2023 20:19:42 -0400
Message-ID: <CAK-6q+gzgVuQViEC=uBXDtz8wqPBaf9Je5TywHB9n35L1ZqAzA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Sep 27, 2023 at 11:40=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Tue, 26 Sep 2023 21:37:23 -0400:
>
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Coordinators may have to handle association requests from peers which
> > > want to join the PAN. The logic involves:
> > > - Acknowledging the request (done by hardware)
> > > - If requested, a random short address that is free on this PAN shoul=
d
> > >   be chosen for the device.
> > > - Sending an association response with the short address allocated fo=
r
> > >   the peer and expecting it to be ack'ed.
> > >
> > > If anything fails during this procedure, the peer is considered not
> > > associated.
> >
> > I thought a coordinator can also reject requests for _any_ reason and
> > it's very user specific whatever that reason is.
>
> Absolutely.
>
> > If we have such a case (that it is very user specific what to do
> > exactly) this should be able to be controlled by the user space to
> > have there a logic to tell the kernel to accept or reject the
> > association.
>
> Agreed (not implemented yet, though).
>
> > However, I am fine with this solution, but I think we might want to
> > change this behaviour in the future so that an application in the user
> > space has the logic to tell the kernel to accept or reject an
> > association. That would make sense?
>
> Definitely, yes.

ok, thanks to have some agreement here for the future.

- Alex

