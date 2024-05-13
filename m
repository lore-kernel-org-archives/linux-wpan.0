Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AD1FA1
	for <linux-wpan@vger.kernel.org>; Mon, 13 May 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584153; cv=none; b=H7amXlfN+TsE028z2LPTplf+EDJkDaj4xqBQNXI4VmRYy99oLt8nxhZtYuGGCnvK56lewJb4BLCbpvfWbCyq9eDNCUh9/rm+HWZHJawRl6JEuhLftqBnN3BJ3yAAZJayu6UE0kOxHyG/XSFWrsz9o7iD0IrdlL7jC10ZnZfLwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584153; c=relaxed/simple;
	bh=Noz5Ic90A+qweS4CkmeEQ9vWnlduobx1k685mlf30MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJl20esOKvKUEN3dQ+xxlleUT1sh/MuLP+vT88RVXVGAG/68FuNLFeb3IzXi4LT9BjtIdVydjdhUvBZFGjjerk80rTZQaj1EKJ+4p4IT7M1sPx/F5wEQTAN+lERNif/vqgeUtiJJB5dVCXyXgVvmcbl27W2UncK8BJMr/C27Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iGm5ut3r; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iGm5ut3r"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EFD320013;
	Mon, 13 May 2024 07:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715584144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H67D1OmhMRPQ3mOdup0RhKyHTuX1TcxAN5gm9xPh/80=;
	b=iGm5ut3r7yUsNESfOj5hug5korYg03aXilBYAlD+iDFojjcm4KxKkLBP6LBAEcuO+/l/L7
	F9u+A9K9Bcw1KZfvqrEyLndQ8ZkDgOnxpaxNuFJNRwNXcI3goqaTcTpWYpvbKXpGKLB3QF
	9xdIlcSTnCXmysGPeTBVLJMo+8Y3Gx+cWMEAl1Dl2aN6vrsIAVJIaXfnQASZlfi2j9sYuT
	xVU9DBNe/LXa6UhF6841yBQZLi8pXeIMVg3HXsGSSMGwFnKlZ/okEs2v0IPjkThvmGSc20
	ChbKACvWYvDbIdtRO+ZVn+9GlY7nsQBNJ5qvjMW7Rhbw4z8p4aEp0mvq7IpeGA==
Date: Mon, 13 May 2024 09:09:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 lvc-project@linuxtesting.org, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] mac802154: fix time calculation in
 ieee802154_configure_durations()
Message-ID: <20240513090902.2d61ca02@xps-13>
In-Reply-To: <20240508114010.219527-1-dmantipov@yandex.ru>
References: <20240508114010.219527-1-dmantipov@yandex.ru>
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

Hi Dmitry,

+ Stefan

dmantipov@yandex.ru wrote on Wed,  8 May 2024 14:40:10 +0300:

> Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
> 'lifs_period' and 'sifs_period' are both in microseconds, fix time
> calculation in 'ieee802154_configure_durations()' and use convenient
> 'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
> Compile tested only.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20

Requires Fixes and Cc: stable I guess.

Otherwise LGTM,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is also a candidate for wpan, so [PATCH wpan]. Stefan, Alex, who's
handling wpan this release?

Cheers,
Miqu=C3=A8l
