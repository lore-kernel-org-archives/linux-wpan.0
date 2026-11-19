Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121590;
	b=Tn2QTVun6LfXvM4wI4JqC0/RW5gdfnhs5qwfpk8MtzK8ST8iu+IPgi9//EvSr9MT3uUd
	 d0TPtgQXFbRFreas+nqMo4Zs7jz9JLrHmpSOPT+bbIv6R91itXt3BdDbMjR21IHrY8+8f
	 sNuBlBmv2yXNoBZtStCuQo4NIEqEhb02nGhp5NdCHV+uV/dM3h+XtIG4cUWHoiSp5haWU
	 V5qI1V95pqJETYWJXoZmpVdWDemG6dNpgoxzFpeJ+SlfokingLXEQgl6A6Dza7AmUTtKF
	 H32xuogKfbgBKXKoKMDuPQsVy6QUhMuU5r9Qgkiid8O3nxx0v9iWLR947wAh4MUjK+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121590;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=bhQV5Yxj7EHBlSO67J3AjWtG+BkdwCTCOMv6otj2Ow0=;
	b=qjZiLFyk49ydUIZFc0S6MKaosfUO+KKbGhUkQp0nfNuZloaILQMuDkuFB92D5pomKGAw
	 g0uz+1RGPIqCujVt6gWOXAoViPj2lmAn8l68uoBFW5bNTDHr+wjA6R4/wx8NUC0cilJSK
	 j9v2uWIJDaNOyW8wX2mRIRCdHSGGLIvaq4Z4w+i/j4pqkMo5uaUo/SIvcZPXKObMuG9yH
	 cNRYrpbO/T1l8SFFMPJp9RCUmVWCtjFYtM7MqpC6GE/WiTg9BgKQcwDfE/AByyZwgpRlm
	 Vksvgcw00lUR42AK9yi2Do5kZHPcC6wjH1SlRc5+ejq35f3XjPhIql6HoA20Ocdg+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yWovXsCL;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D048606A901;
	Thu, 19 Nov 2026 20:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D048606A901
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yWovXsCL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C55E44E41674;
	Thu, 19 Nov 2026 20:53:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 894626035B;
	Thu, 19 Nov 2026 20:53:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3507411BC0E78;
	Thu, 19 Nov 2026 21:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795121581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bhQV5Yxj7EHBlSO67J3AjWtG+BkdwCTCOMv6otj2Ow0=;
	b=yWovXsCLMroYPdQQehh0R52sZplMpO3lhiFSbOiM1K/uIjSvuxCqxC0IOjO31Qu9h1EpEF
	CHQfBFtZKOSMqFfP5v0U+9QE3LKYgY7cZTSx3mydjnxeo3y9j5sAr9usrnVf+0dJ/m4FqZ
	OOMfi4qXo33VwF9sVtULZClWd5fPiHGr/XSrT77GbbqG07MlBylWqzRqtEcKgFGN7zxMW4
	AqI4OcEJlcOQd1HQyZWmRfgO+pbDqla1q/HPwGYF6tzQ5slrJ4fY/SBrfeyB/ef0ueG4Xd
	OIAW9/qHNpv18oPKscFMkyUt/diPgrDB4TkjHTUL4wr4vOksk04FNFzBE9bBhw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrey Misiurov <amisiurov@cloudlinux.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ieee802154: keep the original error after a netns
 rollback
In-Reply-To: <20261119172413.2068073-1-amisiurov@cloudlinux.com> (Andrey
	Misiurov's message of "Thu, 19 Nov 2026 18:24:13 +0100")
References: <20261119172413.2068073-1-amisiurov@cloudlinux.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 21:52:57 +0100
Message-ID: <875wxsczme.fsf@bootlin.com>
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

Hello Andrey,

> +++ b/net/ieee802154/core.c
> @@ -222,6 +222,7 @@
>  {
>  	struct wpan_dev *wpan_dev;
>  	int err =3D 0;
> +	int ret;
>=20=20
>  	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
>  		if (!wpan_dev->netdev)
> @@ -249,6 +250,7 @@
>  	return 0;
>=20=20
>  errout:
> +	ret =3D err;
>  	/* failed -- clean up to old netns */
>  	net =3D wpan_phy_net(&rdev->wpan_phy);
>=20=20
> @@ -264,7 +266,7 @@
>  		wpan_dev->netdev->netns_immutable =3D true;

Shall we just shadow int err in this loop? the current implementation is
correct but is a bit strange (having ret and err next to each other).

>  	}
>=20=20
> -	return err;
> +	return ret;
>  }
>=20=20
>  void cfg802154_dev_free(struct cfg802154_registered_device *rdev)

Thanks,
Miqu=C3=A8l
