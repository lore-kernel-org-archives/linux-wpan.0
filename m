Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33678C76196
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Apr 2023 22:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDKWCc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 11 Apr 2023 18:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKWCb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2023 18:02:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E010EF
        for <linux-wpan@vger.kernel.org>; Tue, 11 Apr 2023 15:02:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px0FH5XPGz4xGK;
        Wed, 12 Apr 2023 08:02:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681250548;
        bh=dwIRQRDnR+Le9CRHxfHaLm3aGA9IQnAwgr19MR565SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=skFkESWGddOSmpI6EosFG8PAspP6IBYmCG52j0vvTRpLqJ6RN6L0zvWb5dPuogecU
         2HtfPAup11PyZ2WPxN5T1Jkg8paHzHcmHx1Zn9GUyBhnYv3wSfeCHUcCBrqodBiOn4
         bt5sEp1jQPWBhnaOyTlBhAsnrqoQAcnqacOwo2waldYNOAtJtOD6MLRGn3sach0WNJ
         Mdbw08UGhM6NNttFNQ2tHZKOAeaTx/dZt/uFUaNL4WKcXxXJ3hrPt961ARpj2xg7T4
         SPRI9UJr6211dMs3ClwFvtGrb/EC5C1E7y3RVZTcak6AJfFsefiTOdoLhka75xAKbc
         KiPoxBPSADk2g==
Date:   Wed, 12 Apr 2023 08:02:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linux Wpan Mailing List <linux-wpan@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: Repository changes for linux-wpan
Message-ID: <20230412080223.6de6aa41@canb.auug.org.au>
In-Reply-To: <20230411152616.17f70d99@xps-13>
References: <20230411152616.17f70d99@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J+Y6JZaPOxWfRntImjyIwbQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--Sig_/J+Y6JZaPOxWfRntImjyIwbQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Tue, 11 Apr 2023 15:26:16 +0200 Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
>
> I don't know if you were already tracking Stefan's wpan and wpan-next
> tree but as we are starting a maintainers group to relieve Stefan and
> lighten the reviewing load on Alexander, we switched to new trees:
>=20
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.g=
it
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-n=
ext.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.=
git
>=20
> We will now maintain:
>=20
> * wpan.git master
>   This is our "to net" tree, with fixes, mainly.
> * wpan-next.git master
>   This is our "to net-next" tree, with features, mainly.
>   We plan on not rebasing this branch.
> * wpan-next.git staging
>   This is the same as the wpan-next.git master branch, but we allow
>   ourselves to force push this one in case of problem. Once our tests
>   have passed and if no warning was triggered in the linux-next tree
>   you maintain, we will merge the branch in the master branch mentioned
>   above.
>=20
> We would like to kindly ask you to update your scripts to take these
> branches into your linux-next tree.

I have added the wpan and wpan-next tress from today.  There is no
"staging" branch, so I could not add that.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/J+Y6JZaPOxWfRntImjyIwbQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ12PAACgkQAVBC80lX
0GxnrwgAi717VwIwckdnUYKilT4ATNCbQwq4bMc+I9XC6XzY5M/wjodgCbYEvU/j
rU4HHXmIeQ9KP1MPWQK7zpmU/EIjLoXXT2b4MUx2UEA+pj3Bk9Jm2YgHPIsJJuVX
5aXp0wCWJ+xAwrKSW53afEfmqBOQ8rCXlLqK8fGAQzk2W+mfkEPQQp3D19TYaMSJ
BrTaPZ2VxEF5llwe0hwokPLD+gJ2Rj4/Mi/svSou9ESDDG3KN2MvtpaVsF/ERXMb
AZFYMVvIvw9uRkE8zXLDZEGCz/xCGe3LfbHBanMuwEKjtdcbafiEy1jvnLhIBB9A
3hypPpO7C0VmxXWJSQMYEgd7ogQQ6g==
=hPFs
-----END PGP SIGNATURE-----

--Sig_/J+Y6JZaPOxWfRntImjyIwbQ--
