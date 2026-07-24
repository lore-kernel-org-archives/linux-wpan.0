Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878A33B97B;
	Fri, 24 Jul 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886525; cv=none; b=FDgU6eT45HgV7OPvSSC3UotOR8rpFauEuxo1XgVj0hN7PKf/QgFoUWp86Ngh6LU0kHN9Qk4M3dkeTu1DHC0Ta6wam3wd+cIPn72queZjemyCSRmo8qJor1J7tSlKX67eLibgVfiaivw+pr3NpQ6jHuib69P//ZyqkVub9EsasO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886525; c=relaxed/simple;
	bh=Rwmm4RLX0s7DZN3iaoF/nbtciM9DC980VTjUFsxDE6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgYxE4HjCTAkJvF7vWpy7lcyC5WQtj/EKHCDIdZlCItGW63dOD7Y9/cZ4N4rFoyTc/829GvkprcE/9BkzNMNAKMROsjOtT33n+GItPqTpcfcaQn0OejrMhh/WXlbIiiglaGw+//lw9+XQuF09YxwCYTC+dVL/M9yX1HDmcOiX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KMSVSQD6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KMSVSQD6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=CwzCog24SE+SYMPystsC+yIzB2QgOY/HZ1Zz6wBBSmc=; b=KMSVSQD6JKnPeGpHwDYrhG9nGk
	YpWEXMyGR6zrVni8yeLPbm0P844oZruJMdocJIkcSUQNLMHmw8zi9yoivWmFsoA/qmgz1hVk2AieR
	Ge+hsVDoOtm6myUglCiRxFO5HUmHfUg9Dqf1qQWF+vpvz3WE2QfEI1pPppafo6KdCjkGIzY+AQ/JJ
	bGoZ2OxPSYPpouMt28b9W7BsMFN3qgG3Y8nO4estNj/9XKaJG/l1kqCKOoYfjYWOJNR0H7AhtoUMl
	NB0NpPsrZVxB6AqLHIa8PDksGuGdOMLw5lzjpKjSrdhPP5zsdMMwyYf8Wy6S6UpzRimMTcWbOec2C
	2aFzhrBQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnCW1-004TDn-25;
	Fri, 24 Jul 2026 09:48:25 +0000
Date: Fri, 24 Jul 2026 02:48:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH net-next v2 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <amM0KRJ0QYnfR8_D@gmail.com>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-7-8a08fcfa0d72@debian.org>
 <amHs_xGASCAA1J3k@krikkit>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amHs_xGASCAA1J3k@krikkit>
X-Debian-User: leitao

On Thu, Jul 23, 2026 at 12:29:19PM +0200, Sabrina Dubroca wrote:

> The TLS tests themselves look good.
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks for the review!

> I guess there's a question here (for components that already have
> their own tests, so I think just tls for this patch) about whether
> getsockopt tests belong with the other component tests (net/tls.c) or
> in this getsockopt_iter group.

That's a good point. I've kept them together in this group for two reasons:

1) It simplifies cleanup once the full conversion is complete—we can
   remove the entire group in one go (if needed)

2) It avoids inflating the selftest count, which helps keep NIPA CI
   runs lean.

That said, I am happy to separate them, in case you think they would fit
better somewhere else.

--breno
