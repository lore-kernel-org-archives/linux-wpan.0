Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D8360EFF;
	Tue,  2 Jun 2026 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367404; cv=none; b=Xxi2EE8XzmzVe133r3EyJQDi9GKyciWhuUdevuSUZvgLsinX4ryQ6NGiFtO/5KV7F9ZLsKOAK4HA0bocOJDrn1wN3Ig2aTyJrzrxKDBD6d7LPqoOfkoRSLHGujvxREB5FWdgwmKmS7NP7F1CJLa8IzuFW/3Pjnsj/LbBfS0Nvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367404; c=relaxed/simple;
	bh=nw9/t1jHsZZPhclU5hIT7EIOeyHOsBRGb5Vs4GKUqxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxWVFIVXlBawW0fRcMHu9MMvqrqluTghGYdPTU1dWWvuUGAbePddD98vCThmH6OHTPcJ7CwrHSNKBWNHChnLnj2ObsSLoz6d+q+J6dH3OzOpnmGAVO0WhmEcv33cKrxKcPt6x9qG7n4TWqLuJonnsHC8bfk3/3Zru3Udj1xma4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7fwm83B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7fwm83B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704531F00893;
	Tue,  2 Jun 2026 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367403;
	bh=yAq2xlBKXNJacMsYTq0rhFMMvLLHesg2+GnmPVXK+dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c7fwm83BcNBRwMcMBnhXNMYryVlyOvLekouG+MMvyYiMLuD8NKddEBWNX6/HPl4Mt
	 w20/+DLdLeFfQFQAUD50Ybl1h9zKGe3B8IpAw/y8J7Vfzafo4V9oIbdretzVgq+R9B
	 +Gd+6VWw0ERLpLRxWQVpqvteA89VmLWNADkYuQOQ+Aaim6fN6V+xvxDcRMERIFou2o
	 3l75Mm0e9vtCea/E+4tc1YP4YzUahkeVizrjL8kNuk9ZqryUptOSp285m2BpHx0uap
	 ViVsltMI8tVs35tpvOnMIRjZLC/rP2Ui7RzBKuwIRfr73y8gvgxUp7hU+J82WuzD4i
	 /dRQmxcTVNxXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A7238119F9;
	Tue,  2 Jun 2026 02:30:06 +0000 (UTC)
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
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036740541.211970.3874244656503204922.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:30:05 +0000
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

This patch was applied to netdev/net.git (main)
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
    https://git.kernel.org/netdev/net/c/2a58899d1100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


