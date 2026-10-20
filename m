Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484027;
	b=t0U+QQmSnVoz2bEZQwD9NLVj9BA0wZWrJCSYo2G3YsUR0TdIpie2ofzdRHpTJJhShLK3
	 VbuBTZIDsFNp3sXdufGbUGbx4Fk24OFPyG2rX6A+9JW0nnKupBeUl028Bvw8scNSUamxp
	 ATsazgbUPoGZzjytHbIEBg5f9hv39oJN1raZPcfhBhFAyXS98aQLkvhWGRdEZoPq5qhV3
	 Oe8rIsvY0cAxzkADwP60x8C6Ct/0tOpG8/ANwDAdIJP/VA7515XTkkuTbd54c7anunogm
	 ogasQKIgn2IaMm/7L691rE/qqb3BxuW7bJ0kWF7kYyJmSruIHexGA+SK2pRGKSRfPJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484027;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=MN63htuYUqrgFOXv/xwBT/iNnGMFTc69oLMOIWBDMN8=;
	b=C0fRw7RsQ/+uoMO6Aj0mgq9BVAl9Vo2adh/MWcDh6JiehU+51ARUu5ZxzzvzQPWConHF
	 Z10WGUDfkVxJySGZJy7KQbNir21LWY+aGvY9VBhW1AI6YHUz7MeU0Ddr4J7PtzfvMGftF
	 E6tzPaWntjOL3UD2hz56vmXDkOh3SwwYh0wcSqpDxB5U13h4fx3sdx0Bzb8MyojEAvfnX
	 mNXbytfViBBcLwz9/tdVKsrwcc9iCeY8X3Fs/95jpdv1mQduiDhm5nemJVhVjWAiQoSOY
	 IhncBF/woBAsy9Y1EkkN+5TdtzmMLP2luW6/xOjLjYqB6/vorKH03qqlBhgr8xmUU0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=03OZ40IQ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0E606A31C
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 08:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=03OZ40IQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AD542C63454;
	Tue, 20 Oct 2026 08:14:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C3A060393;
	Tue, 20 Oct 2026 08:13:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1925D10328A45;
	Tue, 20 Oct 2026 10:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792484024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MN63htuYUqrgFOXv/xwBT/iNnGMFTc69oLMOIWBDMN8=;
	b=03OZ40IQu92p+6zcM7lPsTtHDySziOlL6p2l7mREPKNcIKAdggk/zBqFUYfhtfeAL07r3t
	j0n7+Dj4Rim8EAwgcKN53lOYIl9/Yff5WfFqMUb9aiKsBSfvbDGgqxJiOnLcn6+PgQkVqL
	6wrdIiWr+5A1I3m7I67WEy034pwF4AGD9osfqoRzr73PpJXMl/jL0ll4aAKo7z5ZPQ24El
	bw92Xh7KhRxXuz8sJe15OugBJ1GJJk58MokHZdzZImRbTlLhq5zoju5d5adGEbNXgSzaVY
	+RxZJOfedAiiLWNpcMA0IZI7AajeBFBOdtmGTyZtvWHAmwRXKlG+rvBnwPB4mQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  Marcel Holtmann <marcel@holtmann.org>,  Chandru Gopi
 <chandru.gopi.dev@gmail.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in
 the caller's netns
In-Reply-To: <20261020065125.896530-1-maoyixie.tju@gmail.com> (Maoyi Xie's
	message of "Tue, 20 Oct 2026 14:51:25 +0800")
References: <20261020065125.896530-1-maoyixie.tju@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 20 Oct 2026 10:13:40 +0200
Message-ID: <8733u0vlfv.fsf@bootlin.com>
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

On 20/10/2026 at 14:51:25 +08, Maoyi Xie <maoyixie.tju@gmail.com> wrote:

> nl802154_dump_wpan_phy_parse() looks up NL802154_ATTR_IFINDEX in
> init_net, while the dump only returns phys in the caller's netns. For a
> caller outside init_net, the result depends on what the ifindex is in
> init_net. If no device there has it, the dump returns -ENODEV, even
> when the ifindex is one of the caller's own 802.15.4 interfaces. If an
> 802.15.4 interface there has it, the dump is empty. If any other device
> there has it, the filter is ignored and the dump returns every phy in
> the caller's netns.
>
> GET_WPAN_PHY needs no privilege, so an unprivileged process outside
> init_net can use this to tell which ifindexes exist in init_net.
>
> Look the ifindex up in sock_net(skb->sk), as nl80211_dump_wiphy_parse()
> does. Commit 66e5c2672cd1 ("ieee802154: add netns support") added the
> netns check to the dump loop. It also removed the "TODO netns" comment
> above this lookup but kept init_net.
>
> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
> Cc: stable@vger.kernel.org # v4.8+
> Assisted-by: LLM codeql
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---

Seems sensible:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
