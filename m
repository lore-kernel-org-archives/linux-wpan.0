Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163152;
	b=IWFS7zvgOV/cki7tC9GHAg+qSyUtH1KXUiEARoqditG17vam33kfW+qWgyzgwa/67CY2
	 NTwjCXxRzCilat0Z5cXiSmhVsUSL2xFaeos5LCmrfAGiILDRYELjVA9SJlkChuORQeu3Z
	 4tDqCFaKogr/ON4xXD23aNctNTVWKsILjbB+e8CruE7a7DufvWrO0Brk3N+24qYJzi89s
	 bt1iYQir0XR+YBG35CV/l0WcB0/w6pzrGnydO3ApUTHTL9XkKC5VcL1a/fVXTbu9D92ho
	 gffZ4gABtU9Z5Sp5yV4ideKEw4wJLHEIAMf6VhD0mBKEoW+7j5u0J9PnIxFCjJdL40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163152;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=IC9XMH+T2hnZHNkyr7/NV6aB8tE9x3aA982mVIUmLFI=;
	b=G5+1O+Vf65j0vt479d+pdlCjEd47w/DsArFU+P+pGYFHuEZRNzJQST8bwjxvSMB5X2HE
	 amjpHMHhIIFNw587qzgnunN8rLwu+MC27YkUXTN/ToGtX+lwHj0PpPD9iusxYQae1Fgi9
	 QICgH8Hro41fdRzddpg6srBY9oQ8+q66UVcP62pS+n5/sL0NbzyQ/l8u+AhRt/uDxluvq
	 xx8qmRcDVlPebumbS+awWiOsHgsYjQuKw+nA71SnN2kCx+igwyMoFbvcC1CfFNRz0DTlA
	 q/gCnJSdAesAZCVsKnDjIds/5mJUj8nmj5o5totraSJL6Kkhkt4Ac0zfx71tqPh2AGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C+KX3P+q;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A745606A320
	for <linux-wpan@vger.kernel.org>; Fri, 20 Nov 2026 08:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A745606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C+KX3P+q
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2118C2F4DE;
	Fri, 20 Nov 2026 08:25:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CE5D6017D;
	Fri, 20 Nov 2026 08:25:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5631211BC10CA;
	Fri, 20 Nov 2026 09:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795163149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IC9XMH+T2hnZHNkyr7/NV6aB8tE9x3aA982mVIUmLFI=;
	b=C+KX3P+qdxZTebUJj5kTuArH0nr5DdVrMljfMShhv4ZQkkvQmh8XFoOYYT5Gt3LPhZiM9o
	vfkuLqmx66pngGFQQ4mPDgEn/YZ0KIlBd3apXmSY9sUpob/KXXqw9iff4uyhA27B/GD1Px
	IRrJ1lorLU+nwb22GKCylXJqvlqrFjNp23cXFT7QZW2umiHhcZTyVVjbUMsuCRq9zStyZU
	EpydEMxuNuKXRXskHkHeRLlEPNx9S30Zej/SHsg+4rnTV16LodVJa/J2j2D2u/B6ghCUgp
	JqIojmp7TyudUYI7SBRJ9eBAd2qKZtximNx6LHx5zcYka9Xxlk9m3CCxIY7gHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrey Misiurov <amisiurov@cloudlinux.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ieee802154: keep the original error after a
 netns rollback
In-Reply-To: <20261120065750.3274661-1-amisiurov@cloudlinux.com> (Andrey
	Misiurov's message of "Fri, 20 Nov 2026 07:57:49 +0100")
References: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 09:25:45 +0100
Message-ID: <87tslbc3jq.fsf@bootlin.com>
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

On 20/11/2026 at 07:57:49 +01, Andrey Misiurov <amisiurov@cloudlinux.com> wrote:

> cfg802154_switch_netns() moves all of a phy's netdevs into a new netns. If
> one move fails, it jumps to the errout label and moves the already-moved
> netdevs back to the old netns.
>
> That rollback loop overwrites the same 'err' variable with the result of
> each move-back. The move-backs succeed, so 'err' ends up 0 and the function
> returns 0 -- success -- even though nothing moved and the phy stayed in the
> old netns. nl802154_wpan_phy_netns() then tells userspace the move worked.
>
> Give the rollback loop its own 'err' so the original error survives and is
> returned.
>
> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
> Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
