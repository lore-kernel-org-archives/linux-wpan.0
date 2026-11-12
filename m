Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445206;
	b=BJxWihDyh1sjvZ5NVBwVJX53MLw41jJg2CaYLYE1MSNEhvYyA7gdNWgm7XVt1uZXRwhb
	 5024PeNCNzYIWPQwqJER+AlO5AmLQA2LZTPBu5V71cuNoCsbLbaHakG5k0qg/BgF58gf+
	 E1Zaj3zf1Gi6jKjPUVojpiVi0rphUioxqK6x4W8teP31WDWRfwwSDAzLvxNvBzmPnPbJO
	 vWG8UqipZcg7dAkhPi/BtjgIJFqSIRqBAryKda0/gQRJqjBLGZi7yvLw5wowJKBiulInC
	 s+fUUn39JeVRfkypU33sii672rC+7eiH534lEtnyqFqqEeB0QAb3AdXh9boq1TSZi1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rw8fU+RPNYfzHQgBcgq/+3Cakn9swjOarArfHTPFBo0=;
	b=pNPEDzatSrZJOMWdjjdyon1VUtPoVkFrszsgNivdFYIbkfnbSeDIMXRI/gnfan9IWm41
	 KPmOuddEM49mJiTUVazlZ9DjVcXx0CkPSskgM2BSfuDO1qqB+5DM+hZ2NJ3+JOiT6fXOZ
	 86M1tZRS3s8c1owGRmpN64Dx+SITE/gKG/H4zhWjoa/ANnmaZun/4dxdM5ApNjzr36UIn
	 FKm7D9Y9E2cqQEUgqsJoUNL/tlPB7TW7KgkKHv++lb28C/Gprap+UhfVFZVeQxvBKXGvn
	 uNOOMkdPNR49cxxOkP4fNxxINsxmtIQ4pn8/M5bo6+3yQlG6OentO3MnDIo5uyBG1rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEBt4GWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C7606A31C;
	Thu, 12 Nov 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEBt4GWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A961F00A05;
	Thu, 12 Nov 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445206;
	bh=rw8fU+RPNYfzHQgBcgq/+3Cakn9swjOarArfHTPFBo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gEBt4GWb99VVhrLIN7fOwSl3Q6+39cJ+jRNN6prlyM19M1GNAKN44h90dllK2VsfS
	 TiPS0u1Hdr70b6HNIsp4cWjcqBD60EZ47VLynnYsDJ2MhM+uxTARZizShHh+8DHfzq
	 9B6CVdWTErAt0ssNZadOIAqQrmXTvBnDr7IWIR+AMJpX4hXrElvNvQLKLNxG9LPhDr
	 +iTLo1BEidOkLPDY1+H7a64cE8RwjofVe4Sm1l+iSvRGNm2wYC5vrftqHuRa56lCel
	 cS/bHO8uokMVh8lHx+76AfzIydS/fkwSk9kV9m4/Elo3DW1iFN+wcYxobEvp0ko7je
	 QoMw5n8tp/gwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D825D391AFCE;
	Thu, 12 Nov 2026 01:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net v4] tun: disallow setting IEEE 802.15.4 and 6LoWPAN
 link
 types via TUNSETLINK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444520444.1739789.1727685745049840269.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:00:04 +0000
References: <20261109083037.22337-1-skalpesh942@gmail.com>
In-Reply-To: <20261109083037.22337-1-skalpesh942@gmail.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 14:00:37 +0530 you wrote:
> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
> via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
> recognized these types.
> 
> However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
> interfaces:
> 
> [...]

Here is the summary with links:
  - [net,v4] tun: disallow setting IEEE 802.15.4 and 6LoWPAN link types via TUNSETLINK
    https://git.kernel.org/netdev/net/c/968f2b94a596

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


