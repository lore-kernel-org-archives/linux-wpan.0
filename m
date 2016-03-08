Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:42197 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcCHOJT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Mar 2016 09:09:19 -0500
From: Michael Richardson <mcr+ietf@sandelman.ca>
Subject: Re: [6lo] big frame support in 802.15.4G
In-Reply-To: <56DDED58.5060500@htt-consult.com>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega> <18168.1457123400@obiwan.sandelman.ca> <56DC2A0A.6070906@htt-consult.com> <4538.1457367913@obiwan.sandelman.ca> <D302EF45.3625F%d.sturek@att.net> <56DDED58.5060500@htt-consult.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 08 Mar 2016 09:09:16 -0500
Message-ID: <23240.1457446156@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Robert Moskowitz <rgm-ietf@htt-consult.com>, Don Sturek <d.sturek@att.net>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, 6lo@ietf.org

--=-=-=
Content-Type: text/plain


Robert Moskowitz <rgm-ietf@htt-consult.com> wrote:
    > I was thinking that there is also some difference in the physical
    > header to support the larger PPU?

Yeah, but you guys seem to be stuck thinking about whether 802.15.4-2011
PHYs/MACs would be able to receive 15.4g packets.

That's not the question.

The question is again:

    > 1) is it physically possible for a 15.4g device to send both 15.4g
    > frames and 15.4-2011 frames?  Another email suggests that this can
    > never happen because frequencies are never the same.  If so, end of
    > problem.

    > 2) if the answer to question 1 is yes, then 15.4g devices need to
    > know if they are speaking to 15.4-2011 devices, and a) adjust their
    > frame header bits appropriately.  b) to 6lowpan fraglettation.


--
Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
 -= IPv6 IoT consulting =-




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVt7dB4CLcPvd0N1lAQLsyAf/UQhfwO1HhNIaXw00JcNs70W+fHD0JxYP
M+Y7swZs1Q2exSVmQ4UWYCSRBK+Z3n0Qwftsz6uAR2xBEy/vX5XPhz3PgzbzmcA/
WKWmLMXJZOQjTZEMgC8lOTSZkYaa3tNU5ojinQECq5Maz3attntn2ZfTW6Rqftw8
OiRa7wxpNEYcIw+bfFHPqi+JEJ/mx3YoaN7Z1OFnsX2uhxt8TbCW4kRn5McFaEY1
dGR8CKbxMUEznw1PLg+maSMULHFXY5zOFVjOhUH6buIqiwSrz2+dv42Skby+46IA
3TZhYnLR4n7uJBYfb5r2MNCxGwLiS4lXU9RBkDUNDNLA0gxmprAfDA==
=WrZK
-----END PGP SIGNATURE-----
--=-=-=--
