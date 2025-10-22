Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE82FDC4A
	for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125083; cv=none; b=NM7kxA2y8L5PmK0UoXgUbmhFBVsVe/7kliVHvNQqnIES6p50m8x4OWEH4C1oLiZKojFsOGUwVn/eMiIeTVfMUI8YIlP1tOjwTbPBfIZRtQs3F4GZ+74+PGzDyvh80pjMnzUql6BjO2/4GDO+YTlz18ZQSBniPM9AlV8iSPg1HjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125083; c=relaxed/simple;
	bh=ntaNBdvKJwuR+IMdAsMBbtfcIVIdX5f4IGUpZQnNP64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BQinli8l3K7JmrWrwsmL2xORizocz4gGTpH401cvhDY+Vp6LICKsXXYBrx6q8RBnG2H5bZWag0aSBWSSzXVS3c2zTRNXx7h9ldEeTxh/OMXAr9S79gi6RAb660xhQ5F3Hjv3YDAgZSjfrsK3fz8aR8Hm1PDYGcS4XvotfEj78Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yKAQuWUc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yKAQuWUc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D40194E4126D;
	Wed, 22 Oct 2025 09:24:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B36C606DC;
	Wed, 22 Oct 2025 09:24:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F014102F242C;
	Wed, 22 Oct 2025 11:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761125076; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I/jCJmMPMaHx+VwiIpzUr0FsIJF1KiSAuL0aYSClYS0=;
	b=yKAQuWUcA1u7xDpkvUh7EQtHd9HX5RVl8Ez5JCn02qPfIBrSvRSG1y0NZS2+aUNtsxn7l6
	Hs/OJb81q6vsneaObe6J3zedJS6kRjAm2ifkKY7H9RdPBkg7a5Y+o8NRhjWInP4qxbhKqL
	QH2rnX8yX+z5yyqRsfmnNoQqp7UvEqcTqdw9Hd7x2bX34Cah8WwIKIUr24B0SoyPI2VfGm
	K8fW0z5gLYrbNK3hB2sbO5lfEIskimlOYC4lszkr0mTQVYIuwWGaL4xC8C1qj5/G+m+oCb
	W8JQZWyi+4zVAmiQMq2yU3oSVTBELRruhRyo2AfREry2nQ3q0eQafpvjydHPNQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,  Alexander Aring <alex.aring@gmail.com>,  Stefan
 Schmidt <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] nl802154: fix some kernel-doc warnings
In-Reply-To: <20251016035917.1148012-1-rdunlap@infradead.org> (Randy Dunlap's
	message of "Wed, 15 Oct 2025 20:59:17 -0700")
References: <20251016035917.1148012-1-rdunlap@infradead.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 11:24:28 +0200
Message-ID: <87347bthkj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 15/10/2025 at 20:59:17 -07, Randy Dunlap <rdunlap@infradead.org> wrote:

> Correct multiple kernel-doc warnings in nl802154.h:
>
> - Fix a typo on one enum name to avoid a kernel-doc warning.
> - Drop 2 enum descriptions that are no longer needed.
> - Mark 2 internal enums as "private:" so that kernel-doc is not needed
>   for them.
>
> Warning: nl802154.h:239 Enum value 'NL802154_CAP_ATTR_MAX_MAXBE' not desc=
ribed in enum 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MIN_CCA_ED_=
LEVEL' description in 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MAX_CCA_ED_=
LEVEL' description in 'nl802154_wpan_phy_capability_attr'
> Warning: nl802154.h:369 Enum value '__NL802154_CCA_OPT_ATTR_AFTER_LAST' n=
ot described in enum 'nl802154_cca_opts'
> Warning: nl802154.h:369 Enum value 'NL802154_CCA_OPT_ATTR_MAX' not descri=
bed in enum 'nl802154_cca_opts'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
