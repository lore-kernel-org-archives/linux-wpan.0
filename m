Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703E17736;
	Tue, 21 Oct 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006027; cv=none; b=VdOE7taYjPn0RQbqvpcTWU4ZIl8/BERU4a7ru5OB0raPbmihVDmCXreEUv10w6C4V1MUfy25oXlFB+9JuMlK4Fmo29n/B6hb71ZGIowQJzwh1jR6ljTXwNxGO4BAZDnVg634Lco8MkT+pj16omngaB2thkQV7xxQsb3Ydt1u28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006027; c=relaxed/simple;
	bh=kjoJL4F+dxLnfncFX3OgL0yigXMLmBo/QLKPikXHaKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fo7jMP0MezKOuduO1IRv+13aoDMiF/dAAormwqtlNUIUErXsYCOLqDVGBxPTX6CaL5ip5Nnk0d9QemxgglAu47QTLPN9VSQGTnCJ9suGXHh/wy7E8PmyMZTVNVJc6bhGUMjDvpXXJpysasvqk53GR6ZMS7hSoWIwYzBWtSqlRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4DYsP2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4DYsP2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BD0C4CEFB;
	Tue, 21 Oct 2025 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761006027;
	bh=kjoJL4F+dxLnfncFX3OgL0yigXMLmBo/QLKPikXHaKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g4DYsP2gWvOCJlV2BMSIU9zmWgYv+ktGKqABWEB8VfU6+qRVENqiBqxIW8lBn6aF+
	 9ob9d8jncE3bPyc1rM8Yfx08eW2ZIHPugBSz0fb+2vGdLC2xPdnesWpKad2an/qxKp
	 LElAunCSe1iS+ujPPHdZOvSehl8EDx5kH0dtbVxNFPBx3t95bLufsNH1Jo4XFa/IUK
	 VklPoB4pkVirDT1uh/NvV8yckvwIuYqR2XpDnazmOKDkdNsDNxLKR+80qS9FfHpH9W
	 0vEvsmBb1M9PqwE1FqNSeaCqAS0I2wTVDbREwWE9hJ/pJwjxcpf4iouLp01uCBYsa5
	 l/YaeTPl4ceUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710213A4102D;
	Tue, 21 Oct 2025 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nl802154: fix some kernel-doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100600926.466834.5768353468531245075.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:20:09 +0000
References: <20251016035917.1148012-1-rdunlap@infradead.org>
In-Reply-To: <20251016035917.1148012-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, linux-wpan@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 20:59:17 -0700 you wrote:
> Correct multiple kernel-doc warnings in nl802154.h:
> 
> - Fix a typo on one enum name to avoid a kernel-doc warning.
> - Drop 2 enum descriptions that are no longer needed.
> - Mark 2 internal enums as "private:" so that kernel-doc is not needed
>   for them.
> 
> [...]

Here is the summary with links:
  - nl802154: fix some kernel-doc warnings
    https://git.kernel.org/netdev/net-next/c/370157293175

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


