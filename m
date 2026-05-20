Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BEE3A545A;
	Wed, 20 May 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264709; cv=none; b=tNfamEQxsHpLcxcPSPLlKcgORErExOC1Dm8kDNae1MfLcShVXJV39vJkBZ46K6KUnezYKFLXsuqpIB6Rnp7x94Gf7lH3xvf9dL5loOezdiQds7LJJMvAIGePVs/Rf8dkxnuz4b3nNiSKdzI0GsLbiAVN2kspn4xYopkZzpy7I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264709; c=relaxed/simple;
	bh=Fdxm3Vn1AOFhUkYyB44/D2Qh3Bnq7xCWi1/UeH17wX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBtBH/TzgyCWHGxPf0r99DtSZrPlE2ubZFJ4sCB3ckef9nbqk/0I2supHd9dD3J7oO0ktT/D4TGERnaZDmgdMa/OPSvqXda4uBUCzji75flZsVVh9TVDDBHVE3ar5/6B4s8Tp8i0IGLCmItsf4LNULeQq7QkMWq/P79jq4w5VEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KKgYZ1gv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KKgYZ1gv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0D50AC2B9FB;
	Wed, 20 May 2026 08:12:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70E466070E;
	Wed, 20 May 2026 08:11:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2F4B107E9D89;
	Wed, 20 May 2026 10:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779264699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DdZv3J2pCE/mvIb6zkVmZxOxqGg0ys9/r9v2yQA8PjE=;
	b=KKgYZ1gvW6m4Xlq+HRrCKY9ejhnura8Ve//r/VOSTko+5kMC61kLF98xFjwu3TxpRt2LpU
	vzTHB0WTQHDPml6chbEAsSrxP13i0vUZN+QAeUAwM125kIEBMmTCS2Kb+6TShkQwDFsElC
	k5TqlwLHLDbDH+Gmyf3AKHa07k5bHviOFe8L4PlhiMGeKV3V+ledm0jR8QBIQSUiBGuYnd
	dmWa1eFiHWaL5P88xV92AhcebXzeS5B3TV7qxGTDyEG6qGPh1x9vDkkTw+zPQ6ZyM+mXkI
	Q+2uTaTuBfVyvtG406wl9McJF6wJsa0WcqrKv14cDTiECULWwxQWwIdbZ8gHIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Simon Horman <horms@kernel.org>,  Andrew
 Lunn <andrew+netdev@lunn.ch>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org,  Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in
 kfifo on 64-bit
In-Reply-To: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Wed, 20 May 2026 10:37:07 +0530")
References: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 20 May 2026 10:11:32 +0200
Message-ID: <878q9esdor.fsf@bootlin.com>
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

> @@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
>  			!kfifo_is_empty(&priv->test.up_fifo)
>  		);
>  	}
> +	unsigned int copied;

Why is this declaration in the middle of the code? It should be at the
top,no?

Thanks,
Miqu=C3=A8l
