Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486625;
	b=E0SGsTdAGJeW/RghlYhYjuREgiEf6ABDTWD9TKdRnmexi7M59M2lraNmnxXTv28YPWDH
	 R7oaDmk+ybqGOW8CWqoEGC/KxpjHsZ5hICUlYNTB+ShlWnpUUZ0xqJ5JckhXMaODjSmnk
	 2jMKV6Q/favWIeO0iqlflmlWY+5ZmAbUPDW8ocoLBZRrDPfUOmfd5lTKW6swRpZo/tcAM
	 Lz7SEw5IOOy5Nw6hyH23eQLmfKVthAs1PtNPPIPRNHfoRVF1n21js8J/jntaOk1kaHH6c
	 SRKTZ2PJ7bOb1F8LMIA+FXoSk+0Qyv4WNHXo9kKoipU3EA+V8o7l0YcM4CLplmStczw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486625;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=bjU/He36oIo9V2EyitAnUUJoY8mbNPh0cMaL0C3XdC8=;
	b=sPRbkc45kXnD44fQmkxLvuzZJ0fPMxxDlgbQehS+JFpJg+Ashebc4YL/3Kl19vs938MM
	 YSubIiGd+G3HuugPha0+gVqV2/b/EIAqh/IuJT+dfs2m2+SQ+paIy4TKP1DbnjNylbSZI
	 Mxf8qHbBsrDSTCzv6V7C10haVRMDLtqjob1scsug58kH/L/zSPPFZ+WUWYvnJJcGdSmvs
	 mZlG0gUrWZIP/021lOHD+hacWIXuaPC6iuDAk3LnKA27wM3wJv9B54ahfv4kxTWqUlORW
	 lonolhTTnz8BYguK+1otTFxndB8B8mVzzWMF1Ow5NzxaGPNMRMOzTUWgZssnBB1U2ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lp8FbzbB;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA0606A31A
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 08:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8FA0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lp8FbzbB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 31B831A12A4
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 08:57:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 054E260393;
	Tue, 20 Oct 2026 08:57:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3427A10328D1B;
	Tue, 20 Oct 2026 10:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792486621; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bjU/He36oIo9V2EyitAnUUJoY8mbNPh0cMaL0C3XdC8=;
	b=lp8FbzbBite8Qcnb/8KMEd1p4mP4M0ImLt/izimRT05Hi8ZoP8iz88aR7CTuuXVmN95GyP
	Ff0MYMk4myKoZWi65xV0rih83CfN6C0T75FGrXDpkuMMtsFTdnkD5y4BwLnFFIYU/zBhsJ
	ccQPvXPXN64PlJHCIFnmmbQYcTQGlCt7Uyc7ySGA3U7sv5aB3NCD65FA9IGleWfHcknY5w
	OXRQ1GaEtN4Pe1LFbuD5w0gi/22V91VUmp7j0gbxx9u5gO4iEYf9mrfcGaKuLFWh3RoB8+
	d64yOseodLio2Y19OB051//PLYsktFSaVIHSbAd24fDIZPxYZFvjxkTBq1fL5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jiaxin Li <18135327133@163.com>
Cc: linux-wpan@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: validate received command lengths
In-Reply-To: <20261019115400.459-1-18135327133@163.com> (Jiaxin Li's message
	of "Mon, 19 Oct 2026 19:54:00 +0800")
References: <20261019115400.459-1-18135327133@163.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 20 Oct 2026 10:56:57 +0200
Message-ID: <87jyncu4va.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/10/2026 at 19:54:00 +08, Jiaxin Li <18135327133@163.com> wrote:

> ca8210_rx_done() computes len from buf[1] but only checks the upper
> bound against CA8210_SPI_BUF_SIZE.  The code then reads command bytes
> that are not guaranteed to be present: buf[3] for MCPS-DATA.confirm and
> buf[2] for the HWME wakeup indication.  ca8210_net_rx() similarly reads
> command[26] for MCPS-DATA.indication and command[3] for
> MCPS-DATA.confirm without a lower-bound check.
>
> Add the missing per-command length checks and drop or ignore short
> messages.
>
> Signed-off-by: Jiaxin Li <18135327133@163.com>

You are making totally arbitrary bound checks. Yes these checks may be
relevant, but please go beyond the very single array access that your LLM
saw and try to make sense out of what is done in the driver. Then
propose meaningful checks.

Thanks,
Miqu=C3=A8l
