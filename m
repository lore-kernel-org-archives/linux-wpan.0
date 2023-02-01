Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA394C38142
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Feb 2023 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBARQk (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBARQj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Feb 2023 12:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C76A7D
        for <linux-wpan@vger.kernel.org>; Wed,  1 Feb 2023 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675271756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gzT36ewgNE+R9sO4cnT/wtnArdFhfnssBOprO3RY7o=;
        b=C2B0czcrdZY2Ss06HRyCvCvtKN5vdgEwMaKyuYjV/yR1k6+0QhNtbSEBVzI+U9HLQ77R8T
        r2hvKQTM8uUY3t3nC39cPG0gJXUrDDW+0fu/s9nbElVGJz0PjI9rf48cs9K3ZnIxfM3fyA
        Oub2Zwydi6TNcejIJ9F//neGrXRnwLg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-O734IQ8zOqipEkXJcCokIA-1; Wed, 01 Feb 2023 12:15:55 -0500
X-MC-Unique: O734IQ8zOqipEkXJcCokIA-1
Received: by mail-ed1-f72.google.com with SMTP id s26-20020a056402037a00b004a25c2875d6so5463574edw.8
        for <linux-wpan@vger.kernel.org>; Wed, 01 Feb 2023 09:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gzT36ewgNE+R9sO4cnT/wtnArdFhfnssBOprO3RY7o=;
        b=WyLJjiky6HyqFMp00QH/ddKgTl/tjXHk2pQIyBzyCHOwRil5tWSVXnSr2gr5fqRzaJ
         VojctlyT6eIbx7UxrD1pl4v57C5rsCgGsvsbK1KfHoVAWAjqA677F2wdwccJM08xoHXw
         EYwcZ0bI3eezE6TQNxGJGi4YQFeL/vzikWyRobFR+B9zbmwAB5ZlBa+bj7DkEg2gJh8n
         AG7YeHMFEK3Fji2CpjfpWSx/LFrbz/WuKnrzAr7CvCGFhMx4ZX3GKtV7YJ0O3Maa6noc
         vgqUUk+8FccKa93HyFa6S0eiUFmDQj4VzJ+XmtSHQdeoEvi1p9nRbgKHIR6XvVuPv71j
         Tv6g==
X-Gm-Message-State: AO0yUKVkwVPPhpZejuh2E2gX2OHHX7CT2m0n0RypO7sAp9NiLCStU8Ox
        xaaXRWh/brLLvWhSFRXKllFoVtFQdFqfKqPUYQcHDRbIm7mnpdWLzkTMjhvyi+cwDULxcruDQts
        HWnqiJ702V5Le3i1gCl3S2PHWIkDkIE9Vew8Xdg==
X-Received: by 2002:a17:906:1155:b0:882:c2dd:f29e with SMTP id i21-20020a170906115500b00882c2ddf29emr1045599eja.268.1675271753997;
        Wed, 01 Feb 2023 09:15:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9B1Q2R+IjQ0DwAJ9OEgIZzbhxXmqFRXFMAltQje6Ao2YS8s7kqlk8kYzYfHTu/rpqvNio2oJvFSLsqjJH+yU4=
X-Received: by 2002:a17:906:1155:b0:882:c2dd:f29e with SMTP id
 i21-20020a170906115500b00882c2ddf29emr1045587eja.268.1675271753834; Wed, 01
 Feb 2023 09:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20230125102923.135465-1-miquel.raynal@bootlin.com>
 <CAK-6q+jN1bnP1FdneGrfDJuw3r3b=depEdEP49g_t3PKQ-F=Lw@mail.gmail.com>
 <CAK-6q+hoquVswZTm+juLasQzUJpGdO+aQ7Q3PCRRwYagge5dTw@mail.gmail.com>
 <20230130105508.38a25780@xps-13> <CAK-6q+gqQgFxqBUAhHDMaWv9VfuKa=bCVee_oSLQeVtk_G8=ow@mail.gmail.com>
 <20230131122525.7bd35c2b@xps-13>
In-Reply-To: <20230131122525.7bd35c2b@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 1 Feb 2023 12:15:42 -0500
Message-ID: <CAK-6q+hAgyx3YML7Lw=MAkUX4i8PVqxSKiVzeAM-wGJOdL9aXA@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 6:25 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> > > > > > Changes in v2:
> > > > > > * Clearly state in the commit log llsec is not supported yet.
> > > > > > * Do not use mlme transmission helpers because we don't really need to
> > > > > >   stop the queue when sending a beacon, as we don't expect any feedback
> > > > > >   from the PHY nor from the peers. However, we don't want to go through
> > > > > >   the whole net stack either, so we bypass it calling the subif helper
> > > > > >   directly.
> > > > > >
> > > >
> > > > moment, we use the mlme helpers to stop tx
> > >
> > > No, we no longer use the mlme helpers to stop tx when sending beacons
> > > (but true MLME transmissions, we ack handling and return codes will be
> > > used for other purposes).
> > >
> >
> > then we run into an issue overwriting the framebuffer while the normal
> > transmit path is active?
>
> Crap, yes you're right. That's not gonna work.
>
> The net core acquires HARD_TX_LOCK() to avoid these issues and we are
> no bypassing the net core without taking care of the proper frame
> transmissions either (which would have worked with mlme_tx_one()). So I
> guess there are two options:
>
> * Either we deal with the extra penalty of stopping the queue and
>   waiting for the beacon to be transmitted with an mlme_tx_one() call,
>   as proposed initially.
>
> * Or we hardcode our own "net" transmit helper, something like:
>
> mac802154_fast_mlme_tx() {
>         struct net_device *dev = skb->dev;
>         struct netdev_queue *txq;
>
>         txq = netdev_core_pick_tx(dev, skb, NULL);
>         cpu = smp_processor_id();
>         HARD_TX_LOCK(dev, txq, cpu);
>         if (!netif_xmit_frozen_or_drv_stopped(txq))
>                 netdev_start_xmit(skb, dev, txq, 0);
>         HARD_TX_UNLOCK(dev, txq);
> }
>
> Note1: this is very close to generic_xdp_tx() which tries to achieve the
> same goal: sending packets, bypassing qdisc et al. I don't know whether
> it makes sense to define it under mac802154/tx.c or core/dev.c and give
> it another name, like generic_tx() or whatever would be more
> appropriate. Or even adapting generic_xdp_tx() to make it look more
> generic and use that function instead (without the xdp struct pointer).
>

The problem here is that the transmit handling is completely
asynchronous. Calling netdev_start_xmit() is not "transmit and wait
until transmit is done", it is "start transmit here is the buffer" an
interrupt is coming up to report transmit is done. Until the time the
interrupt isn't arrived the framebuffer on the device is in use, we
don't know when the transceiver is done reading it. Only after tx done
isr. The time until the isr isn't arrived is for us a -EBUSY case due
hardware resource limitation. Currently we do that with stop/wake
queue to avoid calling of xmit_do() to not run into such -EBUSY
cases...

There might be clever things to do here to avoid this issue... I am
not sure how XDP does that.

> Note2: I am wondering if it makes sense to disable bh here as well?

May HARD_TX_LOCK() already do that? If they use spin_lock_bh() they
disable local softirqs until the lock isn't held anymore.

>
> Once we settle, I send a patch.
>

Not sure how to preceded here, but do see the problem? Or maybe I
overlooked something here...

- Alex

