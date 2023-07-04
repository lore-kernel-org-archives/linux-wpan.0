Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D116EB64DA
	for <linux-wpan@archiver.kernel.org>; Tue,  4 Jul 2023 11:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGDLfS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 4 Jul 2023 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGDLfR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Jul 2023 07:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BF10C8
        for <linux-wpan@vger.kernel.org>; Tue,  4 Jul 2023 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688470469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXnq89Vx5Bj4GKEzPiuso1zUj9ISNTq+r+8jY2dLtAU=;
        b=XooERkiF0dJihK/qWA6STd+fuJzCMX+LRIVT21T+FlZdmbZsm07uMyzWkmcC1IQ53t3tJE
        wl4xa6lL8VkTJNK36DyV+NGZDeJNHbnMw8YnYPEHH11tmHuX0ZRBliKqqXHkrlZD2l2902
        cvq1iUAxRC1tRlMWV0Olb4GPHuVCHwQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-v-DrdRKdNiCn-YgQqMuU3w-1; Tue, 04 Jul 2023 07:34:27 -0400
X-MC-Unique: v-DrdRKdNiCn-YgQqMuU3w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-56fffdea2d0so47279667b3.1
        for <linux-wpan@vger.kernel.org>; Tue, 04 Jul 2023 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688470467; x=1691062467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXnq89Vx5Bj4GKEzPiuso1zUj9ISNTq+r+8jY2dLtAU=;
        b=kmY/pFsN1LmwgVXDghK1BA2CkzTIJgQDehkEqweH9scKNiCh1fbdoxuCJTYxgk6kr6
         dPh5ATzoObVHogbb73r8ZW2IoK5i1qlsq9mtjTYuNHCCWDc+eIzzIauAj43bwH7Gth0v
         z7/OYGl2ZV7LHbzhWv5dCCYUDSYoB+umFFUX4oA3prF9M6j/9C1GEvNeiFBB+Y4j206X
         +KziMt7MgY5jq3gw6kaQfo2lerDX7ocSDz4MyjgLQvMzVa8c3LzTjbahkCKCwnd9l9JL
         Wr6rMwTnEDZQ0Hbc3wiuSJVwz8517ROngCfWQXm+GluwY52k7Z8iKrQOq1rZSOOn30Db
         P55w==
X-Gm-Message-State: ABy/qLZY6ubl/OByVuZc1pvYc5r/oyaJVrKre1LtIEJL5Vxt0KssF7mp
        CtAHA+Ila1fIDsRsVCOXaqZbqP7dUapvVD2gCc990HhXLbnVOecFdquPINsbTyAozDsFyXsQJvg
        WRFE+wA6UPIn/zKB+dhKnn1WMd5viooJHVK/pkg==
X-Received: by 2002:a0d:df86:0:b0:579:ec06:eb3d with SMTP id i128-20020a0ddf86000000b00579ec06eb3dmr8401473ywe.21.1688470467333;
        Tue, 04 Jul 2023 04:34:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5MOd7qOxgSjWgDl9pSrHRuFKa43Hot6W59FTuInBNuqzINdcyIeDq+YGAQ4+QkEQ5ltD6O4RxW8//WwZqgZU=
X-Received: by 2002:a0d:df86:0:b0:579:ec06:eb3d with SMTP id
 i128-20020a0ddf86000000b00579ec06eb3dmr8401459ywe.21.1688470467004; Tue, 04
 Jul 2023 04:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
 <20230601154817.754519-5-miquel.raynal@bootlin.com> <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
In-Reply-To: <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 4 Jul 2023 07:34:15 -0400
Message-ID: <CAK-6q+g_0LZ_OPZtCjAsL8Vn6TiTKM5RUzQTxK7GDzuEEVNSEg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 04/11] mac802154: Handle associating
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

On Sat, Jun 3, 2023 at 6:09=E2=80=AFAM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Hi,
>
> On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Joining a PAN officially goes by associating with a coordinator. This
> > coordinator may have been discovered thanks to the beacons it sent in
> > the past. Add support to the MAC layer for these associations, which
> > require:
> > - Sending an association request
> > - Receiving an association response
> >
> > The association response contains the association status, eventually a
> > reason if the association was unsuccessful, and finally a short address
> > that we should use for intra-PAN communication from now on, if we
> > required one (which is the default, and not yet configurable).
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/ieee802154.h      |   1 +
> >  include/net/cfg802154.h         |   1 +
> >  include/net/ieee802154_netdev.h |   5 ++
> >  net/ieee802154/core.c           |  14 ++++
> >  net/mac802154/cfg.c             |  72 ++++++++++++++++++
> >  net/mac802154/ieee802154_i.h    |  19 +++++
> >  net/mac802154/main.c            |   2 +
> >  net/mac802154/rx.c              |   9 +++
> >  net/mac802154/scan.c            | 127 ++++++++++++++++++++++++++++++++
> >  9 files changed, 250 insertions(+)
> >
> > diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> > index 140f61ec0f5f..c72bd76cac1b 100644
> > --- a/include/linux/ieee802154.h
> > +++ b/include/linux/ieee802154.h
> > @@ -37,6 +37,7 @@
> >                                          IEEE802154_FCS_LEN)
> >
> >  #define IEEE802154_PAN_ID_BROADCAST    0xffff
> > +#define IEEE802154_ADDR_LONG_BROADCAST 0xffffffffffffffffULL
> >  #define IEEE802154_ADDR_SHORT_BROADCAST        0xffff
> >  #define IEEE802154_ADDR_SHORT_UNSPEC   0xfffe
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index 3b9d65455b9a..dd0964d351cd 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -502,6 +502,7 @@ struct wpan_dev {
> >         struct mutex association_lock;
> >         struct ieee802154_pan_device *parent;
> >         struct list_head children;
> > +       unsigned int association_generation;
> >  };
> >
> >  #define to_phy(_dev)   container_of(_dev, struct wpan_phy, dev)
> > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_n=
etdev.h
> > index ca8c827d0d7f..e26ffd079556 100644
> > --- a/include/net/ieee802154_netdev.h
> > +++ b/include/net/ieee802154_netdev.h
> > @@ -149,6 +149,11 @@ struct ieee802154_assoc_req_pl {
> >  #endif
> >  } __packed;
> >
> > +struct ieee802154_assoc_resp_pl {
> > +       __le16 short_addr;
> > +       u8 status;
> > +} __packed;
> > +
> >  enum ieee802154_frame_version {
> >         IEEE802154_2003_STD,
> >         IEEE802154_2006_STD,
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index cd69bdbfd59f..8bf01bb7e858 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -198,6 +198,18 @@ void wpan_phy_free(struct wpan_phy *phy)
> >  }
> >  EXPORT_SYMBOL(wpan_phy_free);
> >
> > +static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> > +{
> > +       mutex_lock(&wpan_dev->association_lock);
> > +
> > +       if (wpan_dev->parent)
> > +               kfree(wpan_dev->parent);
> > +
> > +       wpan_dev->association_generation++;
> > +
> > +       mutex_unlock(&wpan_dev->association_lock);
> > +}
> > +
> >  int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
> >                            struct net *net)
> >  {
> > @@ -293,6 +305,8 @@ static int cfg802154_netdev_notifier_call(struct no=
tifier_block *nb,
> >                 rdev->opencount++;
> >                 break;
> >         case NETDEV_UNREGISTER:
> > +               cfg802154_free_peer_structures(wpan_dev);
> > +
>
> I think the comment below is not relevant here, but I have also no
> idea if this is still the case.
>
> >                 /* It is possible to get NETDEV_UNREGISTER
> >                  * multiple times. To detect that, check
> >                  * that the interface is still on the list
> > diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> > index 5c3cb019f751..89112d2bcee7 100644
> > --- a/net/mac802154/cfg.c
> > +++ b/net/mac802154/cfg.c
> > @@ -315,6 +315,77 @@ static int mac802154_stop_beacons(struct wpan_phy =
*wpan_phy,
> >         return mac802154_stop_beacons_locked(local, sdata);
> >  }
> >
> > +static int mac802154_associate(struct wpan_phy *wpan_phy,
> > +                              struct wpan_dev *wpan_dev,
> > +                              struct ieee802154_addr *coord)
> > +{
> > +       struct ieee802154_local *local =3D wpan_phy_priv(wpan_phy);
> > +       u64 ceaddr =3D swab64((__force u64)coord->extended_addr);
> > +       struct ieee802154_sub_if_data *sdata;
> > +       struct ieee802154_pan_device *parent;
> > +       __le16 short_addr;
> > +       int ret;
> > +
> > +       ASSERT_RTNL();
> > +
> > +       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
> > +
> > +       if (wpan_dev->parent) {
> > +               dev_err(&sdata->dev->dev,
> > +                       "Device %8phC is already associated\n", &ceaddr=
);
> > +               return -EPERM;
> > +       }
> > +
> > +       parent =3D kzalloc(sizeof(*parent), GFP_KERNEL);
> > +       if (!parent)
> > +               return -ENOMEM;
> > +
> > +       parent->pan_id =3D coord->pan_id;
> > +       parent->mode =3D coord->mode;
> > +       if (parent->mode =3D=3D IEEE802154_SHORT_ADDRESSING) {
> > +               parent->short_addr =3D coord->short_addr;
> > +               parent->extended_addr =3D cpu_to_le64(IEEE802154_ADDR_L=
ONG_BROADCAST);
>
> There is no IEEE802154_ADDR_LONG_BROADCAST (extended address) address.
> The broadcast address is always a short address 0xffff. (Talkin about
> destination addresses).
>
> Just to clarify we can have here two different types/length of mac
> addresses being used, whereas the extended address is always present.
> We have the monitor interface set to an invalid extended address
> 0x0...0 (talking about source address) which is a reserved EUI64 (what
> long/extended address is) address, 0xffff...ffff is also being
> reserved. Monitors get their address from the socket interface.
>
> If there is a parent, an extended address is always present and known.

I want to weaken this, we can also have only the short address of the
neighbor. But it depends on assoc/deassoc, I would think the extended
address should be known. If you look on air and make per neighbor
stats... you can see a neighbor with either a short or extended
address being used. Map them to one neighbor if using a short address
is only possible if you know the mapping... (but this is so far I see
not the case here).

We need some kind of policy here, but with assoc/deassoc we should
always know this mapping.

- Alex

