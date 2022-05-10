Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11116C4332F
	for <linux-wpan@archiver.kernel.org>; Tue, 10 May 2022 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiEJPRS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 10 May 2022 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345732AbiEJPQW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 May 2022 11:16:22 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E73210BBD;
        Tue, 10 May 2022 07:52:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D8B3C100013;
        Tue, 10 May 2022 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652194361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqSy1wZBw7nlBSHWf94mTTkrdt8QjFQJgNOLK+C7leA=;
        b=YbEWIAm1PuEj1GqtW+MDx3PF1xjSMq6r5SO48D1wGYFsxHM6MkdAFADa4Y3mluCTnFtXzh
        5vOrQMT6O27GrDQt+sUFTkU+pj8J0V06vnePSnSJb62BZ72HeQHWsMWIyjvcgYzIqmlnKY
        byv0xfCSBX9IJrJbRN0uGrDfQYVQSNnr0MSO4T7ZBOSaMKmOWHfsoIJg94GdTRMuCLH1ro
        Z9ttmTZliQ/C3z1/9lUrw0Sgsl+n7c1mJDOc1eiWPwm6esaD/MhmnubgJyPzBBgI/0hFsS
        iZbosRRN4jFGLwU7q7A4BzZR+n7v9++kG+zq3b/b/67KNQvkXsr663pSJyqtew==
Date:   Tue, 10 May 2022 16:52:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
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
Subject: Re: [PATCH wpan-next 06/11] net: mac802154: Hold the transmit queue
 when relevant
Message-ID: <20220510165237.43382f42@xps13>
In-Reply-To: <CAK-6q+jCYDQ-rtyawz1m2Yt+ti=3d6PrhZebB=-PjcX-6L-Kdg@mail.gmail.com>
References: <20220427164659.106447-1-miquel.raynal@bootlin.com>
        <20220427164659.106447-7-miquel.raynal@bootlin.com>
        <CAK-6q+jCYDQ-rtyawz1m2Yt+ti=3d6PrhZebB=-PjcX-6L-Kdg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alex,

> > --- a/net/mac802154/tx.c
> > +++ b/net/mac802154/tx.c
> > @@ -106,6 +106,21 @@ ieee802154_tx(struct ieee802154_local *local, stru=
ct sk_buff *skb)
> >         return NETDEV_TX_OK;
> >  }
> >
> > +void ieee802154_hold_queue(struct ieee802154_local *local)
> > +{
> > +       atomic_inc(&local->phy->hold_txs);
> > +}
> > +
> > +void ieee802154_release_queue(struct ieee802154_local *local)
> > +{
> > +       atomic_dec(&local->phy->hold_txs);
> > +}
> > +
> > +bool ieee802154_queue_is_held(struct ieee802154_local *local)
> > +{
> > +       return atomic_read(&local->phy->hold_txs);
> > +} =20
>=20
> I am not getting this, should the release_queue() function not do
> something like:
>=20
> if (atomic_dec_and_test(hold_txs))
>       ieee802154_wake_queue(local);
>=20
> I think we don't need the test of "ieee802154_queue_is_held()" here,
> then we need to replace all stop_queue/wake_queue with hold and
> release?

That's actually a good idea. I've implemented it and it looks nice too.
I'll clean this up and share a new version with:
- The wake call checked everytime hold_txs gets decremented
- The removal of the _queue_is_held() helper
- _wake/stop_queue() turned static
- _hold/release_queue() used everywhere

Thanks,
Miqu=C3=A8l
