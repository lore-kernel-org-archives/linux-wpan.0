Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D6C4332F
	for <linux-wpan@archiver.kernel.org>; Sat, 15 Oct 2022 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOI6U (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 15 Oct 2022 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJOI6T (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Oct 2022 04:58:19 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5E55094
        for <linux-wpan@vger.kernel.org>; Sat, 15 Oct 2022 01:58:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A7B7840004;
        Sat, 15 Oct 2022 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665824296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHhxZFk2BW91kohsTpslpABFXq/4Mb/vKzl4B7bZP5Q=;
        b=W1/TVXCjtySkpfv3lF0LYH6vfpF5PpvSDIoK6DjnZgfGYXD9DTJscDHv6Tg6nXI2mJoc6s
        2sfadkCZiNkKE23edJTXv8CyIgZTfOuIVTzO8WGJSV0G7VaD80GW2gnQfAw/fY4vVNC1nq
        hkc1TN8aAIn/+0I0VFUN+7Nv7NXfsl0pYgXDmr7LnkfFaAzUEo3Dtlb1QU8eLXJ4QC4m7/
        CebygzSahDyB0FioUdbpEnGPiLPUUb9h0jtvhkEzED4SKPKeq8dJD+C8s8pS+d/O3n7yDa
        FANSaANCv98v2fd3y2PFEfPNUqxEjFeUXvwbq3sh1gnK8IwglPnqNv8l+Rj27A==
Date:   Sat, 15 Oct 2022 10:58:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     werner@almesberger.net, Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain
 instructions
Message-ID: <20221014081808.1b30bba7@xps-13>
In-Reply-To: <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-2-miquel.raynal@bootlin.com>
 <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 19:54:49 +0200:

> Hello Miquel.
>=20
> On 06.09.22 10:21, Miquel Raynal wrote:
> > Those instructions do not work anymore for several reaons:
> > - Two out of the three files to download return a 404 error:
> >        * The binutils version does not exist, it was 2.21.1 or 2.21.1a
> >          instead of just 2.21.
> >        * The avr-libc is no longer hosted on the pointed website, I've
> >          found an alternate.
> > - The binutils version mentioned is not able to compile the firmware on
> >    a recent distribution, the Internet advised to update its version and
> >    it worked.
> > - Most of these compilations will throw warnings if you use a recent
> >    gcc. Sometimes -Werror is set and it fails the build. To avoid that,
> >    just use --disable-werror in the ./configure options.
> > - I had issues building the gcc doc but those issues are trivial to
> >    fix inline.
> >=20
> > Update the instructions for building the toolchain and while at it,
> > start the file by mentioning that this is maybe not useful anymore, and
> > provide the packets to install. =20
>=20
> I can see that it was a frustrating process to get this working. :/
> Sorry to hear. The truth is only a handful of people did ever build the f=
irmware themself, I think. Even I have not done it in a while. (ugh, 5 year=
s ago most likely judging from the git log).

Oh I'm not blaming anyone here ;)

By the way I would like to make a another round of tests because during
my demos I could observe a wrong LQI, and I don't remember if the LQI
was valid before my changes or not. I haven't got the time yet to get
back to it. Or maybe the devices were too close to each other? I don't
know, I'll need to figure it out so we don't break a useful existing
feature.

Thanks,
Miqu=C3=A8l
