Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795267919;
	b=pVgqQTQ2vajX9pANnhkxptW55FZUWGyriE1DwUkvOYmevwDXoVPLOT8R7R93n+XU7/fo
	 bwg7ajA+sYApEzRAv0hwlbtIM0Vn9ndUX4uBHhdgXpNuXIsTgvR7wZdM8boz0pmKjZZ4v
	 r8bWp3NJTHTEWBK18PLdXGncHCBYBYwniCQalnl0bFJQHn7CwzbPtYVlO+Un2YKSv4WFk
	 n2bBkcScaDL12Zd9J0uaGnY0fY1NBtpPpx6HXBtDNJqkWq0sN8ZGhCMbjQXBck/beFV4D
	 NVJKX0MXX9ajr5vZH6JkqULJ5XvZjv+E6f5WOcJc+9Z4wzHsaOvPaw8RW+UjfK9s57g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795267919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=Wk0zObl8wRUHDRi5zjx+Z/1qnEvhFT9oAzEHyM0+5233BZnlwlwqLMx0xQfQhAPDGuId
	 FKSToMrWu9jeCdqkTaeA1skO7G8DZ747udcZ7ixXnW28iBAw94Wzn4T5kfS1Aihc6v5lc
	 MjehM98QyjQ/BJEsh5BPqxXxY7i7Ko8ilF5YZO8PVz+iDN7RNVvQ4sJNBzQ0mvpgoC2As
	 6R+oXfAV+lHfRkt/Es9lq6iCEaAl8/exkSI4uAO+0bz29MMZBitZwfsnWsMqf1LPK1ge/
	 Sz4mmSgv6sFsNC/J3LCBwI/NsPNYxQDJ/yVHfAAF7e7IFXMnSNt5PMiUSfwgWGQCziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN8fg0a0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E91606A320;
	Sat, 21 Nov 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN8fg0a0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D841F000C4;
	Sat, 21 Nov 2026 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795267918;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AN8fg0a0rNgxCVyj09uAIbl1T6EZsJl+C2dB+l0A2ietU7ITH5zOW3vKi+pwwk1Ss
	 1laOxSjEthgJllhe7VzezkU6/eCzaGXgm8GkpmO0OeYIoVomJIMRssmThx5sAAvfbV
	 9LOhebrrq1Vb7Map6OoKOeycrsQE5btE8Pkq39FR/NzqjaRbtQ655HO2Uq9lF7+CNN
	 rCq+wuhRqLaYV2QUh9oJ5bEebarQiz7iJejMKEneUATKfPpu0ESHZ3wYcya4LBkuB3
	 sIk9T+WxkkdIPO0hMm+7ikrjzNvd/GZgrgqj12BXSMA1BFUoN/cKvYRmi2z1qBf5ZD
	 1XsUE5So0Cocw==
From: netdev-bot+sinfo@kernel.org
To: Lee Keon-Hyeong <leegun25@proton.me>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] mac802154: fix duplicate association handling
Date: Sat, 21 Nov 2026 13:31:57 +0000
Message-ID: <179526791776.3294.14103729218391473997@kernel.org>
In-Reply-To: <20261121133101.240921-1-leegun25@proton.me>
References: <20261121133101.240921-1-leegun25@proton.me>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
