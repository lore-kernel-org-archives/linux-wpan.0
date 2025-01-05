Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6C184F;
	Sun,  5 Jan 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736041812; cv=none; b=GskWFl3g9RO4iVj1Wae3MzdavzdNBRBF++Ujm0gfOeQR4WrNjS/SG6Zarw4ewZzLFHdimJZoHSy5QjO6RlytTakorywjioDwlBm8sKxKkY6ke8eV1jsBrodXJW/xOonhAjaQh3BbfDy8DoeiAPVLbzaH0fcmTUnBgPP+lw3i6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736041812; c=relaxed/simple;
	bh=fHsK3Juz2eebVci9ayXiUNBsoGNnMe3IgVMzlGIZCto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8kPvOG7Oh248C3UX2noEbBIQQmrTHtM4A4/NTA+RmAV/vZzs+60fndQ5QhO0MvMX8JO/wQOa8YxKEY00cRGCTHLqAc4NF2fz0mpyDI1Lhopms92YPpRX18qY0EEFbCzhh00eu9kxgW8Z5RIhdC5NSL1gKwrZsOoCCpLhbk8EKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Xer+J6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Xer+J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFDEC4CED1;
	Sun,  5 Jan 2025 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736041812;
	bh=fHsK3Juz2eebVci9ayXiUNBsoGNnMe3IgVMzlGIZCto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D4Xer+J6bpii8+UxwCQjOtG/P/FeDdUJ8QXKHiEcz+dhbqbBo6I7sxmGYxzyzw0v7
	 vWVkoVruFu1YeLKP81GNm7yluOEuxfs8k8c2aWQCnY8WJ+YjbU8ZTOP25VVNHfXVlG
	 uHOedQbIKFf6HqMTSSQFP5nOIqdQnMDL0drRXHoBvw89QacLUPgeVoTjD+osddaMty
	 /u67Ra+DGuZv+ZbQD4veBwI4B9tXXXgDB5A+2jVw+Kc1LZPDpJrWRN3NPEQpNlHGB2
	 wMwmeEXvHqLjDDeJIlfUmHVxP+6yXC27ZiSLXZWX50PjF1diNjwsHHPBFW1iuJAfw+
	 /XgDhAzVzxeew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2B380A96F;
	Sun,  5 Jan 2025 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154-next 2025-01-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173604183274.2530845.4792479222536964181.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jan 2025 01:50:32 +0000
References: <20250103154605.440478-1-stefan@datenfreihafen.org>
In-Reply-To: <20250103154605.440478-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 16:46:05 +0100 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net-next* tree:
> 
> Leo Stone provided a documatation fix to improve the grammar.
> 
> David Gilbert spotted a non-used fucntion we can safely remove.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154-next 2025-01-03
    https://git.kernel.org/netdev/net-next/c/3e5908172c05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


