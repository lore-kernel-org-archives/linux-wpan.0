Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA483783C4
	for <linux-wpan@vger.kernel.org>; Tue, 21 Apr 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757959; cv=none; b=E3duYShe+gSYObGzbOUwPemQFAvbF/OJrMi0dxkemP+DTaIPtqMuskamPm5YheC4eo8GdCX8BabBUlyoD/P1wVMjtOrMqz9ZavjgTLf3euN21xQeRyDXg9PezuyvS4rqATwMD0kNlnYrHr4cUWQaqmfOB4jVjMzARknpViRCBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757959; c=relaxed/simple;
	bh=1UJdStWuXc+3P6vByY9wa8GVOgl0OgdrU4BHWgXWlrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtMcAOz38wrdmzGyX1x0EMyNZ0PHL1+IMyn4kKm0vuyjmVbW9hI8RMf2S058VnUdMRWWf+5xoxtVisraty+84YcSFe+OzgBOf2xnq19WgySje+G4dUl6ShieQzqGpj1IpMdPThf0dNLmqhyJzKbv/Hg3nYKD4St3yCIZI/CRbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=deiTA/zq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="deiTA/zq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 262251A3380;
	Tue, 21 Apr 2026 07:52:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7DB7600D2;
	Tue, 21 Apr 2026 07:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE1E910460A02;
	Tue, 21 Apr 2026 09:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776757954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1UJdStWuXc+3P6vByY9wa8GVOgl0OgdrU4BHWgXWlrc=;
	b=deiTA/zq9+xnKePVLAxop9BBN2NUkb67CAWuKL2Svmbf66rzR7fvRlfOSZAQNIdf7a8MTo
	I2DZMsoiaNmYbIiMw3kl+95j8AQPbW0z7O76zMkvPylYlGWiFXcPZLNPWIasnTAOTAGxOB
	KOxXPnlwULLTzpl2hXhfPd1UmT1xecTcXGNyGQCP7afVWITQ+LAGGjSmuOJt4wlFB6ttWg
	OiX7+OqRo1m1PKL5uF6uWbUYCYriU1dCXXp/PXSGVb4T7OTIOAQ6RHhjB8lt3CcC1xtuQA
	h9JrUFjl9ZmhMystswXLe9FrmeC1y/8hF2x6REQ0yw4loTOlLAv0zREF9/1wOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
In-Reply-To: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Tue, 21 Apr 2026 13:02:59 +0530")
References: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 21 Apr 2026 09:52:30 +0200
Message-ID: <87340o7nsx.fsf@bootlin.com>
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

On 21/04/2026 at 13:02:59 +0530, Shitalkumar Gandhi <shital.gandhi45@gmail.=
com> wrote:

> ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
> and relies entirely on the SPI completion callback
> ca8210_spi_transfer_complete() to free it.

[...]

> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
