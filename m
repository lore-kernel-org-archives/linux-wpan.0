Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCFBE7F150
	for <linux-wpan@archiver.kernel.org>; Wed, 27 Sep 2023 02:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjI0CNB (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 26 Sep 2023 22:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjI0CLB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2023 22:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA00D1F23
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695778283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKKWgd5VsqXZ/BIG1sZfFJbYnkYOL9oMt5Zq9rtrFwA=;
        b=Ib5g9FbVIvQaz6yWzEi/EPZ8Y4HAu7xsrCanMRQSx0F7JqdoweoZcYdGWsMntElTmYr7OQ
        zlzfnRMAqMbZKrwIlklwILdF9Tcc92M/gKBQYqSve3G/egWoQcGPnZCA028vN1zEEq/41W
        kSUE3eXSRoAqesrbK6wmB3s5iekuxmA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-2Vu1YqD3Nsi_fB3mXOxfjw-1; Tue, 26 Sep 2023 21:31:22 -0400
X-MC-Unique: 2Vu1YqD3Nsi_fB3mXOxfjw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so858343866b.2
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 18:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778281; x=1696383081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKKWgd5VsqXZ/BIG1sZfFJbYnkYOL9oMt5Zq9rtrFwA=;
        b=Q2C4beu5nbmtGGemleL9q/+iXruKii/Of3EM16/Yj3F4H7OAVkTUIVAR8XJ5eX0Vb6
         77JrqtiD3jn2s9Pc1HPzLAe8z5+8wzDmAE26b2cvBrdhuu1zVH4bWnjzx6bXWJ6QgvGW
         GSYtqke7/NjEetPNNxVhaZ7FJkMAkRIEh+AIEhJIwKPsCKMzrPJnmqY1YAbhWtaQnDBo
         +czZgzE+4L0b8XlMi0H+3MZ1mjfKmbVvlHpik2q60hH2i0aIWHBdJNl2hlmjP49knkVw
         a2GiBHT50T96TDQaSIxrod3ykG3jV1HYqBtfklUwNFJkr9oRAnxhVqJHKvCy5hEbKM2i
         55kw==
X-Gm-Message-State: AOJu0YwpoO7jYJ5upyiqiW3OBTAocQH2sErph+YXCrTu/O0WryPRJJio
        C2KOhxY6UbiQ0GoxcouxE0blrBG1pk3zUEqBjR0ushylWQFyStKp3BVgJrPCx75AJwtRE1B8nKA
        u5L0YChgQfW8tDGm6vt+yKM9/1il3XO9XIgQYRA==
X-Received: by 2002:a17:906:3112:b0:9ae:6388:e09b with SMTP id 18-20020a170906311200b009ae6388e09bmr324716ejx.40.1695778280955;
        Tue, 26 Sep 2023 18:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGieOngArYKjbDZq9ItVo4lMu8KHH9bkbQTWHVzS+VH7ZAmNietCpu1nvdDCLEVyOAgGWGkqlAqAMKupLcDZM=
X-Received: by 2002:a17:906:3112:b0:9ae:6388:e09b with SMTP id
 18-20020a170906311200b009ae6388e09bmr324708ejx.40.1695778280682; Tue, 26 Sep
 2023 18:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-8-miquel.raynal@bootlin.com> <CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
 <20230925094343.598c81d1@xps-13>
In-Reply-To: <20230925094343.598c81d1@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 26 Sep 2023 21:31:09 -0400
Message-ID: <CAK-6q+jFmvXGWOJFvHagC06mnbu6O1=Ndg8auNkGXTaqSf-7rg@mail.gmail.com>
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

On Mon, Sep 25, 2023 at 3:43=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun, 24 Sep 2023 20:13:34 -0400:
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
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  include/net/cfg802154.h         |   7 ++
> > >  include/net/ieee802154_netdev.h |   6 ++
> > >  net/ieee802154/core.c           |   7 ++
> > >  net/ieee802154/pan.c            |  30 +++++++
> > >  net/mac802154/ieee802154_i.h    |   2 +
> > >  net/mac802154/rx.c              |   8 ++
> > >  net/mac802154/scan.c            | 142 ++++++++++++++++++++++++++++++=
++
> > >  7 files changed, 202 insertions(+)
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index 9b036ab20079..c844ae63bc04 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
> > >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > >                           struct ieee802154_addr *target);
> > >
> > > +/**
> > > + * cfg802154_get_free_short_addr - Get a free address among the know=
n devices
> > > + * @wpan_dev: the wpan device
> > > + * @return: a random short address expectedly unused on our PAN
> > > + */
> > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> > > +
> > >  #endif /* __NET_CFG802154_H */
> > > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154=
_netdev.h
> > > index 16194356cfe7..4de858f9929e 100644
> > > --- a/include/net/ieee802154_netdev.h
> > > +++ b/include/net/ieee802154_netdev.h
> > > @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
> > >         struct ieee802154_assoc_req_pl assoc_req_pl;
> > >  };
> > >
> > > +struct ieee802154_association_resp_frame {
> > > +       struct ieee802154_hdr mhr;
> > > +       struct ieee802154_mac_cmd_pl mac_pl;
> > > +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> > > +};
> > > +
> > >  struct ieee802154_disassociation_notif_frame {
> > >         struct ieee802154_hdr mhr;
> > >         struct ieee802154_mac_cmd_pl mac_pl;
> > > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > > index a08d75dd56ad..1670a71327a7 100644
> > > --- a/net/ieee802154/core.c
> > > +++ b/net/ieee802154/core.c
> > > @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
> > >
> > >  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev=
)
> > >  {
> > > +       struct ieee802154_pan_device *child, *tmp;
> > > +
> > >         mutex_lock(&wpan_dev->association_lock);
> > >
> > >         kfree(wpan_dev->parent);
> > >         wpan_dev->parent =3D NULL;
> > >
> > > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, nod=
e) {
> > > +               list_del(&child->node);
> > > +               kfree(child);
> > > +       }
> > > +
> > >         mutex_unlock(&wpan_dev->association_lock);
> > >  }
> > >
> > > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > > index 9e1f1973c294..e99c64054dcb 100644
> > > --- a/net/ieee802154/pan.c
> > > +++ b/net/ieee802154/pan.c
> > > @@ -73,3 +73,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_de=
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
> > > +               get_random_bytes(&addr, 2);
> > > +               if (addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_BRO=
ADCAST) ||
> > > +                   addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNS=
PEC))
> > > +                       continue;
> > > +
> > > +               if (wpan_dev->short_addr =3D=3D addr)
> > > +                       continue;
> > > +
> > > +               if (wpan_dev->parent && wpan_dev->parent->short_addr =
=3D=3D addr)
> > > +                       continue;
> > > +
> > > +               list_for_each_entry(child, &wpan_dev->children, node)
> > > +                       if (child->short_addr =3D=3D addr)
> > > +                               continue;
> > > +
> > > +               break;
> > > +       } while (1);
> > > +
> >
> > I still believe that this random 2 bytes and check if it's already
> > being used is wrong here. We need something to use the next free
> > available number according to the data we are storing here.
>
> This issue I still have in mind is when you have this typology:
>
> device A -------> device B --------> device C <-------- device D
> (leaf)            (coord)            (PAN coord)            (leaf)
>
> B associates with C
> A associates with B
> D associates with C
>
> If B and C run Linux's stack, they will always have the same short
> address. Yes this can be handled (realignment procedure). But any time
> this happens, you'll have a load of predictable realignments when A and
> D get in range with B or C.
>

I see that it can be "more" predictable, but what happens when there
is the same short address case with the random number generator? It
sounds to me like there needs to be a kind of duplicate address
detection going on and then choose another one, if 802.15.4 even
handles this case...

I am also thinking that there is only one number left and the random
generator runs multiple times to find the last one aka "it's random
you can never be sure", when it always returns the same address.

However, that's only my thoughts about it and hopefully can be
improved in future.

- Alex

