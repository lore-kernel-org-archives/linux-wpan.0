Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:48617 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeIJBuE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Sep 2018 21:50:04 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: about openthread and 6lowpan
In-Reply-To: <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>,<SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com> <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 09 Sep 2018 16:49:49 -0400
Message-ID: <3503.1536526189@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujay G <sujay.g@hcl.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

--=-=-=
Content-Type: text/plain


Sujay G <sujay.g@hcl.com> wrote:
    > I have been testing openThread on Docker. I wanted to use 6Lowpan with
    > openthread.  I assumed openThread would interact with wpan interfaces
    > and added wpan interfaces in container namespace but it did not work.

    > Then I came across change for 6Lowpan.  Comparison yielded changes in 7
    > files vs the latest openThread repositiry
    > github.com/openthread/openthread/compare/master...linux-wpan:af802154

Why are you asking the linux-wpan ML about openthread patches? :-)

Alex did some patches to make openthread work better with the virtual
interfaces... it's up to the openthread people to adopt them or not.

    > I manually merged the files and am trying to resolve the errors.

    > Had few queries regarding the openThread and 6Lowpan

    > Why was the project (af802154) abandoned ?  Was openThread working with
    > the above 6Lowpan changes ?  Does the current openThread stack support
    > 6Lowpan ? any configuration needs to be enabled ?  or is it the right
    > way to port the af802154 to current implementation of openthread ?

You could rebase it, and maybe you have more influence with the
openthread people than we do.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAluVh20ACgkQgItw+93Q
3WU+PQf/auDa9c7PyXllGvEOe+YP1UIcsQhUKZMGnhhpv1StfQrojZK1igGW/k24
qiMZTj5lsnoZOEAIoyiLUSud9t4ZqIxNztYQOWJIdoHGPtyig/foGa0UTfZ0Q7Vh
hKx1yXZu1DgkEvUunJiYpJq3aFMI6vpXOPjsaFbHIrdypZ40BukFwHT+rP5hQjSz
GDYC/15wHouZsDVimvappv1/KO++B0qCZzJeLe9kPKtRT890jHfslx7VRPYhsYQf
91QgioDj71nzN9bMhS34FX6OqUOv/hf5DtJpoBlPBIGi6a84IwPFDjJfZzsTb37V
0VHc9JxrbRePb4IMcXfIsLwx1prrWA==
=cCe0
-----END PGP SIGNATURE-----
--=-=-=--
