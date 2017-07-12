Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:35194 "EHLO
        relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdGMFaO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Jul 2017 01:30:14 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: handling multiple MAC instances (multiple address filters)
In-reply-to: <20170712171051.z35bk6piiqtqypwm@omega>
References: <20170712171051.z35bk6piiqtqypwm@omega>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 12 Jul 2017 16:00:01 -0400
Message-ID: <8887.1499889601@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <alex.aring@gmail.com> wrote:
    > Then the discussed stopped after I took a shower and realized we lost
    > ack handling when going into promiscuous mode... The transceiver will
    > simple ack every frame which it's received then if we don't stop ack
    > handling.

The issue is that with the filters off, we will ack packets aimed at other
nodes.

    > Now, after I looked because RX_SAFE_MODE into af86rf2xx datasheets
    > again. I think we could try to do the following:

So don't get too hung up on the limitations of the af86.  It could be that
it is impossible with that device, but that another device will make it
possible.

    >  - RX done irq comes - Grab buffer information - Doing fast a source
    > address lookup and check if we have a mac interface currently running
    > which has the address and ack is requested.  - If so trigger pin to
    > send ack.  - If not do nothing and drop (because we are not meant)

This sounds very cool.

    > Another question is: Is running multiple interfaces on one PHY the
    > thing what we "need". I think yes, because the 802.15.4 spec describe
    > only one source PAN to operate on. Another idea would be to override

I'd really like to be able to operate on multiple PANs at the same time.
I think that 6LBRs will need this.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZZn/BAAoJEJVM4Vb9/EKQkQQH/A9e92S+SAr7mXqpnHj1T/pL
KIhgWrYxWuD+0IABecX/ml7VsZ5SSXZ2nfJE+gU6WQVSCG/8izA82cbSeLSLr+lK
67JDAttxrgJ1mQgpaDltNVqNKDKziuowtAk6RMIEZcsdcqAcSBnkbMkzdCtdg4v7
ImJ6tnQVo/qtwlpNb1RLd7zS5wJSPd0GgGq8YewcVbu8tvNiAH6zLX54jHaeA4vw
Y+uGDfK0672RIk4IKdsaGXvjT2nGSQj1E5WKS3n9tgTLE+RUqwQlbV3OvKrbA/lj
7f9KDF45xjXZFSHlVKKbb3IFUpBRrLqZzLtRyvqZXFoNiWclRTrTI7RtfZ1CrhY=
=HFo5
-----END PGP SIGNATURE-----
--=-=-=--
