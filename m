Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C928BF3;
	Mon,  8 Jan 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EsIySqX+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFA39240009;
	Mon,  8 Jan 2024 07:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704698918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsyRsr5wVllmTXkOLhKmpaaVCbFdvpUU1HVC9nK9ZEI=;
	b=EsIySqX+BV/Z4yLXA4rIh+cFQiicFJE/Ycdh1/Vo11UgMCGb/Yj7nLchXngBHsHaZ0qToR
	KqqQ0x41Ll3eRRDeOVCUeNqntWSGWeWnKZQzjoxwGAk7UgHssFagK/MihM5veYkdn1Pxd3
	GhZ8xuP04Bjf8+meEa9dIZw5y7Wx0zmNBNvqJ/7WHtxHQ+Z/2UqTdY/KDsPjF++bRTnJmS
	B48khh0nPxbGMusJTa9tLsWYEnBmHKidNVkd2lTjGKDpSd64oR9vZBjdwNCRvXIGHBSSgA
	5eIczHGTbYlYOhpRb3Fu9d51DqD/chhljJsI1MizUzz3jkr62aB15RCQ77ECMQ==
Date: Mon, 8 Jan 2024 08:28:37 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net-next 2023-12-20
Message-ID: <20240108082837.3507d4d7@xps-13>
In-Reply-To: <20240104143135.303e049f@kernel.org>
References: <20231220095556.4d9cef91@xps-13>
	<20231222152017.729ee12b@xps-13>
	<20240104143135.303e049f@kernel.org>
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

Hi Jakub,

kuba@kernel.org wrote on Thu, 4 Jan 2024 14:31:35 -0800:

> On Fri, 22 Dec 2023 15:20:17 +0100 Miquel Raynal wrote:
> > miquel.raynal@bootlin.com wrote on Wed, 20 Dec 2023 09:55:56 +0100:
> >  =20
> > > Hello Dave, Jakub, Paolo, Eric.
> > >=20
> > > This is the ieee802154 pull-request for your *net-next* tree.   =20
> >=20
> > I'm sorry for doing this but I saw the e-mail saying net-next would
> > close tomorrow, I'd like to ensure you received this PR, as you
> > are usually quite fast at merging them and the deadline approaches. =20
>=20
> Sorry for the delay, I only caught up with enough email now :)

No problem with the delay, sometimes e-mails get lost in SPAM folders
and I was unsure about whether you would pull after closing (and
possibly re-opening) ne-next.

> > It appears on patchwork, but the "netdev apply" worker failed, I've no
> > idea why, rebasing on net-next does not show any issue. =20
>=20
> That's because the pull URL is:
>=20
> git@gitolite.kernel.org:pub ...
>=20
> the bot doesn't have SSH access to kernel.org. IIRC you need to set=20
> the fetch URL in git remote for your repo to be over HTTPS. Only
> leave push over SSH.

Oh, right, indeed on another repo used to generate pull requests I have
a different fetch/push remote, but I totally overlooked that one. I will
update my setup, thanks for the tip!

> > https://patchwork.kernel.org/project/netdevbpf/patch/20231220095556.4d9=
cef91@xps-13/
> >=20
> > Let me know if there is anything wrong. =20
>=20
> Pulled now, thanks!

Perfect, thanks!

Miqu=C3=A8l
