Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8056E743D0
	for <linux-wpan@archiver.kernel.org>; Fri, 29 Sep 2023 00:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjI2AX1 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2AX1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 28 Sep 2023 20:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9347F3
        for <linux-wpan@vger.kernel.org>; Thu, 28 Sep 2023 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695946958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=666yXX+Rj9/y3DrZAVThOB3jlkyaoQEETt9yyPl70zw=;
        b=f9hhpxzWkcGMkvYq1mhpePDRMaC+7Hd/ok4mtHb+L8l/Tqqt+E9csjtyOmmUNZ7IlPbf0w
        YELZG22smG9JHwo+z2iaWV/9g3niU9cQrBz/xzOpp2CjYQy/sannvZrysK8CGA+J/K1co9
        4rsaRi/CrDcOkn+ZcFZUTotdkBSLXQM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-2IwOA_MYNqGVom9be6nTow-1; Thu, 28 Sep 2023 20:22:37 -0400
X-MC-Unique: 2IwOA_MYNqGVom9be6nTow-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so1195190866b.3
        for <linux-wpan@vger.kernel.org>; Thu, 28 Sep 2023 17:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946956; x=1696551756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=666yXX+Rj9/y3DrZAVThOB3jlkyaoQEETt9yyPl70zw=;
        b=X3uWOkzAuIY2RZSWoFAkJPs5mze15eKn8Ht9ZC5gBDM2O5jV6Mq/sgap1prxp3Rd9a
         4cFWqwPdlNdmhwXyZk2KiHJOSqmedYP3UtZa4/ZXEORfRUyVBrciJzofzPazlSXVUkQY
         TiederpHwFqggBSmkHvHOtCk/OWHyHkpFGAT5P/aRulPk/YOpG3DtNZ3Vd9HNq9s4sy2
         GbyKO80g2ZFtbPy9u+6e1PdXevrEu1HzLYJ5UY9zu9lWLJEaPISN3pzTfaptsDH1Z0pt
         FfpvbVt3xUU6YLLlSXDLy/A8CJUI/SN2X7ODk1jwCDQU0MuPPPDTCDBaW+rk6dx+WhFx
         evlw==
X-Gm-Message-State: AOJu0YxeDycpUs5ef26pm+KbqLDQe6548nPOM3NfYx5Ky+xFFmSTRbEN
        5ij2k6UK0QHZOxCrSJp4wC+NxY39O2M8ZOUCk+AuMgSdcoh/t82772RGfMRV537fw0Zw7jMnYA2
        suriLMR3c7UTl0LbH74yFxQayEwhNivdtqFYBIs/u9Uw5Mw==
X-Received: by 2002:a17:906:6a19:b0:9a9:eef6:434a with SMTP id qw25-20020a1709066a1900b009a9eef6434amr3035475ejc.36.1695946935881;
        Thu, 28 Sep 2023 17:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuppoHwvTpg1KFZiUtD4X/AbtaNHLSnQmyb2ostcKahHEJUcmjUOWI8ySL6L2H5t5oBG/K96u1mTGkfAeXB9Y=
X-Received: by 2002:a17:906:6a19:b0:9a9:eef6:434a with SMTP id
 qw25-20020a1709066a1900b009a9eef6434amr3035448ejc.36.1695946935564; Thu, 28
 Sep 2023 17:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-3-miquel.raynal@bootlin.com> <CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
 <20230927175635.2404e28a@xps-13>
In-Reply-To: <20230927175635.2404e28a@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 28 Sep 2023 20:22:04 -0400
Message-ID: <CAK-6q+iWit1KoHfz-sQOLD3MiONcaHXAJHbL02V3srLx4C7X2Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
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

On Wed, Sep 27, 2023 at 12:10=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <net/cfg802154.h>
> > > +#include <net/af_ieee802154.h>
> > > +
> > > +/* Checks whether a device address matches one from the PAN list.
> > > + * This helper is meant to be used only during PAN management, when =
we expect
> > > + * extended addresses to be used.
> > > + */
> > > +static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pa=
n_dev,
> > > +                                   struct ieee802154_addr *ext_dev)
> > > +{
> > > +       if (!pan_dev || !ext_dev)
> > > +               return false;
> > > +
> > > +       if (ext_dev->mode =3D=3D IEEE802154_ADDR_SHORT)
> > > +               return false;
> > > +
> > > +       switch (ext_dev->mode) {
> > > +       case IEEE802154_ADDR_SHORT:
> > > +               return pan_dev->short_addr =3D=3D ext_dev->short_addr=
;
> >
> > This is dead code now, it will never be reached, it's checked above
> > (Or I don't see it)? I want to help you here. What exactly do you try
> > to reach here again?
>
> It's a left over. All association/disassociation operation so far which
> need these checks are operated using extended addressing (from the
> spec). I will simplify further this helper.
>

I see, it makes sense to me.

>
> > > +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> > > +                               struct ieee802154_addr *target)
> > > +{
> > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > +
> > > +       if (cfg802154_device_in_pan(wpan_dev->parent, target))
> > > +               return true;
> > > +
> > > +       return false;
> >
> > return cfg802154_device_in_pan(...); Why isn't checkpatch warning about=
 that?
>
> checkpatch does not care I guess, but I can definitely simplify this
> return path as well, you're right.
>

ok. Was a nitpick.

Thanks.

- Alex

