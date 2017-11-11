Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:52122 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdKKSx3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Nov 2017 13:53:29 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: Bridging a lowpan interface
In-Reply-To: <D59C859A-19A4-4898-A7E1-19C09BEBEA4E@ntnu.no>
References: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no> <730.1510335972@obiwan.sandelman.ca> <D59C859A-19A4-4898-A7E1-19C09BEBEA4E@ntnu.no>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 11 Nov 2017 13:53:27 -0500
Message-ID: <22033.1510426407@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

--=-=-=
Content-Type: text/plain


David Palma <david.palma@ntnu.no> wrote:
    > I'm all for routing and starting with RPL is fine. However, the idea
    > was also to enable traffic differentiation based on flows (the SDN
    > part), without breaking them, and not only based on IP
    > addresses. That's why I mentioned that I used routing and ip6tables.

I don't understand what the problem is.
What would you do with bridged interfaces in an SDN?
What kind of breaking are you speaking of?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAloHRyYACgkQgItw+93Q
3WXJlQf/QJt13v1mHAS5UWEpYWIWnR/3arR/Pq/x/RTEJPn28BLd5+7BD3fOGKRp
OrdZGywgiv0HQbiCcxi0hpqX36AGU0/BW8Gx26Q8d+4G8AkIq7awUaZO8PyLam6A
4jLsDtDg+QddHqi3oEcAOU4vsP4Nq6/egVMEmpAyoePWNOjntDBfUnfFO/LJpWBG
g3IiyhranT0aDgjoeBd6dsYBbNido5Tz4r1cqW3BVqBTHYvnxoVnjIiShN8Z9Y54
xiWFuBUaOJ3FTb7A6dPsgqOvb0wXDdqa6SwBf8YF3YPVzvkwjmbz7Y68PEhpxvKx
YbAWL8Gcg3L0Em48iBwkRU+P8Fsd/w==
=cBjF
-----END PGP SIGNATURE-----
--=-=-=--
