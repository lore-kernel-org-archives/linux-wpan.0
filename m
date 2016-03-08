Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:49841 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcCHORp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Mar 2016 09:17:45 -0500
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: [6lo] big frame support in 802.15.4G
In-Reply-To: <CADrU+dKHiNd2xW0Nd=ZWJCAZQ_PbWXwNFo_V2u4nd7A_ccfwCw@mail.gmail.com>
References: <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega> <18168.1457123400@obiwan.sandelman.ca> <56DC2A0A.6070906@htt-consult.com> <4538.1457367913@obiwan.sandelman.ca> <D302EF45.3625F%d.sturek@att.net> <56DDED58.5060500@htt-consult.com> <20160308082207.GA790@omega> <CADrU+dKHiNd2xW0Nd=ZWJCAZQ_PbWXwNFo_V2u4nd7A_ccfwCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 08 Mar 2016 09:17:44 -0500
Message-ID: <25003.1457446664@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "6lo@ietf.org" <6lo@ietf.org>, robert.cragie@gridmerge.com
Cc: Alexander Aring <alex.aring@gmail.com>, Robert Moskowitz <rgm-ietf@htt-consult.com>, linux-wpan@vger.kernel.org, Don Sturek <d.sturek@att.net>

--=-=-=
Content-Type: text/plain


Robert Cragie <robert.cragie@gridmerge.com> wrote:
    > 1) is it physically possible for a 15.4g device to send both 15.4g
    > frames and 15.4-2011 frames?

    > Yes, in theory. The PHY would have to support both the SUN-O-QPSK and
    > the O-QPSK PHYs, the intersecting frequencies, rates and spreading mode
    > and somehow be selectable on Tx and discriminate on Rx (accept both
    > PPDU formats)

Thank you for this answer.

Alex is trying to make the lowpan code for the Linux kernel more flexible,
and the question of whether we need to include a way to use different MTUs on
a per-destination basis has come up, and we had no clear answer.

We now know that this is physically possible; we don't know if chipsets will
implement this, or whether it SHOULD be possible.

This is now a technical policy question for 6lo, in my opinion.

--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVt7fBYCLcPvd0N1lAQL31gf/XKbV7jzXY/qQaK8wu88X2k59UXhkh0hP
8RiM+1eJ6YaImOAiR3C1Fn+5/QJzWWWcJwYsYS4PXtTRjQcZyzhRWCxswmpbBO8t
lGSbuAcGiu+FcMV3hLQZn9cION/6gVKf8VQ8Ckc1+MjuyJ+YRE0fO95FQ9Eo3DBv
0mZDUamj77dvJTdDUyrXsO29EuljfLdb0lanOPxAk3txrKMaj6XAkEY8foOWUQlC
OelILL8wqjgUj5knwFObaY3cxe8or1fTzlsvGUojmGrnY280TDrlyqmwpB9VWYUq
qnrNRz5aCdZ3J31McBdbNpN5bn0af/C1LFdNLJtZjUJnILJDzBpRYw==
=LTSF
-----END PGP SIGNATURE-----
--=-=-=--
