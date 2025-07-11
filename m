Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB739ACC;
	Fri, 11 Jul 2025 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193845; cv=none; b=sKG2A7nqw/9ytkTM4T2MtxINCs0MQZp2lHk+dOVOsaxDTQ+eipW8cHrzOHHrZh7LrxldTMYzDyhXy3JCrqrDcyRInwX/5Fr21Wj5hVfriaMgWXcvUSmBgEvUu09oWROpuVwD6rFCG+fw6LzDQyabb995+Z40tG7q+KcO8icjp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193845; c=relaxed/simple;
	bh=4TcUQRKoGXD7lDinYTHq6z5jiftadbgG7wdz5mhdvsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llzLjpAjeihNIWDkZXVdr/tA0EC5QHikASzTFXeVnb//3YxXjho5HNwQU1TNZCt+xMkMtLzHfrBju0yrW0kG28HLSZcb6PAz5JWMpuq/uqpkqGwU7PB78xFxtUY4Z1a6MgdqLo+CpXfBnzBloEWw5tdCeixiISpjpHdmzcfXG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsj1gscz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsj1gscz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D8C4CEE3;
	Fri, 11 Jul 2025 00:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752193844;
	bh=4TcUQRKoGXD7lDinYTHq6z5jiftadbgG7wdz5mhdvsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lsj1gsczFIMUMLfnOrCeoOjNxR0+SFVyGpnX2etxaDdyJNppZIcdb5jz0JKcXJMzC
	 Gp9swqJ2Ajsd7A6ZhaN2KRNcNsvABZCsUo8BfdJrj22sXG0rs5PRZ2BH4fQ9a/bCzh
	 lrsrJutyU+uEXczsFdblK41OLhK6ax+bcdowAvtTRETlMw6IAt7ebhLjqhJJdQF6dD
	 o0ZxrNAW31UROQe23Hg5BW35iC7Eg4xzlJ5GwZlSbpK2qAPotN9PMZKrNh/jPY4ZJJ
	 4NokIKWxHSQ/o5Cf0u9mLONB4ixEHqVO1OaMF/NqdEiqnPa0wHuoDy3duCZT6ps2W6
	 ku8DoxZZxfh6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFE383B266;
	Fri, 11 Jul 2025 00:31:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: replace ND_PRINTK with dynamic debug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219386649.1715084.6809706721646089401.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 00:31:06 +0000
References: <20250708033342.1627636-1-wangliang74@huawei.com>
In-Reply-To: <20250708033342.1627636-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 dsahern@kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Jul 2025 11:33:42 +0800 you wrote:
> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: replace ND_PRINTK with dynamic debug
    https://git.kernel.org/netdev/net-next/c/96698d1898bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


