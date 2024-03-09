Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B210A34;
	Sat,  9 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709959231; cv=none; b=YVCAtNUd3tENXIkbQvvwBCUVcENQ8+CtyihaMbqmULp6AlI0W7chbIfJTnaGm/a76JnqALUrDJ/HX+CK9fyY7J1jURsCSXk9s6gZkBJGsDqCNI9BOgT3Wpvzlf61BWza+HL4SoFD4quDfnGTMT7JeSYOK5S88HHyEeMBP3NJFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709959231; c=relaxed/simple;
	bh=fJIPG9UQLUAFLhv0yJud14lWN7eoQYLxdALEouubRUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/qU8Ig2p0o7MuOIE1MPUBo1Gad6hTkI6f/L0loQHVGfGPNY3RlNCsuRDh6s/B7n3k33W6GYi9TbEYytUXFIG5/RNaIkYDfrqBl5M9GuCSMsNbA8NUsP4U55oq+rv02XPSNx76RMaohjE/kvDZIibJGFPDLFAyxej5Dz3IE+46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk4PJx9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk4PJx9d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E66A6C433C7;
	Sat,  9 Mar 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709959231;
	bh=fJIPG9UQLUAFLhv0yJud14lWN7eoQYLxdALEouubRUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xk4PJx9djjhz5mE7qYKmmK/5ulO/LQfdhh7EAn6vrWNs5fSjwuf1HJ+Ls1MIYTwub
	 Gwe8YEW7jYBLrb7aAT/5DITX1Rgekpnfax7db2+kmkgIHIdOdXmSDEiujmiqqDVRQx
	 flNhJTphgGtduSNA7uLIAYlhuYSBleiKwNBVE8nuYhH28bKT0TE+W29hvcKeN0RHjP
	 T6U73IG/pwkzqGaupvRcbzpoTRu7sHqUYSQbRpFT7XjIbiwxMIeENPHLc0cIFcAKOB
	 l18C8DIDbxVZLQ1gL5ieOPS5HAow/RflYwCReCn0Iwm7m2CRxG+VkdYF620Ne+FkcH
	 pY2XV3UqqTbVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6D3AC04D3F;
	Sat,  9 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154-next 2024-03-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170995923080.2022.5674268528661372119.git-patchwork-notify@kernel.org>
Date: Sat, 09 Mar 2024 04:40:30 +0000
References: <20240307195105.292085-1-stefan@datenfreihafen.org>
In-Reply-To: <20240307195105.292085-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 20:51:05 +0100 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> A little late, but hopefully still in time.
> 
> An update from ieee802154 for your *net-next* tree:
> 
> Various cross tree patches for ieee802154v drivers and a resource leak
> fix for ieee802154 llsec.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154-next 2024-03-07
    https://git.kernel.org/netdev/net-next/c/2612b9f10c5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


