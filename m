Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAC37F75B;
	Tue,  4 Aug 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804060; cv=none; b=MOs03fz2u/d8tuerNV1GxeazWlkoxU7fWLueIRtJGYVV928hVxhrBfDZvm3MCa0zQh4N7Tr2HZBE/WRFXXYOZ+VbZPS2ntINYI7AoA+YKHHwttfDuX9VKKn/INLXpO8yaq84ycJ4+5aKC+0Ij6w9P11TuQPxG43OoJJoOiMhrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804060; c=relaxed/simple;
	bh=XZuIyhDNwBk9Eyv+la6sPhj7BVxhXavKiUQ++AeVIrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XGmvJ6xWL+2af1o6tPvl/yBIorT8n7J8wdexVbczH05j8ynDNp0Rl3n2b51r7i5EQTQNATTy6ud9CMukYFgNuREPQmnMDyS5WZu1e8NIUOEOPbcDsMEhNB0OfXfjm8wkznl8WUj425RHvL5xtwMIB7i5jpOVIsNmfDKfLwkuKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/rCJ+RL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/rCJ+RL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36541F000E9;
	Tue,  4 Aug 2026 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785804058;
	bh=+PZgqEv1Au8SDYqdzdFIk7I+j3Y9scLbRGeASAO9kFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T/rCJ+RLl1/g2aBac/QefbFAx/GUqhZ9E4DdGq1LxCmulk89mmh8I6P1np/vrESIN
	 8hFPHX1dly/sySiICzP2RC9mCDwtCZjkt6Zg64uMAajO8iRE4IEpK1Chm0HUJJdTNI
	 HvmO1dWHXiTGih/4rM7S59BI7VECHjLKA8vLCQze7qPeYb8G3oXJvmhWTnJEZ8jE0K
	 js0AXWyajqzO5OxdVCtBiCB0Lh8K+T3S4jAdi0Bhvjnn5qk3h9c4xk1oOCjEIsC1sY
	 ZtGFIRaltEUnNypUEWL43OD1jWvyi1R2L1RGuw0fOicRBVG9o2lwuu6Yi0ES0MZHHb
	 eGP0PZed+BmpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B563924467;
	Tue,  4 Aug 2026 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] net: convert rawv6, ieee802154,
 phonet and
 tls getsockopt to sockopt_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580401944.2893509.4047199420753049273.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 00:40:19 +0000
References: <20260729-getsockopt_phase4-v4-0-c44576757c17@debian.org>
In-Reply-To: <20260729-getsockopt_phase4-v4-0-c44576757c17@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, courmisch@gmail.com,
 remi.denis-courmont@nokia.com, john.fastabend@gmail.com, sd@queasysnail.net,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com, joe@dama.to, remi@remlab.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 02:29:43 -0700 you wrote:
> Now that sockopt_init_user() was already merged, builds a user-backed
> sockopt_t from the __user pair. A getsockopt leaf can then take
> a sockopt_t behind a thin __user wrapper: the wrapper builds it, calls
> the leaf, and writes the length back to optlen. The leaf copies with
> copy_to_iter() instead of copy_to_user().
> 
> Convert four more leaves the way udp and raw already were: ipv6 raw
> (do_rawv6_getsockopt), ieee802154 dgram, phonet pep, and tls
> (do_tls_getsockopt and its per-option helpers).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] ipv6: raw: drop unused level argument from do_rawv6_getsockopt
    https://git.kernel.org/netdev/net-next/c/aee44196d216
  - [net-next,v4,2/7] ipv6: raw: convert do_rawv6_getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/8472b68c2497
  - [net-next,v4,3/7] ieee802154: convert dgram getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/6cd4e6c0449e
  - [net-next,v4,4/7] phonet: pep: do not write beyond optlen in getsockopt
    https://git.kernel.org/netdev/net-next/c/77e5eb0e192a
  - [net-next,v4,5/7] phonet: pep: convert getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/d05a7f0ab550
  - [net-next,v4,6/7] tls: convert getsockopt to sockopt_t
    https://git.kernel.org/netdev/net-next/c/c7049902075a
  - [net-next,v4,7/7] selftests: net: getsockopt_iter: cover rawv6 and tls
    https://git.kernel.org/netdev/net-next/c/6b21a3ac84c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


