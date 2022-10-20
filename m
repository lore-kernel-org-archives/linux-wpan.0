Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19791C4332F
	for <linux-wpan@archiver.kernel.org>; Thu, 20 Oct 2022 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJTORY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJTORU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Oct 2022 10:17:20 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D85BC87
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 07:17:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 86DB61BF204;
        Thu, 20 Oct 2022 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666275435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9zmuvydUMq1aC1jDaVN1GNYzSP7N1okSZS/9g3EbwU=;
        b=jghxbGza/PRmTSWWr3Kv/gDzIClvW/J1sFD8jIDIDoByvX8aRZTnVZ0n0MWry/Yv8jme4J
        vvEMX021HM6Cu6SFlnerR0pCv9ClNdRLbehYKY7zzsbnjmuUrqwzAmDCAWtckNVtMulVRH
        KRsu56xJzA9RYvLmXM8TSpxBlz11n3/S2KSxp74FM8Ts2lEMJaOiu0iJY4XrbdEciwqbRh
        PCsm9oh/MkIq56VMPisf73oQdekjkSWpdHmr7jSnRVNUuwlJfKledL4qWfYwTed8JnCxHz
        5KjgbyFXQJq1yLsQfH5lrenE+o40uqXVvbxY6UAIEE/V/G9N6AkSY4Mbbi5obQ==
Date:   Thu, 20 Oct 2022 16:17:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain
 instructions
Message-ID: <20221020161713.6004b0cf@xps-13>
In-Reply-To: <20221019214625.22101769@xps-13>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
        <20220906082104.1338694-2-miquel.raynal@bootlin.com>
        <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
        <20221014081808.1b30bba7@xps-13>
        <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
        <20221019214625.22101769@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Wed, 19 Oct 2022 21:46:25 +0200:

> Hi Alexander,
>=20
> aahringo@redhat.com wrote on Sat, 15 Oct 2022 21:02:08 -0400:
>=20
> > Hi,
> >=20
> > On Sat, Oct 15, 2022 at 4:58 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote: =20
> > >
> > > Hi Stefan,
> > >
> > > stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 19:54:49 +0200:
> > >   =20
> > > > Hello Miquel.
> > > >
> > > > On 06.09.22 10:21, Miquel Raynal wrote:   =20
> > > > > Those instructions do not work anymore for several reaons:
> > > > > - Two out of the three files to download return a 404 error:
> > > > >        * The binutils version does not exist, it was 2.21.1 or 2.=
21.1a
> > > > >          instead of just 2.21.
> > > > >        * The avr-libc is no longer hosted on the pointed website,=
 I've
> > > > >          found an alternate.
> > > > > - The binutils version mentioned is not able to compile the firmw=
are on
> > > > >    a recent distribution, the Internet advised to update its vers=
ion and
> > > > >    it worked.
> > > > > - Most of these compilations will throw warnings if you use a rec=
ent
> > > > >    gcc. Sometimes -Werror is set and it fails the build. To avoid=
 that,
> > > > >    just use --disable-werror in the ./configure options.
> > > > > - I had issues building the gcc doc but those issues are trivial =
to
> > > > >    fix inline.
> > > > >
> > > > > Update the instructions for building the toolchain and while at i=
t,
> > > > > start the file by mentioning that this is maybe not useful anymor=
e, and
> > > > > provide the packets to install.   =20
> > > >
> > > > I can see that it was a frustrating process to get this working. :/
> > > > Sorry to hear. The truth is only a handful of people did ever build=
 the firmware themself, I think. Even I have not done it in a while. (ugh, =
5 years ago most likely judging from the git log).   =20
> > >
> > > Oh I'm not blaming anyone here ;)
> > >
> > > By the way I would like to make a another round of tests because duri=
ng
> > > my demos I could observe a wrong LQI, and I don't remember if the LQI
> > > was valid before my changes or not. I haven't got the time yet to get
> > > back to it. Or maybe the devices were too close to each other? I don't
> > > know, I'll need to figure it out so we don't break a useful existing
> > > feature.   =20
> >=20
> > What is a wrong LQI here? =20
>=20
> I just took the time to reproduce the demo, I get an LQI of 0xff with
> both firmware versions (before and after my changes). There are 2
> meters between the devices, isn't it enough?

I hard a hard time putting my two devices "far enough from each other"
on a radio POV, so I used a shielded bag, multiple USB cable
extensions, a microwave and my co-worker K=C3=B6ry to finally get a
reduced LQI. So nevermind, the hardware/firmware works as expected and
the firmware update we proposed recently did not break anything.

I however found a nasty bug in the way the LQI was stored in the stack
(the control buffer skb->cb was initialized/reset after the LQI got
stored there), I will soon propose a fix.

Sorry for the burden, patches are coming soon.

Thanks,
Miqu=C3=A8l
