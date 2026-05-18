Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82013F88AC;
	Mon, 18 May 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105407; cv=none; b=JG9dj1TR4l+KmOkTK1zeqPBK+fMcw2U9qIoCl7C/HsrLqgLPV1iaE3E8E94tvaiUtmSo08aZWei4+yg9a9GVA+8v31pXj3hDpUs4d2J9RAaH3LyyOfzRlppq73+9ja08+EknEHujA4UHYg+p5ErTdA66EwuPyUZEB5r9Mahi7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105407; c=relaxed/simple;
	bh=0lRi5TC10tfwVZPqC59MI4zysRNQoBCeqBGlQwSHOrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MM9/uti1Sq4EyvHPhGjVH24cBxMw9ZbhKtlRpMzh98SRpuSIFKLqh3VV2GaqkI6dUdxmM79wHU8bQurosravVJaNx4kpHzjNSP60KHRERTx2xN3OZlMgJk4KXtOcK/U5v4W6tjzhXkQ35o2innmoZPoGrMUb4RJsiuWd9M8wFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xvt6Y9FL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xvt6Y9FL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 47EC31A3607;
	Mon, 18 May 2026 11:56:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 141DA5FFA3;
	Mon, 18 May 2026 11:56:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F04C411AF84A3;
	Mon, 18 May 2026 13:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779105402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pxpe7iIx2G4tBbQyj/ZO12IXMY9/CrHISr2PmrKBAzU=;
	b=xvt6Y9FLrhmACZU/qfPnfqfPTSG4UKIrKL6ikRnt29aVnqkLQK6od+RVu0EsMBb0gFcSde
	4OWaTfsiDyNfqcoEaTguZZIMHTfDhd0/1pishD0kftaME/kwJcTjdM8OaAXXe16focKkP6
	0OUWBAbLphH8+Pxx7BhrgtCFWk0721oiJLbFkU3PZdoNHrNzkVjE4gvjcgCDswKFnRNF7M
	JvvhQZwwkyn1Uca723m2nHFampilLTRogkItw+m2kPY8eRHqmxG1VH9hZWzxp6yrV9N0yA
	ZVwgS7tnYuzjpqTOmoN8NDG9dvMFDVnimhkWemMzVIlrIBUlkWGVKt3rmpmFrQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David
 S . Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Shitalkumar
 Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in
 kfifo on 64-bit
In-Reply-To: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
	(Shitalkumar Gandhi's message of "Wed, 13 May 2026 21:04:12 +0530")
References: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 18 May 2026 13:56:33 +0200
Message-ID: <87qzn9szgu.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Shitalkumar,

Thanks for the patch!

[...]

> Found via a custom Coccinelle semantic patch hunting for short-byte
> kfifo I/O on byte-mode kfifos used to shuttle pointers.
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device
> driver")

I don't remember what the net rules are exactly, but this definitely
should be backported:

Cc: stable@vger.kernel.org

[...]

> -	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) !=3D 4) {
> +	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer))
> +	    !=3D sizeof(fifo_buffer)) {

This line becomes unreadable. Can you please use an intermediate
variable? Something like:

          ret =3D kfifo_out(...);
          if (ret !=3D sizeof(...)) {

Thanks,
Miqu=C3=A8l
