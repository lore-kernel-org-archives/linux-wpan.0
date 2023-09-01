Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CFCA0FE4
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbjIAPpy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbjIAPpy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 11:45:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37710E4;
        Fri,  1 Sep 2023 08:45:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DABE3FF803;
        Fri,  1 Sep 2023 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693583147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE3qgu3x6/GrX88lBaW9YyXsn7DQIvGzCmJgZvdFqtM=;
        b=A0JLxx43TCRvsxIAObhhC/C6t2VTHPvPR6NMc9HnGh/IKcnz/2xWByoDA5GoVHkqc7xdfO
        3oxeyy0fvEb6WExEcQVVdqxouG6gXhmRJrJLF9i80NgTNjMT6nsZpO8os277ginja7lGq5
        NAKXUi1lexjm6p9TWSm6V7bmuI6Vuh8xolJQkveTYjSt+Mqk9w8btsiW9mOSlGgZTx0pt4
        uZqqvOCxF5mC/Aoxdc3AZZ1PQIbfYgOvkhxkDZ7h1Zo/8fDDYuQot5A4pTtFV5ZV/7vqUA
        YmoODyLgOoPDWJjLMOM8/wgUxDkU6yoUNEKNQQoDkOJhqSjykkxRF9NblvXNPA==
Date:   Fri, 1 Sep 2023 17:45:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
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
Subject: Re: [PATCH wpan-next 07/11] mac802154: Handle association requests
 from peers
Message-ID: <20230901174537.50f88d60@xps-13>
In-Reply-To: <20230821105259.4659dd74@xps-13>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
        <20230601154817.754519-8-miquel.raynal@bootlin.com>
        <CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
        <20230821105259.4659dd74@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

> > > --- a/net/ieee802154/pan.c
> > > +++ b/net/ieee802154/pan.c
> > > @@ -66,3 +66,30 @@ cfg802154_device_is_child(struct wpan_dev *wpan_de=
v,
> > >         return NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > > +
> > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > > +{
> > > +       struct ieee802154_pan_device *child;
> > > +       __le16 addr;
> > > +
> > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > +
> > > +       do {
> > > +               get_random_bytes(&addr, 2);   =20
> >=20
> > This is combined with the max associations setting? I am not sure if
> > this is the best way to get free values from a u16 value where we have
> > some data structure of "given" addresses to a node. I recently was
> > looking into idr/xarray data structure... maybe we can use something
> > from there. =20
>=20
> I actually thought about using an increasing index, but the pseudo
> random generator seemed appropriate because of its "unpredictability",
> but there is not real use for that (besides maybe testing purposes). I
> can definitely switch to another solution.

I looked into this deeper. I didn't felt like idr would be so much
useful, but I started converting the code to use ida instead (so the
simplest approach, with no associated pointer). There are actually two
use cases which clearly match better the random address mechanism.

a/ One can freely decide the short address of the coordinator (it is
freely selectable by the user) but ida has no mechanism to handle this
with an API which would prevent such "number to be used".

In practice, this could be workarounded "easily", even though the
implementation would be dirty IMHO: getting an IDA, if it matches ours,
just try again without freeing it. TBH I don't like much this idea.

b/ In case we ever want to support master handover, the ida solution
does not work well...

For now I've kept the current approach (actually adding a missing
check), but if you know how to solve that I can either update the
implementation or make a followup patch, especially since the current
approach is not bounded (in the theoretical case where we have 65k
devices in the same PAN).

I believe the allocation strategies are not set in stone anyway and can
easily evolve.

Thanks,
Miqu=C3=A8l
