Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11104C433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 01:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiERBOS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiERBOR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 21:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD45E51E4C
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652836456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mV6LTTKwyqfq/7ssemAlNvDeD4O9G77Xds9teeBGd1M=;
        b=eQuwB4wOeUxB0RchFNPARhT8gTzbVrSXMn4CiqlhbDpgHQ07VIdffX/J1Bsmus2Umi3BcW
        bBllyGldlbm/8ht88kdOyHa4I8vZb8r97OBHlF1/CuGipxUKnqWc/4X/ZpjRtyXt6SQnQu
        oeO4ETpqAUVkegZjDvZpng/ncyXmHF0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-pcLvpbuyO9yQYPOPSgUfiQ-1; Tue, 17 May 2022 21:14:14 -0400
X-MC-Unique: pcLvpbuyO9yQYPOPSgUfiQ-1
Received: by mail-qv1-f72.google.com with SMTP id c9-20020a056214146900b00461c7b83672so484879qvy.7
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 18:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mV6LTTKwyqfq/7ssemAlNvDeD4O9G77Xds9teeBGd1M=;
        b=DkKsf0Zhe9rjY1McQ3SOMyvQ9cZbxA9UYTXTotWQYCoDehbY7wTeNKj68pScGmLW0D
         hazGWoz4v5g+b4ZN+X4y21MyUaN0WeO9Hq6g420e9EHXUPtrBFVQN5/+rlGqFeD2qnDR
         +GN8OovrYSIKDZMpJ5BvSI7d4MJhMfsKNMMseFz7iHorFoCDjDaVMAkiuU95boJq7ScN
         nfhTcIPHnabjtdBX3yp6c7t2U40U/yqck+W3xD/njobtERjS1B1Pnm0O3HqiWVKUkM+6
         NIdI/rA8MU7+EsifjxEr8icTmgFbfkUKvdopz4Xb+KU08bp404wEwlJyZgjaHF17H3KM
         Ssvg==
X-Gm-Message-State: AOAM5320H6JDyHfvcqmForfEpDFtJHdOcXGw9TPuN+B/VO2hF/Lcjvky
        mkKZFcveitnuXFV6fxKE92IUIKL7Xh2WeR1vje/ojZ/9PQrYss3s84zmbclVNLjwCVXsrmQzZV4
        FDe+WSlVWTmo6YIMrdK/QpwE6lBizJF85csJrsA==
X-Received: by 2002:ac8:5a8d:0:b0:2f3:e201:33ab with SMTP id c13-20020ac85a8d000000b002f3e20133abmr22039833qtc.470.1652836454209;
        Tue, 17 May 2022 18:14:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Z7hqz4nu2xjcaYj7EyXEAss12lPSBXSsGnko8uptJmzaUiDC/Isw4ptT1w0Ih1zl0A6PnqmBI63IrLM8jIk=
X-Received: by 2002:ac8:5a8d:0:b0:2f3:e201:33ab with SMTP id
 c13-20020ac85a8d000000b002f3e20133abmr22039822qtc.470.1652836453995; Tue, 17
 May 2022 18:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
 <20220512143314.235604-10-miquel.raynal@bootlin.com> <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
 <CAK-6q+i_T+FaK0tX6tF38VjyEfSzDi-QC85MTU2=4soepAag8g@mail.gmail.com> <20220517153045.73fda4ee@xps-13>
In-Reply-To: <20220517153045.73fda4ee@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 21:14:03 -0400
Message-ID: <CAK-6q+h1fmJZobmUG5bUL3uXuQLv0kvHUv=7dW+fOCcgbrdPiA@mail.gmail.com>
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

On Tue, May 17, 2022 at 9:30 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>
> aahringo@redhat.com wrote on Sun, 15 May 2022 19:03:53 -0400:
>
> > Hi,
> >
> > On Sun, May 15, 2022 at 6:28 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, May 12, 2022 at 10:34 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > This is the slow path, we need to wait for each command to be processed
> > > > before continuing so let's introduce an helper which does the
> > > > transmission and blocks until it gets notified of its asynchronous
> > > > completion. This helper is going to be used when introducing scan
> > > > support.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  net/mac802154/ieee802154_i.h |  1 +
> > > >  net/mac802154/tx.c           | 25 +++++++++++++++++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> > > > index a057827fc48a..f8b374810a11 100644
> > > > --- a/net/mac802154/ieee802154_i.h
> > > > +++ b/net/mac802154/ieee802154_i.h
> > > > @@ -125,6 +125,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
> > > >  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
> > > >  void ieee802154_xmit_sync_worker(struct work_struct *work);
> > > >  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
> > > > +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb);
> > > >  netdev_tx_t
> > > >  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
> > > >  netdev_tx_t
> > > > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > > > index 38f74b8b6740..ec8d872143ee 100644
> > > > --- a/net/mac802154/tx.c
> > > > +++ b/net/mac802154/tx.c
> > > > @@ -128,6 +128,31 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
> > > >         return ieee802154_sync_queue(local);
> > > >  }
> > > >
> > > > +int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       /* Avoid possible calls to ->ndo_stop() when we asynchronously perform
> > > > +        * MLME transmissions.
> > > > +        */
> > > > +       rtnl_lock();
> > >
> > > I think we should make an ASSERT_RTNL() here, the lock needs to be
> > > earlier than that over the whole MLME op. MLME can trigger more than
> >
> > not over the whole MLME_op, that's terrible to hold the rtnl lock so
> > long... so I think this is fine that some netdev call will interfere
> > with this transmission.
> > So forget about the ASSERT_RTNL() here, it's fine (I hope).
> >
> > > one message, the whole sync_hold/release queue should be earlier than
> > > that... in my opinion is it not right to allow other messages so far
> > > an MLME op is going on? I am not sure what the standard says to this,
> > > but I think it should be stopped the whole time? All those sequence
> >
> > Whereas the stop of the netdev queue makes sense for the whole mlme-op
> > (in my opinion).
>
> I might still implement an MLME pre/post helper and do the queue
> hold/release calls there, while only taking the rtnl from the _tx.
>
> And I might create an mlme_tx_one() which does the pre/post calls as
> well.
>
> Would something like this fit?

I think so, I've heard for some transceiver types a scan operation can
take hours... but I guess whoever triggers that scan in such an
environment knows that it has some "side-effects"...

- Alex

