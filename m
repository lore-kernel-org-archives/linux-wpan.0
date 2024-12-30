Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C919E7F7;
	Mon, 30 Dec 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549544; cv=none; b=C7WPWBPQOJ1ekxcXkxjBlniugvjKrXsX+9GhtHC32+UlwnbqScv/KrFdSXwH+TlJks45RbXUqLapKBDDGisMyGQC5KADS7PTTOCharqNNoRs2Iy5Oka6gvbHgPEtkZhtp1UQ+UYmKDRildcq/7BaymPAHv1b9rcxJMbIgJ9qj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549544; c=relaxed/simple;
	bh=VPtk7k/0XSXxj0VMk53so+IUXRcKgGHEGfEa+ZJMsZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgO94zw+iK1PrWudsDoDQBIgWan2ae1Mi+hHgg5jseIG0IfL+23fnkAKs9uh4O/QqH8Ss1Cs6o6zsuiIBx9z6/ptfMPIX2zmCm4SmV0mThyqaCix/rgXUQ/tELm7Mdl4C/tJF4iHSxaJ1qoq8BZ0BYkN6LSzzxU0m7nnpuphA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bYSGMhzs; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bYSGMhzs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6832BFF807;
	Mon, 30 Dec 2024 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735549534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPtk7k/0XSXxj0VMk53so+IUXRcKgGHEGfEa+ZJMsZo=;
	b=bYSGMhzs/KRr44tCUCAG8aRGMON5HLZfzU6ujK+BxEebDdMqBaiPB1N7I/fHfG7o0eJQXK
	TqOtgizJa9X6S9uMqx6t4sMpXbVTlv7QN7WrrVSB3dG4vULcPHbM6ebjurdIvjF+tJxKhX
	J4naHtXaOPtkMtOUaDTpt0q80XuqmMe3z8ApvGDIAfAKmM/1DGJmSdZ7VZnyGLNcdw+BLC
	q9uQH5CEUwg1/N75Ds5rMjRzILHf8gmcaXRRMJkU99vW8MsZQ7S63uQV+IIDE0+93yj383
	DkOP037sWgbLrSUnCyXmuU7xRU/h8ubiEYVJNcaai0/7PAnI7XkX4XHbq331kg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux@treblig.org
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: mac802154: Remove unused
 ieee802154_mlme_tx_one
In-Reply-To: <20241225012423.439229-1-linux@treblig.org> (linux@treblig.org's
	message of "Wed, 25 Dec 2024 01:24:23 +0000")
References: <20241225012423.439229-1-linux@treblig.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 30 Dec 2024 10:05:32 +0100
Message-ID: <8734i58rs3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 25/12/2024 at 01:24:23 GMT, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> ieee802154_mlme_tx_one() was added in 2022 by
> commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
> commands") but has remained unused.
>
> Remove it.
>
> Note, there's still a ieee802154_mlme_tx_one_locked()
> variant that is used.
>

I don't remember what this is for. I didn't find any use of it in my desper=
ately
downstream branches, so it must be a leftover.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
