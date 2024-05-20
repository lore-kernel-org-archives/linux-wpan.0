Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65710208A0
	for <linux-wpan@vger.kernel.org>; Mon, 20 May 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195240; cv=none; b=C5O7t8EbSnrA9SEBikt573v8PEMJCdyhgvB9iZtPWBu0Ax5sz50VZdN8ph3kTslwK7c5pgZovae8Y4l7u/YzbS/7I3BMPHS4eYXVQ/eo+t1qJO9SNSeMvdVn/0VNAjCVjUJuJwAbfuLjfC2itsCz0Rhm/+CSgk4sxakQwBVo8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195240; c=relaxed/simple;
	bh=yrZmRFcu/5GiA9nuhAfepZM11DVZbT7a12GsU7Kgzyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRuIQ9oKoOjAjxqvd62gX2uwNPdmYFgTHdsyPjGt94sohIX+kWXn+1/Z29L6LDzENsScoHSY0l5zYYt+WmMGhT0wlcNHrLhrSia6FCZS87w/d23Hxe00Vqu+ge7Ds0o5ckx1kpvGyW+G4KgFWfcltiTim8/iyj/l3gphgyy5cSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jcHU2hJr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jcHU2hJr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C29E40008;
	Mon, 20 May 2024 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716195230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VjofWda1hWsGOH9j5iwF7nU1rS4Bo+qxQVveXUpteg=;
	b=jcHU2hJrz0hZsd6hRNizGQ+kb5EaaJLoftIuqcngMrxVr1P1FnBaGvD12L69lUdFcqlyih
	Z93h9d9f5/+FtfM3znbJFPDZKQcjuHQltBtcn/mEWDdv0+NBwghCuC4Jn28254g9PER3KC
	rC02Ugj5Z2NgPgeExoK+91HqYHwzoNGbxodDZQ9mqz6rki1R3M9C8qVfScVkbsyVds+iK+
	cS0O26TiU+fPMk78ik4VkM3d2rT6xijA6rTukABqCYfT6yQrF1hYxcmP9mz46EODXD2xvW
	KhWDfhfvrg79hcY1W33o9aR3ctPQScG6qPpo5X1XCxUUNtEH+nCpF9hZELZklQ==
Date: Mon, 20 May 2024 10:53:49 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Alexander Aring
 <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] mac802154: fix time calculation in
 ieee802154_configure_durations()
Message-ID: <20240520105349.3c5620a2@xps-13>
In-Reply-To: <ea13c022-11f7-4474-88f3-9ff9169600f9@datenfreihafen.org>
References: <20240508114010.219527-1-dmantipov@yandex.ru>
	<20240513090902.2d61ca02@xps-13>
	<ea13c022-11f7-4474-88f3-9ff9169600f9@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

stefan@datenfreihafen.org wrote on Sat, 18 May 2024 23:49:41 +0200:

> Hello Miquel,
>=20
> On 13.05.24 09:09, Miquel Raynal wrote:
> > Hi Dmitry,
> >=20
> > + Stefan
> >=20
> > dmantipov@yandex.ru wrote on Wed,  8 May 2024 14:40:10 +0300:
> >  =20
> >> Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
> >> 'lifs_period' and 'sifs_period' are both in microseconds, fix time
> >> calculation in 'ieee802154_configure_durations()' and use convenient
> >> 'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
> >> Compile tested only.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >> =20
> >=20
> > Requires Fixes and Cc: stable I guess. =20
>=20
> Fixes should be enough to get picked up. Added before pushing.

Actually, unless the process changed recently, IIRC we should add Cc:
stable when we think it should be backported (like this patch). The
stable team indeed introduced an algorithm to collect patches not
flagged with this tag "by mistake", but they ask us to continue Cc'ing
them. Of course a Fixes tag is a good hint for the algorithm that the
patch should be backported, and most of the time the patch will be
backported anyway. Also rules being often different in net/, I think
even net maintainers now comply with this and not longer do the
cherry-picks themselves.

But maybe this changed recently again and my just lost :-)

Thanks,
Miqu=C3=A8l
