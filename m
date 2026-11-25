Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614439;
	b=Fs6NVmFOnmSo5Pf/lPxAfglhoPyuqAZ0kAZR0iP8hkuffP1oWxxm+yXD6fduyaFRgU4A
	 NiaWRRHbKj+UfE0glFkDlluG/i3VCG/xZmQT4YqZEiRtT3XdY/9IjUA2O/GfA4tv1wvrV
	 vKVPHP+tQXytWu8w/q91+RKCYi5DXYfINjdptABYovNDVX2N0YqvtHKQA907efToaY81O
	 hW6lxTdEuCu6/eFRwCIzZiyvby24eQI1rX1AO6t1qSh9vvmZ4rRvQmBA/tEsxCIjtTHOl
	 jnV9yKeCBX/on2TbyKh3F2VS0RkjoYmE2VFaVKZWOM01vH5E24IOM6m5GvsFntTApqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614439;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=dQVo+RJkRWUXi39CCYAbrishKwRW9Uh9wlHTLjDPbzo=;
	b=OyCP79cQnDm3jG9/3FkETG/O7jecEZOj440AWybkkaQH5vQIkSZfIr0EPzHHFXrkpNJm
	 oVFLT2A+HorNPZHQKkV8fq3YMTIR45rDGRTtuxODTR0prGnxWR7OD6pd5L9CidkZ/Dg2y
	 Yclz5NWQcFLsNp/oI/mThj6kSeSgE/o9/Tp/nJO8/ozsxnqiHUXqhuCedJ5hE+tfKde+E
	 BfAlOqqVfDGvMmATl4GWJAhmtFuVV98iqF/xBO010TnIraFW7TMBsgNA8PvWrVjZPSqnQ
	 TfuKi8ca/36xt4ftR14H48aTqJ1FlrWMEMkem0XDM2+CHvpUVPlHdJ3XVhNrzvR8l/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VvgS7Sgu;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A6606A321;
	Wed, 25 Nov 2026 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C31A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VvgS7Sgu
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0F91DC69149;
	Wed, 25 Nov 2026 13:47:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D2C860480;
	Wed, 25 Nov 2026 13:47:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0077611E6962E;
	Wed, 25 Nov 2026 14:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795614436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dQVo+RJkRWUXi39CCYAbrishKwRW9Uh9wlHTLjDPbzo=;
	b=VvgS7SguyalFJpNuYoqMJRlNHyDZDNcc9ApNTBKI3llYdBdsFRICru7mKZIFMWzGiE8MKp
	CcglldnMTdW8qE2zfY/oLdNwCE5RfdyR3OVJ/Ja/3NIHAKtiDtU8cF9OpLMvXygxdJYOGn
	u+w723rHoLjgCWoCUjyFbraIJL/iTDvlYt1NDidE/FHwEGAA8rKvKUjsiH3q232W2D/rnP
	f3VU2qu/nMmmS76qHerOeVAoymBIWPgBvQQapJNa/HjdUb04KW75A+ahJ22Q2igsMJh6FJ
	QqW/AhAtlkej770gQrIl42LekKYGydghp7ynx1XIqSq7rXWTbjdcWj08f7Ilgw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Keon-Hyeong <leegun25@proton.me>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] mac802154: free a replaced child
In-Reply-To: <20261124085905.710751-1-leegun25@proton.me> (Lee Keon-Hyeong's
	message of "Tue, 24 Nov 2026 08:59:12 +0000")
References: <20261124085905.710751-1-leegun25@proton.me>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Nov 2026 14:47:15 +0100
Message-ID: <871p89yqe4.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 24/11/2026 at 08:59:12 GMT, Lee Keon-Hyeong <leegun25@proton.me> wrote:

> When an associated child retransmits an ASSOC REQ, the coordinator
> removes the old entry from the list but never frees it.  It also
> increments wpan_dev->nchildren even though the number of children
> has not changed.
>
> Free the old entry and increment nchildren only when adding a new child.
>
> With alloc_addr=0 the lookup in cfg802154_device_is_child() matches:
> 300 retransmissions from one peer leak 300 kmalloc-32 objects and make
> the association table look full.
>
> I found this during an LLM-assisted code review and reproduced it with
> mac802154_hwsim.
>
> After 501 retransmissions, the kmalloc-32 object count stayed at 840
> with the series applied.  On the unpatched kernel it rose from 780 to
> 1260.  Kernel selftests were not run.
>
> Fixes: 601f160b61b2 ("mac802154: Handle association requests from peers")
> Signed-off-by: Lee Keon-Hyeong <leegun25@proton.me>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
