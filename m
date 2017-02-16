Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:40397 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbdBPTo3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Feb 2017 14:44:29 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
In-Reply-To: <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com> <28517.1487255767@obiwan.sandelman.ca> <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 16 Feb 2017 14:44:26 -0500
Message-ID: <32430.1487274266@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Alexander Aring <aar@pengutronix.de> wrote:
    > I think the important thing is here (I suppose) the device can somehow
    > handle TWO address filters. Meaning you can operate on TWO source
    > pan-ids and having address filtering on.

I imagine that yes, this is what the device is offering.

    > PAN is not just software if you have address filtering. Sure you can
    > turn off the address filter, but for some transceivers this is only
    > possible to go into promiscuous mode and then you disable all filters.

I think that this is exactly the point: you can (have to) do address
filtering in software if you have turned on promiscuous mode.  If you have
hardware that does this, then you can take the PANID from the hardware.
We could literally overload the entire VLAN process for this as for the
moment, 802.15.4 does not have 802.1Q, but I understand 802.15.10 will
change that.

    > Setting Destination PAN for a 6LoWPAN 802.15.4 interface -> we can talk
    > about that, this is software only. But listen source PAN -> problematic
    > because you change address filter parameter while receiving is on. :-/
    > If you do so, you also could miss some frames from other PANs...

Yes, a good point.
I'm not trying to be dynamic here, but rather to leverage the capabilities of
devices...

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAlimARMACgkQgItw+93Q
3WXueQf/QVilDmWpHVuKXDBPqHkE1aiZQdnbUCqC3fEH/ePfpnWYFtKyUlxCvgAR
CKLMKtz1j9F/gyE9JI+pmaPYKyNwKLhzW+iL7Qrdds36/SJk0u+0AZEPr9oqQOFI
jTl3/O+HOOR0bNQA2gjhxnVF69OML99lR/4musOsWic89CUm8aJ3Yel1zgdlsqVI
tNErHC86oMwCHVRm9sHP1ITorKN8sBlzqVuvuGxFzi1f4uXfKOaMJdaMb3xPRJqC
a4TUxvBNZZiDspGcmYjqktaAa0tso1FrtcVAzGHabbgxzWjn2mTVC0JJKS2Gyfow
qNryCapefMRJux/jgALGMmLlpRW9zA==
=NwrJ
-----END PGP SIGNATURE-----
--=-=-=--
