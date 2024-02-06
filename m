Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0112C541;
	Tue,  6 Feb 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209993; cv=none; b=mTo9+/bXK+MEA30xBpz7o9VadJYZvurtH9hNVxho8GQOp/zX3XMQsZ8h8/w/qMtEzPZXb+yBphz8nv/DWEHjwGuW3djYXS+U76NCGHSROl3/h4H7XWD1YRV46lMW6lyFxjKjQXIe14eLvIXBL2rT1NYGAFsFb2c6vEa1F+9ryR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209993; c=relaxed/simple;
	bh=JZWoZl8RGgLWPx+gK8cXes8dw9X6gICGMEVTHwFXxmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APFJg8RP5Tll+VKc6CY0ZCHAIBxPkCCRa35GqAcb4/X5ZPF0YYUyNLAzXw3MCi20GhHC0evI1aYl38XJDm2rPJJ2B17wXpfkx1BrhuZwa9zv4T25fdbjnmY31UXKhFiR15DUU7lLoGLg+UJ+t6RKIVWUtgKqwz5otWNZORwymII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PptRUyWm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PptRUyWm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB9B8FF80D;
	Tue,  6 Feb 2024 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707209983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZWoZl8RGgLWPx+gK8cXes8dw9X6gICGMEVTHwFXxmw=;
	b=PptRUyWmO7ox0PRxfN/ZpDEoxOZV7PAbsJKx7Hhj1pTuY7N2DlPLCByN+1uJhckt+zdTGF
	HP0w0NCPtHRnu5ATO6JpHrlkwZGEn2dkMhixEbGf4pGa9bN92flDK/uLASmlzA1FUNshhT
	ylJH63kzmbqQuIzKHlqAryLLLuCMyqcs7rz2hjnKj+w4ql6cWKXy/twchByZrgsz0yzKc7
	aaJeO3Y7ddz1emEN0kX3f4p3kiKRRcWyz3LvhL0hNf2d0lTnLeBnbRkDWIMk6Gxwj9f2yd
	Ro/6cYsL12dpwlAIidDXFQgdtgKhryK8kuCi/EFrCqzjvCOtfjX5YJabLxmqSg==
Date: Tue, 6 Feb 2024 09:59:40 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <20240206095940.66e17802@xps-13>
In-Reply-To: <ZcF1El7fn5xkeoB1@slm.duckdns.org>
References: <ZcF1El7fn5xkeoB1@slm.duckdns.org>
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

Hi Tejun,

tj@kernel.org wrote on Mon, 5 Feb 2024 13:53:54 -1000:

> Workqueue is in the process of cleaning up the distinction between unbound
> workqueues w/ @nr_active=3D=3D1 and ordered workqueues. Explicit WQ_UNBOU=
ND
> isn't needed for alloc_ordered_workqueue() and will trigger a warning in =
the
> future. Let's remove it. This doesn't cause any functional changes.
>=20

Looks okay to me.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
