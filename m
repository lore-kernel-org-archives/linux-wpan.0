Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591F2367CF;
	Thu,  3 Sep 2026 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397005; cv=none; b=FnaZJ5bwKG/Q4MYjSYuzoUUGWOD6QCStL9A9y1jHvzS2Y02WtEiNlOsl6jLOReltlk4wn9swagrnoU9blvhnuUhakSXfqexE6cChoaVvlbwO3KboonnbntqJa5qTKrfyElb3fW/JILEbhSxHcbyDFXzukyUk7oXeiSiKex+ve2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397005; c=relaxed/simple;
	bh=70myD9FqYPs9K0IzEYD88oafv4ip7rL916oac+BF/Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0XQm6e1EQI0r6lGKyi7+xzDeuASa4qsF6ke3eJjafdEgGMkO85iVXh3V72V/hDr1N0MkpWOhx9q8uEzJ048v6Qw32X3JN+mRRMfqazx/QOw/0i17Hyq1IKOImbRaqnHh5VW1YGt1cUj5Qi/+tnGIF5kdf2HEVGl6EUtX9GagQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEEHFHs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEEHFHs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40731F000E9;
	Thu,  3 Sep 2026 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397004;
	bh=mPKkiH6D3mUbkJBYD1aYVQVcOeLvSwS5GndluyQrfGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fEEHFHs0B3urNWRUZ6vrgCsKfqvORfUpr5Ctbd6B+i/MCirJci0J0esN45vZmyUS/
	 i6AL7v+GHrprGR3MEzSApJY9q3oelNSiC56SBxOyKs5WwRZ5VmrXuOFuOTYW4plYah
	 JPO72tgaKe1BFQXWsaQE1KPAkKaILFScidGXxTofScCgMAyV5AJA6n7pok2jMrrCA1
	 ul+M9NSAPhOmj1zfOMpTOpdEySO+wyyuHApRsg0XTcRhViM4Lt9uM0aQp0ucjo7vdv
	 MBHoQaNIUt3xsSyX7thkF8tpJ80pvg2IO6X4jC0bznNQlDupmnzCinaP/wahwxOi51
	 vi5/yA5hS+Tng==
Date: Wed, 2 Sep 2026 17:56:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: zihan xi <zihanx@nebusec.ai>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, david.girault@qorvo.com, vega@nebusec.ai
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon
 worker
Message-ID: <20260902175643.709fb711@kernel.org>
In-Reply-To: <ceb38e6c-832e-4345-bbc3-52721aa4b6c6@datenfreihafen.org>
References: <cover.1785596603.git.zihanx@nebusec.ai>
	<e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
	<6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
	<CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
	<ceb38e6c-832e-4345-bbc3-52721aa4b6c6@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 14:35:23 +0200 Stefan Schmidt wrote:
> > This change already landed in net.git as 5f26a690e8ef
> > ("mac802154: fix netdev use-after-free in beacon worker"),
> > applied by Jakub with Miquel's Reviewed-by.  
> 
> Ah, I missed that Jakub took it already. Thanks.

Sorry about that, vacation season, I wasn't sure if you're AFK.
I'll try to avoid taking mac802154 directly going forward.
