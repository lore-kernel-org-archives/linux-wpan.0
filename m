Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8236DA02
	for <linux-wpan@vger.kernel.org>; Mon,  9 Mar 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046570; cv=none; b=Ypipzb2klpCDjdTNcCuVyF6rUEMIeEjN5NWiKkXLvvyaUxwXZQZpGIXgWPgzwlfI5pj8LV8hnFdvzRIVuB0DFuIzo0iA04AhdGT2+kQw3tR4JcGcauAaxVfKbYeNtkhV2abknh5GXK9u9La4AMBoSai+eBJVUHUf8WLJ9dxcUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046570; c=relaxed/simple;
	bh=11tlPpTwnFTyOQw1wgwUs3kQCRJtAAlwuHiVJT4IYFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgJUd56AI0H4jbYYeOoYG1Cg3SwDsnjxBhvER8bL+PgBFVK8CVQciz+l4e9kyZK3eabxyec49Q57EIm+iO76qehxjkmiTTgHLGOhGEk/aL5cClF0gueXgLB9kC4gHCM8AfzYJ9ItVkDaGrwac63IfiKakvhof+JxwUETPfQ9Ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XbDj2xhy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XbDj2xhy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC8E91A2D8E;
	Mon,  9 Mar 2026 08:56:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B05405FFB8;
	Mon,  9 Mar 2026 08:56:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EAB710369ABE;
	Mon,  9 Mar 2026 09:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773046562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=11tlPpTwnFTyOQw1wgwUs3kQCRJtAAlwuHiVJT4IYFY=;
	b=XbDj2xhy9DohxFWLd7waC1Pmlf92tPz5ciU2e1nwLgwpnzjErvemmxcSPrHEka60r0Zl4Z
	T29OUXg5Mj5oUPNNOuTlVKC0NXdXBf7kTxUa5vnggUT77vnn2MoF1IYtprC3R0H4phjbXT
	xVPEiqHSDhFw7eJqYpXWYReS9wpwxGasU6r0ZwFy8hjdPpEzU5yKxbjPQxGpv+015Szo5A
	/0FE83ZUlKsm6pOS/hWSCA2Hxxm6/BTw97BSwuG31Z9iC1im0chItp6D/JWy6Mf80+lDCt
	1hdSPMZa7+Lnf2BB2Kpyd5rE+NTjrloHl1NMIU2keGrAx3g8bAMT+3EqQPUMJg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,  Alexander Aring
 <alex.aring@gmail.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S .
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
In-Reply-To: <20260305104313.15898-1-johan@kernel.org> (Johan Hovold's message
	of "Thu, 5 Mar 2026 11:43:13 +0100")
References: <20260305104313.15898-1-johan@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 09 Mar 2026 09:55:57 +0100
Message-ID: <87h5qpgz4y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 05/03/2026 at 11:43:13 +01, Johan Hovold <johan@kernel.org> wrote:

> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
>
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

I'm not qualified enough to judge how useful that can be, but on the
other hand I don't believe it will hurt either, so:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
