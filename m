Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA407C636D4
	for <linux-wpan@archiver.kernel.org>; Fri, 17 Feb 2023 04:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBQEiM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Feb 2023 23:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQEiK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Feb 2023 23:38:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4182CC42
        for <linux-wpan@vger.kernel.org>; Thu, 16 Feb 2023 20:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676608643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ME7B8xvczMkJTzc+YtG3ediEUY9/joNnuGc7NSRWYM=;
        b=aItv032rRl2kxyJUxWROT8Y03OZwDtGhUSN6fbeBUlKSTQfO/VSCQUG+5xdec5fjrxG1fO
        Ho2+09DqUp334qt5NPZMx0VarLgLbK+9rylm5wRyh3DEKkwcAU3kaEedsF2cO13ERIFbDp
        OEcBfnmNJzhRAoR7hV7Kwap6Mb5Eeu0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-CRRg8t5FNFqfW-mIB1a77Q-1; Thu, 16 Feb 2023 23:37:14 -0500
X-MC-Unique: CRRg8t5FNFqfW-mIB1a77Q-1
Received: by mail-ed1-f70.google.com with SMTP id ee29-20020a056402291d00b0049ec3a108beso25069edb.7
        for <linux-wpan@vger.kernel.org>; Thu, 16 Feb 2023 20:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ME7B8xvczMkJTzc+YtG3ediEUY9/joNnuGc7NSRWYM=;
        b=NG/ay6q6INILPEUVIkf1wR74fiilgzeU3J7WqozOiYSFOcUQuAuBPAEWi/5WmPBHHq
         Gm4V4nuQf00431gyvdAwa4/0mDPtlltreb5O8jM1gbXDZ1sDQIAsz+JwZN4T2t3T6la+
         DnPI4MrQHQXPyItgbcKDzsnvg9xl4u/HWfZxGRTzDsp4snhvI2pbt0HUY0Ik8PQBA3lF
         QujS7ZGNGC/jjjkqSFOD0yTqgGSuk9max1BANmsyrXQ58KzfFPabKmRhUFMoFKYRw8Kd
         Sxxt+VN0exXgNLZr/097xDVs/BhI16LTXdsjfYh1u82BqJ0AdBYAh2xKeBZNtR5a9/FX
         XwQQ==
X-Gm-Message-State: AO0yUKUeVml1y3UyGKjY7J/4hCf6rERRzSlwUpVzTLbag3DXVdWwhduI
        JIUXDqGnFGOtfX1Cy44fiLWOOHIQaK/6eDKSJuG32PXdSeyJ2e9bPeI2Nw4rjtzky6XdAL/43AA
        nJ0xs1W9rnrXePUk1zSIyRvelJUQREgIXQFfsew==
X-Received: by 2002:a17:906:2dd8:b0:8b1:2898:2138 with SMTP id h24-20020a1709062dd800b008b128982138mr3867467eji.3.1676608633730;
        Thu, 16 Feb 2023 20:37:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+g+NOWmP612b9qud0ZhwUi+VxdJVy3tKmDHi88Bq0UqKSY5Hc1cydneGSpzu/aS6F42DY8iG9pq9WF+1zpkl8=
X-Received: by 2002:a17:906:2dd8:b0:8b1:2898:2138 with SMTP id
 h24-20020a1709062dd800b008b128982138mr3867456eji.3.1676608633463; Thu, 16 Feb
 2023 20:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+iwqVx+6qQ-ctynykdrbN+SHxzk91gQCSdYCUD-FornZA@mail.gmail.com>
 <20230206101235.0371da87@xps-13> <CAK-6q+jav4yJD3MsOssyBobg1zGqKC5sm-xCRYX1SCkH9GhmHw@mail.gmail.com>
 <CAK-6q+jbcMZK16pfZTb5v8-jvhmvk9-USr6hZE34H1MOrpF=JQ@mail.gmail.com>
 <20230213183535.05e62c1c@xps-13> <CAK-6q+hkJpqNG9nO_ugngjGQ_q9VdLu+xDjmD09MT+5=tvd0QA@mail.gmail.com>
 <CAK-6q+jU7-ETKeoM=MLmfyMUqywteBC8sUAndRF1vx0PgA+WAA@mail.gmail.com>
 <20230214150600.1c21066b@xps-13> <20230214154632.69e8e339@xps-13>
In-Reply-To: <20230214154632.69e8e339@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 16 Feb 2023 23:37:01 -0500
Message-ID: <CAK-6q+h2TzWYHJVmPekgze6uqkSkA5G7Mu-FHSzSXUfD8ATb9g@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] ieee802154: Add support for user scanning requests
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

On Tue, Feb 14, 2023 at 9:46 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>
> miquel.raynal@bootlin.com wrote on Tue, 14 Feb 2023 15:06:00 +0100:
>
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Tue, 14 Feb 2023 08:53:57 -0500:
> >
> > > Hi,
> > >
> > > On Tue, Feb 14, 2023 at 8:34 AM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Feb 13, 2023 at 12:35 PM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > Hi Alexander,
> > > > >
> > > > > > > > > > +static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
> > > > > > > > > > +{
> > > > > > > > > > +       struct cfg802154_registered_device *rdev = info->user_ptr[0];
> > > > > > > > > > +       struct net_device *dev = info->user_ptr[1];
> > > > > > > > > > +       struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> > > > > > > > > > +       struct wpan_phy *wpan_phy = &rdev->wpan_phy;
> > > > > > > > > > +       struct cfg802154_scan_request *request;
> > > > > > > > > > +       u8 type;
> > > > > > > > > > +       int err;
> > > > > > > > > > +
> > > > > > > > > > +       /* Monitors are not allowed to perform scans */
> > > > > > > > > > +       if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > > > > > > > > > +               return -EPERM;
> > > > > > > > >
> > > > > > > > > btw: why are monitors not allowed?
> > > > > > > >
> > > > > > > > I guess I had the "active scan" use case in mind which of course does
> > > > > > > > not work with monitors. Maybe I can relax this a little bit indeed,
> > > > > > > > right now I don't remember why I strongly refused scans on monitors.
> > > > > > >
> > > > > > > Isn't it that scans really work close to phy level? Means in this case
> > > > > > > we disable mostly everything of MAC filtering on the transceiver side.
> > > > > > > Then I don't see any reasons why even monitors can't do anything, they
> > > > > > > also can send something. But they really don't have any specific
> > > > > > > source address set, so long addresses are none for source addresses, I
> > > > > > > don't see any problem here. They also don't have AACK handling, but
> > > > > > > it's not required for scan anyway...
> > > > > > >
> > > > > > > If this gets too complicated right now, then I am also fine with
> > > > > > > returning an error here, we can enable it later but would it be better
> > > > > > > to use ENOTSUPP or something like that in this case? EPERM sounds like
> > > > > > > you can do that, but you don't have the permissions.
> > > > > > >
> > > > > >
> > > > > > For me a scan should also be possible from iwpan phy $PHY scan (or
> > > > > > whatever the scan command is, or just enable beacon)... to go over the
> > > > > > dev is just a shortcut for "I mean whatever the phy is under this dev"
> > > > > > ?
> > > > >
> > > > > Actually only coordinators (in a specific state) should be able to send
> > > > > beacons, so I am kind of against allowing that shortcut, because there
> > > > > are usually two dev interfaces on top of the phy's, a regular "NODE"
> > > > > and a "COORD", so I don't think we should go that way.
> > > > >
> > > > > For scans however it makes sense, I've added the necessary changes in
> > > > > wpan-tools. The TOP_LEVEL(scan) macro however does not support using
> > > > > the same command name twice because it creates a macro, so this one
> > > > > only supports a device name (the interface command has kind of the same
> > > > > situation and uses a HIDDEN() macro which cannot be used here).
> > > > >
> > > >
> > > > Yes, I was thinking about scanning only.
> > > >
> > > > > So in summary here is what is supported:
> > > > > - dev <dev> beacon
> > > > > - dev <dev> scan trigger|abort
> > > > > - phy <phy> scan trigger|abort
> > > > > - dev <dev> scan (the blocking one, which triggers, listens and returns)
> > > > >
> > > > > Do you agree?
> > > > >
> > > >
> > > > Okay, yes. I trust you.
> > >
> > > btw: at the point when a scan requires a source address... it cannot
> > > be done because then a scan is related to a MAC instance -> an wpan
> > > interface and we need to bind to it. But I think it doesn't?
> >
> > I'm not sure I follow you here. You mean in case of active scan?
>
> Actually a beacon requests do not require any kind of source identifier,
> so what do you mean by source address?
>

Is this more clear now?

> A regular beacon, however, does. Which means sending beacons would
> include being able to set an address into a monitor interface. So if we
> want to play with beacons on monitor interfaces, we should also relax
> the pan_id/addressing rules.

mhhh, this is required for active scans? Then a scan operation cannot
be run on giving a phy only as a parameter...

- Alex

