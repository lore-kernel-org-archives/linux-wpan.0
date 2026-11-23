Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475649;
	b=ZwskIHdlvqePJ6Ktgak/4cvGfheqAYQ5ncn/rM94X+HGgVqrw32j/xWPMmKeL9F52Mpb
	 8ymuJuC4rPUVlnhQKovSWcVuy238zCasXC7BQwzk2cPZY0GXDxb0p1BcVdkRg+w/4y3LP
	 ZCNHVuIkrdxy0Ix0ED6szlqnqdwUAQhSBVgYAwpb6gGd11t3cAOcLQimu9/rURyIhDCV4
	 8XjCW+GFQl2G7mlpVjjIsNDZPHHztE1dx7jdDDfrMZCJU8+xpdHP1hyT2vwzuOvYxeZli
	 biM99n4wfusUdyVPTGE/iKbMTWvULfVONSnfVwj1VFR4UxlDD9rp3yMHcc5hz+cS1OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JPUPthGap/e3ZUgIbzXcpl0zmaDMBGPupHW0i1UrtNM=;
	b=gRC1A7cy1PSZ0sH2va16R5qo/U9HmyauQ2Qx2R6FKMx8CZcSfSBfJBSw+7uxKvmto48N
	 TkSd+l01S58VZwqDb/m7NDnHr0Zpcbxi0cd49yi1xTQdpiPLL2KZ6ko7QSmcjH5X7C5nX
	 5Tz82/EiYMwSyPuslixxYhfdf0W3DldU3S7PRBg8AUETbhmi+3HcoAC+/6kfio/NLefFC
	 Y+xFVwa8Zup4oNmHeIejDTUnb6RpmXWPcghPrnqwvnuUr0edehcTb8rOhikLjWVenJ+8L
	 S0BIcly5SA+R3pFz1UY1wW5NPGL1+9K6jHXKpnvDjG6Y3pABUAeplmTv8svgY5OpMEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T68tBP6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1E606A688;
	Mon, 23 Nov 2026 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T68tBP6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBBF1F000D2;
	Mon, 23 Nov 2026 23:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475648;
	bh=JPUPthGap/e3ZUgIbzXcpl0zmaDMBGPupHW0i1UrtNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T68tBP6+YPs2Orwns72rzyGkHszGqjcGUNewqpTan21XZJABrA3Hhz37joVOFrxex
	 jHFYt+M8T4WL5Z7UGsWWIP2VzT8tD3RiWSiOWZ4Xlv972DvLcTjpFm2+m1msC0aKRn
	 k1S6L9z7tOnqVx9p1HP1gvKrq78SyqhHfKtaUrIdxwEH94BZMh1VetB7j7kC8xDm7G
	 ah/xSo+HUZbRzgXCKr/cwZDCvAbkRMz2fDxHP8GbYrRz6PxePCAzZMvCOZVZucP+Sx
	 M2Rq0uKWhsUi7dtH4gRtO9HgnaMVsYNByRwCTuG8d26To0UUOVMB3vlfF7aoxXMdLn
	 OhPOgFyYl1imw==
Date: Mon, 23 Nov 2026 15:14:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ryan Prinz <rc4d5a@protonmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ieee802154: 6lowpan: validate fragment offset
 against datagram size
Message-ID: <20261123151407.09f929c3@kernel.org>
In-Reply-To: <20261123134343.1638026-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com>
	<20261109090226.799973-1-rc4d5a@protonmail.com>
	<20261112153034.1015181-1-rc4d5a@protonmail.com>
	<20261123134343.1638026-1-rc4d5a@protonmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Nov 2026 13:43:58 +0000 Ryan Prinz wrote:
> A 6LoWPAN fragment carries the datagram's total size (d_size) and its
> own offset within it. lowpan_frag_queue() never checks that the
> offset, or offset plus length, fits inside d_size, and never rejects
> an empty fragment.

Please don't send patches in reply to existing threads.
