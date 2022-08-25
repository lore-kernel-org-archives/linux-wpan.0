Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FDAC3F6B0
	for <linux-wpan@archiver.kernel.org>; Thu, 25 Aug 2022 12:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiHYMzd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbiHYMzX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Aug 2022 08:55:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE445052
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2022 05:55:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79960E000C;
        Thu, 25 Aug 2022 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661432118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpNTPrvEDKUm8h6b1qaXXXac/Vjy37QHlY3NErKemUc=;
        b=gBQv/7V6YWnv7HM3WCVIbpFGUPhGXBncWUnDqzKP3yPHjFKQhjC3JyE/E7qCi9NokdSauf
        /3ZLaZgRaGKKRj8xDpELbqkQvP72fpptJvr/Ate6pJRPclivT11UBYqPci708YWSTPZSuE
        Br12lZRDTIn9zdu4mf1LrQmZqJ/Rsf91fkXwsxQG+9IRv42VwL8ZFelQaJqroGwKX1ED6h
        p9MXBdiord7iGenWosmu/9YDqx3wh3N7yhSAcoH5RHn1tBjhPu7g4qw6lJEL+njU8JaVFo
        ctcFXFrGjbLREoqk4nxA4zNf81toEepCy1YKhXKhxygTjrBkZuroyq9HsI2GYQ==
Date:   Thu, 25 Aug 2022 14:55:16 +0200
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
Message-ID: <20220825145516.14bd5b45@xps-13>
In-Reply-To: <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
        <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
        <20220819190654.6af62bca@xps-13>
        <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Tue, 23 Aug 2022 21:36:23 -0400:

> Hi,
>=20
> On Fri, Aug 19, 2022 at 1:07 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sun, 3 Jul 2022 21:18:40 -0400:
> > =20
> > > Hi,
> > >
> > > On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.=
com> wrote: =20
> > > >
> > > > Hello,
> > > >
> > > > This series follows the work done in the Linux kernel stack: now th=
at
> > > > the core knows about the different netlink commands and attributes =
in
> > > > order to support scanning and beaconing requests from end-to-end, h=
ere
> > > > are the userspace changes to be able to use it.
> > > >
> > > > Here is a list of the new available features.
> > > >
> > > > * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
> > > >   valid for passively sending beacons at regular intervals. An inte=
rval
> > > >   of 15 would request the core to answer BEACON_REQ.
> > > >   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fix=
ed rate
> > > >   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ o=
nly
> > > >   # iwpan dev coord0 beacons stop # apply to both cases
> > > >
> > > > * Scanning all the channels or only a subset:
> > > >   # iwpan dev wpan1 scan type passive duration 3 # will not trigger=
 BEACON_REQ
> > > >   # iwpan dev wpan1 scan type active duration 3 # will trigger BEAC=
ON_REQ
> > > >
> > > > * During scans, there is a dedicated netlink channel event to liste=
n to
> > > >   in order to get events like "a new coordinator was discovered" or=
 "the
> > > >   scan is over". When beacons from new devices are received, the to=
ol
> > > >   would print something like:
> > > >   PAN 0xabcd (on coord1)
> > > >         coordinator 0xe673d7a3f3a87ccc
> > > >         page 0
> > > >         channel 13
> > > >         preamble code 0
> > > >         mean prf 0
> > > >         superframe spec. 0x4f11
> > > >         LQI 0
> > > >
> > > > * It is also possible to monitor the events with:
> > > >   # iwpan event
> > > >
> > > > * As well as triggering a non blocking scan:
> > > >   # iwpan dev wpan1 scan trigger type passive duration 3
> > > >   # iwpan dev wpan1 scan done
> > > >   # iwpan dev wpan1 scan abort =20
> > >
> > > why do we need an abort? =20
> >
> > Perhaps the tool --help would have helped to get the naming, but we
> > need:
> > - a command to start a scan, either use:
> >   * "scan" alone and it is synchronous, I mean the command returns when
> >     the scan is over
> >   or
> >   * "scan trigger" which is asynchronous, and returns immediately after
> >     starting the operation
> > - if the scan was started asynchronously with the "trigger" keyword,
> >   the "done" command will wait until the scan is over (maybe this one
> >   needs to be renamed?)
> > - if the user made a mistake and do not want to remain blocked for
> >   several minutes (a scan can last for very long time), we need the
> >   "abort" command to tell the kernel to stop and return to a standard
> >   state. Once this has been processed and the scan effectively stopped,
> >   the kernel will send a nl command saying the scan is over (which
> >   "scan done" would capture)
> > =20
>=20
> For me, trigger and done should be for the simple cli use case in one
> command like "scan list". It will block them and trigger any scan
> event popping up. The user can send SIGINT to stop scanning?
>=20
> Although there should be still available an asynchronous way which is
> for me "scan trigger" (non-blocking) and the user can do "iwpan
> monitor" to observe upcoming events (all inclusive scan) and tell
> optionally "scan done" to stop scanning if necessary (which probably
> also produces an event to notify all listeners e.g. iwpan monitor).
>=20
> However I think most people using iwpan want to trigger and wait and
> the cli is filling up events and blocks until it's done (that would be
> a combination with trigger/monitor into one command).
>=20
> Both solutions should be possible over cli?

Yes, that's what I was saying, the two solutions are already supported.
The iwpan tool is being enhanced with the "scan" composite command,
- either "scan" is given an additional keyword and makes just that
  (trigger, abort, done) and returns as soon as this precise
  command is done (eg. it returns almost immediately on "trigger")
- or, no additional command is provided (only the parameters for the
  scan) and the command does an equivalent to "trigger + monitor +
  done" which blocks after launching the scan, shows the results when
  they arrive, and returns once the scan is finished.

Do you want something more? I just miss a "monitor" command I guess, I
may add it.

Thanks,
Miqu=C3=A8l
