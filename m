Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:41770 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbdBPOgM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Feb 2017 09:36:12 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
In-Reply-To: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 16 Feb 2017 09:36:07 -0500
Message-ID: <28517.1487255767@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Xue Liu <liuxuenetmail@gmail.com> wrote:
    > Now I am working on a driver for MCR20A radio chip from NXP. This chip
    > has a special feature: support two PAN networks. It means it can
    > operate on two different or the same channels with different PAN IDs,
    > short addresses and extended addresses. I suppose to add two 802.15.4
    > interfaces for this feature. And I have two questions:

Neat. Too bad it can't operate on two channels at the same time...
BTW: can it do 802.15.4 TSCH mode?

    > 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
    > with different struct ieee802154_hw ?

    > 2. how to deal with tx and rx regarding two interfaces.

I think that at you will need to call register_hw() twice and manage two
virtual queues, and then service them in your real driver.  Perhaps the
fakewpan device structure will help you here.

My take, however, is that the PANID processing on some devices is really just
software, and perhaps we should be treating PANID the same way we treat
VLANs: as something often sorted out in the stack, but sometimes coming with
hardware acceleration.  We also have support for multiple Tx and Rx queues
now, so this should also help.

That's how I would think of this in the long term.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAliluNcACgkQgItw+93Q
3WXljwf/bDnvbIVNweC1M0gOIlx9kB+D5PS32mpa3o8xi4L8ebVvHH/9fPdShCi1
QwzHCwYcCyrgexBSDLfaWzeYcCWk7VmW5o8SrqqrhcZavMnx1K/R61DwDSScZEBh
BVzqVpX7oTgiE+HAXJ8kHzrYlweo+UytwSqLKvAIxH18IODBhW4e76j2IppVx2in
eG/QZWUBwEHCTaip/V1N4qoZQe+F/VD4BxABUDNx1JX3ys2o4vFqZl2VakA44S1z
Gk9Bo77XpOIgXJSc4tR5c2XOWJZPbO15jLMqK8iF7irzljG0o0IjdZrH6b+GZCqB
GyjAtUGpjQQvP2jDQ6EpP3Mnb8sJ3g==
=FSB5
-----END PGP SIGNATURE-----
--=-=-=--
