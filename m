Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hUABaerL"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456E1720;
	Fri,  8 Dec 2023 01:21:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FFC524000A;
	Fri,  8 Dec 2023 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702027279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Msi6erEgCpiWv9MPv11fKWqWAHsTV6A1PZwaFnQ0nVs=;
	b=hUABaerLa+y55sEgSDYxck0g0XDnwHp5Fv6zSRQImcmhcbrOLntQ4LosSqfOtCi5x4xiOU
	D4La77AeosXF6BaLnujTHzzS6xTp443ye5Qj1tKNJGTsPVfkfAF86Nxx/a3jol/16lPgs+
	yE8+cCfmm6D8Q8mjsVKFJFDVpsrpS7W7lq1xO8fa/hGKKsawanH8DlUfe3xsjtTm8KrIR+
	jV3HeeOR2VX6bauwKRpq89hFZWXhwQp4gYC0Gp68LxIbXuHJhkzwaFS9jLCpbZCDLFGCFf
	k8almZhFycFKMCstu2MIQdFzjUK9p8p0OTHBpHE4PmUxJLXhFIcE/eMcMiwE+A==
Date: Fri, 8 Dec 2023 10:21:14 +0100
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
Message-ID: <20231208102114.56bb1a88@xps-13>
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

Oh! Thanks for spotting this, I actually pushed the branch (otherwise
the hook would not have sent these messages) but the push operation
apparently failed at some point so the tip of the branch was not
updated. This is now fixed.

Thanks for the reviews by the way.

Miqu=C3=A8l
