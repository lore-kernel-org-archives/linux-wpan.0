Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CD2C326F;
	Tue, 24 Mar 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313425; cv=none; b=h9m7+s3/cAyZvM8IluygmRllSMkxh6BLmEARj5TNWc5e8rgfE2nIK6rokaWiCb7Ky6DDqcjtR/RL6ShCM0bELDZoNwwQFxsu4uQO4byBmEOkQOK5WqSq3eqHX6IjhyvoM07UBE2pUk8vDNh+OXV+dOOEaH3ofplqhi1VGnNZg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313425; c=relaxed/simple;
	bh=krx1trM2EwRhUXASRjrcczPnAsg8kGAhhKVfUyBmAyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TARHGg4CTRcfu+a9aKVIBd8KpqHaV2B1Gmivnxj0o7WhNgN/NOgSoPDr3WwRKUnTr/G4ROSKLzCrIlqnYzDHPXW8l/eeVcSiaYljVMPHdrCXwcWoonACO5I7XorKw///BbcwOiBHKxEcwdHJLI85Jf8CSpa07BeLrTpMBLtpA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbBWjCKt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbBWjCKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B2FC4CEF7;
	Tue, 24 Mar 2026 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313425;
	bh=krx1trM2EwRhUXASRjrcczPnAsg8kGAhhKVfUyBmAyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbBWjCKtwaEg+bEQnuK1+QOcjehdQI1VC/qpqULXoOSKM3RYkAPHFGn3oM0JGTC7G
	 edJZHxH6E0va4CTWztfTzBCCHtVnOCUPNN7eRMQvgbYhncZmrw170NAzEvr5svMRYj
	 KFWl52/53KjTXZP6j9oKEcp0aAIbKH7SA/RxMo8qadaOvI9tISxtXD53EQVg5FvCt0
	 i/XQR4+xrTxzeQLOj9SXArud6jEQnghOptGSR74AmAcdl6ezW+ajhCxWK7TjNTXZnR
	 quJvkGtJgBcpK3xAmv3Kxge3jvQvRJO5WLmKYB1EPKdiUqe6ICKGdBSl4ssdAqaRpT
	 JBG40gMdQBhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DDD3808200;
	Tue, 24 Mar 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431341353.395707.10248845346932260597.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:50:13 +0000
References: <20260305104313.15898-1-johan@kernel.org>
In-Reply-To: <20260305104313.15898-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: stefan@datenfreihafen.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 11:43:13 +0100 you wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> [...]

Here is the summary with links:
  - ieee802154: atusb: drop redundant device reference
    https://git.kernel.org/netdev/net-next/c/4e9b1994a105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


