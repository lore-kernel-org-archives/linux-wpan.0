Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E4C38145
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiIFH5O (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiIFH5L (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 03:57:11 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5246674B94
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 00:57:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 261B724000D;
        Tue,  6 Sep 2022 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662451024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJXK5AGCQbvy66/rbOnbvZblOOC3W5LttrCOlcxIClg=;
        b=YJkkYkbdMYncRZvBPKPeYcZsTH6WUYXyA+SOfv0QFpwjZ9V2g+hCd3U0dkDaWbeuSFTcvg
        1KDoHRfbAV6IciEZtLc5n8+jx8RMBFaDg42mD9+HTvtd1lbO9FflKyvqirzJUa/RU1rv5J
        81NBn4LYEfWy/p4nEmboxwQLf5Q1utebn7OirLjBmCB16L8M3r9UHzrm3srw3ZiUxlnCLW
        bF7RIq0V5Vf7//D9POeO4N2uVxDlNY+Losv4nFs7WHOOrv8sjIpBgoAjc59Zf69FQQUq12
        eZNoQoaCiYoipJ7X/f0zzj+/YMTypoFaxtUyl8BD8vpNiVV/0GOnNkI/wLUK/w==
Date:   Tue, 6 Sep 2022 09:56:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH atusb/fw 1/2] atusb: fw: Update toolchain instructions
Message-ID: <20220906095658.492ff6cd@xps-13>
In-Reply-To: <CAK-6q+hM5_uVurQL3ctrWcpF6EozcNSkC0uZF3n5AxispSM8uQ@mail.gmail.com>
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
        <CAK-6q+hM5_uVurQL3ctrWcpF6EozcNSkC0uZF3n5AxispSM8uQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Mon, 5 Sep 2022 19:33:47 -0400:

> Hi,
>=20
> On Mon, Sep 5, 2022 at 4:43 PM Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> >
> > Those instructions do not work anymore for several reaons:
> > - Two out of the three files to download return a 404 error:
> >       * The binutils version does not exist, it was 2.21.1 or 2.21.1a
> >         instead of just 2.21.
> >       * The avr-libc is no longer hosted on the pointed website, I've
> >         found an alternate.
> > - The binutils version mentioned is not able to compile the firmware on
> >   a recent distribution, the Internet advised to update its version and
> >   it worked.
> > - Most of these compilations will throw warnings if you use a recent
> >   gcc. Sometimes -Werror is set and it fails the build. To avoid that,
> >   just use --disable-werror in the ./configure options.
> > - I had issues building the gcc doc but those issues are trivial to
> >   fix inline.
> >
> > Update the instructions for building the toolchain and while at it,
> > start the file by mentioning that this is maybe not useful anymore, and
> > provide the packets to install.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  atusb/fw/README | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/atusb/fw/README b/atusb/fw/README
> > index 99ceb22..44f65f5 100644
> > --- a/atusb/fw/README
> > +++ b/atusb/fw/README
> > @@ -1,4 +1,6 @@
> > -Requires a very recent toolchain, because ATmega32U2 is relatively new.
> > +- Toolchain:
> > +
> > +  apt install avr-gcc libc-avr
> > =20
>=20
> grml, it's just the other name around... but I think an important
> notice is here "use the debian packages".
>=20
> gcc-avr avr-libc
>=20
> I know it was swapped and was not checking it... it was a 50/50 chance.

Haha I blindly trusted you, I should have double checked.

Thanks,
Miqu=C3=A8l
