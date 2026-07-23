Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2241D231;
	Thu, 23 Jul 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815540; cv=none; b=D+R6cPY24t2hNJnAELfQ5kYX5wak+caiY9pX0gaRNPGx9uROsoa0JyDhdsbRUYvuNvq6LKIWu8jVYRQJne3iinjDv9lqYYqi6ITZGAImO9UVVm7Fu5nMAGwFOgQlPjxfS/vUcRqfDX/g/CTrzJ8pT5jIq52JQwOduQiIN91QTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815540; c=relaxed/simple;
	bh=AqJ/qfdsnWqkYkr9XAl2/NCA50zvmqEPaDjyqs+bDGg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfT0St8GsyLoNQS0J2NDZAj08bTgd+mmMqkj1j0qIrupDJsLRZDiHOa0H+zhMpa5VcgFO5YGM/3oRyV1B4mBHRq3zd6d97uKrwXAgZpC7tcoALhHdtGjcf2f8EU4iBbgsdw1uNQExgFtwCos1ghSjd/yWVELEsmLWsmKeC8CrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mtMhCphU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mtMhCphU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBles+/LV/+QarLEC3kzhcZ3IlKvTBVZi40zuE/epM0=; b=mtMhCphUJdTk7RLZVrJjrJs8z4
	6eEiB9Q7YZIwglfiuyMOFW0G0ovnN1Cd3gpwnxY1OXg8Efu3tuT/nX0nCoDNqM4y5xr5iVB+4sZc4
	wT9WAi8YWumRD48jhhOLyNv5P43pLswfW/WxtGAGeq90vJB23lwDd+hnFE3gawxSLGkkH4qSXFEiW
	g/UKuR+x96hCtRRRnm4pClPDYOc5uQVnHNL+Pg2b1kdCQ17TcN8TjMb+Ij7FryOgmh9qcZCke6xQK
	sKZx2R5+Ne/So0xraTsC1OJ1uG6wmL2OJzi83s7kfSf6JMPI/MLWezZHRgj0ZjRusIcAInHAJlN1R
	/WtF4DEA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wmu30-003pfh-0a;
	Thu, 23 Jul 2026 14:05:14 +0000
Date: Thu, 23 Jul 2026 07:05:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Joe Damato <joe@dama.to>, sdf@fomichev.me, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	david.laight.linux@gmail.com
Subject: Re: [PATCH net-next v2 0/7] net: convert rawv6, ieee802154, phonet
 and tls getsockopt to sockopt_t
Message-ID: <amIeCfhPS_4Vfh9p@gmail.com>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <amDI0T9mfHakF+7I@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDI0T9mfHakF+7I@devvm20253.cco0.facebook.com>
X-Debian-User: leitao

On Wed, Jul 22, 2026 at 06:42:41AM -0700, Joe Damato wrote:
> On Mon, Jul 20, 2026 at 09:17:41AM -0700, Breno Leitao wrote:
> > Now that sockopt_init_user() was already merged, builds a user-backed
> > sockopt_t from the __user pair. A getsockopt leaf can then take
> > a sockopt_t behind a thin __user wrapper: the wrapper builds it, calls
> > the leaf, and writes the length back to optlen. The leaf copies with
> > copy_to_iter() instead of copy_to_user().
> > 
> > Convert four more leaves the way udp and raw already were: ipv6 raw
> > (do_rawv6_getsockopt), ieee802154 dgram, phonet pep, and tls
> > (do_tls_getsockopt and its per-option helpers). 
> > 
> > Converting phonet surfaced a pre-existing bug: pep_getsockopt() clamps the
> > length it reports but writes a full int with put_user(), overrunning an
> > optval buffer shorter than sizeof(int). It is fixed in its own patch, with
> > a Fixes: tag, before the phonet conversion, so it can be backported alone.
> > 
> > The last patch adds getsockopt_iter selftest fixtures for rawv6,
> > ieee802154, phonet and tls, checking the returned length and errno across
> > exact, oversized and short buffers, an unknown optname and a bad level.
> > 
> > For full motivation about these changes, please check the initial thread
> > at link
> > https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/#t
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changes in v2:
> > - Replace min_t() by umin() (David)
> > - Link to v1: https://patch.msgid.link/20260716-getsockopt_phase4-v1-0-4f45cb12dce7@debian.org
> 
> Other than the nit I mentioned about min vs min_t on the one patch, it looks
> good overall to me, so for the series:

Thanks for the review, In fact, I'm using umin() rather than plain min()
on purpose: opt->optlen is a signed int and sizeof(int) is size_t, so
min() trips the signedness check unless the compiler can prove optlen >=
0.

I don't think min() is correct here, it would be min_t() or umin(),
I would say.

--thanks
breno
