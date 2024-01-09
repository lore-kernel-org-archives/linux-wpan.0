Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3439876
	for <linux-wpan@vger.kernel.org>; Tue,  9 Jan 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="LsXRoKcE"
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 94D7F1800D;
	Tue,  9 Jan 2024 08:57:11 -0500 (EST)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IpMy0AFmxY-o; Tue,  9 Jan 2024 08:57:09 -0500 (EST)
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
	by tuna.sandelman.ca (Postfix) with ESMTP id A68251800C;
	Tue,  9 Jan 2024 08:57:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1704808629;
	bh=Ba8UPpR/r101zEvMds6lmpXs0erMZSONKp83cTFfjEI=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=LsXRoKcEJxmH24cIvPpfRGT0itM5SQ3c7oXdD0GnsneTRL3yW6qeW2Yf3cc7QEt+R
	 FAP5pm0T70ZLzY0R1IXC69dYxe3n1/yFyGJt1mgJYh8VH+djr76Sl1NA9KaO6vBZ0k
	 TAeRrA7ntUj0UqK5HkEOgRHssco7Il9Kuc90QBLa91KLu4WgjTQIqV3eb6QDmB3e4I
	 exbaSXZaOcMmQ/f4T5wWwWt2HuEgpS6LNE+WmuJYrbPW8xMnkAI3hCxTs0PBiYY/ju
	 dxeTC0zOOiet1BG+pB1vzdupS01KBmUMIsCsF/gkNgm3yJFx0wV7u2ZO5/uM2if68q
	 Qsupb0wE6zYfA==
Received: from obiwan.sandelman.ca (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 9BFFF14F;
	Tue,  9 Jan 2024 08:57:09 -0500 (EST)
From: Michael Richardson <mcr@sandelman.ca>
To: Marek =?us-ascii?Q?=3D=3FUTF-8=3FB=3FS8O8dGhl=3F=3D?= <m-k-mailling-list@mk16.de>
cc: linux-wpan@vger.kernel.org
Subject: Re: Linux WPAN and Contiki NG
In-Reply-To: <20240108170928.2b1d0fd9@ciel>
References: <20240108170928.2b1d0fd9@ciel>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 28.2
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 09 Jan 2024 08:57:09 -0500
Message-ID: <26711.1704808629@obiwan.sandelman.ca>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Marek K=C3=BCthe <m-k-mailling-list@mk16.de> wrote:
    > I would like to try Linux WPAN with Contriki NG and have some questio=
ns
    > (I am new to the topic, so the questions may be quite stupid): Contiki
    > NG, as I understand it, implements various 6lowpan standards -
    > including 6TiSCH, TSCH and 6TOP. Which of these are also implemented =
in

As Stefan said, you can not yet run TSCH on Linux.
Many of us would like to make it happen, and a few (Alex!) are writing code,
but there hasn't been a resources to allow anyone to spend real time on it.
Typically, people combine a Linux host (like a openwrt router) with a USB
connection to a Contiki or RIOTOS (or maybe Zephyr now) device that acts as
the 6TISCH device.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmWdULURHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WWhdwf/VJJaSUyiXI+Xy/eQ/1ZEPhptXNB3aNSR
J8L/IlNhxf412lT8oXmTBmFLc126bZbDFKay9dKDYIfUtXpKBtjl1V5GBBMZ731Z
OL14yT4kEEQLZtQAJa799HLToihyKnAF8JIrWUpHZe0+UsyJmko76TfqgC+0ymvw
p2G9AWbBTPrB3DXFOOvMOorb3LT14OqoJTOT73aGp+b84TfM4krB0MSnE3GyaqTV
V2DJ1FtTnBghTVfJd79aJH2d/bTJrgUUmn0Q1fjTYTDtOVIAw/Sl1g3JPEn66Y5K
xaGNaa+JHTaOcM/r+HISNr028LFrMF69RajMUD1laUft6gsxjkRC+A==
=Gcca
-----END PGP SIGNATURE-----
--=-=-=--
