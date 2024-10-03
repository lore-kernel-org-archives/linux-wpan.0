Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EFBA49;
	Thu,  3 Oct 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914834; cv=none; b=SwhrepU9/ruuJYaj9AQ3eYZ7cpSNoyrqCohHC0oVfRCaBQ3KVAOyYDil/UaeyJnwl+EuYJ2/m5nQx+0NTuJduJQNEdSEVi6cu9eXWieSHoGU5IkhOqJwVTdgtAEi0kgW3OIZzyOB82S5CD+fEKkadB93xyNl7Qnu5zC/VkRhGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914834; c=relaxed/simple;
	bh=y5Qq5Zmg1rl0OEUIQb6X8iY7i3KmVYyZKymFaB6N02s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ol9p4Z3ZM4yD7W2k1idoX8DHYhEqNRG6Ni6Oh/kCeg0EM4cJJy9jq3ITL4Yx0BGqcd0t75bRKEXrI2/bYYNaHgMb5TApq3zNvoQiKx4jTugE/gVJO+/m7reZnPDLZ/lbUzV9lMmMSeJBDmGKGu6U8XK7ErtiQ6cEW+FxjVz/OOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2y+naGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2y+naGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4A2C4CEC2;
	Thu,  3 Oct 2024 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727914834;
	bh=y5Qq5Zmg1rl0OEUIQb6X8iY7i3KmVYyZKymFaB6N02s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f2y+naGHgczdRTBjlATBH/aDbucPSHigvCZ+EwlSahm3OQv/vn8CPWKl6Z7wmkWqP
	 ME3JZjyA0PoSuH+PotFsIx8B2u7FSZcYUDQJa3YIRZz9XyGKlQr9MaKP4PrNHjvHhC
	 QAQwxlpQ/IpNZdY/MXnlXtBw14W4guzR6KtdP8KRUQrKnNek1qeexHH4lar3Y2k4Do
	 Le4s7k7ZpAy6jO1XPzmbkcG0IslnLCy70ZeT8qe3Pn9/GjKNEPgxpEqsvv7YRFpeDZ
	 USJxCyh7UKHVC0Z2lkUM2nzBRiItAcWpPthbLwrkMbKnV2uI/YPFhViKsXH3BclxXa
	 zhQHqYBOkAcPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7E380DBD1;
	Thu,  3 Oct 2024 00:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2024-09-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791483728.1382939.3159825793349245389.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:20:37 +0000
References: <20240927094351.3865511-1-stefan@datenfreihafen.org>
In-Reply-To: <20240927094351.3865511-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Sep 2024 11:43:50 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Jinjie Ruan added the use of IRQF_NO_AUTOEN in the mcr20a driver and fixed and
> addiotinal build dependency problem while doing so.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2024-09-27
    https://git.kernel.org/netdev/net/c/cb3ad11342a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


