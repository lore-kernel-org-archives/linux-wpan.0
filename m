Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F7259498;
	Tue, 28 Jul 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278257; cv=none; b=P2VLLPHOIl5ULqfCzFbk37xtb0qW/AXCiaUHP/ataCfgBMpR5BT6Fee8Sv1nZarBNsy3BFtnbJHaeBk0xUwQSQID/EDGvk2JMY+3QnkkpKO3tphHmRd/G/Qkw3LYbj2UaGf7mRU58Uhf+uE/4EuTgzU3gfCkk3YWiXWQ9xnHpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278257; c=relaxed/simple;
	bh=GCaZziVtjkdxhmrqFTsVptBabsWdedH6/+xOhCpa++k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYcFOHA+DthQJbp2hItaiXMYaAfH7TRZV/hG86xUeTVGNSTKC1N5wMKWAMuFzWaCFm4guKrqvLLThilRT97wB0aO844nGU5H+OM9NJBV+RVVLWvn6eJo1Nh/zy2wYY5EuMJGoLyZTw3662XESgRoh1YxWSqSzlS2ZV8D2D0hXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGnCjlqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGnCjlqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73271F000E9;
	Tue, 28 Jul 2026 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785278256;
	bh=+VFRakV5zaOkLzwGK5ZXFV14kncpiSlfIudegRT6tFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iGnCjlqaQj1jKwT6cExoAZ0EgOzoUEE341gi5WA4y/lg09Ru1oq/NnfwDxXpyFjuA
	 QVCVb0SXdziTs7/lP/wIb8Qa72l3d2hjKME5FAvS5UwJshNx/OhAbog0b9Yu2mlX6y
	 opAu16FV0V7CeCyfna4WBCl/9adIhIU+fjA29/5Udll91WBaNt0Vd/q9Bcp/VsdAql
	 rn5xgOncgAwo6alP7sEE988Bl8k/6DRqGgneu3VLXEsLujGJBF6Dsgum1zxLyIohDT
	 +/hIUo4fZUNt/p5L/AlCsk89Sf7cE9/mXBOqRP4z8ddocz0ERy6JTh/bTLmMZ6B0f7
	 O39UWnUhY+YCA==
Date: Tue, 28 Jul 2026 15:37:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Remi Denis-Courmont <courmisch@gmail.com>, =?UTF-8?B?UsOpbWk=?=
 Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, =?UTF-8?B?UsOpbWk=?=
 Denis-Courmont <remi@remlab.net>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <20260728153735.7e449d76@kernel.org>
In-Reply-To: <amh3JXocONXT8Gb7@gmail.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
	<20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
	<20260727161652.58de366a@kernel.org>
	<amh3JXocONXT8Gb7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 03:04:21 -0700 Breno Leitao wrote:
> On Mon, Jul 27, 2026 at 04:16:52PM -0700, Jakub Kicinski wrote:
> > On Mon, 27 Jul 2026 03:06:41 -0700 Breno Leitao wrote:  
> > >   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
> > >                 rejection.
> > >   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
> > >                 rejection.  
> > 
> > The config options for these are not enabled in the config for net
> > selftest target. Doesn't look like we're testing anything particularly
> > meaningful here, so maybe just drop the cases for these?  
> 
> Sure. Just to confirm my understanding: you'd like me to keep the
> selftest patch but drop the ieee802154 and phonet test cases, while
> retaining the rawv6 and tls cases. Is that correct?

Yes, that's right.
