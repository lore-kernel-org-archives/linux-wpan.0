Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778120;
	b=FTyceRWSnlWyH3bh1zmiwp9OkKejhRvEnk46qdKXjL6qkeNcf3D6o9OT3RXcfb8HuZVo
	 oKXG9RkrLa+SE8N5fvhk7nNCvL8AY5lyAT3smm76Y+q4JTqFJ4Nfj9lWKVfz3NUu7TE8W
	 I5b9ilffd3jJWzY0ZhHIxlCovegkn5Q4k+oxKSJWi4hG+E+4Xrnwnfyv7k6XLrWsl/5wq
	 f1WfUPALaQJrlHrvKxjuy+G+/Nm6q5zXwsfSRGv5I8wp0cLhQouKDyqzWo7uNyZDFRNil
	 gZhjYyB/AilSXb/QrGx7lptZ43R6fcNZuF6td15X0CfAD2dRLsAPKCh27W7EmuQuNVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778120;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M/oTCAfz1pZj1oXn7XvR2Jz97HWzfzq72DK2xSSzeJY=;
	b=M+4tQn78Hus+lJRH8i204agqVp6YKpPSHi64Um+t6F13cBNEAG3Bzcs9+EWW4Yqwdll5
	 h8oweP2ELeMQvDTlpP20fcOTxykyoumPuV14Jze02gUASVq4H/+wBnBgrsn6gEfPIUED2
	 VxQ5MPnHHECwMettTXEXi4A+IWqPtr9PwmvvowQRy/uIMzvGZ8u/qTZ6Gp3MceQbHAbXj
	 GiFbiDEc14U9+gIC6hPg24avsJbKAflkSGHrYiqXRmUHlMBBchIp0j0fbXp9yl7EXlApm
	 xNdKIUMu8jd7ueTuGrgaOpr/iCAuP1vgCw+8MPz0fyr6IhdtHsvi1fdWBTr1PXI1SoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAWuegQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99E606A31B;
	Wed,  4 Nov 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAWuegQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E491F000C1;
	Wed,  4 Nov 2026 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778119;
	bh=M/oTCAfz1pZj1oXn7XvR2Jz97HWzfzq72DK2xSSzeJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LgAWuegQmYFm1wxO/Z9R1tkyF//aY2SUMcXeVH8wuIeVGwW71QZi8RSkP/iqpdS7Q
	 2gSEd/Wj/Xe92XAtMDa49pKswEvgRwfpN9bVc8MKVNftCM3GMptHDvhTLgcsdCaPO6
	 X3aG0+nUcDjkvmBF9cD2z75wvyzf+aPJmATq96/gDkdmn+ecnOi8/m1fXqZXWkdf9a
	 byZGoTawXSvd67/NXTd7t0kBaWeCsmdF6dvKCcIY0bFcnpPepr7ehCoGf9axpSVKlB
	 dpCuu7WraU+G94XghyvvFUhU/ONn5LEJPK8XfWxtxzV/xxBhM8DhGnHQX/kl6ELKbj
	 ISnXthO1Useiw==
Date: Wed, 4 Nov 2026 08:41:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	linux-wpan@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: drop the URB reference after a failed
 resubmit
Message-ID: <20261104-cocky-relaxed-perch-d994fe@quoll>
References: <20261104021458.1468481-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104021458.1468481-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:14:58 +0000, Wentao Liang wrote:
> usb_get_from_anchor() returns the URB with a reference held by the
> caller.  When atusb_submit_rx_urb() fails, that reference is not consumed,
> and re-anchoring the URB takes an additional one.  The caller's reference
> is then never dropped.
> 
> Release it after putting the URB back on the idle anchor.
> 
> Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ieee802154/atusb.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




