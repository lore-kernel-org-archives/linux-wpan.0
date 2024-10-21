Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7951D14FD;
	Mon, 21 Oct 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495643; cv=none; b=OMGTEa1bOr9YV71ZPIlcBBlXW5FYd2e4yJJKmvRJ1Uy0QB2rVuiQdv5Qub5LvvzzMqTTSAmG2Bot0dqP5akgHdqXw87LZBxOOYGWQzgiCddC1hKvyd81XhfEY6/peeYCUnKwcuuDFwZp8MkX2RsSgQxhrwnj8PxSWCN4wdBWRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495643; c=relaxed/simple;
	bh=QF6KY4k5GY0VkT+IkLLmKOGfh6/RS9SVdO/NmhkaPDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YetvsKirto+J7NioDFBtMKxjUDk7mqGLSAv1mPaXVohBA5KWLV0oBxAoJUqQWuDiem3Z0ZJAzejCgqZOHiFQ0wmfJjIHXBaF4f2OaDRpoFL3KNNQaJGtfm9cx3tmO3maHOL6Gx/EfIrmoR6AlAiZfirEUeQUbrAvj7V/+3Rosek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WFbYoJ0H; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WFbYoJ0H"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E6BA4000C;
	Mon, 21 Oct 2024 07:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729495631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF6KY4k5GY0VkT+IkLLmKOGfh6/RS9SVdO/NmhkaPDo=;
	b=WFbYoJ0H/0B9WBzg4BGbisbZwOR/1LxXOqXphTYkIUKa6eRhun3ZoTTZo9r5OwJFsceG3G
	wdm1LtT61mL31lHlgZG4v4a1lAJcpH425fv/NaG2KOuXpknhxxY30mBW7aWlQsTQmomVPt
	esNesj/G7+3Yl2ioW05/WP+dSkc7CQ6tkZhlZJzYMrR4gs8yc8SZFk6ck7PZ8VrKvdyFYm
	81aMBvq2PTug21D75z+89HmCgQ8odjT4ulO6kH7ijWkHmZM7lla4mQ30rmxF+GeeEi4ybb
	ET5mChhe1pu6zcKMOhusSs+2kU9m7dGvpsvDbNPm4K+R8aeikTvWP5ouXsJnHQ==
Date: Mon, 21 Oct 2024 09:27:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with
 str_true_false()
Message-ID: <20241021092709.2458367a@xps-13>
In-Reply-To: <20241020112313.53174-2-thorsten.blum@linux.dev>
References: <20241020112313.53174-2-thorsten.blum@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Thorsten,

thorsten.blum@linux.dev wrote on Sun, 20 Oct 2024 13:23:13 +0200:

> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
> function and remove the macro.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
