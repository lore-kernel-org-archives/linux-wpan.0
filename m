Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:57413 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbcCITQe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Mar 2016 14:16:34 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: RPl on Linux
In-Reply-To: <CAPpUg6MMTrwOiNC5M-e52zZpNkh58AQ7TC7x2p_fY916CvyHpw@mail.gmail.com>
References: <CAPpUg6OTHiaWvANusmnty0DW0GRonTgX5uOLfR5cOSgbdnYyqQ@mail.gmail.com> <30027.1457531123@obiwan.sandelman.ca> <CAPpUg6MMTrwOiNC5M-e52zZpNkh58AQ7TC7x2p_fY916CvyHpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 09 Mar 2016 14:16:30 -0500
Message-ID: <3583.1457550990@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

--=-=-=
Content-Type: text/plain


Baptiste Clenet <bapclenet@gmail.com> wrote:
    >> Baptiste Clenet <bapclenet@gmail.com> wrote: > Thanks for your work
    >> concerning 6lowpan, 802.15.4 and wpan tools, > that's great!  I'm
    >> wondering what the status of RPL mesh implementation > on Linux?
    >>
    >> There are few implementations, see for instance this article:
    >> http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html
    >>
    >> 1) Mine, which is at http://unstrung.sandelman.ca/ Currently storing
    >> only; non-storing requires kernel work that is not yet done.

    > Thanks for your answer, I see that you suggest to make it work with
    > Contiki RPL implementation., a serious competitor to Contiki is RIOT,
    > have you ever tried your RPL implementation with RIOT RPL?

We interoperated with RIOT-OS RPL back at the 6lo interop in November.
I haven't yet successfully flashed my own openmote with RIOT-OS (or OpenWSN).
[It's a JTAG/bootloader issue that I haven't had time to resolve...]

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVuB2i4CLcPvd0N1lAQJ9DggAv0MusUf+CZpNtoDJ7Y1GN0HT1yYNNEK5
twNzVSjG3LFEnMHpI4ZlDThgv2dFjETZXflVH5KNifiZPC1c/rukkjGHkI6wLKGY
XeWpyhyeruPx4YFuJOnZ/qL2ePwf+dIRP21eEI6TdguDAuZtkjpTtU1bE5mDGuhE
weeFlS13StY+cz97nA9r9Fr1MGRgm00QBKGhim8EOgu8MzTvMNnfj3tciNKAlJqE
l0M/I7hIuQbkRJR+PgM6DsGcvT+dP9IcUNTDWhxFlTOGyPd1SPal015g8q4JRwUu
gT4DzCX00znlLBuqAiZbsFg4zjcpNxenP2puHYK62ZkE1jx/7NJE3g==
=XhT/
-----END PGP SIGNATURE-----
--=-=-=--
