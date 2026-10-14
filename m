Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FC414420;
	Wed, 14 Oct 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003930; cv=none; b=XmgTD+aWSyheVtL1Ysu802TfLN+3nsAExPasa/IHYACkTEdCx518maXsDntzIiffdlZMZlNBVtxUenicKBRd6c9mPAitfqDZUhypTpPfCNOOJ5YTcuAIu2zcZoF2MFYivkfTdfOJr9tG30pBobx7GA8OYUd5PwjeuvrUgvbGtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003930; c=relaxed/simple;
	bh=kZGH7MMg2Wja19RtiSj+1Amamfv1gUdu4bTkRRmWSj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YQdc7543bqk41bE+Q4uYJj48mUoJHCc/uM9yeMHgAyZ7Fq6MMMBRbOWYA+xjRYWhTK9n1LdundOKJQvs+csCp8/7i076fd3XqbB/75x96pl2nmWhMnTeCXvUM9xQyl7ISUHqK0V3wi2YS17Nu50fjOJ/G4W6Ze15HUCVWpCf0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMQs2zYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMQs2zYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BFE1F000C4;
	Wed, 14 Oct 2026 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792003928;
	bh=FbdBpumkp5+TpG0Fvg4ZlYm6pvo7OQXZOJFAULwlruw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CMQs2zYVlrOTPI2e3vvIGR/Aqn8snA0+6m88Npnasq9AMvw7t4YuRdgKw3R/7VVFN
	 pmdQzHku+yQpgYvMb5hl+Me+ObYFMga9pkOx190Z0CFUtkGi/z8JRAjjqRJH7vEmHz
	 kdRG316YHio7c+yVYgfdgoXpRgstu027FIhR/wDhy/XSjjud1m6fgWvUHEI3r6n+Py
	 Zfr0ulzUIrYG2+8AMT04kSojpY8UXdpYsSw8joEZ6RPFx1q0krxtmOfEhUXgu1JmM0
	 ye+JAMS57028W8IHoqzEhVYV93jjddpowM8iIX11HpwVwH/ATX0qbdz+6n8tnxqsfF
	 zk+lSMb2njXoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773CE3A5499A;
	Wed, 14 Oct 2026 18:52:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: protocol: use assign_bit() where applicable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179200392701.2906069.4708864552723867241.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 18:52:07 +0000
References: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, razor@blackwall.org,
 idosch@nvidia.com, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 andrew@lunn.ch, olteanv@gmail.com, sam@mendozajonas.com, fercerpav@gmail.com,
 ms@dev.tdt.de, linux-kernel@vger.kernel.org, peng.fan@nxp.com,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, bridge@lists.linux.dev, linux-x25@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 10:27:44 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API. Where a bit is toggled based on its own value, use change_bit()
> instead.
> 
> [...]

Here is the summary with links:
  - net: protocol: use assign_bit() where applicable
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab86dbf4a6ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


