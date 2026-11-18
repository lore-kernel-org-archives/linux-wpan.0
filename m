Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960006;
	b=0gyFmy+HjO93G4jSjXpmWmUFXXbpFea1FhbiLw7KGZJ4ErSZqAb2+14B3UoUmmlq+r5e
	 ZRX9nNnieJ0EldnLCMkuuiv3wfMfox02E5SC+md5LilNAQY4J0nBFxuQ76LU2xerDhZkw
	 AUtM0J2CIYuU2gTK8d4cP7r0OoF4Eb987rgTxxHzDunnoELP3gIBzRlDNFqlp9YLBitcM
	 X8RHcV9GZXaz0cx3aM15invDkI/+nKO9BJRACpwlcYENdRYXZ0BjWzs0TMGr3AhmXArZK
	 uT8eSqQ0z21z0iMeB4lfGgIsSXd/NgF6hut8iqkTAStYxGO+yfgBqSKGPo+9V1mIQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GiURft2QvxZZWpBbleYcT6aUWp3j93QX8hyE/waAhkI=;
	b=HvWdJz4okV/WAE0wqrHG7DCZqKrbAxTqz/LSzUr03g7hBQA75h3kNwEAufLs+q8GsXsR
	 58TzQrEewVomcjbecOI8gtSxI38idJqcnRCUkwc44Sae7DrfRtzsGt5jsEmOjvu/2ozG0
	 leOGer30X3sN9qJ++tmPRBXq8C3iDu12mvn03E7xrQsVM+7QneLPtN3a+J6QDSJiyYCg4
	 B8G4Dk94VrCuR9IT0+yKJBqOtICnAXau/A1hGuwBTjVJ6V/LHyCKdSSxOoVA4TmbwKSD6
	 MJ/BXyq3vsjb8H8Z0L4hNJAf//KwKUoBX06SyvT8Ynbb26wFDL2aLFQgzA48/Q/H10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HihnQWwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AF606A31C;
	Wed, 18 Nov 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HihnQWwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847641F000C5;
	Wed, 18 Nov 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794960005;
	bh=GiURft2QvxZZWpBbleYcT6aUWp3j93QX8hyE/waAhkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HihnQWwEt+HmxkvCUUW/vHvLD4nn2UOUERi6fPofv46VDW78C3+ygUnzVxMcMEiiG
	 EqvA0n2Pq583E/3wyQJwdP26WEAbCXLW04bSHAKpA2i1DVbsYaBcjbvT4iX4eg4KZV
	 cx94l2VbxGi7WiruEVZHROXl+LZkaWyo3YCFgAs8jydkl8Lj6dE4SS3z4nw3tTFfIS
	 qf7zVy2pxS1GoXZJtNQEyj+IWUKbjONeR/0jGmFatZohXF5YUy8XiLqHioBoynbN0n
	 yZGuw0AyeKqabZZp6VCxkys3FGAN4CtiPcks0jGEXt7dIzmUuYJ9NE9ny5BgxQb5k5
	 Psit5CzoaKJag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773AD392B1FA;
	Wed, 18 Nov 2026 00:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496000428.1359162.2050059000473015924.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 00:00:04 +0000
References: <20261107093601.619363-1-tjdqudcks0424@naver.com>
In-Reply-To: <20261107093601.619363-1-tjdqudcks0424@naver.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Nov 2026 18:36:01 +0900 you wrote:
> PF_IEEE802154 DGRAM sockets are available to ordinary init-net processes.
> Their family-specific SIOCSIFADDR path calls the netdev ioctl directly and
> does not pass through the generic network-device setter capability check.
> An unprivileged process can therefore change the PAN ID and short address
> of a separately administrator-owned down WPAN interface.
> 
> In a local fakelb fixture, uid 1000 changed both identifiers and the values
> remained active through a later administrator interface open in three of
> three fresh KASAN boots.
> 
> [...]

Here is the summary with links:
  - ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR
    https://git.kernel.org/netdev/net/c/a0abc1e4c9d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


