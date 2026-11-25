Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646118;
	b=CLeD/TxQ94St6n9Vz3g4W3xI/ZPsNTgB8MYNIhmVINtH/e5egFLhSvb/lH/gH+scSOa/
	 r77x2z0YHvyCMmH28LpSTVeAfwIam53xDCv1A65e0akBIrNy4U4os39u5vuJhv9S4DZvh
	 hv0IoIp/1sWs+KU/A6B1Pv+pvITTeiWnnP2/ykFH09lcw/7K/bUC48JnneCCPP08JzGv7
	 D7krHUT2F2zp+dDbtHY9aL3LsOBXEDzpPDFrAIYlGO97g21qd8S9A+yOweoV6DoaJZilu
	 CxoS3MnEHcPwmEJBqqvpVjW3LZ7D0XH7ycoL0eQQzx7/NhnLGKp6xUexCShEzHP7V8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646118;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=goJy59c94Cs4tzv9h9Aqp74228tx3mJVbRda5/b+on4=;
	b=DCKsK1Nqfm/34BbUwivJJbS0kGAjEwWVOb5EErEnofC3t/2k1JfWglRtKrwrkxFHQBLk
	 LWC8M42lREcce8yxueaL/6qxPlYi/ySxUYYD7VLtiI7D4p0k3GookP9kq7fmd9vXtHMs0
	 8r/1NHPDOhRY3fHd92UmZPhkihOJrW6d9/uc1ZCz/PMsoz7fCbwqnGSaLcOiaexVOZjMY
	 b8Wo2hVq7EzXQdSql8QcOqW7kCyc1XnW085N7Un+yxJPNXmh6a6XIC6nAT8HLo8hOA01i
	 DyEmjjbWUFM45qOZMUMOgr/44CU7j0nNCcl/lNVYvNILedlKBQyeSOCRR8yPkKwblhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=UyKpQ78g;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76D606A31E;
	Wed, 25 Nov 2026 22:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC76D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=UyKpQ78g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795646115; x=1795905315;
	bh=goJy59c94Cs4tzv9h9Aqp74228tx3mJVbRda5/b+on4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UyKpQ78gE0ylMVupVqzPplhHjewa6O/cDvWeY4dFw/Rj9cZ7/guMP3meIw21jF289
	 eYyHzeJF3lF0h1/aH7aWGmOmuVVL9oSPTUNTJsAlGB37yXyl1ti67C5COCDsUwJPxs
	 Uj+o9SCQhw1PFLlsKXW8UdMoWL009THHZOh46CFt527aPzvVNDSZHDYsjg6Icrwm2D
	 qFhLGnbPL7nOzFcHIirD3DPF6oqMF8YwYFr4IXQCxW/2lEAFGcx3ID+GHTkUpNm7AY
	 wWYeZ2r8dQrg9Z0lDIHEb658MNZ7mXwAkk2+AfD2Ybm588kBkkxIPM9ATJP2knQR9V
	 uhQB/sDFqDZHA==
Date: Wed, 25 Nov 2026 22:35:11 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
From: =?utf-8?B?7J206rG07ZiV?= <leegun25@proton.me>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: take RTNL around ASSOC RESP transmission
Message-ID: <-4vARCf0AvznsCw8bnUA-0HXh6HLIvZclkIK_aUJIf4ULKof8WuzgWidE8XZJi5Cndbt9iMVb_IiHNVA4W6GDQlym0Ny8mSRaxRCojci95o=@proton.me>
In-Reply-To: <87se0qqd5l.fsf@bootlin.com>
References: <20261121150835.256812-1-leegun25@proton.me> <87se0qqd5l.fsf@bootlin.com>
Feedback-ID: 167971190:user:proton
X-Pm-Message-ID: 4893f12c8a26393d929d93438b8bc47abf15b0aa
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

Hi Miqu=C3=A8l,

On Wednesday, November 25th, 2026 at 03:48, Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:

> First let's approach the numbers. 4ms is on a locally run simulator. You
> are fixing a subsystem that plays with radios. A physical IEEE802154
> radio would probably bring the usual bad case to > 100ms, and worth case
> would be above the 1s boundary. So taking the RTNL lock as you do it
> there would no longer warn in dev mode, but might lead to a DoS.

Thanks for pointing this out. I also found that taking the RTNL in
the association response worker causes association between two PHYs
on the same host to time out in hwsim.

> Reviewing your patch makes me realize we do something even worse: up to
> 10s waiting with the RTNL when waiting for an association response (for
> which we are ouselves the initiator). That is slightly less a problem
> since it is not remotely triggerable like the approach you propose, but
> still.
>
> I don't remember why we *had* to take the RTNL in the mlme_tx path.
>
> Alex, maybe you remember why?

Commit ddd9ee7cda12 added the RTNL to prevent ndo_stop() from running
during MLME TX.

I also found your 2022 device_lock proposal:

https://lore.kernel.org/netdev/20220826144049.256134-11-miquel.raynal@bootl=
in.com/

I tried adding a per-PHY mutex shared by MLME TX, ndo_open() and
ndo_stop(). With this change, the association response worker uses
the new mutex without taking the RTNL. The existing MLME TX wrappers
retain their RTNL requirements.

In mac802154_hwsim, association between two PHYs on the same host
works, and I saw no warnings or hangs during 5,000 association
requests and 100 interface down/up cycles.

With an artificial TX delay of 1 second, bringing the interface
down still takes about 900 ms. ndo_stop() can still wait for an
in-flight association response TX while holding the RTNL.

As Alex pointed out in the 2022 discussion, page/channel changes
also need to be considered. These are not covered by the new mutex.

Would this be a reasonable direction for the fix? If so, I can send
a v2.

Thanks,
Lee Keon-Hyeong
