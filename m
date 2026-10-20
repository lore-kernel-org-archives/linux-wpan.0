Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462058;
	b=YaETmfFArKjBJ/ywOJnzGjCfDWYPsgZ2CA2prFrM764MSUlakN0D5hr8VGwyOr2n5/iV
	 AD0tvtAv+fEuC3cO+W5nk4EGFm5Rzzm4a43coDYu4kQC2PXDf+5tMm+LCnzX9IQRlsCKP
	 pia6p/WVhazQbMTfhiZc7OLl9fHw71yAHAx45MdEbL7ZjMYLEOdPmPIJq9vNXhGhZxxzd
	 Nw8/YnIAvT0YnvS4nFrBHVCVQeFzia6xReE8PK69yhlntO/N+3IkgoREBvIjxbiLdCj9j
	 l+DDMC5u2fLgTXWhXGQe3H1Kti8uAcuyLRMClIsY/q+D3b65PWHi/qTNeePA7AhTEBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D18Do73LP6fjkjNHU/xIgVYce/hWY7LNn5G+tMk/7wI=;
	b=RhONXWswGAcux8ZfzaSFAkyP7SkPTISHspGvolaf4axjCpHQ0Ox2oFIzfCNvtryFHCpa
	 m/Qul19/oVoG3TUQK5/nZ27HsSmicjSU7dQrKbeU3XfM/mabnC/ivhY2+XEo3EZqBahEV
	 87csI3zdoTOoTZALP5RRZw4zvMtzpPvTgHPXmYVBoQ2j1D6C/5W18gauBbC5DkXBamzgt
	 hbtyhp86Ct+0ULRcxWXww/JBOJx6nEZZUvVzDDob+C9iTvXyR+6XHIF1LUriZdPhspCVu
	 4BYDRiDrHmsr0lnHm+vc3NbTxvClaLpm6wftrzKKu9BERqfVzAobC06cQRQTzCd9X2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7ejKhjz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0E606A319;
	Tue, 20 Oct 2026 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7ejKhjz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC001F000C4;
	Tue, 20 Oct 2026 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462057;
	bh=D18Do73LP6fjkjNHU/xIgVYce/hWY7LNn5G+tMk/7wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C7ejKhjz3TjK6nDPqrYLQoevEVgE/9l2S4paQJSCTcE1SvVav9DmFs3wy6grD3dcK
	 XJCHBedaFOVwqvmP+EGuVY1ipDC9ZFkt/42m/IWWm9Jk18o37RKqo7twWU+d/xbLvT
	 2oxOpyLsJ4USEc0PIUHgtwTrgHO1hJCo84yGHi6PuDr74l4XPEjgSrsn0GOp0ZFoo9
	 mbj9jTxO782KDVlIz5dh3GYLSGerPXOQRLXa4j86pOt41xHcdQZUYBJuXn1oeM6/1N
	 gdBn8NUttjdK4OeXbBY/4z/PRGzEb1hMAJXkY2LDwlgPS2Un3BNC74vQXhtPPHPALJ
	 OrWZq+yZRKgPg==
Date: Mon, 19 Oct 2026 19:07:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Aryan Arora <aryanarora.w1@gmail.com>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David
 Girault <david.girault@qorvo.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during
 hardware teardown
Message-ID: <20261019190736.33bc37e6@kernel.org>
In-Reply-To: <87v77626rq.fsf@bootlin.com>
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
	<87v77626rq.fsf@bootlin.com>
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

On Mon, 12 Oct 2026 19:00:41 +0200 Miquel Raynal wrote:
> I thought this had already been fixed but apparently not.

FWIW / in case it's falling thru the cracks - we're expecting Stefan
to pick up mac802154 patches. Please shout if that's incorrect.
