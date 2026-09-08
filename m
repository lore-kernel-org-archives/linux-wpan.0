Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BB1EB5E3;
	Tue,  8 Sep 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871868; cv=none; b=ILWLv0LCQzg1+ZTQbAKUWJnY9Vrzr8QMDg4YQ8HOntkfsy7L/MXq/V0FGT19PBbRj77AzAkSaLlVU1sc+/Hudznl2NCKNSBCuoJ6W70GFTDDd0bEW03gvG9qWndfmmhhtfrxHR6lDIJVL3ZBe2xQvqZx6epcgYxwm3iLrVEkpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871868; c=relaxed/simple;
	bh=D3nJxlXYDhex6GUnmsgvSYdhSjTfjXR06Bwr81Z8Jk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fwe1Q9Z59+Kh/zQayWbvUXdFzyl9UUYlnoY0Hm4wpnbvJ7qUplpERsqqFMfcORsARj+rn2Xf7b3i847ZkAW5Tb33V2jLv+WrZ6N/lEBVPEkbvG9qHP344Vgtnls9auSro92lA3s/HvScN6b/ZJ4hpNbrWLZxds8HcAEJbn4BOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm9wvPR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm9wvPR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCA51F00A3A;
	Tue,  8 Sep 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871866;
	bh=qWDNMWiIifZD4P86Gd2vFK/Xee0Zj0TCiySjH2eMjjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cm9wvPR4nUvHZUrccUHEkgPlCafpTEEWJqhRDcJ1xtVWVQd9gEwqBMjP7tl3QnfTo
	 GUU6YKTtBYlDte4XZwfxhvF4ONyS3L5S/nTqkTfPPXuhAhDekqoW+YsnMjarJ8g+kh
	 RhhfL1PLxlTlzse6mas9mGrjZ/sGjHn52dKYAbsqt8fuwdkwRccHh0FWGF7oCTex4s
	 QHLJ2qi4zdj8piWJDDSwfxFN7VbeMVrQNlYZqH2MiLt8YHTmsOc13F2SZq9yzU2lJQ
	 9qoQ5b0S6FEl8n3Skb1W3MEpeXSADgctwMk0rWQZAZliksiB6rhuDgn0nNVCkSBpNf
	 0WTTcwKt549nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DE39E961E;
	Tue,  8 Sep 2026 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178887180515.3511527.12117142863557069456.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 12:50:05 +0000
References: <20260907064346.3288-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907064346.3288-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 12:13:46 +0530 you wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/1773727507ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


