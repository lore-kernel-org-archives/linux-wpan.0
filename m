Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from relay.cooperix.net ([176.58.120.209]:48417 "EHLO
	relay.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbG0BEA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Jul 2015 21:04:00 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: testing and building for RPI
In-reply-to: <55517906.2060204@gmail.com>
References: <19096.1431373298@sandelman.ca> <55517906.2060204@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 25 Jul 2015 14:27:21 -0400
Message-ID: <7829.1437848841@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, unstrung-hackers <unstrung-hackers@lists.sandelman.ca>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Varka Bhadram <varkabhadram@gmail.com> wrote:
    > You can directly use linux-wpan-next tree directly, which has the bas=
ic
    > support for RPI. No need to rebase it on rpi kernel.

    > Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

I have some edits for this; mostly unfortunate typos or copy/pastes.
I did get it working; my major stumbling block had to do with u-boot
apparently not really sending out multiple DHCPs messages.

The first goes out, and if the network is truly ready, it works.
Why wouldn't it be ready?  Cisco switches with STP enabled... plugging in a
trusty 8-port 100Mb/s stupid switch solved the problem, but cross-over cabl=
e to my
laptop showed me that it was really only sending out a single DHCP request,
not 8.  Once I put the "boot.scr" in place, it seems to boot very reliably,
but I haven't removed the 100Mb/s switch yet.

The suggested "agx" tree's defconfig didn't seem to enable the correct set =
of
kernel CONFIG options for the AT86*, etc. I'll post my whole recipe when I'm
back from the cottage.  You need to enable the IEEE802154, to then see
MAC802154 (and enable it) options before you'll see the AT86 drivers
available if you are using menuconfig.

=2D-=20
]               Never tell me the odds!                 | ipv6 mesh network=
s [=20
]   Michael Richardson, Sandelman Software Works        | network architect=
  [=20
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails  =
  [=20
=09

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVs9UGAAoJEKD0KQ7Gj3P2ZnIIAJEOqzrMR7WiP98y1auWmPQm
klGqAkqWc15zHBoSrU7vrA51bAgsvwXeOgtMS5QJf0pGHl9LjU7hjUkst7OaNOos
tmBYhODefVPoFg4MQM0k/Zlu3LnePw1paZ1xmp08nmPlyHiIYt5iLphrQrUKpkP7
8kpWNNTo5WYC2VUG/td1BZ405kwo5AlPb4UtPEAZkf+VphKfETaKkIfikbaDzh3h
hbtA27IKUda54IsjzYa71nq0c3NAT3/7a3KPBBVU5B2oW6Ub7UhbtyL1JJxFKWHw
3icHH5j5NhIdORVtDyDQ4MhlcftP/wf8SmoXrNIdGRRfItaUCNcPnYHP7EZncT8=
=nFv7
-----END PGP SIGNATURE-----
--=-=-=--
