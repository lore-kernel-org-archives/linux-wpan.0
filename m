Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E9ECAAD1
	for <linux-wpan@archiver.kernel.org>; Wed, 31 Aug 2022 15:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHaPRc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiHaPRb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Aug 2022 11:17:31 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F3D741D
        for <linux-wpan@vger.kernel.org>; Wed, 31 Aug 2022 08:17:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5DBE210000C;
        Wed, 31 Aug 2022 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661959047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFClo7PE4tk4mmPKy6Sz9IE9EcIn8XrLmEwZWmykRtE=;
        b=h6qnRbWM3ZQg78xh30AVmq9lBTSX1RzaSMaM4PUVGapdWj9XmY94RgNasZ0sYR0QIWOXY3
        3NYCJ9tK8Y0AX0xLWDZRcaBOGdJe8LPBmlPiU4/LzS3vz3QynMeMMHdb5nirdOPjO0XQVf
        OKXTjeCexU/mVqpQCKs5R7YDTfwnE3j6XXIbbEiyK6NKAnJD+wqrszJC32QeMXo6NMHswQ
        OOcKK3AEYTnYTlWITXMJDMIcKZVk2iJHPzISdgII+24k1QohitgCppXyfISgA78dTerzQh
        wq5FEttnEuPCOY/1SktRT0HKq19/0UvKMKXQd9iSjIhhzrl3PsAEhdjemVoJ8g==
Date:   Wed, 31 Aug 2022 17:17:23 +0200
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
Message-ID: <20220831171723.3ed4a8c8@xps-13>
In-Reply-To: <CAK-6q+jxtxvkcmmfRnQad7NhsWJ1OSAsdhw1PsfgT2SDhwGNrw@mail.gmail.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
        <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
        <20220819190654.6af62bca@xps-13>
        <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
        <20220825145516.14bd5b45@xps-13>
        <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
        <20220826125020.414964fd@xps-13>
        <CAK-6q+jjainnsMDm9tXjr7rD7--XjBFU8gg_FA65BrXYNkLNHw@mail.gmail.com>
        <20220829103702.4cce4670@xps-13>
        <CAK-6q+j3mak0exMnQT9kw3pu6zNkXwY6Fxbjz8akap3N04AEeQ@mail.gmail.com>
        <CAK-6q+jxtxvkcmmfRnQad7NhsWJ1OSAsdhw1PsfgT2SDhwGNrw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Tue, 30 Aug 2022 23:17:35 -0400:

> Hi,
>=20
> On Mon, Aug 29, 2022 at 8:57 AM Alexander Aring <aahringo@redhat.com> wro=
te:
> >
> > Hi,
> >
> > On Mon, Aug 29, 2022 at 4:37 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote: =20
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Sun, 28 Aug 2022 09:55:24 -0400:
> > > =20
> > > > Hi,
> > > >
> > > > On Fri, Aug 26, 2022 at 6:50 AM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > > ... =20
> > > > >
> > > > > I've updated the tools so that we have:
> > > > >
> > > > > * "scan trigger" which does not block
> > > > > * "scan monitor" which displays with a pretty output the new
> > > > >   coordinators and stops blocking when the scan is over (either b=
ecause
> > > > >   it reached the last channel to scan, or it got aborted)
> > > > > * "scan abort" which stops an ongoing scan
> > > > > * "scan" which is the same as "scan trigger; scan monitor", and w=
ill =20
> > > >
> > > > no, there is a race in the design of "scan trigger; scan monitor". =
=20
> > >
> > > Right, I've used pthread to first start the monitoring, before actual=
ly
> > > triggering the scan. That should be enough.
> > > =20
> >
> > I think we should look at this, because it requires that all
> > applications link to pthreads if we offer such an API. Any thoughts
> > about alternative ways, can it not be done over libnl, that libnl
> > internally used e.g. select()? The above example is only regarding the
> > process context.
> > =20
>=20
> I think pthreads are not necessary here. If we don't close and open
> the nl socket everything should be queued.
> Forget that with select(), just send() and recv() (whatever that is
> underneath of libnl) should be enough.

That's way more clever. I've changed that, no more pthread and no more
race, thanks!

Thanks,
Miqu=C3=A8l
