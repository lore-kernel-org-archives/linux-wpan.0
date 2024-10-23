Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DF145B0B;
	Wed, 23 Oct 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671216; cv=none; b=KgTTW0q5imlCtRUVVQMcsNxkrytR7urXm5eJpgvTwHA8chPtmtEcYHOowaGiyrePEuMePd2v0EUr9xQWYfBVf8tmzy6+oT9lxS/9l3YnkxIHEh0pMEoZD9NFem9Rhv4JDnBH5WpHT1vRCPzNeYmRPhpGzgTKvii8po+fVP9RO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671216; c=relaxed/simple;
	bh=Y6OB0T9eVIvbtDeAbcfkqhd81lAUoIF0KWm/CGFLIWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAuXkYnIXzt8hfiTo0yczwFEW0tyZdP+xa17vPOZSuKkQ51q+9kW9LnfDs2wnkJi07PCy1W16BSH5mYw1l5e5FcZsShtYhe00aTc+q00m363Q5SkTSI0RfdSWmcMetfD3vz9WhQpgarTNTK/vS2Glqz1iOaINeyeweSHLlY43aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=alkkpS/n; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="alkkpS/n"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFB5A40003;
	Wed, 23 Oct 2024 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729671212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6OB0T9eVIvbtDeAbcfkqhd81lAUoIF0KWm/CGFLIWA=;
	b=alkkpS/n4/Yo8gi382U6tXaUlltsCAaLaVUx2WsFBYA1M3CNqjrVY5zXwPyFnBmosoS61f
	w0xIS8PKTr0dIhX9p+Mvn4NyBReYAq067qBVPCRnzqVp1AiwZD0a4PaUbbBOtMrg4tMuxb
	EJgsG0scBhK6Ia0g03DGrPv+s+rKjyGmwvCt+6oceXFIWduDE1KD5DEd7cptVE7Wt8ReP9
	8mfzV8/fikF4uZ8UjEh0I0EWXFLD5rtoGf7eST5Z1SSixeNi8LDzfAdGp/aQLXtR32XuA1
	LRJ1YODU5PvTiXDi5uojItflSBHSG8mM7QTB3AjRaJhHZPCvYL1oR2Yqq0X/1g==
Date: Wed, 23 Oct 2024 10:13:28 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Leo Stone <leocstone@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewmail@gmail.com
Subject: Re: [PATCH net] Documentation: ieee802154: fix grammar
Message-ID: <20241023101328.76bb70bf@xps-13>
In-Reply-To: <20241023041203.35313-1-leocstone@gmail.com>
References: <20241023041203.35313-1-leocstone@gmail.com>
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

Hi Leo,

leocstone@gmail.com wrote on Tue, 22 Oct 2024 21:12:01 -0700:

> Fix grammar where it improves readability.
>=20
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
