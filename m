Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34032 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbdARKzy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Jan 2017 05:55:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so3170254wmi.1
        for <linux-wpan@vger.kernel.org>; Wed, 18 Jan 2017 02:55:49 -0800 (PST)
From: =?utf-8?Q?Jo=C3=A3o_Pedro_Taveira?= <joao.p.taveira@gmail.com>
Message-Id: <86AE743A-D69C-469E-8693-95F7636BFD3F@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C4DA6629-BBB2-464B-AEB7-591CADAC1191";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: please help me to integrate RPL in kernel
Date: Wed, 18 Jan 2017 10:55:40 +0000
In-Reply-To: <865f1a70-68e3-b947-f37d-ee856147c341@pengutronix.de>
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
 <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com>
 <865f1a70-68e3-b947-f37d-ee856147c341@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: JANARDHANACHARI KELLA <eni.chari@gmail.com>, linux-wpan@vger.kernel.org


--Apple-Mail=_C4DA6629-BBB2-464B-AEB7-591CADAC1191
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

Apologise me if I was too hard in my previous mail. It was a simply =
outflow about something that I kept for too long.

You=E2=80=99re right about the wide range of changes and/or =
contributions to kernel that RPL requires. I agree with you.

What really wroth me was the =E2=80=9Cno way out=E2=80=9D situation.

My implementation of linux-rpl touch mainly in netdev (ipv6, icmpv6, =
NUD, extended headers, routing tables=E2=80=A6). When I tried to contact =
netdev, I got no reply whatsoever. But before propose anything to =
netdev, I wanted to get linux-rpl to work with contiki using MRHOF and =
ETX. This would only work with feedback from 802.15.4.

So I tried to get some support from you. You were extremely active by =
then getting wpan moving forward, so I thought you could help me get =
metrics from wpan stack. Since you were too busy and (now I think I =
didn=E2=80=99t explained correctly what I needed) you couldn=E2=80=99t =
help me.

Now I know that you already faced and noticed the problem of MRHOF and =
ETX.

In a previous mail with subject =E2=80=9Cthesis - MLE=E2=80=9D you =
wrote:
=E2=80=9CAnyway for 802.15.4 I need to implement some kernel parts to =
calculate
ETX, which means I need some ack received/non ack received counters or
something else which can be inserted for the ETX calculation (I need to
look into that).=E2=80=9D

=46rom wpan, this was and still is the only problem I need to solve =
regarding to RPL and wpan subsystem. RPL works in a completely area of =
kernel.

I hope get some time to get back to this project and get some kind of =
stats/metrics system working with RPL Objective Function =
implementations.

Best Regards,

> On 18 Jan 2017, at 09:59, Alexander Aring <aar@pengutronix.de> wrote:
>=20
>=20
> Hi,
>=20
> On 01/18/2017 10:46 AM, Jo=C3=A3o Pedro Taveira wrote:
>> Hi JANARDHANACHARI KELLA,
>>=20
>> Just a little of context.
>>=20
>> For the last 2 or 3 years I've been working in projects related with =
smartgrids and LV powergrids. Among the huge list of requirements of the =
projects, let me just refer two (or three).
>> 	=E2=80=A2 Sensors mesh networks must use wireless connectivity =
(not PLC, nor ethernet, or some kind of wired links)
>> 	=E2=80=A2 Sensors were deployed on Street Lighting poles (thus, =
would require power provider cranes and "brave" guys to install them)
>> 	=E2=80=A2 One of sensors features is to detect power outages, =
thus it would require some kind of backup power to make them work, =
but... usage of any kind of batteries were forbidden.
>> Long story short, RPL was simply part of the solution. At the time =
there were only one good implementation of RPL: contiki's one. For =
sensors it were a good approach. Anyway, in some use cases, contiki was =
not enough. After a search for RPL implementations for linux, I only =
found 2 or 3 which worked on linux userland which required huge =
resources, so I give it a try and started a linux RPL implementation on =
kernel land.
>>=20
>> 	=E2=80=A2 https://github.com/joaopedrotaveira/linux-rpl (kernel =
patches)
>> 	=E2=80=A2 =
https://github.com/joaopedrotaveira/rpl-userspace-tools (userspace tools =
like iwpan, based on libnl)
>> To figure out the SoC power consumption of those on the market and =
decide which one to use, it was required to test several boards (rpi, =
beagleboard, beaglebones, olinuxinos, Atheros AR9330 boards, ...), check =
power consumptions and test RPL implementation with some contiki based =
sensors. It was also required to use 868band radios, which were very =
dificult to find. It was very hard to implement RPL in kernel and port =
it for every single kernel versions of each kind of ARM SoCs, which =
exoteric patches from this or that SoC vendor to best support for power =
management (namely pm3).
>>=20
>> After Linux RPL Implementation in kernel space being tested, on =
several SoCs, with transceivers 802.15.4 on 2.4GHz and/or 868, I tried =
to get in touch with kernel wpan group, but no one seamed to be =
interested in my contributions. ROLL ietf group was very receptive to =
know that a kernel land implementation was in development, but =
wpan-linux had other ideas for the wpan stack, some kind of scorn about =
RPL, they simply ignored my issues and questions.
>>=20
>> After this "kindly" and "warm" acceptance from wpan-group and the =
lack of interest in merge efforts, I was forced to give up on get RPL =
implementation in kernel.
>>=20
>=20
> It's not OUR job to merge ICMPv6 protocol into kernel! I already told
> you - you need to send your patches to netdev mailinglist... but I =
think
> you need to switch some stuff there, so far I remember sysfs is used =
->
> switch to netlink.
>=20
> We didn't ignore anything...
>=20
>> RPL standards require information about transceivers link quality, =
stats about physical layer of 802.15.4 radios, and wpan-linux simply =
ignored my calls.
>>=20
>=20
> Oh I have patches which provides some per-neighbor LQI information. =
:-)
>=20
> If you see lack of support, just: send-patches!
>=20
>> After months trying to get things working with dozens of different =
kernel-trees, from different SoCs, different kernel versions and almost =
no interest, I was forced to come across on unfair and insulting =
reviews: http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html
>>=20
>> After months trying to get fully RPL supported kernel with following =
goals:
>> 	=E2=80=A2 RFC6550 RPL: IPv6 Routing Protocol for Low-Power and =
Lossy
>> 	=E2=80=A2 RFC6551 Routing Metrics Used for Path Calculation in =
Low-Power and Lossy Networks
>> 	=E2=80=A2 RFC6552 Objective Function Zero for the Routing =
Protocol for Low-Power and Lossy Networks (RPL)
>> 	=E2=80=A2 RFC6719 The Minimum Rank with Hysteresis Objective =
Function
>> 	=E2=80=A2 RFC6206 The Trickle Algorithm
>> 	=E2=80=A2 Support for adding new Objective Functions Modules
>> 	=E2=80=A2 Kernel Network Namespace support
>> 	=E2=80=A2 Userland tools
>> ... I was forced to stop working on this, and move forward on the =
project I was working on, when I get a nice surprise reading conclusion =
of the already mentioned review:
>> "Conclusions
>> RPL for Linux is usable. Joao Pedro Taveira's implementation seems to =
work with Linux 3.17 and 6LoWPAN (after minimal patching). This is very =
surprising, that implementation is no longer developed. Linux box is a =
superior solution for Border Router than any embedded system. Open =
Source's inefficiency is sometimes amazing."
>>=20
>> Right now, I don't know the current status of wpan-linux stack. I =
recall that wpan-linux was merged with bluetooth-stack or something, but =
I assume that the required changes to netdev that allow me (or anybody =
else) to get RPL really working as expected in kernel, are still =
missing.
>>=20
>> When there will be interest, will and gumption to resume linux-rpl =
project, simply let me know.
>>=20
>=20
> I don't know if the ipv6 folks want's to have a RPL implementation in
> kernel. For non-storing mode kernel handling is needed but currently
> e.g. unstrung (which use storing mode) -> no kernel handling is =
requirement.
>=20
> You need to ask on the netdev mailinglist how to maybe deal with that, =
I
> am _not_ an ipv6 maintainer -> you can always send RFC patches there.
>=20
> It's a big challenge to look how we can deal non-storing mode in =
future.
>=20
> - Alex

________________________________________
Jo=C3=A3o Pedro Taveira Pinto Silva
e-mail: joao.p.taveira@gmail.com
github: joaopedrotaveira
linkedin: joaopedrotaveira




--Apple-Mail=_C4DA6629-BBB2-464B-AEB7-591CADAC1191
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYf0mxAAoJEGSfKKvIvRlLQugQAJdp370dLhyJtGYgYGrrTV29
wGYkCL+aYbPW3UpIGc02g7YQuoM4I3HEOoJEjEVV+j6lH2EUZkx38RuOWt4hD2OJ
bWlkZ/R2YmrXOfNVHrghprcRRUzkemr9uKIW1WIXnrMCt323AW433D1EbhcogVk9
RBUfp+cgzAUfVrAeM6oiEGfYnw+ajlmLdTO6xleT+yuNSqBFvOs0feEjhVBf4FAG
jzLUmb1+aaZkcpmt0OdaVEVpxD3rAuV7DtcFiq6982RF9rGHeGlpdsC6onB+pjia
50k0F59oWXUrPPnhXe+NCRKqIU4mcomRcLecroWPvxoG63WXTWSzKqhccx+ItzJ5
msoUpXzvVyDCGWKBh7dHuQYQI1KseL6adzGoCu4+07wtp3RuI9UL9qR70gDTtslg
oMOyyP+U8LQwuzbxVd/JN5329mrtW/BLPJSAU2FbxyfbVcOS9216MohjT8p8J1FJ
MmH0X54Uyshlo5/GJa9WiHaQRDtagKRpWx3vxjheU3PMhoDTTHuAat56R9T7u3AL
R9Fz6fTa7NLp0Wbjx8ZOa+sUA8XqzgBInEtQqRxog/gchcK91CLRvt9BQHHjK/Y0
fXbeSuRz9zVX1v97iECcq8OZag8gzHTrjsZi0BbFdBXqyEZuejzdM6wd9+c97z7H
ZB4yN7gX0UNtUOyE/Iur
=F3Hb
-----END PGP SIGNATURE-----

--Apple-Mail=_C4DA6629-BBB2-464B-AEB7-591CADAC1191--
