Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38248C433FE
	for <linux-wpan@archiver.kernel.org>; Fri, 21 Oct 2022 06:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJUGyG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJUGx5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Oct 2022 02:53:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4522E8F8
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 23:53:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C205D1BF207;
        Fri, 21 Oct 2022 06:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666335234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmBNv8XZi2VfEHcKakHFw3GLaffJaMLAmhioZB6cYGs=;
        b=V0Txuoqk/DMlktpBRGCRreK6yMb52mvszR4iS7+FZo9IpeoxTs1E1rwUY+prWiqKS7uv/w
        0SMVLHjWlgmIhq5DqgmNr12Z/ulHwDtdM4zYfWmNMXH1cgd1ZhGCBRS71/ofebcQWQVBSe
        1CUnANTANXa6GE4AB9aPykT5Epbg6SJP7Te5Igpbu1daiHFv78E+K5PnopmFhlXhcL6ONl
        6TmpZSyU6wfh0dznXVnHHZ08k04v1fGpWRqpZPYnznl4inHWfXthaJ7B9uvOFJgR5pqYZn
        gSBcFBMsIt1pChOoA5kGIeco45ZGD/wxNuTdWoKYZtQCJa4dR/YY9cqPESaWMA==
Date:   Fri, 21 Oct 2022 08:53:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain
 instructions
Message-ID: <20221021085353.2ad567d4@xps-13>
In-Reply-To: <CAK-6q+iffiLx0U3W0Gaw=xtDn3ipRb5v5BPKEazxfpe343h5iA@mail.gmail.com>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
        <20220906082104.1338694-2-miquel.raynal@bootlin.com>
        <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
        <20221014081808.1b30bba7@xps-13>
        <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
        <20221019214625.22101769@xps-13>
        <20221020161713.6004b0cf@xps-13>
        <CAK-6q+iffiLx0U3W0Gaw=xtDn3ipRb5v5BPKEazxfpe343h5iA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Thu, 20 Oct 2022 19:32:52 -0400:

> Hi,
>=20
> On Thu, Oct 20, 2022 at 10:17 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hello,
> >
> > miquel.raynal@bootlin.com wrote on Wed, 19 Oct 2022 21:46:25 +0200:
> > =20
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Sat, 15 Oct 2022 21:02:08 -0400:
> > > =20
> > > > Hi,
> > > >
> > > > On Sat, Oct 15, 2022 at 4:58 AM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote: =20
> > > > >
> > > > > Hi Stefan,
> > > > >
> > > > > stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 19:54:49 +020=
0:
> > > > > =20
> > > > > > Hello Miquel.
> > > > > >
> > > > > > On 06.09.22 10:21, Miquel Raynal wrote: =20
> > > > > > > Those instructions do not work anymore for several reaons:
> > > > > > > - Two out of the three files to download return a 404 error:
> > > > > > >        * The binutils version does not exist, it was 2.21.1 o=
r 2.21.1a
> > > > > > >          instead of just 2.21.
> > > > > > >        * The avr-libc is no longer hosted on the pointed webs=
ite, I've
> > > > > > >          found an alternate.
> > > > > > > - The binutils version mentioned is not able to compile the f=
irmware on
> > > > > > >    a recent distribution, the Internet advised to update its =
version and
> > > > > > >    it worked.
> > > > > > > - Most of these compilations will throw warnings if you use a=
 recent
> > > > > > >    gcc. Sometimes -Werror is set and it fails the build. To a=
void that,
> > > > > > >    just use --disable-werror in the ./configure options.
> > > > > > > - I had issues building the gcc doc but those issues are triv=
ial to
> > > > > > >    fix inline.
> > > > > > >
> > > > > > > Update the instructions for building the toolchain and while =
at it,
> > > > > > > start the file by mentioning that this is maybe not useful an=
ymore, and
> > > > > > > provide the packets to install. =20
> > > > > >
> > > > > > I can see that it was a frustrating process to get this working=
. :/
> > > > > > Sorry to hear. The truth is only a handful of people did ever b=
uild the firmware themself, I think. Even I have not done it in a while. (u=
gh, 5 years ago most likely judging from the git log). =20
> > > > >
> > > > > Oh I'm not blaming anyone here ;)
> > > > >
> > > > > By the way I would like to make a another round of tests because =
during
> > > > > my demos I could observe a wrong LQI, and I don't remember if the=
 LQI
> > > > > was valid before my changes or not. I haven't got the time yet to=
 get
> > > > > back to it. Or maybe the devices were too close to each other? I =
don't
> > > > > know, I'll need to figure it out so we don't break a useful exist=
ing
> > > > > feature. =20
> > > >
> > > > What is a wrong LQI here? =20
> > >
> > > I just took the time to reproduce the demo, I get an LQI of 0xff with
> > > both firmware versions (before and after my changes). There are 2
> > > meters between the devices, isn't it enough? =20
> >
> > I hard a hard time putting my two devices "far enough from each other"
> > on a radio POV, so I used a shielded bag, multiple USB cable
> > extensions, a microwave and my co-worker K=C3=B6ry to finally get a
> > reduced LQI. So nevermind, the hardware/firmware works as expected and
> > the firmware update we proposed recently did not break anything. =20
>=20
> note that one LQI value alone doesn't say anything about the link
> quality, also LQI value is a _very_ weak vendor specific thing how
> it's calculated.

I read a little bit more about LQI during this test phase and indeed,
"weak" seems appropriate :-)

> I heard successful reports also using aluminium foil around transceivers.=
..

Indeed I've heard it could work, I'll keep it in mind!

Thanks,
Miqu=C3=A8l
