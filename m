Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA52E3FE;
	Sun, 20 Sep 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863074; cv=none; b=mMLK18uQY9ZlCuuRBx6CTgjxscTnH4jget0qkHmFvfkN2mV85uEGEBgk0Qjj/dRvCyeWU1yTvAc0AYoSwskP2b6e+GmOKP6EFyNrk0JP6W2b2EaL5HuCaThLdzwEikPu7+JI4M5yvuwYydXmTwc4bnV0EF8ILz74stJ8/biesU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863074; c=relaxed/simple;
	bh=7vUTseSL+rJ+6R0iP9wFxY61tMSAYIJa1+x6gTZq+48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQ63ix9/zrdWlUuL5dI18jxRI9Sp0g2fXgHSvkJxyvodtFRIYfcZcRiIhqNMYdIQ9I+8BxEKRoH7GFoZO+7nmVbHsLkO+eYbQB8wkCo8QxhtiBD1o0DBBT8xIC0lFFU1bCClzTh5WzUGLNbRQRbyH0I86pG+zfMhmcrvaPbcKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT2mXWDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT2mXWDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FCF1F000FF;
	Sun, 20 Sep 2026 00:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863072;
	bh=qjfOALelCpaMXzihyQwvcXJ/N2dtlvY20KC9O+XhEUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KT2mXWDIB6DRk/grXGwd+890btLYChperrJJPYzWoU49SiGbgBJRKL5HzDGXy75b1
	 0hJ5pEtVVgTZfyg550RVUU+MpxASN4z0+AXUnymzsxT+8v+aV5Yz/OA4d8cHEi5Jzn
	 8C4yhlgTQAUksWCe5W/OAuGiyw3xwd2Ph4w5DSTttWcbq/EDC22TQOLcsnJL54CZsw
	 fD+T5bcEeso7nL3y2gd3Hnt9BYEZfbAaFYj80F3/nfTYVQ07eeg7ha8q22mFjq5q9I
	 ln7XY19yE3CYVDt5BsZj7W8dz/5BhephNIc4qHXoDII1JbJssIyy0cxbCE/PbkChcY
	 qpVndkEz1x7Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A53924A46;
	Sun, 20 Sep 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] [net-next v3] ieee802154: avoid deprecated
 .ndo_do_ioctl
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986300540.1499536.16990573585709011019.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:10:05 +0000
References: <20260915211538.1519815-1-arnd@kernel.org>
In-Reply-To: <20260915211538.1519815-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, horms@kernel.org,
 security@auditcode.ai, kees@kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 23:14:03 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ieee802154 socket implementation is the last remaining caller of the
> netdevice ioctl callback. In order to completely remove this, add a custom
> pointer to the existing wpan_dev specific operations structure. Since that
> structure is currently only used to wrap the 'create' header operation,
> adjust the naming slightly to make this more generic.
> 
> [...]

Here is the summary with links:
  - [1/2,net-next,v3] ieee802154: avoid deprecated .ndo_do_ioctl callback
    https://git.kernel.org/netdev/net-next/c/52fb7cca01e1
  - [2/2,net-next,v3] net: remove ndo_do_ioctl handler
    https://git.kernel.org/netdev/net-next/c/d98a52ae914e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


