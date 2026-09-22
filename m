Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382D23BD06;
	Tue, 22 Sep 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037093; cv=none; b=ozOFzHmQ8JOsUFnLPyQTOqvVMBBduc5OFLErqfyC5D1YsZ9cGN9dlpdIoG7XBJuT6GXobdkTF1rs0UoeQDfBTG02qwumKd4rvskEh38trdy+z1BPZlpr0qCtLxsxilKQ2WKsh/ajFypknX7EJ3/jc4Zr50x4cWOn4u8h7ZDU0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037093; c=relaxed/simple;
	bh=xrAoS2lbPIjmuDo3x75RRez5baTTW8g9IZOVigYYkVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCQXvVM5f+gJqUGiK1XtBvrQ+rebjt5h+scXoQrIGAQafPvgRQcUY8XnDqE7b5q/vGKTZB7SKjj3KMzBR1Eo1Rya+IajY7xLfYhMhYGNU/NhEL4TYmZy5pb0eJDKJ5cfK+2v5lPXy12qLaSizd4itKEhqJroqIV8mHZzL5PK5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDW8edXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDW8edXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D271F000FF;
	Tue, 22 Sep 2026 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037085;
	bh=+gylHeSN9wOe1CSp8YJJlUiPkKFBx1Baw+rpY728J/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDW8edXQ0fO4PPQFAyg1k5liJeWB7IeLlMX5Wu5ukbmLFX6XsF8SpHrsBaTCLvWHZ
	 KQJg3wwbV9h27KVTx+53G5W5n/j2ORLZNNJ8ubAjC0kYWX+ppKodWjJ/v4nRx7f7g3
	 XDK6sx3temLoti4wCj3s4GBVOE3lK31vpXbQhr+40kv5eleu6ZI3kPlV/+apUZKU8W
	 mkMTFYvjGt3yiQnnKmuqcmbkmvm2wyDH1J3vcBliAk4oao19bDM0UcWclV02tZzh3T
	 w8MffvFDJf0S0MkMt2CU/dGKeonF7Ofcy16uxdw1XQ52xMpc/ltbRDdey7eGXZq+xv
	 /2c7nFH9poZ5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199423930203;
	Tue, 22 Sep 2026 00:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: protocol: use assign_bit() where applicable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003701664.3305732.17812200087292035808.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:16 +0000
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

This patch was applied to netdev/net-next.git (main)
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
    https://git.kernel.org/netdev/net-next/c/ab86dbf4a6ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


