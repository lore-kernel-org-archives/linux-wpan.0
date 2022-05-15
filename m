Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80DC433EF
	for <linux-wpan@archiver.kernel.org>; Sun, 15 May 2022 23:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiEOXEK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 May 2022 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiEOXEI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 May 2022 19:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 501EA3617C
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652655846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HED6sqrRMHt5M94sg8hRTn2o/jwlXD/g70Ops+h6TfM=;
        b=NRtKCOlLOkrNVf1RmfSR6MDSvOY0PE4AY4T/vFbMG0bt8g8CJaLIiaXa86XNROKBGxQBa/
        0kH72Z/tiASOUFWfSXVk/91oQGTjguox2Sf91NJNb9Isv05CHgGpBIZ272beWzj/nXcFo0
        c5di/KYMFzXnaVVrl5yemu1X7PYY6BA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-esTDzromOSiokn2XpJ9Ukg-1; Sun, 15 May 2022 19:04:05 -0400
X-MC-Unique: esTDzromOSiokn2XpJ9Ukg-1
Received: by mail-qk1-f198.google.com with SMTP id z12-20020ae9e60c000000b006a0e769f9caso9455609qkf.5
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 16:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HED6sqrRMHt5M94sg8hRTn2o/jwlXD/g70Ops+h6TfM=;
        b=qC/F2gG4ViocnKL3u6zsTwfu0Y5PkugET7mcXX/AK3mL6q/5MJ+lw5muguUgGZ740W
         v1oetmtQak7shVvP8eQtCbUZ3uosH5gFC7ku73yxXUkj9uEYBbqBQFt4wu6rtuCX5CTK
         zJLT3cNlhR1Kg6T3ndYoSDa9tj/Lfbh8FySTFoHcNO3ESHRocTZH3K/ag3Mq1nloRmY5
         OB9NdSKLyDuGHJpC/D9aTnyzWfwtmYXdv9UVlLf9WJ/wMohMw7p99M/WnkD0F22j1Zp1
         OhJcZ0cb7x0c0e5qU9CqDJ3OjBD25y30AmA+hHRlk/RyBUAfu9PUOYrpTqWxlzFAr3Vt
         46yA==
X-Gm-Message-State: AOAM533bAV2F0JJK5SQ352x3WmLJ9663e54y/OFTHEkb//GglifiPs4v
        5fEVodzqendVPP3YHfgK4heXYwwG2Cgw8r7k1Lqmls6RYmmUag5yENKBco2gW0SwBikmRi2Bg0R
        JVx73GaGmXy8levjOWg8RNbAyJIE2gyyZqx6ybw==
X-Received: by 2002:a05:620a:919:b0:69f:e373:3de8 with SMTP id v25-20020a05620a091900b0069fe3733de8mr10431658qkv.27.1652655844632;
        Sun, 15 May 2022 16:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVzzoy/qyjeaBmM2f/mbn7p3QjZ3CLZ+xk+5lleqUjWBiKRiluPA00va3+zN49cME8YcJnOEtooTr3RySqlk4=
X-Received: by 2002:a05:620a:919:b0:69f:e373:3de8 with SMTP id
 v25-20020a05620a091900b0069fe3733de8mr10431642qkv.27.1652655844437; Sun, 15
 May 2022 16:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
 <20220512143314.235604-10-miquel.raynal@bootlin.com> <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
In-Reply-To: <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 15 May 2022 19:03:53 -0400
Message-ID: <CAK-6q+i_T+FaK0tX6tF38VjyEfSzDi-QC85MTU2=4soepAag8g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 09/11] net: mac802154: Introduce a
 synchronous API for MLME commands
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

On Sun, May 15, 2022 at 6:28 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Thu, May 12, 2022 at 10:34 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > This is the slow path, we need to wait for each command to be processed
> > before continuing so let's introduce an helper which does the
> > transmission and blocks until it gets notified of its asynchronous
> > completion. This helper is going to be used when introducing scan
> > support.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  net/mac802154/ieee802154_i.h |  1 +
> >  net/mac802154/tx.c           | 25 +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> > index a057827fc48a..f8b374810a11 100644
> > --- a/net/mac802154/ieee802154_i.h
> > +++ b/net/mac802154/ieee802154_i.h
> > @@ -125,6 +125,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
> >  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
> >  void ieee802154_xmit_sync_worker(struct work_struct *work);
> >  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
> > +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb);
> >  netdev_tx_t
> >  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
> >  netdev_tx_t
> > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > index 38f74b8b6740..ec8d872143ee 100644
> > --- a/net/mac802154/tx.c
> > +++ b/net/mac802154/tx.c
> > @@ -128,6 +128,31 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
> >         return ieee802154_sync_queue(local);
> >  }
> >
> > +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > +{
> > +       int ret;
> > +
> > +       /* Avoid possible calls to ->ndo_stop() when we asynchronously perform
> > +        * MLME transmissions.
> > +        */
> > +       rtnl_lock();
>
> I think we should make an ASSERT_RTNL() here, the lock needs to be
> earlier than that over the whole MLME op. MLME can trigger more than

not over the whole MLME_op, that's terrible to hold the rtnl lock so
long... so I think this is fine that some netdev call will interfere
with this transmission.
So forget about the ASSERT_RTNL() here, it's fine (I hope).

> one message, the whole sync_hold/release queue should be earlier than
> that... in my opinion is it not right to allow other messages so far
> an MLME op is going on? I am not sure what the standard says to this,
> but I think it should be stopped the whole time? All those sequence

Whereas the stop of the netdev queue makes sense for the whole mlme-op
(in my opinion).

- Alex

