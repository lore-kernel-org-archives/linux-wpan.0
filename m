Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910615;
	b=L9HjYmUcI5lJppAZgc3HqAH5CnPwTfeIEywbEUWi3aMwqc1CA0HLyi1ZP8HIVm+vwfim
	 ZsEnoPPgtPXf/Mjjg8aLD9yZKFk0RnlK85LHbA5bLulXLM49ABT7HOndwr+nNE90rJk5L
	 Z1DAZbvUFPHDQ+09d3/pRUBCO6BsOfJw0WlintXiqxnl41Y3oOYX2pByWM5k+ZcLQKmkS
	 DJ/tzzT7c+qHVO7RkgtfpaCNE9uZ0zUvWiryMQorKCF+GRC9kOfDkRUh3AYfUi1swi4qC
	 +mysVidhcnfIzfuxDGseGq7xiBsz41b4GCMKlmG7wiT5qeDRgknT/Kx5ebd7Vhg/ILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910615;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=/yULjHrkb4hwM4FdkPiZ2o9LDpu8AeCzRvhmR///Mq8=;
	b=0k9VXJSFc0oMHoT4S6bH+dYDFvupNXj3qRt6uUtjJWwIlt1wX7xb7xx9IiejkJOjdBa6
	 v6PcLfYEbUfEmlxkJHgt0W0t85UgaRY2rGqelSm+Rc/rZEeMbMR1MlzdAkbHtaFn99tlf
	 ATVKsR6I/1v/GDEoY0tRQZ2iTBmPnQCD4ciIcS6ziGsvs20ESQNHy36TW23WEcN2Rl2kw
	 6NXdMsV6Ol3pjkbK3OFM92+MD6Up6wurFHwxbWR5WnudyP+wLOWEUioJdCs8MAYwJ6qwp
	 eXLUlaWIQuTRhAfQO96h5JMP6AffP4W9+tzHcorksl29HNhuUV2A5rKI2ibOjjBqybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Yukzvv8i;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE44606A33E;
	Tue, 17 Nov 2026 10:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE44606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Yukzvv8i
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54899C4D3D7;
	Tue, 17 Nov 2026 10:16:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C80F45FC81;
	Tue, 17 Nov 2026 10:16:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B922C11BC0493;
	Tue, 17 Nov 2026 11:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794910610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/yULjHrkb4hwM4FdkPiZ2o9LDpu8AeCzRvhmR///Mq8=;
	b=Yukzvv8iX5tIxIesYK4K66Yczzr2qBqS/BGaI+miClApiU0uedkLgaLvlUeUAO9W3wIaK7
	RsOfdlO+Tuy4LmL9Q0GvEu/Lqpjor7nO3xo8qW8Van/hknyIFykY4RCm1tzjAwhkWfZBdG
	eT0WzPTnhTz2jqW7SIaXGVxMlXmKmRDjCxMrnPvsHNGFI8aRgMFRHJgvqFH+ztCye2JfUq
	5DvhNtgOsSXtf8e83izlYU8gh5S+A7ALy8IJm7lqNoQddMOBVvpzTbKpYUKOB9qlYCqGjS
	rnCFUsJdNjC5ys6J4mbx63EZ6flNVrdRm2U4cNgmQI2xXv6Srvb0wE8IZ/4B7A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: hwsim: fix edge allocation leak and netlink
 attribute validation
In-Reply-To: <87v7809ivq.fsf@bootlin.com> (Miquel Raynal's message of "Sun, 20
	Sep 2026 15:01:29 +0200")
References: <20260919223434.3882824-1-benquike@gmail.com>
	<87v7809ivq.fsf@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Nov 2026 11:16:47 +0100
Message-ID: <87qzgjn4og.fsf@bootlin.com>
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

On 20/09/2026 at 15:01:29 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> On 19/09/2026 at 22:34:34 GMT, Hui Peng <benquike@gmail.com> wrote:
>
>> In drivers/net/ieee802154/mac802154_hwsim.c, clean up allocated edges
>> and phys on error paths and validate netlink attribute bounds.
>>
>> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
>> Assisted-by: LLM
>> Signed-off-by: Hui Peng <benquike@gmail.com>
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

The commit message is incoherent, I would like to withdraw my tag.

Also, this is the fourth time we receive a similar fix. I already
reviewed this one:
https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.co=
m/
For which I wait for a v2 which never comes. You can take the feedback
sent there into account (still applies).

Thanks,
Miqu=C3=A8l
