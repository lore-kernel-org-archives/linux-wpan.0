Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D51D5CC0;
	Tue,  3 Sep 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390628; cv=none; b=aeV+W3mjZPdRHkXicm+smEhfpg7f023+1hJp3aOeVRDZ4bP1gOp+/CjSQma8cjezCFBFcvSgGj/rTotxqz+5jd2FZIB5dDuFS3VGuTOlwZHIt+tbWae16dA2WESAyB9bkXMPNyj6eOcoYdgnCmiawIOhc6Jcllo6ARXoIV6Kga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390628; c=relaxed/simple;
	bh=c8nYbOPawLoO1JYsTEp9Xsg/XNh27k9hR48mh1dHua8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mN0e1x5Yp1mKmutrUG7HfBk2bmtr4xGVKhKtrBqaUVtu9QjoH1v8szc8eP2kTt66euNwFvSUi8yiuZ+XVwH6FRiGLL21yfB1rGp2642WtwHPPPL7KidlRIhZjka9CkebdgjG+xUCSBxVjIa94PcEebGv4dGdQfbKO6QEpL6PrMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzNwEMw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzNwEMw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F2C4CEC4;
	Tue,  3 Sep 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390628;
	bh=c8nYbOPawLoO1JYsTEp9Xsg/XNh27k9hR48mh1dHua8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IzNwEMw3DvCVohBk08UE5S7SSHn+nnTWmoAoCEH/tD/E+SFhq05YTYvYeoVSznASc
	 uv9zAnPnIsfgl4V1VNjEtnVvuSNxhhBN2R5NYoI/78F8fh8OZsJUQHqp+peQeTRTb7
	 UpuI5F8StCm6XQ9g/K+0liUN+16EjdmRskjVRtzA4Tc1z27Q857aTBfazzCQ78X7m8
	 8qQADLCssydnQU5QRt9F4lXYTRvCgFnofrY3sMS8YJND9iy93aZ2bsFx0yJGI+MHwR
	 B8oLk+onv1w3XoC+UHQLBwX+QLdACnLUVWfRfe76gtDrpAMdDmrvg1ekyebsQhd0VC
	 rUQnCoQHU3Wwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDDAE3822D69;
	Tue,  3 Sep 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ieee802154 for net 2024-09-01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172539062877.409367.12269030715500042500.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:10:28 +0000
References: <20240901184213.2303047-1-stefan@datenfreihafen.org>
In-Reply-To: <20240901184213.2303047-1-stefan@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Sep 2024 20:42:13 +0200 you wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Simon Horman catched two typos in our headers. No functional change.
> 
> regards
> Stefan Schmidt
> 
> [...]

Here is the summary with links:
  - pull-request: ieee802154 for net 2024-09-01
    https://git.kernel.org/netdev/net-next/c/7f85b11203dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


