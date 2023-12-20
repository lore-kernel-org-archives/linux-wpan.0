Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374C18E0B;
	Wed, 20 Dec 2023 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OYgU0HIf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 400C91BF204;
	Wed, 20 Dec 2023 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703058462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/Rm48/cqo114dbZkQAt3fLIDwYToj71lL7QWamBTuI=;
	b=OYgU0HIfSxaUeX3rdkb77dYL3dwqnXhjOZl61WmcdzR/bQdBLcbH/DqizS3iOsdGowIkQ/
	AHKBSjkZesWTyWs/4cw3ngvCDhA6U38YdRnbKH7zL6sYFVahyir4ChCkEHswey/1O7UFvr
	JJmhRPFNZDa753LYIlFGonDIuMw5v58c+XIV13Dm9VYmXDbyGSYclAtW6KXSu5nkQ9PUuv
	m7fpLgtxnn4OI7Fetu2gYztf868ztY64fE8NqjxzG8esnhzUQkw0RgRH+1DH2UuvyEbmsG
	7WZwiBx+lfujeaZJMmiBaop6ii2WJSZqVfw7cyJUkItsrSdMI12aLriLUn1Y9w==
Date: Wed, 20 Dec 2023 08:47:40 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v5 01/11] ieee802154: Let PAN IDs be reset
Message-ID: <20231220084740.6e16c1c4@xps-13>
In-Reply-To: <51de3b76-78cf-5ee4-ec31-6cf368b584b7@datenfreihafen.org>
References: <20231120110100.3808292-1-miquel.raynal@bootlin.com>
	<51de3b76-78cf-5ee4-ec31-6cf368b584b7@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Stefan,

stefan@datenfreihafen.org wrote on Thu, 7 Dec 2023 21:27:59 +0100:

> Hello Miquel,
>=20
>=20
> On 20.11.23 12:01, Miquel Raynal wrote:
> > On Wed, 2023-09-27 at 18:12:04 UTC, Miquel Raynal wrote: =20
> >> Soon association and disassociation will be implemented, which will
> >> require to be able to either change the PAN ID from 0xFFFF to a real
> >> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> >> disassociation. Let's allow to do that manually for now.
> >>
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> >=20
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-ne=
xt.git staging. =20
>=20
> I can't see this, or any other patch from the series, in the staging bran=
ch. Did you forget to push this out to kernel.org?

While preparing the PR for net maintainers I realized that in the above
message I actually pushed on the wpan repo instead of the wpan-next repo
by mistake. This explain why you didn't see it on the
wpan-next/[staging|master] branches. I've fixed my mess hopefully, and
will anyway send the PR today as the patches have been in -next for a
week or more already.

Thanks,
Miqu=C3=A8l
