Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0DF423147;
	Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200692; cv=none; b=MDNnPQhPVfDBbS9Fvwqmc2a9nPIJltmY8oZj1rnD7Wa4vAjfJ3i6gkJ4tsI/izZTCr877MALYv/j6YWFgs3wKCcWkSt/hnqFTujN2b/0UPQ0XCuOZsBy+2uDbRzkWBV9BdIdcAdiT5gByhnJUb1FXtW+3pJ2N6/VrlmRTXJVpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200692; c=relaxed/simple;
	bh=bDUkAmYtmD4pItY4TPuaNON76nZaykXKFC5g+En4bJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAagCbv7yUKaCSX1UoVKFHOW/ob3zWUb/7nwuUk0R2SPcywukBCOMGYo5JOT7B6qDj54wnswB5RD+SIjdxLVbNkIu0ftp6MaqajQsEdK0EGF/9Hjxpx0nTtT4gBOVer0O5+LnGDTKyaejM810zwd7hqqAboqOBvATcsxo5QwHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlv46Rf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlv46Rf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E411F00893;
	Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200691;
	bh=U/3zkkWJvcg3IxQG2o7h/eCFA2CXQIxPRH111Q5EBT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vlv46Rf1BEJGLGrXMQWM6NHG/IxWBDJDmIxbiVW3GUKU8BjyT+eFBMPfP6LZ7cDci
	 HvVwW+ae19bLNK+S3Ahf7tpDnju6Fo7ja/DTAmNp2vwzx2ddG6A52uPutriq5eSZT7
	 Jyur2dVX9mUMtunk2DzgQi6chOGht+6yhHeufIbIRmucUvjmN9qjBIOmyD8uKxxzCr
	 WVpZHrh457ucOJ48tMPG8IWAk/3lEf/0RuU306QWOz0dlBMh1/E/f+RWVYx9dojCgV
	 DPy5CpA5VDac12wamqfryaS57Ib1WIO9KQ9amhBl/yg5OY9Py9b2M6yQNc2z4q/ucv
	 WAQiW6zR0Ooug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199493930F87;
	Thu, 11 Jun 2026 17:58:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] 6lowpan: fix off-by-one in multicast context address
 compression
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120068868.286318.1150941519711898889.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:08 +0000
References: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, alex.aring@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 16:18:01 +0800 you wrote:
> The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
> &data[1] as destination and &ipaddr->s6_addr[11] as source, but
> both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
> respectively.
> 
> This off-by-one has two consequences:
> 1. data[1] is overwritten with s6_addr[11], corrupting the RIID
>    field in the compressed multicast address
> 2. data[5] is never written, so uninitialized kernel stack memory
>    is transmitted over the network via lowpan_push_hc_data(),
>    leaking kernel stack contents
> 
> [...]

Here is the summary with links:
  - [net] 6lowpan: fix off-by-one in multicast context address compression
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a58899d1100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


