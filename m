Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33457 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbdARJq2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Jan 2017 04:46:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so2718375wme.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Jan 2017 01:46:25 -0800 (PST)
From: =?utf-8?Q?Jo=C3=A3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Message-Id: <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A156C9D0-23BA-4B6A-A92B-BA955DF5A840";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: please help me to integrate RPL in kernel
Date: Wed, 18 Jan 2017 09:46:15 +0000
In-Reply-To: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org


--Apple-Mail=_A156C9D0-23BA-4B6A-A92B-BA955DF5A840
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi JANARDHANACHARI KELLA,

Just a little of context.

For the last 2 or 3 years I've been working in projects related with =
smartgrids and LV powergrids. Among the huge list of requirements of the =
projects, let me just refer two (or three).
	=E2=80=A2 Sensors mesh networks must use wireless connectivity =
(not PLC, nor ethernet, or some kind of wired links)
	=E2=80=A2 Sensors were deployed on Street Lighting poles (thus, =
would require power provider cranes and "brave" guys to install them)
	=E2=80=A2 One of sensors features is to detect power outages, =
thus it would require some kind of backup power to make them work, =
but... usage of any kind of batteries were forbidden.
Long story short, RPL was simply part of the solution. At the time there =
were only one good implementation of RPL: contiki's one. For sensors it =
were a good approach. Anyway, in some use cases, contiki was not enough. =
After a search for RPL implementations for linux, I only found 2 or 3 =
which worked on linux userland which required huge resources, so I give =
it a try and started a linux RPL implementation on kernel land.

	=E2=80=A2 https://github.com/joaopedrotaveira/linux-rpl (kernel =
patches)
	=E2=80=A2 =
https://github.com/joaopedrotaveira/rpl-userspace-tools (userspace tools =
like iwpan, based on libnl)
To figure out the SoC power consumption of those on the market and =
decide which one to use, it was required to test several boards (rpi, =
beagleboard, beaglebones, olinuxinos, Atheros AR9330 boards, ...), check =
power consumptions and test RPL implementation with some contiki based =
sensors. It was also required to use 868band radios, which were very =
dificult to find. It was very hard to implement RPL in kernel and port =
it for every single kernel versions of each kind of ARM SoCs, which =
exoteric patches from this or that SoC vendor to best support for power =
management (namely pm3).

After Linux RPL Implementation in kernel space being tested, on several =
SoCs, with transceivers 802.15.4 on 2.4GHz and/or 868, I tried to get in =
touch with kernel wpan group, but no one seamed to be interested in my =
contributions. ROLL ietf group was very receptive to know that a kernel =
land implementation was in development, but wpan-linux had other ideas =
for the wpan stack, some kind of scorn about RPL, they simply ignored my =
issues and questions.

After this "kindly" and "warm" acceptance from wpan-group and the lack =
of interest in merge efforts, I was forced to give up on get RPL =
implementation in kernel.

RPL standards require information about transceivers link quality, stats =
about physical layer of 802.15.4 radios, and wpan-linux simply ignored =
my calls.

After months trying to get things working with dozens of different =
kernel-trees, from different SoCs, different kernel versions and almost =
no interest, I was forced to come across on unfair and insulting =
reviews: http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html

After months trying to get fully RPL supported kernel with following =
goals:
	=E2=80=A2 RFC6550 RPL: IPv6 Routing Protocol for Low-Power and =
Lossy
	=E2=80=A2 RFC6551 Routing Metrics Used for Path Calculation in =
Low-Power and Lossy Networks
	=E2=80=A2 RFC6552 Objective Function Zero for the Routing =
Protocol for Low-Power and Lossy Networks (RPL)
	=E2=80=A2 RFC6719 The Minimum Rank with Hysteresis Objective =
Function
	=E2=80=A2 RFC6206 The Trickle Algorithm
	=E2=80=A2 Support for adding new Objective Functions Modules
	=E2=80=A2 Kernel Network Namespace support
	=E2=80=A2 Userland tools
... I was forced to stop working on this, and move forward on the =
project I was working on, when I get a nice surprise reading conclusion =
of the already mentioned review:
"Conclusions
RPL for Linux is usable. Joao Pedro Taveira's implementation seems to =
work with Linux 3.17 and 6LoWPAN (after minimal patching). This is very =
surprising, that implementation is no longer developed. Linux box is a =
superior solution for Border Router than any embedded system. Open =
Source's inefficiency is sometimes amazing."

Right now, I don't know the current status of wpan-linux stack. I recall =
that wpan-linux was merged with bluetooth-stack or something, but I =
assume that the required changes to netdev that allow me (or anybody =
else) to get RPL really working as expected in kernel, are still =
missing.

When there will be interest, will and gumption to resume linux-rpl =
project, simply let me know.

Best Regards,
Jo=C3=A3o Pedro Taveira

> On 18 Jan 2017, at 07:48, JANARDHANACHARI KELLA <eni.chari@gmail.com> =
wrote:
>=20
> Hi,
>=20
> i am trying to integrate RPL feature in linux kernel to use on
> raspberry pi2 b with at86rf233 module. can any on suggest/ provide any
> information to integrate RPL feature?
>=20
> is this Rpl feature supported for new kernels like(4.x)? for rpl which
> kernel i have to use?
>=20
>=20
>=20
>=20
> --
> Sincerely Your's
>=20
> Janardhanachari Kella
> Contact:+91-9908469599
> E-mail: eni.chari@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________________
Jo=C3=A3o Pedro Taveira Pinto Silva
e-mail: joao.p.taveira@gmail.com
github: joaopedrotaveira
linkedin: joaopedrotaveira




--Apple-Mail=_A156C9D0-23BA-4B6A-A92B-BA955DF5A840
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYfzltAAoJEGSfKKvIvRlLBxkP/i1atYRLhFw1DfZc59XpgKyi
R+jaMiOwMjW2nqzHYWuouk7C7/gS0dnT/9nAGG4J65k0zsTOUOKE9MF3u9RApaSQ
kcUllOCYbk6qp95D8bQm8rm4vysnqGPHqPDPsgQ5FG/4rUgyZf8N+WnhY5ZwC2Oa
gRKziKWmaUfgsvS3rWORNExS1rP9iS5wIvGetK+gbEd36a2F15zLTzRFMLQDtZeG
DzoY655ukoMtoj1ciIiGK+ew6alBx4xPFin9mPYiYBEMMbOR09pVWjXWJxebAHer
zGXcquOWkTVCH658TFI2ID35N+JGmXICYE7w45p0egxOlSngGFXOvc7AWKbQtt2w
L5a8EbYly/25ODngm3TH+7YfH3rbMVHDME9cTAosrRnBpfOpu/gxuC+LZt9NvV+o
K/fKxR1yceKpkveUo+5SVunH6SrwwCOr67Zz38vbKFilYFlgC1K3yHVOcbEARy+Q
RQq2VCG+M5jiXvtfj/n1ZQRrv+y1K2n7+pOMFaIjxLBv7BNnE02cuLVKr2IkJSCt
KIlgHFcL+pM5l9p1in7qWJJ/fuO5lO52lHSLYC4+jjVCS/0UbnTjv4jWZ2I18QoT
w5nwCWn19PN03IX/bapoh/awaYfa3jAYfCo9H5IbFxCpt/78+zow0b6Pb1NdUFjB
64ZxWdXWbZjIb784+XpC
=kKHI
-----END PGP SIGNATURE-----

--Apple-Mail=_A156C9D0-23BA-4B6A-A92B-BA955DF5A840--
