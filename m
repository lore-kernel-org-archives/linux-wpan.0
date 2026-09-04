Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71244E652;
	Fri,  4 Sep 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560483; cv=none; b=hLgMl/YuZ2T9pdFvsb9XGt0DXTJIxd1E3q+vE3Vj4NJh1N4ltzmu8pzculDzGWtCAiZB9dejHyMeTje6i4Z0HhgZoXIjm5i+oMG2w8vqyIaB051IWqibtatJ67/qxxeBkwa+re4kbX/nvRQMNX46FQyAkkwqFoMZc3yVCcufn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560483; c=relaxed/simple;
	bh=FlrbfR3jV/MNfhkdzPdnZiAgX3jk1Jwfds82HMGKsDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lr1BfjXvTE1abGzTppUxIXAPEhNdA5FzrieSsW2Fmpurp43Bd0/PVQ1BAxUUwAnBjjb0BYQ7QjwGWzw/LJSOf4f7aImr27PyD4y3lNaYsUHLCitXHDzS+QTKvrtCUhnZB/GYpHCRcKRwet162YevmVUWgLErLMP+0LT6rbPu3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxnnVqzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxnnVqzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A32C1F00A3D;
	Fri,  4 Sep 2026 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560473;
	bh=nTpNVlI/Ot0nNaTi08bgbwLjehduYjfYTbIjvyWfr74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DxnnVqzUAiMSmgwv4ExHgyopZSwneks62rh+vpESIly9QqqUPbtWCgqxCY/LeEGRE
	 AbjOcA+nt0MLsUTHUsLNO5XCbRNtIQ9wvOJ8Oaqm7IdOw7DtIQaa5mHwHD4r7t5Z8Z
	 5LVWWMfnHwrczi4j8F5KvYpCHVB7jIebbdETAH2t4TX71GZpnGlirM9wcar1mkTxx2
	 GgSf6fPJq2I7YZ3GFO/OusBZEvQ3I7YXw8nvekStC/Fm+oIGKh4EKE4HlMWFwqJWC/
	 iCh5IjESLJjFsx74mUT7B/xSWmtsKUGTsDIDq2j5JOTaAJN8lUlSqszp2Yhp4n6vmF
	 uK6XRMqztHgSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19ADD3924A7E;
	Fri,  4 Sep 2026 22:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2026-09-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856041367.992241.4070153041479622832.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:20:13 +0000
References: <20260903093012.4032586-1-stefan@datenfreihafen.org>
In-Reply-To: <20260903093012.4032586-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 11:30:12 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Zhiling Zou fixed a NULL deref when coming from a TUN device.
> 
> Fan Wu fixed a UAF in the cc2520 driver.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2026-09-03
    https://git.kernel.org/netdev/net/c/fb3088dc5811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


