Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68C0C4332F
	for <linux-wpan@archiver.kernel.org>; Thu, 12 May 2022 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355522AbiELOo5 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 12 May 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355519AbiELOov (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 May 2022 10:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDBBD261956
        for <linux-wpan@vger.kernel.org>; Thu, 12 May 2022 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652366688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDn+rJrqCWL0whZkTRg3HfuDKIQLnq7/rvfqZhPp9Dw=;
        b=BT39E+Qhu+tOMMRdZ79aErajc3OIi3bdC9IQZUrcIeykk6SCOFEn0Vlit74vAMTGelBZ0o
        NJUQWOgOwahX1GRDsqQHeBE3/Z4zj+oPq7l0b9bniYIccPKq+ZHzePxBSqw5ZzBXg9FOp4
        ah+LpVak/r3ouwOPn+hMq7mp7P2G+yU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-jNotzL1yPUaq9Bm4OQpdfA-1; Thu, 12 May 2022 10:44:46 -0400
X-MC-Unique: jNotzL1yPUaq9Bm4OQpdfA-1
Received: by mail-qk1-f199.google.com with SMTP id x191-20020a3763c8000000b0069fb66f3901so4248120qkb.12
        for <linux-wpan@vger.kernel.org>; Thu, 12 May 2022 07:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDn+rJrqCWL0whZkTRg3HfuDKIQLnq7/rvfqZhPp9Dw=;
        b=kUBAC4aKmVMPTCaeo2ueycEP7ad9fvzSLvyZ0qwebzbVtk0vvpjYcjXNq3bt833no1
         wejfF8swvyYsHfXV7s6c1J+cNVrrkg7EfsY3bR5i/E3LMcY1BXdlhBz39IT8H4gF0bgV
         bGJszCxBs28cexYHuFinPR1cig7rPSa1NiyYKHmhGqNI59e+USgu8c6lSwEVIbrnmviR
         /PqGXOTM+XwxRr0RyiW+HoIAWdk5Oj0ekSOM01xPNbjFrGI6ikkX8xpIHLIzbIZIcc+O
         puJR+GvFKR5qfli7MYoBcos07nKzUXjmk0dA1uR+NPBm/4FURyPL2OyOXqVsUL0Gw+I5
         CGsA==
X-Gm-Message-State: AOAM530dszGKCIlWZsxFQKReWqTxsDIcSLJsF/3o/eAUkhW5str059OU
        WSrtYXL10Si9jCPr29VH3fiEydgt/inPhAt1gkbLf3sOhka9wKuOsVqCYvFT/XOjM3+hZI5Ogfq
        P0UDYIAjiIwfmiJ9sj4b355wHwReXbRvSOYqWmw==
X-Received: by 2002:a05:622a:351:b0:2f3:d8e4:529f with SMTP id r17-20020a05622a035100b002f3d8e4529fmr57468qtw.123.1652366686178;
        Thu, 12 May 2022 07:44:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR+6Osf3CvRwy7Ah7LACYipP4JyjvLB85JHn/ZxzsxI0lx2gfrRsWsVax9Le6bXtd4m3xXaSGkWkuODNi5pyY=
X-Received: by 2002:a05:622a:351:b0:2f3:d8e4:529f with SMTP id
 r17-20020a05622a035100b002f3d8e4529fmr57452qtw.123.1652366685957; Thu, 12 May
 2022 07:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220427164659.106447-1-miquel.raynal@bootlin.com>
 <20220427164659.106447-7-miquel.raynal@bootlin.com> <CAK-6q+jCYDQ-rtyawz1m2Yt+ti=3d6PrhZebB=-PjcX-6L-Kdg@mail.gmail.com>
 <20220510165237.43382f42@xps13> <CAK-6q+jeubhGah2gG1JJxfmOW=sNdMrLf+mk_a3X_r+Na=tHXg@mail.gmail.com>
 <20220512163307.540d635d@xps13>
In-Reply-To: <20220512163307.540d635d@xps13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 12 May 2022 10:44:35 -0400
Message-ID: <CAK-6q+h07LM1-Cu_mkxAZWN2kG9LLxoKvXxUiQ5DPSYwRkbXZw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 06/11] net: mac802154: Hold the transmit queue
 when relevant
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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

On Thu, May 12, 2022 at 10:33 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Wed, 11 May 2022 09:09:40 -0400:
>
> > Hi,
> >
> > On Tue, May 10, 2022 at 10:52 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > > > --- a/net/mac802154/tx.c
> > > > > +++ b/net/mac802154/tx.c
> > > > > @@ -106,6 +106,21 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > > > >         return NETDEV_TX_OK;
> > > > >  }
> > > > >
> > > > > +void ieee802154_hold_queue(struct ieee802154_local *local)
> > > > > +{
> > > > > +       atomic_inc(&local->phy->hold_txs);
> > > > > +}
> > > > > +
> > > > > +void ieee802154_release_queue(struct ieee802154_local *local)
> > > > > +{
> > > > > +       atomic_dec(&local->phy->hold_txs);
> > > > > +}
> > > > > +
> > > > > +bool ieee802154_queue_is_held(struct ieee802154_local *local)
> > > > > +{
> > > > > +       return atomic_read(&local->phy->hold_txs);
> > > > > +}
> > > >
> > > > I am not getting this, should the release_queue() function not do
> > > > something like:
> > > >
> > > > if (atomic_dec_and_test(hold_txs))
> > > >       ieee802154_wake_queue(local);
> > > >
> > > > I think we don't need the test of "ieee802154_queue_is_held()" here,
> > > > then we need to replace all stop_queue/wake_queue with hold and
> > > > release?
> > >
> > > That's actually a good idea. I've implemented it and it looks nice too.
> > > I'll clean this up and share a new version with:
> > > - The wake call checked everytime hold_txs gets decremented
> > > - The removal of the _queue_is_held() helper
> > > - _wake/stop_queue() turned static
> > > - _hold/release_queue() used everywhere
> > >
> >
> > I think there is also a lock necessary for atomic inc/dec hitting zero
> > and the stop/wake call afterwards...
>
> Mmmh that is true, it can race. I've introduced a mutex (I think it's
> safe but it can be turned into a spinlock if proven necessary) to
> secure these increment/decrement+wakeup operations.
>

be aware that you might call these functions from different contexts,
test your patches with PROVE_LOCKING enabled.

> > ,there are also a lot of
> > optimization techniques to only hold the lock for hitting zero cases
> > in such areas. However we will see...
>
> I am not aware of technical solutions to avoid the locking in these
> cases, what do you have in mind? Otherwise I propose just to come up
> with a working and hopefully solid solution and then we'll see how to
> optimize.

Yes, it's not so important...

- Alex

