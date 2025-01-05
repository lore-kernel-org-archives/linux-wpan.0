Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EA224FD;
	Sun,  5 Jan 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736039409; cv=none; b=pCQ0xfI873Dk7mzP39/LKVpU5fpkDwQGY6P9XPy7ZX7uCNmfY92Kq+Lx4cPbG1Jv4SBHTqpnJ9XTLQhJ5Nz3Daz3Y9YQUNvAMYlK5Gaki3tT3OG5BAgquhYqPec6BeZZBwKyB73fNP9BmwKruvWHIWf0XxcifrHUxPe0dOJ55mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736039409; c=relaxed/simple;
	bh=93cO7ih7WIhVLJrV2SVsWTTFLcHHn3JayrnEWYpn+D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YmZx7Dpz8BqCDKDLKwuQFBn3tXR1Livls7sDTVTTI+n96LFp6bmoyBldoK/q3zqsn9/cry9ABWDV6gt7ksILS6E7qoXdCodSI8BFHe4Cxfs93z6jX/Io1ko9SCoJpo4/1ZODdkRFAVjgOUd/OehpOXJB0TdHX8r49PLvzyaTLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoxQAti0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoxQAti0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E2FC4CED1;
	Sun,  5 Jan 2025 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736039409;
	bh=93cO7ih7WIhVLJrV2SVsWTTFLcHHn3JayrnEWYpn+D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OoxQAti0wRUtNYl4ya3vX3tYMvfJEtuphVrZ2qMk/UcNG1Kjmq2ZyzfSVBjYpS2ZV
	 vc29LoFG7ehcr/vUYc9xWDjyJOB4ucFlGajRsK4UGEfdCkQVttdcKTbqgmWLzGFKPO
	 fkJdKx+ROXshJ6RwWGfXmRDwSmnakNdj+PcOrrqtAos4JZ6wn92ukxkIiX0LKgj7Ac
	 jwwlj1HPtDpSowjboYEk1fjC5Fl5peL9ix2gxvxds9NaSC4yQpp9qC3lIXlLpfW1o5
	 MHnSQ1CI0gl2VhiGE1ptYmKWYhQDUGFSnh3nCPcI7MbcUzf9rvxN0CQwxhEJ8NeJ74
	 hQVS/mmTiUz2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACDE380A96F;
	Sun,  5 Jan 2025 01:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2025-01-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173603942980.2526111.4204144053410444632.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jan 2025 01:10:29 +0000
References: <20250103160046.469363-1-stefan@datenfreihafen.org>
In-Reply-To: <20250103160046.469363-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 17:00:46 +0100 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Keisuke Nishimura provided a fix to check for kfifo_alloc() in the ca8210
> driver.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2025-01-03
    https://git.kernel.org/netdev/net/c/a4faa15d28f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


