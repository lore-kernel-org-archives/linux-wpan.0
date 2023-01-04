Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE8C3DA7D
	for <linux-wpan@archiver.kernel.org>; Wed,  4 Jan 2023 01:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjADBBm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 Jan 2023 20:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjADBBk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Jan 2023 20:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366FDE4
        for <linux-wpan@vger.kernel.org>; Tue,  3 Jan 2023 17:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672794055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/uYxQV02/XeM/qq8IXJH1eY5rLF1MvYLWNvFjGLeNo=;
        b=QmUZdstdP2ygIoWYaq0MuFNC2rZ+Bvyr9OaDBu/GJGXoiab+NwOHDs7VJ28wJOKKojYHP2
        2wvJSBYq4GO4uLx1zcwDmlWw96G7jN7H1ALQ9InKGK85SyhFyIOTOW0n1idipQpaLmiHiM
        fgvf3R6CWcgeLEC2qKsCrUjq+UqQ/v4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-9LQbqrfKPWqKFbswQepKRg-1; Tue, 03 Jan 2023 20:00:54 -0500
X-MC-Unique: 9LQbqrfKPWqKFbswQepKRg-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b004853521ef55so14346958ede.8
        for <linux-wpan@vger.kernel.org>; Tue, 03 Jan 2023 17:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/uYxQV02/XeM/qq8IXJH1eY5rLF1MvYLWNvFjGLeNo=;
        b=L1odx7CSorwxHG3mWg/BfbJMzNfAnWtFJxR0HYqCprv/yuzW+XLjef8w6lsJPCS+zk
         3RSj0N8aDOMSX5lqVP85y1LqZsb1+nPNf/iRxgouCqLdx7Cqd+fcojKjRPpuKnYuWAct
         FyCM1K4djwD+4+F0YXNCH1ZCEu3Trm3JOrYPWGuBT5Y/LcV8jVf5NvbH3Xu0rxOsDpCa
         UNKw1jrlcDKlA3OOLFaSUHdvKR26UvJKx+JG70PohXW+rSrffdxYAXaxK9+hdZ+vNYdg
         IcWrFgvbK0BHBwlxiZAWfVY18rvAEgzqHvU79mRUKLxAnSgTIrE/QayYvZ70VHurP8jA
         qBPw==
X-Gm-Message-State: AFqh2kpLjmhT/tZ6y4ZmIC2ASE6w9OJ4v4Kg8wKN2Z57/9NGZWeVKqh8
        OlTJKJOsSJxs8JDNYMcMRAPDzXPKf3CnH/9wx2EZslmL8pZdRIhv4yC2WPftSJAIqMrL6S8s9Um
        D+qzqsbIW2WTiJ4K+xfjBOXHtIbxUbgEG9oawVw==
X-Received: by 2002:a17:906:a2c3:b0:839:74cf:7c4c with SMTP id by3-20020a170906a2c300b0083974cf7c4cmr4640623ejb.265.1672794053046;
        Tue, 03 Jan 2023 17:00:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtLPURpb8cwylJfwu2pTR96g/A6IZS14ymgh74kRRCgmbhFAH/x2QIuQCnUPaqYm0xNBmt22+U61b5VvlRWKLs=
X-Received: by 2002:a17:906:a2c3:b0:839:74cf:7c4c with SMTP id
 by3-20020a170906a2c300b0083974cf7c4cmr4640619ejb.265.1672794052829; Tue, 03
 Jan 2023 17:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20221217000226.646767-1-miquel.raynal@bootlin.com>
 <20221217000226.646767-7-miquel.raynal@bootlin.com> <CAK-6q+hJb-py2sNBGYBQeHLbyM_OWzi78-gOf0LcdTukFDO4MQ@mail.gmail.com>
 <CAK-6q+gTQwS5n+YVFDeGTqEnSREt9KjC58zq9r2c8T456zXagQ@mail.gmail.com> <20230103161047.4efc243c@xps-13>
In-Reply-To: <20230103161047.4efc243c@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 3 Jan 2023 20:00:41 -0500
Message-ID: <CAK-6q+hniz7tw74Nzvjs6VPA6Goc1ozi231PcdWpysCdLdaf4Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 6/6] mac802154: Handle passive scanning
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Jan 3, 2023 at 10:15 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Mon, 2 Jan 2023 20:15:25 -0500:
>
> > Hi,
> >
> > On Mon, Jan 2, 2023 at 8:04 PM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Dec 16, 2022 at 7:04 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > ...
> > > > +void mac802154_scan_worker(struct work_struct *work)
> > > > +{
> > > > +       struct ieee802154_local *local =
> > > > +               container_of(work, struct ieee802154_local, scan_work.work);
> > > > +       struct cfg802154_scan_request *scan_req;
> > > > +       struct ieee802154_sub_if_data *sdata;
> > > > +       unsigned int scan_duration = 0;
> > > > +       struct wpan_phy* wpan_phy;
> > > > +       u8 scan_req_duration;
> > > > +       u8 page, channel;
> > > > +       int ret;
> > > > +
> > > > +       /* Ensure the device receiver is turned off when changing channels
> > > > +        * because there is no atomic way to change the channel and know on
> > > > +        * which one a beacon might have been received.
> > > > +        */
> > > > +       drv_stop(local);
> > > > +       synchronize_net();
> > >
> > > Do we do that for every channel switch? I think this is not necessary.
> > > It is necessary for bringing the transceiver into scan filtering mode,
> > > but we don't need to do that for switching the channel.
> > >
> > > And there is a difference why we need to do that for filtering. In my
> > > mind I had the following reason that the MAC layer is handled in Linux
> > > (softMAC) and by offloaded parts on the transceiver, this needs to be
> > > synchronized. The PHY layer is completely on the transceiver side,
> > > that's why you can switch channels during interface running. There
> > > exist some MAC parameters which are offloaded to the hardware and are
> > > currently not possible to synchronize while an interface is up,
> > > however this could change in future because the new helpers to
> > > synchronize softmac/transceiver mac handling.
> > >
> > > There is maybe a need here to be sure everything is transmitted on the
> > > hardware before switching the channel, but this should be done by the
> > > new mlme functionality which does a synchronized transmit. However we
> > > don't transmit anything here, so there is no need for that yet. We
> > > should never stop the transceiver being into receive mode and during
> > > scan we should always be into receive mode in
> > > IEEE802154_FILTERING_3_SCAN level without never leaving it.
> > >
> > > ... and happy new year.
> > >
> > > I wanted to ack this series but this came into my mind. I also wanted
> > > to check what exactly happens when a mlme op returns an error like
> > > channel access failure? Do we ignore it? Do we do cond_resched() and
> > > retry again later? I guess these are questions only if we get into
> > > active scanning with more exciting sending of frames, because here we
> > > don't transmit anything.
> >
> > Ignore that above about stopping the transceiver being in receive
> > mode, you are right... you cannot know on which channel/page
> > combination the beacon was received because as the comment says, it is
> > not atomic to switch it... sadly the transceiver does not tell us that
> > on a per frame basis.
>
> No problem ;)
>
> > Sorry for the noise. Still with my previous comments why it's still
> > valid to switch channels while phy is in receive mode but not in scan
> > mode, I would say if a user does that... then we don't care. Some
> > offloaded parts and softMAC handling still need indeed to be
> > synchronized because we don't know how a transceiver reacts on it to
> > change registers there while transmitting.
>
> In case of error during an MLME transmission the behavior depends on
> which MLME it is. As you said, for passive scanning it does not matter
> because we do not really transmit anything yet. However active scans
> and beacons sending need this feature and have to transmit frames. I
> assumed both actions should not have a very high importance and if the
> transmission fails, we will just wait for the next slot and try again.
> It was the simplest approach I could come up with (I will send the
> beacons part very soon). Should we consider retrying a fixed number of
> times immediately after the failure? 1 time? 2 times? Or should we, as
> it is implemented, wait for the next slot?

use the simplest approach. btw: 802.15.4 and ack handling has it's
"own" retransmit handling, but I think csma retries could happen
without setting the ack request bit. We should avoid that the user
gets an error "channel access failure" for doing an active scan, or
this maybe should be and the user can react to it? It would then
require that the user's implementation cares/is aware about such a
possibility and maybe does a simple retry on user level as well or
whatever they want then? However they are probably not happy to start
a whole scan again...

I am not sure what the right thing is... it is probably a rare case.

- Alex

