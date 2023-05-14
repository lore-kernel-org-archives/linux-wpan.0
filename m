Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F4C77B7F
	for <linux-wpan@archiver.kernel.org>; Sun, 14 May 2023 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjENXYc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 14 May 2023 19:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjENXYc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 14 May 2023 19:24:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496510DF
        for <linux-wpan@vger.kernel.org>; Sun, 14 May 2023 16:24:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKJVZ1r3hz4x3s;
        Mon, 15 May 2023 09:24:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684106662;
        bh=3jAaEXVzikKewSDF7l1X2uMg9OKorqDRwD5TeUJqCxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ttt6OUyvzJoAqSxWU+wywPP3/EVrh9g7eIjqQP/QsHU2oUWgZ0I7SjAJnPE5hPJ+l
         HTCemiUKXrohnbjCMkpWb3MMlz7mk135AodKLP9TL9gdYYdnyUq3SfgSX08nLZWPR6
         /WPiDrPtPV3PyfRfCPN2ylYvfWr5K2BBg//qquvDXgyFrnVbTh3TEDCcRTEaTtSQYn
         u9RJCwLuQkYox3NlR5lmhDq4N5iR560O5IgBm8vkFEyf87R5IdfYoxF9KsKrQJUp8S
         IcFO2UknrTfR3ug+0ScpCqRMBWk8i0BSbUqIG8by1d3hiNu9PCwbYaqGLnZC1Urvv7
         DRqk9d6tq8Uww==
Date:   Mon, 15 May 2023 09:24:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linux Wpan Mailing List <linux-wpan@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: Repository changes for linux-wpan
Message-ID: <20230515092421.07c08823@canb.auug.org.au>
In-Reply-To: <20230512175047.3e56b44d@xps-13>
References: <20230411152616.17f70d99@xps-13>
        <20230412080223.6de6aa41@canb.auug.org.au>
        <20230512175047.3e56b44d@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x_S5fXVHibw8BbP8ikErlDJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

--Sig_/x_S5fXVHibw8BbP8ikErlDJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Fri, 12 May 2023 17:50:47 +0200 Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
>
> sfr@canb.auug.org.au wrote on Wed, 12 Apr 2023 08:02:23 +1000:
> >=20
> > On Tue, 11 Apr 2023 15:26:16 +0200 Miquel Raynal <miquel.raynal@bootlin=
.com> wrote: =20
> > >
> > > I don't know if you were already tracking Stefan's wpan and wpan-next
> > > tree but as we are starting a maintainers group to relieve Stefan and
> > > lighten the reviewing load on Alexander, we switched to new trees:
> > >=20
> > > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wp=
an.git
> > > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wp=
an-next.git
> > > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.g=
it
> > > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-n=
ext.git
> > >=20
> > > We will now maintain:
> > >=20
> > > * wpan.git master
> > >   This is our "to net" tree, with fixes, mainly.
> > > * wpan-next.git master
> > >   This is our "to net-next" tree, with features, mainly.
> > >   We plan on not rebasing this branch.
> > > * wpan-next.git staging
> > >   This is the same as the wpan-next.git master branch, but we allow
> > >   ourselves to force push this one in case of problem. Once our tests
> > >   have passed and if no warning was triggered in the linux-next tree
> > >   you maintain, we will merge the branch in the master branch mention=
ed
> > >   above.
> > >=20
> > > We would like to kindly ask you to update your scripts to take these
> > > branches into your linux-next tree.   =20
> >=20
> > I have added the wpan and wpan-next tress from today.  There is no
> > "staging" branch, so I could not add that. =20
>=20
> I just pushed the staging branch (nothing new on it, but now it exist).

I have added it from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/x_S5fXVHibw8BbP8ikErlDJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhbaUACgkQAVBC80lX
0Gy3+gf/RrKldNq+8a4ynyw4Ik6d2bvPcgN53j1cnHVigoi5jTyvXVJr+2NsqcbO
Ip4TFglJOlyNNfo2MVr99AzjamesncnRXNjF8P730J1oTyubnM1U9QcSJNZCslt6
fwtE7fLMj+c9EVfOo5mKkf4HqDxbxXqusPhXZPhyV5Vt5zux79hw6NO+ZsbpT2qn
atxAaCg8jZrU3qpMLgShul+jRnB2jjIw34uEBXhYJnLDybnJQ48IcgNGUqUQjf5b
crbwLdHAG/2GDXivFZh+agvivIclrcYgGG1jQMhfsy82Gko7hTf99nRS9mNMCTdT
KBqO8I14dWan3xr8bBS6KhtB8e5Mkw==
=VCkO
-----END PGP SIGNATURE-----

--Sig_/x_S5fXVHibw8BbP8ikErlDJ--
