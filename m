Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF7C77B75
	for <linux-wpan@archiver.kernel.org>; Fri, 12 May 2023 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbjELPvT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 12 May 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbjELPvR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 12 May 2023 11:51:17 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D966B7AB3
        for <linux-wpan@vger.kernel.org>; Fri, 12 May 2023 08:50:51 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E61631C0005;
        Fri, 12 May 2023 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683906650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNen+7KLpXBnc67Cl/ngYSufUkeb5SOk9UaD20Wu7Cc=;
        b=UAf13Fze7ysjVVITsrNXKWh+N7dmd7QinjZ+NPTCJGdA1JgyWmXWiiNAtOCX7HRAYev4e1
        pAm3LaUFOacqbzfY0bTBAW49zrjcRy4N1QTm8OPZoPyVld9h0dsFbnNp7rNtZ3DSle+hdt
        07CbDRI1MudPC1adjYFn0RDlRHK7R6L+n0zo5+veMGFAXd6+ve4ICs+hAMqJ8NJVnRCiN9
        ikXKNQz/2wLiyerod8LP5hLD18P7Fdz771WxARmBpZg2+ZuREbNAk22Z91cW1sQI3R3cpD
        B1kgstoVwh05PHGrJWXjayfgUMdFoczT1i2Qm+xhQuyZ82+glPB3CeBHUldJlw==
Date:   Fri, 12 May 2023 17:50:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Wpan Mailing List <linux-wpan@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: Repository changes for linux-wpan
Message-ID: <20230512175047.3e56b44d@xps-13>
In-Reply-To: <20230412080223.6de6aa41@canb.auug.org.au>
References: <20230411152616.17f70d99@xps-13>
        <20230412080223.6de6aa41@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stephen,

sfr@canb.auug.org.au wrote on Wed, 12 Apr 2023 08:02:23 +1000:

> Hi Miquel,
>=20
> On Tue, 11 Apr 2023 15:26:16 +0200 Miquel Raynal <miquel.raynal@bootlin.c=
om> wrote:
> >
> > I don't know if you were already tracking Stefan's wpan and wpan-next
> > tree but as we are starting a maintainers group to relieve Stefan and
> > lighten the reviewing load on Alexander, we switched to new trees:
> >=20
> > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan=
.git
> > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan=
-next.git
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-nex=
t.git
> >=20
> > We will now maintain:
> >=20
> > * wpan.git master
> >   This is our "to net" tree, with fixes, mainly.
> > * wpan-next.git master
> >   This is our "to net-next" tree, with features, mainly.
> >   We plan on not rebasing this branch.
> > * wpan-next.git staging
> >   This is the same as the wpan-next.git master branch, but we allow
> >   ourselves to force push this one in case of problem. Once our tests
> >   have passed and if no warning was triggered in the linux-next tree
> >   you maintain, we will merge the branch in the master branch mentioned
> >   above.
> >=20
> > We would like to kindly ask you to update your scripts to take these
> > branches into your linux-next tree. =20
>=20
> I have added the wpan and wpan-next tress from today.  There is no
> "staging" branch, so I could not add that.

I just pushed the staging branch (nothing new on it, but now it exist).

> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.=20

Indeed. Thanks for all your work by the way.

Cheers,
Miqu=C3=A8l
