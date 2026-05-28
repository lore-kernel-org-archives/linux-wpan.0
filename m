Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76D34C815;
	Thu, 28 May 2026 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954310; cv=none; b=OItKjaKPZrsIBA60n487ycsh56eei7K9dTdFUfQM4rwtDzNGfsgjgtnYTaRXMGWv9VyYmY/TcIqkxNxvJbGXaDWR+KTF0vzlHnHI5kml1dgSzle4uYNeWAEcJqbO3U0R458eM2qN3hUNf6zH6/WcJVL1eznUiQg74nrT/OJPvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954310; c=relaxed/simple;
	bh=EJub6JXBaWWgRu5cZ1gvCapF88tx4Za6Fv68dCVsrMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XxQu5Hpb9NXXxkjt7H3YA4QG1tlHDGAzh7lWcGwZRB07VtZIm5K9/WAlKDXVWkzQ7YNVwXVQtelgTqpoP06ZufcBI5XmRw7E9m9D4JcNDq4MMXP5xFuKRpnuHsCqQvXG7guWi1juMO8v3rdx+SuIenHZJUhzS//gywnL/J6KPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RRj0XWqY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RRj0XWqY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E4E744E4106B;
	Thu, 28 May 2026 07:45:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8FE960495;
	Thu, 28 May 2026 07:45:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 422B81088806E;
	Thu, 28 May 2026 09:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779954305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o+jaleTw1PrS9lddrKqjpqnnZcDe+XAxXAP5SJyBXWo=;
	b=RRj0XWqYSEpbhqlQ28lfttUnTJSiY064TTecno3eu5Mnxy4ThKtkOuZ0AeLc4x+SxANGyT
	jWAyTaNwuwdW5uB6FfMIjfrMnKjA+qEdqzvJnq9a41EWCaEjbBjJP7gqvbeijwa1e8cfTB
	uq8YXUjq+foDA41bcXMfmQsX7VParDd9bWIgDGoCcEADUpPUQLxUexMIYIDQdO2F5Qv/TA
	Tp2a7oLhwDb9/HbhUi9swCax7Meznh/H43E/Cdx9i65klynIbufrqbrG1Ph/40h7+facKt
	ZppX/0ttMwX0Klsgn0G6VvkU6HjTa+aX84Zvmtaql4ydmmgOI+KUX4fH/6MO3A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "syzbot" <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com,  "Alexander Aring"
 <alex.aring@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,
  <linux-wpan@vger.kernel.org>,  <netdev@vger.kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Stefan Schmidt" <stefan@datenfreihafen.org>,
  horms@kernel.org,  linux-kernel@vger.kernel.org,  syzbot@lists.linux.dev
Subject: Re: [PATCH] ieee802154: fix kernel-infoleak in dgram_recvmsg()
In-Reply-To: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
	(syzbot@kernel.org's message of "Wed, 27 May 2026 20:18:18 +0000
	(UTC)")
References: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 09:45:00 +0200
Message-ID: <878q94htab.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

LGTM.

> -	addr->mode =3D mode;
> -
> -	if (mode =3D=3D IEEE802154_ADDR_NONE)
> +	if (mode =3D=3D IEEE802154_ADDR_NONE) {
> +		memset(addr, 0, sizeof(*addr));
> +		addr->mode =3D IEEE802154_ADDR_NONE;
>  		return 0;
> +	}
> +
> +	addr->mode =3D mode;
>=20=20
>  	if (!omit_pan) {
>  		memcpy(&addr->pan_id, buf + pos, 2);
>
>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
