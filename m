Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD3ECAAD4
	for <linux-wpan@archiver.kernel.org>; Mon, 29 Aug 2022 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiH2IhN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 29 Aug 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiH2IhK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Aug 2022 04:37:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A693657E16
        for <linux-wpan@vger.kernel.org>; Mon, 29 Aug 2022 01:37:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8500660009;
        Mon, 29 Aug 2022 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661762226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyktvFw61r4BiSjqoOGz/5u7eDhTR55mLLXireYX9OI=;
        b=Kts6QykIkH8h/Snuxieo+WwK2s1UjMB/ClXMyx7zTkcHMfPNMWXtgOlQh0vgLWWlhyUTM5
        EdSjomf0yfgTeMgChZ1zFznc3pRxk8nBJl+r/Y6SZ4EjC1a1BKp6oh9nWSculBCtE3EiPP
        dM7SnrkSQd0JtEiRu0gQkWU/2vb726FFxqeTj2nVuA2pP8u5rdfshz/P8p02LUBSV4K/68
        Ju18SAWoiiurlBwe6qiBP5Q4uxXkEH85RSGoUne86QGECImBnogJLkiAimqDnVpfPeI+Ca
        8EtYeo9EUo3ZRfIp/CjrmdRxoIU92JQqzOaqCWURgTE9+ZlcHK+nf9eM2GGEcA==
Date:   Mon, 29 Aug 2022 10:37:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-tools 0/7] iwpan: Support scanning/beaconing
Message-ID: <20220829103702.4cce4670@xps-13>
In-Reply-To: <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
        <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
        <20220819190654.6af62bca@xps-13>
        <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
        <20220825145516.14bd5b45@xps-13>
        <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
        <20220826125020.414964fd@xps-13>
        <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Sun, 28 Aug 2022 09:55:24 -0400:

> Hi,
>=20
> On Fri, Aug 26, 2022 at 6:50 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> ...
> >
> > I've updated the tools so that we have:
> >
> > * "scan trigger" which does not block
> > * "scan monitor" which displays with a pretty output the new
> >   coordinators and stops blocking when the scan is over (either because
> >   it reached the last channel to scan, or it got aborted)
> > * "scan abort" which stops an ongoing scan
> > * "scan" which is the same as "scan trigger; scan monitor", and will =20
>=20
> no, there is a race in the design of "scan trigger; scan monitor".

Right, I've used pthread to first start the monitoring, before actually
triggering the scan. That should be enough.

> >   send an abort command if interrupted with SIGINT
> >
> > On the other side there was in the previous versions a command "iwpan
> > event" which I just renamed "iwpan monitor" which follows anything
> > 802154 related and displays a single line each time, it looks like:
> > # iwpan monitor -t // -t is an option to display timestamps
> > 1661510897.820505: coord1 (phy #1): scan started
> > 1661510903.874055: coord1 (phy #1): new coordinator detected: PAN 0xabc=
d, addr 0x42aab7e343ea5c0f
> > 1661510908.953874: coord1 (phy #1): scan finished
> > 1661510915.437030: coord1 (phy #1): scan started
> > 1661510916.242412: coord1 (phy #1): scan aborted
> >
> > This should address all the needs. =20
>=20
> I would remove the scan monitor and if it is needed a "monitor scan",

Actually we need both "scan monitor" and "monitor scan". The former
shows what is happening in a clean manner, with a detailed view of all
the information about the beacon received, while the latter would more
something that we run aside to follow what's happening, it's a bare and
short output (one-liners).

> "monitor" will give you all 802.15.4 events, scan will give you a
> filter for all scan events and may we add in future even a ?phy/dev?
> argument to filter per interface? :)
>=20
> "monitor scan" just to move event monitoring to the right command.

I haven't added the "scan" option because we currently have almost only
that, it can be added later, it's just a tool to show how everything
works and give a code base anyway.

Thanks,
Miqu=C3=A8l
