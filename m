Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759568;
	b=DsrrtL7kbUt/XKaBbRa9ECFd3w9qQd5+uiDV3ixjgrs4KSeTJbrWJ8UonI4B2J1SBe5G
	 wc73cwqNu0gvAKguCkatYXIYtW7UXgsp895KneGzCrS14jboxzgoP1X/Y440MY7hWAM5J
	 J8Wo5nhaBedCvUrgzD/ZinKl3eYBW/W1W2i6RXNP1zFlYRN83xKOfRYg4p+Rq25lf+B+r
	 S7RqNCQYKj4Z8lhhvcfzrjrkkD0WuHWsq9hubTeyhhsBRPL5IjspsvwzsWzUnFIhtw8Nd
	 knJIGW42YD8uqjRO1bVgbL9rJ3RFckGmqCnkHpMMyPOTbcsKMmDgleBS3oWZ13wxyQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=4F13Vka+bLY1Kqvm7ka9iajlayyOvv+w08EGklhGGHe1fle/o8H8MnmS6L4FG3BSNxwg
	 wnfM64Kg/LOvPotPPIP9nMpGPt4K1u24sRFs6v3Mcq8zUjD7kRExZG1T1zuy84e92zlCG
	 9RB39mTZ10OokPEvOSDh/K/+nK6e7L3jTNzLkKKLLHOoUBnxHtPYlOECpdf/tJ/YDVFW/
	 93ryAo5PPku02nLj61JY8kWXFqWY+WCzcYgjfP5VJSOXw6nBHHDFUmxedt0no4h48D8vr
	 SyRVZEH4IfT2kQuHyz/2bi5TWVIbspd3ZzKMZr3DJvC2JVQep1VuNzI9eguCABfS1tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg2cnnXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F0606A332;
	Wed,  4 Nov 2026 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kg2cnnXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86C1F000C1;
	Wed,  4 Nov 2026 02:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759567;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kg2cnnXjNn0iEPgJ1cSTtsPdpbst3N8Z2zS9a0XfHjVht0katkFEOmdACRrz3QXjB
	 Yc3P9nTLHvxPaT2+8ItSdd4auZEf3QTV2zslQCsrfNi/Zq9qPvdkra47m+bz0qGLvw
	 ims6IxPakp+e+zARiajMZuwNcfnl3qmdLhDP6wPavZAFWSsnj9pjTbSi4XIvziLb4U
	 jQGaGpee0iUTWS6Y3WAcKLa7/26j0jjLvaEcRTmZpLQHsD4534Pl2eOSXcvBgVjrn1
	 MBkYUqjxwyDh1B69CEvUHxGPmlnWWCUzNpZ4mvPRXGZgb4vodwSODQ7Cd3p7JsjODF
	 S3a+J4Qsigs6A==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: drop the extra phy reference in del_iface
Date: Wed, 04 Nov 2026 02:32:46 +0000
Message-ID: <179375956609.488859.5648802157798426072@kernel.org>
In-Reply-To: <20261104022809.1484165-1-vulab@iscas.ac.cn>
References: <20261104022809.1484165-1-vulab@iscas.ac.cn>
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
