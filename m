Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867075;
	b=w/tskF0VgosrUmEeB61h3zOG7rKxhLnSK53aU8NOvhzZKbQjfITosJ0YH6KhXKBv7Pg8
	 51d1msTMq1GMkh/Eop3w2Pw5DSXn/B/nfkMSbLxFrUJTxvt2/E2DIMHQkZQpOCov8DdjC
	 ZVKR5+xUiU17lSOeYqrpl/eaRh5q9MF2DBPaiaaTJG7gsbQoEVwUH8zHfw5uYnmIE6k4x
	 Unpv/g+aQc6GBBPNR3bqEZjWMY3aJjULoIiw73vsd0yaRJ3JFZ/sci5iTZYlino8g/VZ7
	 R6dh0TgKddsDfcsxgrcLlQuttxUaWytAXkt0SZkN/fzGT6w0hGXRrQIG3jcnRPo4JmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KKsyFJuqb+jISh2VkJXDkgzTB/VIC5Qsn4SZG7ZDQkY=;
	b=DAI4T25fKh73IsNjW/w9BI9K5obatiBHR6atuUTgjd/dgXSshLnEhbjFBjp7ETnL6Kx0
	 puJgW5G0huATUos3QA0pht24qGCSBG89BgGTTPQkFGbbTxwUweO01Ae+5YbAlbwojNCsd
	 FQ/W6efhR8GLkh2xb+RtikQenLYzbXwD1OybOyFno/ZBFktzSXBo0CprO/jWQbnVeviAR
	 aG7Jb31cB8vfKpJIc56BP2/eROEqxT7aoHHFJHy0tdfuunJPxg9z404LY109BfnkB5bMZ
	 aRwU3C7ioUm3BWCd2tG6caOFlz7fc8hdcD+4jDhfTB+4Py/ph6LECj4oEqfgELYybkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k089xL/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCC606A329;
	Mon, 16 Nov 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k089xL/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB731F000C4;
	Mon, 16 Nov 2026 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794867075;
	bh=KKsyFJuqb+jISh2VkJXDkgzTB/VIC5Qsn4SZG7ZDQkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k089xL/f9iDB1bzo+tkp70lRXNwq+ZquZv6//dnWh9RkRIqBx6mndNSMGVW1zsqnk
	 +JAah8xj60i7EX/twVc8XFTBGlfxzsiJTNrJqQI0MBYRP8/3cnI+/UcTrGLz6IVH4t
	 VrQWKxz5o73nY+rHVpFJjY+HQMSb903BUs94mHewRlsXGpv0eCyqKEafQ4+jGjfQpR
	 K2VI+m+ydN9/+RwHCuqS4xBvaZjkyqMfM33rqxDz3hT07LmtvsvUY0+L2lxytX13xG
	 5aUEDe0ejku8GtH95C2kvr91WWO7P+4gzkZ2l5MNCSE4ID1R79B3rQJ+ioLZ+wtbNi
	 jI4un55/yhoWw==
Date: Mon, 16 Nov 2026 14:11:14 -0800
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
Message-ID: <20261116141114.30ead071@kernel.org>
In-Reply-To: <87a4n8rczw.fsf@bootlin.com>
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
	<87v77626rq.fsf@bootlin.com>
	<20261019190736.33bc37e6@kernel.org>
	<87a4n8rczw.fsf@bootlin.com>
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

On Mon, 16 Nov 2026 16:51:15 +0100 Miquel Raynal wrote:
> I believe the flow that works best is if you (net maintainers)
> "continue" applying the patches directly, especially since these days
> there are only AI bug fixes. We can definitely re-instate a formal
> pull-request relationship between us as soon as there are new "features"
> being discussed. We (wpan folks) will do our best to respond with timely
> feedback/reviews.

Alright, we have a lot of patches to handle so having more help
(IOW having someone else handle the patches fully) would be preferable.
But if you review in a timely fashion we can handle the manual labor
parts.

FWIW you can use the "Maintainer" filter on this page to quickly
https://netdev-ctrl.bots.linux.dev/suie.html?delegate=netdev
find outstanding patches to your subsystem.
