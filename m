Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34A3FBB68;
	Fri, 17 Jul 2026 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293377; cv=none; b=rJTvP/7ubQksDjaSsvqK5keaYJxROU1CnxfH4s35iwO4Zgm+ljc63WhzFz6gx10EmLmjgiRXB7CrNkwVGejnBhb5rke21V/peQMrcOQond7tI34EVKRd6vibboPIn90+LNko23uh1H0F1r1AWDUoIh1kq0DdFBsyNcoJTI8I1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293377; c=relaxed/simple;
	bh=Ay6jM39/+ma5j+jiCTlNRbTQpnc5D1HdKVL0kWtdrLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD9d/so4N1oCcqwmQO6p52sewQbhTUoBaUE60y7ugGDw6SgXFPrrhR5EDeWXA3Hv9jTAMd9HuO1I6QXuhfER85+N2RpVboaBLfwX6GMQ6P5z7YyayGURJMrsn0S/bdZY0AStxvY6lPKqNzoTR/xW64zDgYe1e78tsRfIVq21a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lCg8MP2C; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lCg8MP2C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RbW4ajUIf/pxw5rI5NSV+3ul0KS6Q9N+ll922kwV6Dw=; b=lCg8MP2CKyjXLXnKqW/v7d+XCA
	jL1NGWRd3ZOzef1+GPGvwIK2RMEqk+/kOsc+8uAmAV/YegpIAFj8R35TqKWsOCkCDoCFlEEG/KBmB
	rOsZHR6IF8Kj89oZ8NTMrlI/drdJn1UK97yNP77b72CbTesr9e1eUPMYQhY1juzXwhAGvGFum8NOn
	3g6gdQ05zr/cSuaboW9lRcu8zcI4/VDp4o1wjEXcPCVieP74HzHaXAWvnpocA9dmAOdz8wgcd0E8Q
	k37GfsCgzNIgh3uFpwBWiNfJJpR0VKCpGMmDN6NzQQY3iujOWXO0bOE5E3r9qPviG9IJNymIxwWWC
	DrvoFwfw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkiD5-004c9i-16;
	Fri, 17 Jul 2026 13:02:35 +0000
Date: Fri, 17 Jul 2026 06:02:29 -0700
From: Breno Leitao <leitao@debian.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/7] phonet: pep: convert getsockopt to sockopt_t
Message-ID: <alonKANZx3ll0Ryo@gmail.com>
References: <20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org>
 <20260716-getsockopt_phase4-v1-5-4f45cb12dce7@debian.org>
 <20260717092258.776e63db@pumpkin>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717092258.776e63db@pumpkin>
X-Debian-User: leitao

On Fri, Jul 17, 2026 at 09:22:58AM +0100, David Laight wrote:

> > -	len = min_t(unsigned int, sizeof(int), len);
> > -	if (put_user(len, optlen))
> > +	len = min_t(unsigned int, sizeof(int), opt->optlen);
> 
> I'm pretty sure that can be min().

Right. opt->optlen is a plain int and sizeof(int) is a non-negative
constant, so min() takes it fine.

I'll switch it to min() in v2, thanks for the review.

> More generally I'm not at all sure about negative lengths.
> Historically the user type would have been 'int', but it got replaced
> by socklen_t which is probably unsigned.
> (IIRC one of the 64bit Unix had started using a 64bit type but I think
> it was sun objected to making that change so socklen_t was born.)

That's now handled one level up, in sockopt_init_user():

        if (get_user(len, optlen))
                return -EFAULT;
        if (len < 0)
                return -EINVAL;

> Also truncating below 4 bytes makes no sense here on BE systems.

Sure, but this is pre-existing, isn't it?

> Some code will try to write the significant bytes out, but that
> would be better done in the wrapper.

This is the transitional shim. The ->getsockopt prototype is shared by
every proto:

        int (*getsockopt)(struct sock *sk, int level, int optname,
                          char __user *optval, int __user *optlen);

So it can't take a sockopt_t until every leaf is converted.

Each converted leaf keeps the __user signature, builds the sockopt_t
itself and calls a do_*_getsockopt(sk, optname, sockopt_t *) helper.
Once all the getsockopt leaves are done, sockopt_init_user() moves into
the common caller, the prototype flips to sockopt_t *, and these
per-leaf wrappers are deleted. The full plan is in the phase-1 cover
letter:

https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/

Thanks for the review,
--breno
