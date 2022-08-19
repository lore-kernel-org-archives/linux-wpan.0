Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3257C32771
	for <linux-wpan@archiver.kernel.org>; Fri, 19 Aug 2022 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiHSRpG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbiHSRoj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Aug 2022 13:44:39 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E531E
        for <linux-wpan@vger.kernel.org>; Fri, 19 Aug 2022 10:07:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D48520007;
        Fri, 19 Aug 2022 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660928819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENlsQEjRW3FZF5ZsM/YvjpmeB1jbO6xwpGO9SXzpaYM=;
        b=AotXyoehbWb3uP6Z+TSBl3u/dkpZ48EMF04yrlSzgZ43GKRzuNue00DWCkpFaslhQkOixZ
        +zeCiRskAGqPjYsEFR8QrMom4GTIuuJ8FHtFOKRdP4BEj+Y+nH5PrNJMhQNV8rh1RqfrDU
        bqB+MZDxq39Py4hH11eec4+9PXDwu4RkPBIurbVQXqbvFV5qcEl5crhy6BMWo0ILq6qm12
        /cGqpVEan7m33TwlQaEEAEjP2p9X4yc1DS4vIiaVqIxQu2hCg51itqS2JO/K7OvekXsLr9
        MVzv1LMeS64mJJehdsptkJBcROr9k9JYLEzDw18qwOF4ZAijoVd56ggxgsWrGg==
Date:   Fri, 19 Aug 2022 19:06:54 +0200
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
Message-ID: <20220819190654.6af62bca@xps-13>
In-Reply-To: <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
        <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Sun, 3 Jul 2022 21:18:40 -0400:

> Hi,
>=20
> On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hello,
> >
> > This series follows the work done in the Linux kernel stack: now that
> > the core knows about the different netlink commands and attributes in
> > order to support scanning and beaconing requests from end-to-end, here
> > are the userspace changes to be able to use it.
> >
> > Here is a list of the new available features.
> >
> > * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
> >   valid for passively sending beacons at regular intervals. An interval
> >   of 15 would request the core to answer BEACON_REQ.
> >   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed r=
ate
> >   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
> >   # iwpan dev coord0 beacons stop # apply to both cases
> >
> > * Scanning all the channels or only a subset:
> >   # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEA=
CON_REQ
> >   # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_R=
EQ
> >
> > * During scans, there is a dedicated netlink channel event to listen to
> >   in order to get events like "a new coordinator was discovered" or "the
> >   scan is over". When beacons from new devices are received, the tool
> >   would print something like:
> >   PAN 0xabcd (on coord1)
> >         coordinator 0xe673d7a3f3a87ccc
> >         page 0
> >         channel 13
> >         preamble code 0
> >         mean prf 0
> >         superframe spec. 0x4f11
> >         LQI 0
> >
> > * It is also possible to monitor the events with:
> >   # iwpan event
> >
> > * As well as triggering a non blocking scan:
> >   # iwpan dev wpan1 scan trigger type passive duration 3
> >   # iwpan dev wpan1 scan done
> >   # iwpan dev wpan1 scan abort =20
>=20
> why do we need an abort?

Perhaps the tool --help would have helped to get the naming, but we
need:
- a command to start a scan, either use:
  * "scan" alone and it is synchronous, I mean the command returns when
    the scan is over
  or
  * "scan trigger" which is asynchronous, and returns immediately after
    starting the operation
- if the scan was started asynchronously with the "trigger" keyword,
  the "done" command will wait until the scan is over (maybe this one
  needs to be renamed?)
- if the user made a mistake and do not want to remain blocked for
  several minutes (a scan can last for very long time), we need the
  "abort" command to tell the kernel to stop and return to a standard
  state. Once this has been processed and the scan effectively stopped,
  the kernel will send a nl command saying the scan is over (which
  "scan done" would capture)

Thanks,
Miqu=C3=A8l
