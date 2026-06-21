Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B764371873;
	Sun, 21 Jun 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079269; cv=none; b=eBbiFJ3guqiXXbeAXU4y/Z4v6VFv7EklFLErC/oSZ8dsmMcExLBtFo3wW60OXgDv1SSKezEMe0pu3vtkshK18wq5SljznLMwiHBVRl7FUclR3SbdLauFBOH3gdhrio8HvSjyepUhfeEyyNBf+QkG5hVRHv5szZNXSqyPwRZiwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079269; c=relaxed/simple;
	bh=OmtCEXoRXr2eGxNmEGO1gSON5B7dXjYwZpI87PMpR7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP2xAxynlR4i3USDxuviBkgm3eVviJNqIqqlAJW7G705RwH29A4KoHbYh/KOCqy1/4gZYuOnFhjZKft0EP4XVzQCgUxHP20fyPQo6xSnDtndGwWwPBV3q8ahllO0J3KHL/nT39VJnUCi/eWl+x/F2QIQI8gBbWugc3UU9utDPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogn4JXQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogn4JXQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC11D1F00A3A;
	Sun, 21 Jun 2026 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079267;
	bh=iNjPU6HggFuoVA4ZTw1VkLefgRzbA46/D12Fn2e86t4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ogn4JXQ5AOjyBVu9RdfMxiGA6oO5GEQ6HHmWWo1cdNic2AyOhHGXb0ml0CEMED2I/
	 QR87cTLfNF9MwNevDiM8b6g1lZBFcrE2E9uVuCE0kZ4O4xDNszxEy2GCWhyQr8wsXK
	 cMU+sJqMi+BM7BB1gDTCcYzOhiftIPUZi50h3X7vJMS6Ce7AwZYi3mYRyBE4bYdilf
	 1FzdvjCPota9DF+keTLZ9hclY9huU6z3PfRBkLb6RTAluBxjycrmaf/GGp2j92w5Ns
	 05nEcybd1CLb5X9wOugZJde+owlMCniUVnkmwH0ICnfq5T2X9F4MSBpN0LFdGimagD
	 8bnZLgTos5tKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569503AAA6EA;
	Sun, 21 Jun 2026 22:01:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154-next 2026-06-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207925927.516339.17557918871659939971.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:00:59 +0000
References: <20260620174903.1010671-1-stefan@datenfreihafen.org>
In-Reply-To: <20260620174903.1010671-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 19:49:03 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An overdue pull request for ieee802154, catching up on all the AI found issues
> at last.
> 
> Shitalkumar Gandhi fixed problems in the ca8210 driver for cases where we could
> have a leak or a pointer truncation.
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154-next 2026-06-20
    https://git.kernel.org/netdev/net/c/617fb6fa9c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


