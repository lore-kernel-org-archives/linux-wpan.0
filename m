Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F142C433F5
	for <linux-wpan@archiver.kernel.org>; Fri, 13 May 2022 14:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359467AbiEMO0z (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 13 May 2022 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381089AbiEMO0b (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 May 2022 10:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D68105E168
        for <linux-wpan@vger.kernel.org>; Fri, 13 May 2022 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652451981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZ45apDUMX59uVWHQlr04EzDEa2G03GHNP4WpRjWO68=;
        b=AR5BCEukzBA+NUJ83IqZvPLcvWxivYXtiaMwBR4NUqC2ClUG4+dhhUJsQBEiw2DFM5r1N3
        iKMb023heucvhpGUy837kklX7zPtEhaL4MmAP7WcNj31teiSIPCr+4MfEGdAFRSHaaQS13
        HILpJlL3y7+I0PuKjPfiOPR5WPasFJA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-bt0m3lXuNLWeQKP-X7OjJA-1; Fri, 13 May 2022 10:26:20 -0400
X-MC-Unique: bt0m3lXuNLWeQKP-X7OjJA-1
Received: by mail-qv1-f70.google.com with SMTP id d13-20020a05621421cd00b0045a99874ae5so6953940qvh.14
        for <linux-wpan@vger.kernel.org>; Fri, 13 May 2022 07:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZ45apDUMX59uVWHQlr04EzDEa2G03GHNP4WpRjWO68=;
        b=lh09oF+j9c8QXWR3JryseXDhJbtlGmL/fOjzD/8iPweQlmNG+YLHLNnQxYFWfpdMbG
         2W4ICWC8BZaPPZefGLQQZRqJtApHDzv4LwtK8dzgINqW9G6kquP9H3j9wjck+z2VKwdq
         YiUx/02//NquJ4RhPURwfjpoi0PEj9j0KBBg+//VmskVacmicR+vhtBO2ufVRydJazpg
         lNvC6opzLOS+r5i4QDOvOlfK+urZDV/whtSrOrCG/8jOjZxRucclRnZ45uO7uNCl+KMr
         CiagnkG9/EFMy26h7EJcHPdBs48NPn6XCtxQIaeZ7lROEycMOuqodkSlFMyzN2PGcZ6q
         E0AQ==
X-Gm-Message-State: AOAM530BT4U7MPneaNCsMa7ulQ+OftHKpbKplYhoPKv2Ui9ochhWuMxg
        7us/DHkPtCKtjmcPs6riatHPvdVkwt5PQVhmiQv7+xZ8x7DmlbQNRrSL6mFSKEWCmsH+BRwthgM
        qhk4sHKL/IpT4aGEEmMRE6fjW56jfWYybU6P+Dw==
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id a9-20020a0562140c2900b0045afedd7315mr4607922qvd.59.1652451979779;
        Fri, 13 May 2022 07:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPkxhAf96t9d5nOpBcWImYrvg8LbZxsB5Eqn0nc42WMToWRBZiHA3DPgJe1Lgq8S2wv9wLR1gbHt1OF2Uv7iE=
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id
 a9-20020a0562140c2900b0045afedd7315mr4607897qvd.59.1652451979443; Fri, 13 May
 2022 07:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220427164659.106447-1-miquel.raynal@bootlin.com>
 <20220427164659.106447-9-miquel.raynal@bootlin.com> <CAB_54W7NWEYgmLfowvyXtKEsKhBaVrPzpkB1kasYpAst98mKNA@mail.gmail.com>
 <20220428095848.34582df4@xps13> <CAB_54W6nrNaXouN2LkEtzSpYNSmXT+WUbr4Y9rETyATznAbkEg@mail.gmail.com>
 <20220512163304.34fa5c35@xps13>
In-Reply-To: <20220512163304.34fa5c35@xps13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 13 May 2022 10:26:08 -0400
Message-ID: <CAK-6q+hO__T1XujGZNHtrfD4WM5PzxqzjyrRTL-pCw-fMFm3QA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 08/11] net: mac802154: Add a warning in the hot path
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
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
> alex.aring@gmail.com wrote on Sun, 1 May 2022 20:21:18 -0400:
>
> > Hi,
> >
> > On Thu, Apr 28, 2022 at 3:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > alex.aring@gmail.com wrote on Wed, 27 Apr 2022 14:01:25 -0400:
> > >
> > > > Hi,
> > > >
> > > > On Wed, Apr 27, 2022 at 12:47 PM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > We should never start a transmission after the queue has been stopped.
> > > > >
> > > > > But because it might work we don't kill the function here but rather
> > > > > warn loudly the user that something is wrong.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > >
> > > [...]
> > >
> > > > > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > > > > index a8a83f0167bf..021dddfea542 100644
> > > > > --- a/net/mac802154/tx.c
> > > > > +++ b/net/mac802154/tx.c
> > > > > @@ -124,6 +124,8 @@ bool ieee802154_queue_is_held(struct ieee802154_local *local)
> > > > >  static netdev_tx_t
> > > > >  ieee802154_hot_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > > > >  {
> > > > > +       WARN_ON_ONCE(ieee802154_queue_is_stopped(local));
> > > > > +
> > > > >         return ieee802154_tx(local, skb);
> > > > >  }
> > > > >
> > > > > diff --git a/net/mac802154/util.c b/net/mac802154/util.c
> > > > > index 847e0864b575..cfd17a7db532 100644
> > > > > --- a/net/mac802154/util.c
> > > > > +++ b/net/mac802154/util.c
> > > > > @@ -44,6 +44,24 @@ void ieee802154_stop_queue(struct ieee802154_local *local)
> > > > >         rcu_read_unlock();
> > > > >  }
> > > > >
> > > > > +bool ieee802154_queue_is_stopped(struct ieee802154_local *local)
> > > > > +{
> > > > > +       struct ieee802154_sub_if_data *sdata;
> > > > > +       bool stopped = true;
> > > > > +
> > > > > +       rcu_read_lock();
> > > > > +       list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> > > > > +               if (!sdata->dev)
> > > > > +                       continue;
> > > > > +
> > > > > +               if (!netif_queue_stopped(sdata->dev))
> > > > > +                       stopped = false;
> > > > > +       }
> > > > > +       rcu_read_unlock();
> > > > > +
> > > > > +       return stopped;
> > > > > +}
> > > >
> > > > sorry this makes no sense, you using net core functionality to check
> > > > if a queue is stopped in a net core netif callback. Whereas the sense
> > > > here for checking if the queue is really stopped is when 802.15.4
> > > > thinks the queue is stopped vs net core netif callback running. It
> > > > means for MLME-ops there are points we want to make sure that net core
> > > > is not handling any xmit and we should check this point and not
> > > > introducing net core functionality checks.
> > >
> > > I think I've mixed two things, your remark makes complete sense. I
> > > should instead here just check a 802.15.4 internal variable.
> > >
> >
> > I am thinking about this patch series... and I think it still has bugs
> > or at least it's easy to have bugs when the context is not right
> > prepared to call a synchronized transmission. We leave here the netdev
> > state machine world for transmit vs e.g. start/stop netif callback...
> > We have a warning here if there is a core netif xmit callback running
> > when 802.15.4 thinks it shouldn't (because we take control of it) but
> > I also think about a kind of the other way around. A warning if
> > 802.15.4 transmits something but the netdev core logic "thinks" it
> > shouldn't.
> >
> > That requires some checks (probably from netcore functionality) to
> > check if we call a 802.15.4 sync xmit but netif core already called
> > stop() callback. The last stop() callback - means the driver_ops
> > stop() callback was called, we have some "open_count" counter there
> > which MUST be incremented before doing any looping of one or several
> > sync transmissions. All I can say is if we call xmit() but the driver
> > is in stop() state... it will break things.
> >
> > My concern is also here that e.g. calling netif down or device
> > suspend() are only two examples I have in my mind right now. I don't
> > know all cases which can occur, that's why we should introduce another
> > WARN_ON_ONCE() for the case that 802.15.4 transmits something but we
> > are in a state where we can't transmit something according to netif
> > state (driver ops called stop()).
> >
> > Can you add such a check as well?
>
> That is a good idea, I have added such a check: if the interface is
> supposed to be down I'll warn and return because I don't think there is
> much we can do in this situation besides avoiding trying to transmit
> anything.
>

ok...

> > And please keep in mind to increment
> > the open count when implementing MLME-ops (or at least handle it
> > somehow), otherwise I guess it's easy to hit the warning. If another
> > user reports warnings and tells us what they did we might know more
> > other "cases" to fix.
>
> I don't think incrementing the open_count counter is the right solution
> here just because the stop call is not supposed to fail and has no
> straightforward ways to be deferred. In particular, just keeping the
> open_count incremented will just avoid the actual driver stop operation
> to be executed and the core will not notice it.
>

the stop callback can sleep, it's the job of the driver to synchronize
it somehow with the transceiver state.

> I came out with another solution: acquiring the rtnl when performing a
> MLME Tx operation to serialize these operations. We can easily have a
> version which just checks the rtnl was acquired as well for situations
> when the MLME operations are called by eg. the nl layer (and thus, with
> the rtnl lock taken automatically).

The rtnl lock needs definitely to be held during such operation.

- Alex

