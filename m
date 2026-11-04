Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758727;
	b=ZalcyI4wki2bGOo07xVo+2m832StIuo8EqFAgJ9sdMXl1K7eZlP8u5TPBMOWLJpdwxsr
	 kkCPdq54XBgg4KN/s19/gFbcIvL7LlGWaFh+yuJjQnssPvjZHwj6H1vmvq15UcKRy9bpL
	 ASAJ6TfbEc7TELrAtWDj+Lbp075wYB4plfsllOfMVHxT5ExB73AQYmJP6BCGeCZcMRvDB
	 Oh2dEp8gIjW4ZXL5CjQcXsJ7zpfZ5QlycWxZhHAxhC+kCHuMS5XKOYns+n/D9ACIkc6zs
	 Nc9D/3pzTYY4W1x/+Lf3KgXLya2fp7F0AfNIhf+huQz90oX3l+vhn1rhTVP88Elg49A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=lWasISM2rVZPu1b0+z9tqEqHR0wycWUmCzD3VqDfUWmOtFmbGEqvTEC3Jm5pcnnqyNW4
	 Y/ZainFAI7F3/4LK5Wj6ars3kV9YbabgWSekQu3mAfMOsGR+fy1cbNmLBnDY5EoD17HWE
	 fnhNomnDVvnYDzt36s0wA/F1S7NNb4eZSX5iyA8J5ZFKG4ADonIHG08K/3xi/UzYmH8Z9
	 bxWJv0SuhSV1e4OMdpJuUFEeQPsEk74evcLvMVm8/JJvItdwgA+h0PojWg3b7ySKkfGsU
	 uXUmRe4O2KsH5+NSHHk5oiITl8hWVj0s3eFUorQpfxLpPwI9mE1s4XId+9eqLP/zg2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nru57cp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C4606A329;
	Wed,  4 Nov 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nru57cp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DBE1F000C1;
	Wed,  4 Nov 2026 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758727;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nru57cp+r5dr3fRXjlOhwLhv3rIgNqxFIV6K2WXdu5ckGyvO/ay+i+cPlyO7cm0zN
	 2+R7b/JZpavf+xuIp3h7FSC/EOQ29VE62Z8mEKJGCas5NUeiAcegcw233St6xJWIMJ
	 4gb3Pg+LpU46U4oCgMEx5IJMyqGjr0vQv6JGJ98NbwzdP5l7mSZd2OtsjP/A9LblAx
	 MvnAr9WqPcTYyLkjnNKFoUDVXkcmhXa1D40XqGbwAvrLSNKRaWPen28fFyomfS8mbU
	 EG8VmI9QCNJyQ0nNMbdZ3dBtagVE26XAV71b8v6MgATxn9MlwB4MJ0cEbYDIlXcAls
	 /okDy1E36MNHw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH] ieee802154: atusb: drop the URB reference after a failed resubmit
Date: Wed, 04 Nov 2026 02:18:45 +0000
Message-ID: <179375872596.488859.7516921198946176230@kernel.org>
In-Reply-To: <20261104021458.1468481-1-vulab@iscas.ac.cn>
References: <20261104021458.1468481-1-vulab@iscas.ac.cn>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
