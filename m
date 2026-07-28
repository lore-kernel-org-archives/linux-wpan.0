Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44841DEC7;
	Tue, 28 Jul 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233095; cv=none; b=oYtaLGOXqtLCFjGzLf0A7ruPWRiZ1dKOkQmnvh/JUFfNb6O8/S+rWoDTo+YoyxOn2aR695Sj+0EZW7w97H+q9UkVOkfTgCMuIYHx+bN2U2431BOha0PsOT+Nd/FpMs4mzfeOpWq6GenqgNsBaZpkmHDCjdN0YCeYCGTiNY3oyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233095; c=relaxed/simple;
	bh=fldViqCXk7TBmGoVM2Wtji97Bwx+gZkbsvsN1FN8rgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o85UdJgVVKPrtuh0mTGO6ktNbUSiyRnOAUTOUzUQT9BwFuY9a/D+YuTI+Y/Tcw7kX2/ro9b6SI6p8ql6XREutHYWtbYwhg0iSE1EI5RFT+Z/MuHOfvE+pvO6wrACLLuRUVVMQoE11DEakmK0CIXDcAbl8UyrXmRUuy5Cjnl5VIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IyUA7HGA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IyUA7HGA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=omVkx6ZIAXX4NGOWuVToWaCdJsx8TywMjM/M4ZdteNU=; b=IyUA7HGAE9B6DXIthENMNsN5yv
	agt4UUQzMY7rpj8+f6kKvzCXQrtBC1QUsNXsZJEURgIqlRK0TpUI4TcsntRxac55o/EaSD5BQQGZ9
	UKviw5WaelwFblEdUk6X4piuD12gOBQFVlddqTrPb46cUi14L2EjqK76TnNEXE9YErYH8O0maCcAa
	NxEwMbPyvPVtmdxyIrQ/N/D5VhPybDRbL25h2zpii5B3uxO9I2IJs3vlwgt5Eyeu6U3wpPzLLkPkJ
	vCWKmysdN6F0ynIU4SlSt6yb66QQ5gwRk8amJ4Be7RmyktYULTacn/AuEWhrcstsMD29S+7bVf2uc
	zkEaCCGQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woefj-007b81-2L;
	Tue, 28 Jul 2026 10:04:27 +0000
Date: Tue, 28 Jul 2026 03:04:21 -0700
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
Message-ID: <amh3JXocONXT8Gb7@gmail.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
 <20260727161652.58de366a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727161652.58de366a@kernel.org>
X-Debian-User: leitao

On Mon, Jul 27, 2026 at 04:16:52PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 03:06:41 -0700 Breno Leitao wrote:
> >   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
> >                 rejection.
> >   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
> >                 rejection.
> 
> The config options for these are not enabled in the config for net
> selftest target. Doesn't look like we're testing anything particularly
> meaningful here, so maybe just drop the cases for these?

Sure. Just to confirm my understanding: you'd like me to keep the
selftest patch but drop the ieee802154 and phonet test cases, while
retaining the rawv6 and tls cases. Is that correct?

Thanks
--breno
