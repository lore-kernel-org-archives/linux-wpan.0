Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80134C636CC
	for <linux-wpan@archiver.kernel.org>; Mon,  6 Feb 2023 01:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBFBmD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 5 Feb 2023 20:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFBmD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Feb 2023 20:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7719F28
        for <linux-wpan@vger.kernel.org>; Sun,  5 Feb 2023 17:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675647675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGtOuZUmHck2/E47dwj+H1T9NaGss2gPK8QCykYxpIc=;
        b=JmuAKBuFNJ2mNd8xbJhxHxa6CLrYl3N+r7yWUZJHygx217licCh1cCL3+V/fxwRd8wM7cy
        M8YKvBHUf16n1Uq4DkKyEFudNIbxJvXIWYsgQHshKfA/xjz02sYaFJDH0Qj90VQmBMspjR
        g0VZAVedsVLVBQXfyBI//JOxqjLT/mk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-Gb3r5n0UN3mVfnogZ-UDfA-1; Sun, 05 Feb 2023 20:41:13 -0500
X-MC-Unique: Gb3r5n0UN3mVfnogZ-UDfA-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so6672625edz.21
        for <linux-wpan@vger.kernel.org>; Sun, 05 Feb 2023 17:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtOuZUmHck2/E47dwj+H1T9NaGss2gPK8QCykYxpIc=;
        b=tHIX9N1iVFwKWuAEfxmfnxs9sYHeW0mU3XDxxF6hu22uudjOc7ysfZhxjufq9aZSUd
         IFfZsJHUhhqTsLFu+HPkLx9hBgdN7SOmcb9DUIsRJDnjF+MgEpQ+WIagSm2dralE3mst
         w2dsZctUD3tTKgEAYVl7j8lEtw3JC1w/AVBhrQyz3VMmmUTkOG6pX/8goQWn4qnVcC52
         WpdkbLAD6ScggreEqnINvrR3LP8WG78j5ydgTVw9SwWZBfvixNDzsgC48h/pYd0Da5Eg
         O6eZ6XzLDHDHGI03k/k8kKzO2yEG214HWNTC1WXdo5zhMR3PXa91YZGYCD20Ufnfno7n
         X7EQ==
X-Gm-Message-State: AO0yUKU1Ex77OKizjgP3njRYH1HFW5s67/QOrUSzQpo9c1MkM4E5xOdS
        BjmMiq3qp1WZENHjjf9jD8AISBeAOjUTWiPDFwX1NEE1GHgEFPrG0llDniQpr/vnSbPCHyh7onb
        w3fGlX0B+wubNlU9MK2t2zIGCfUBIUooBesjyaQ==
X-Received: by 2002:a05:6402:360a:b0:499:cfee:8d96 with SMTP id el10-20020a056402360a00b00499cfee8d96mr5357743edb.21.1675647672750;
        Sun, 05 Feb 2023 17:41:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9XcVoZijnHt/meWhf5ntYri+OzaCKrBdUNb5bTYQ37i+fKlQboZUciuuKQzZXf70DrrQn1EYKwAiq0OhlwUds=
X-Received: by 2002:a05:6402:360a:b0:499:cfee:8d96 with SMTP id
 el10-20020a056402360a00b00499cfee8d96mr5357738edb.21.1675647672552; Sun, 05
 Feb 2023 17:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20230125102923.135465-1-miquel.raynal@bootlin.com>
 <CAK-6q+jN1bnP1FdneGrfDJuw3r3b=depEdEP49g_t3PKQ-F=Lw@mail.gmail.com>
 <CAK-6q+hoquVswZTm+juLasQzUJpGdO+aQ7Q3PCRRwYagge5dTw@mail.gmail.com>
 <20230130105508.38a25780@xps-13> <CAK-6q+gqQgFxqBUAhHDMaWv9VfuKa=bCVee_oSLQeVtk_G8=ow@mail.gmail.com>
 <20230131122525.7bd35c2b@xps-13> <CAK-6q+hAgyx3YML7Lw=MAkUX4i8PVqxSKiVzeAM-wGJOdL9aXA@mail.gmail.com>
 <20230203161943.076ec169@xps-13>
In-Reply-To: <20230203161943.076ec169@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 5 Feb 2023 20:41:00 -0500
Message-ID: <CAK-6q+h8k4jY7G=eTWNUk+WmhRmRofzOWdCZHFWZEyGCpar2jg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: Beaconing support
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
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Feb 3, 2023 at 10:19 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Wed, 1 Feb 2023 12:15:42 -0500:
>
> > Hi,
> >
> > On Tue, Jan 31, 2023 at 6:25 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > > > > > > Changes in v2:
> > > > > > > > * Clearly state in the commit log llsec is not supported yet.
> > > > > > > > * Do not use mlme transmission helpers because we don't really need to
> > > > > > > >   stop the queue when sending a beacon, as we don't expect any feedback
> > > > > > > >   from the PHY nor from the peers. However, we don't want to go through
> > > > > > > >   the whole net stack either, so we bypass it calling the subif helper
> > > > > > > >   directly.
> > > > > > > >
> > > > > >
> > > > > > moment, we use the mlme helpers to stop tx
> > > > >
> > > > > No, we no longer use the mlme helpers to stop tx when sending beacons
> > > > > (but true MLME transmissions, we ack handling and return codes will be
> > > > > used for other purposes).
> > > > >
> > > >
> > > > then we run into an issue overwriting the framebuffer while the normal
> > > > transmit path is active?
> > >
> > > Crap, yes you're right. That's not gonna work.
> > >
> > > The net core acquires HARD_TX_LOCK() to avoid these issues and we are
> > > no bypassing the net core without taking care of the proper frame
> > > transmissions either (which would have worked with mlme_tx_one()). So I
> > > guess there are two options:
> > >
> > > * Either we deal with the extra penalty of stopping the queue and
> > >   waiting for the beacon to be transmitted with an mlme_tx_one() call,
> > >   as proposed initially.
> > >
> > > * Or we hardcode our own "net" transmit helper, something like:
> > >
> > > mac802154_fast_mlme_tx() {
> > >         struct net_device *dev = skb->dev;
> > >         struct netdev_queue *txq;
> > >
> > >         txq = netdev_core_pick_tx(dev, skb, NULL);
> > >         cpu = smp_processor_id();
> > >         HARD_TX_LOCK(dev, txq, cpu);
> > >         if (!netif_xmit_frozen_or_drv_stopped(txq))
> > >                 netdev_start_xmit(skb, dev, txq, 0);
> > >         HARD_TX_UNLOCK(dev, txq);
> > > }
> > >
> > > Note1: this is very close to generic_xdp_tx() which tries to achieve the
> > > same goal: sending packets, bypassing qdisc et al. I don't know whether
> > > it makes sense to define it under mac802154/tx.c or core/dev.c and give
> > > it another name, like generic_tx() or whatever would be more
> > > appropriate. Or even adapting generic_xdp_tx() to make it look more
> > > generic and use that function instead (without the xdp struct pointer).
> > >
> >
> > The problem here is that the transmit handling is completely
> > asynchronous. Calling netdev_start_xmit() is not "transmit and wait
> > until transmit is done", it is "start transmit here is the buffer" an
> > interrupt is coming up to report transmit is done. Until the time the
> > interrupt isn't arrived the framebuffer on the device is in use, we
> > don't know when the transceiver is done reading it. Only after tx done
> > isr. The time until the isr isn't arrived is for us a -EBUSY case due
> > hardware resource limitation. Currently we do that with stop/wake
> > queue to avoid calling of xmit_do() to not run into such -EBUSY
> > cases...
> >
> > There might be clever things to do here to avoid this issue... I am
> > not sure how XDP does that.
> >
> > > Note2: I am wondering if it makes sense to disable bh here as well?
> >
> > May HARD_TX_LOCK() already do that? If they use spin_lock_bh() they
> > disable local softirqs until the lock isn't held anymore.
>
> I saw a case where both are called so I guess the short answer is "no":
> https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L4307
>
> >
> > >
> > > Once we settle, I send a patch.
> > >
> >
> > Not sure how to preceded here, but do see the problem? Or maybe I
> > overlooked something here...
>
> No you clearly had a sharp eye on that one, I totally see the problem.
>
> Maybe the safest and simplest approach would be to be back using
> the proper mlme transmission helpers for beacons (like in the initial
> proposal).

ok.

> TBH I don't think there is a huge performance hit because in
> both cases we wait for that ISR saying "the packet has been consumed by
> the transceiver". It's just that in one case we wait for the return
> code (MLME) and then return, in the other case we return but no
> more packets will go through until the queue is released by the ISR (as
> you said, in order to avoid the -EBUSY case). So in practice I don't
> expect any performance hit. It is true however that we might want to
> optimize this a little bit if we ever add something like an async
> callback saying "skb consumed by the transceiver, another can be
> queued" and gain a few us. Maybe a comment could be useful here (I'll
> add it to my fix if we agree).

the future will show how things work out here. I am fine with the
initial proposal.

- Alex

