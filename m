Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18733F8A1;
	Thu,  6 Aug 2026 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976248; cv=none; b=NGDXHTgnb5liUmIGKSL01Jvi94YwhiJLU1M1uA5ClXVMJq9R8pmYM33DyEAI1qfyGN+l6gMlljXS9p/bAJlUxQ6NXmeZ0QbSi1t6opdoHK4bes5AuQhgj+Pl+Mqnkwze8pn4QZo7QCv5RWUlagia/cIoPlHRTmYIPtVoXZwlElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976248; c=relaxed/simple;
	bh=YzIN3C4DutPlo4hlhxr1cdeqRurUUFrJt+loOiHVEAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L/XPYx0Wfys70tl3SWWmeeH2ChsolzkH7jD8B/fP7ghpH7VJ9NTq405D6lmzITNj2pXOEguhVv5ISFRyBRDLqBK8ifloHl/L32d0wjNM8eYYoP4Ej2WxgZEjcACgyG4QoqJp9HB3dpEUwv4neUUu1sLKax8fZwCyOrR736icLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+3pUAxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+3pUAxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9EE1F00A3A;
	Thu,  6 Aug 2026 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976247;
	bh=J5oTJCdh3WL83Q5jc009dWqbCQU83IB+nLjNJlQuRbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e+3pUAxWbUI3DAzJgJiVmCUbwaJwZLI/E5dArjsI32+GDzzJqEhht0Cc+UwqSjvuT
	 qc5zR0ZvH+1UCqWH+4dLbYGOb+4NOa3XpEm8Mz8rnUftm589Xo+113FJJSm/KLSVc4
	 dvAa6w7PWXM/flrEn3SndG70tolkYXv45QJ6bmNTTQDAoCc8ZBAFJLfHbgufCgKv/x
	 Qr/b/NCjRVDlA2Ttq4bUJFEuAoizb1jUt9czZxkCGk7Yr5hwPY9ciUWAGC2mtpkG1r
	 zK2NvkNbbkBr/2amf73uHeHTpbGhvlvARqJUVY3IygvalwjdLGTaAtRjqQZHJuaHcO
	 nCOmrjPerAFHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699C392FFD8;
	Thu,  6 Aug 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] mac802154: Fix beacon worker UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597620675.577272.14507658049071086206.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:30:06 +0000
References: <cover.1785596603.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1785596603.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 david.girault@qorvo.com, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 09:23:33 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/mac802154/scan.c. The bug is
> reachable by a user who becomes namespaced root in user and net
> namespaces, with nl802154 admin operations requiring CAP_NET_ADMIN in
> that namespace.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,1/1] mac802154: fix netdev use-after-free in beacon worker
    https://git.kernel.org/netdev/net/c/5f26a690e8ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


