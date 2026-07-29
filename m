Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFA4418FF;
	Wed, 29 Jul 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313775; cv=none; b=aZmSolLpDX7EBQ3m3oSDDKY3pUD2w+A9ZsAfjG2aM6WFUC5bCUGTKhzARIToCt/x3rePUsn6KvIm/r6U7qg6dJfbbJHTMGLqRKCTsxV8HJgeGtonHqAZyG0xMCgTVh5NsBv9O5FlPBP4qfoK0Yac5HrxwDiMMJaULs2M8OTGfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313775; c=relaxed/simple;
	bh=VFZ0+Lh5/JPFmkK6EEPPupE650IIyxbYVnYKHjZ5P64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxTDrZOZrFdtDiyNkuLnl63W7NjibSqVJBBwTwLPJpFz8e4BIs0up/O/+lAmy0rL+h5jArG7ahqDKNhFOvp1dy7xpC2Jac9Oxyi6xql4WwhYL/XSebPPlE4fs/+zOx8b2vUV6nDmqwXHtljJJVK3XvoJaBjsKtnMvF1WDUtEDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mc8Pl7g8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mc8Pl7g8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ha3p20eciL1b0U2/i0foT+nPYGb8ce64+SXodI21S3A=; b=mc8Pl7g846n3Pvpovhu+4c0uz4
	0hAxcrWrf1lrDBkR0fAOMB276ZLgU3OdTlnEBowYWZH2ADYSDWt80F8Cm2C2Zh1KdFZpnWoYOarh/
	udJ28lCwCbBPxbz1lbYbzN5kQ7r11WMZhecsU7EUau2kTaALWbzOxbyUhgjGxqH2z5K7tb/HYLCsz
	CYryUtOaFEt//xEWuJaI4ESSLDKhsofr8tUAX+EKErN1tYe/s86LsExRjhooRBv0Ku23cZA06Gstx
	BOzNd4ItVBijypydpLRARpictnkw/2ss/GCsMrT5SxiTQY27XDFn/4OogWTzsBn8eMxynhN+2kAvb
	QOQctCPw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wozez-008K21-1f;
	Wed, 29 Jul 2026 08:29:05 +0000
Date: Wed, 29 Jul 2026 01:28:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <amm4M6UIEMFTgVtg@gmail.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
 <20260727161652.58de366a@kernel.org>
 <amh3JXocONXT8Gb7@gmail.com>
 <20260728153735.7e449d76@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728153735.7e449d76@kernel.org>
X-Debian-User: leitao

On Tue, Jul 28, 2026 at 03:37:35PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Jul 2026 03:04:21 -0700 Breno Leitao wrote:
> > On Mon, Jul 27, 2026 at 04:16:52PM -0700, Jakub Kicinski wrote:
> > > On Mon, 27 Jul 2026 03:06:41 -0700 Breno Leitao wrote:  
> > > >   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
> > > >                 rejection.
> > > >   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
> > > >                 rejection.  
> > > 
> > > The config options for these are not enabled in the config for net
> > > selftest target. Doesn't look like we're testing anything particularly
> > > meaningful here, so maybe just drop the cases for these?  
> > 
> > Sure. Just to confirm my understanding: you'd like me to keep the
> > selftest patch but drop the ieee802154 and phonet test cases, while
> > retaining the rawv6 and tls cases. Is that correct?
> 
> Yes, that's right.

Ack. Thanks for the clarification.

I will update it.
--breno
