Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D9C433EF
	for <linux-wpan@archiver.kernel.org>; Sun, 15 May 2022 22:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiEOW4X (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 May 2022 18:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiEOW4V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 May 2022 18:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00971DF04
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652655378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8jihZqsmnF0KMPdwjssLfaNbHl50i9BdsMYBRqa0ZA=;
        b=hB/qxl139MzOn5OK7nYoeC5Wiq1ldbqfuD7E74jpFi5IC3OXeyYhfnWyFYUdaBzqY3+OLr
        wTW4dol8E4hlYHH8+Wa76nD8l/uSQKcaeu9v/IgGdNEoUztBlIEofxX3iUi/zygXGmbrDd
        hZsqlAr9MYZk7zArULjGuPctq8ozIIE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-7FWutxI3Ok-marA7Z6ZFmQ-1; Sun, 15 May 2022 18:56:17 -0400
X-MC-Unique: 7FWutxI3Ok-marA7Z6ZFmQ-1
Received: by mail-qk1-f199.google.com with SMTP id z12-20020ae9e60c000000b006a0e769f9caso9446748qkf.5
        for <linux-wpan@vger.kernel.org>; Sun, 15 May 2022 15:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8jihZqsmnF0KMPdwjssLfaNbHl50i9BdsMYBRqa0ZA=;
        b=Q8366+SAUjwHc/VFNZP80Svmzl+0BMoW0rPRjpFsNIvtuhUMiQmSDMgZnWj5JYJjCM
         CRMKw97EjdRaWqDTJJhAtmWsk8Ya2luQGbpy0W4Ciyf2eGfZl3xEyZZfxRBu7vnY0ZUo
         OGJeAdyj8QmUKEWwnm/rJwWA1NF3p3mEMfpsNviwJsJW8+iT0+AVcmKK8HUC5kIDWlZ6
         wwt+oSxHTmEySmz7onVw3NTrwwFfrXSBXE+MQ1f/fxBIZhaGbDbtdHYYLMHtV70lVkIf
         8LDnOHp5RKMseGFU2w/MZw0L6HoREj+YCySrUlQWWsWfniHb5Qkbdgnhak2paS7Zlj6k
         I+Kg==
X-Gm-Message-State: AOAM5308NBLTZD0ZAIVbHKvtCfqDbWliE11DroQ+Jo5h4o5HrdkV5OC2
        hJ1XTMgMUjKuCjeFY7fx4SHqylOuCo7SPzpWS5sQaPLpGKzUJ5AuTlb4SpvIOYqpvVzGcl4GDtC
        Dt/DdDYn4Z8BrK1T0qK2SC6OI6/puraMQFpR2jQ==
X-Received: by 2002:a05:620a:4403:b0:6a0:5093:1742 with SMTP id v3-20020a05620a440300b006a050931742mr10521530qkp.691.1652655377057;
        Sun, 15 May 2022 15:56:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcmfziaShgyFbkoo5M2L5AciQaXrdHp6uz3PIqh90PF4gm8hy73Lf6yjPFlz1WN18rBr/Ia9rKQpxiF409ajA=
X-Received: by 2002:a05:620a:4403:b0:6a0:5093:1742 with SMTP id
 v3-20020a05620a440300b006a050931742mr10521526qkp.691.1652655376867; Sun, 15
 May 2022 15:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
 <20220512143314.235604-10-miquel.raynal@bootlin.com> <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
In-Reply-To: <CAK-6q+ipHdD=NJB2N7SHQ0TUvNpc0GQXZ7dWM9nDxqyqNgxdSA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 15 May 2022 18:56:05 -0400
Message-ID: <CAK-6q+ivVCJOEF+MN-y64K1M-nf2ak0CUqjj0tiiyinaNCAE5w@mail.gmail.com>
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
> one message, the whole sync_hold/release queue should be earlier than
> that... in my opinion is it not right to allow other messages so far
> an MLME op is going on? I am not sure what the standard says to this,
> but I think it should be stopped the whole time? All those sequence
> diagrams show only some specific frames, also remember that on the
> receive side we drop all other frames if MLME op (e.g. scan) is going
> on?

Maybe some mlme_op_pre(), ... mlme_tx(), ..., mlme_tx(), ...,
mlme_op_post() handling?

- Alex

