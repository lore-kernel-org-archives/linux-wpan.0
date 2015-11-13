Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:45091 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbbKMSNb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Nov 2015 13:13:31 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: LL address and IPv6 address
In-Reply-To: <CAPpUg6P259rf9NXGpDXqNq2Qragc5Ht9ZvQCSaDGSG1vSWcbZg@mail.gmail.com>
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com> <CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com> <CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com> <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com> <20151112085333.GA3045@omega>  <CAPpUg6P259rf9NXGpDXqNq2Qragc5Ht9ZvQCSaDGSG1vSWcbZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 13 Nov 2015 13:04:16 -0500
Message-ID: <25991.1447437856@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

--=-=-=
Content-Type: text/plain


I hadn't realized until I was trying to communicate LL (fe80::) addresses to
a plugfest peer that the LL addresses and layer-2 addresses are not stable.
(no eeprom in at86af23x, most of the OpenMote/Redwire devices that Contiki
runs on have same issue)

Yes, we can set them from /etc/network/interfaces using iwpan, but I'm a bit
not keen about this as a general solution.

Now, I have some ideas about deploying (802.1AR) certificates that permit a
node to prove it owns a particular L2 address.  Given that certificate, I
might as well configure the l2 and short address, etc. directly from the info
in the certificate.  This solution will suit my needs well, but probably not
others.

We do not have a kernel command line option to set the LL address, we should,
but in the specific case of the RPI, that won't help that much, because the
RPI doesn't use GRUB (nor uboot by default), so the cmdline is hard to
update.  Does this matter that much; I'm not sure.  Still, I think we should
have a non-programmatic way to do this, maybe some kind file in /etc,
or maybe a sensible recommendation for having udev do it.

I also noted that if I tried to change some things, such as panid and l2
address that it wouldn't work until I rebooted.  Probably there was another
sequence I could have used, but I didn't figure it out at the time.

Also, as far as I know, we can't operate on more than one panid at the same
time.  I could imagine that maybe one could create multiple lowpan on top of
the same wpanX interface, but the panid is actually at the lower level.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEVAwUBVkYmHYCLcPvd0N1lAQLFpQf6Au5I0+mV03xKidFLQ6rm7HWFDF2GvXUt
/BeFyo7m5ygOo2WMzaesQvtYHG7J/BEiqLi6oYK4ehU68r1QLcMF6uKwRhPLDQtF
DwddnfTzUjl+MQ1s8OhP5eGo6rCYd7eS02tToHogZT3GLNkodMDKlIF0z3Fgnoxr
NoEkNRdhsqv5f7hvWtegRHdOlLsKxJbqKlivzj8SE+CR9QdGISCAK7n2om3Vbc0t
1bftG/C2VYl5EmBo7gW4BBiLXdKloSCkNONygRBmq1+46gMT51Bvm4oD1wI8cjGc
ECIsBZx5r3c61MdHrFu1738pZp59dWlDi8wSPke3wzrGlTr0/BdcRw==
=kkCY
-----END PGP SIGNATURE-----
--=-=-=--
