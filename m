Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794044467;
	b=Ps7L051+UCG9NKhpfUTZDxEQxFk4dy4M9ZwGfQcrh6IUQaH3+APRAgfDcR3bik59sCA5
	 1UbqiybnWlsyBSK+Yn7BirNxo3B1atGNdxkSg7J43+5rn+GnlIsQWa2HdkFOo0meNrxQm
	 OCdDvAZVS7weONYMTmS5KSTMZqiuMqPqI0cJ/3KWY+pgjJ1557Nf3B9r3+aJze6kJdLqO
	 y1MHKWgf2JPz9839wvXglhyDk1z0o8FdSXOt+ZwzggLLJ4/MhD6ZMSJ6QLRoF6+r3MkpK
	 ZvATeZkiJc9srdMKV3oAm27pWv/X1qAzv32jMF4byWJmHOo7IN1gmvdwN4M4KvYKV9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=N6Y97n/aP8nmXMo6x48w+ob4TqfbUTi6uQ/Eh9GgmxCCi9kr+ufs1p0j8/Kts8t+mIJR
	 0WdBm+gdH26AuYlQsbwd0vLQyIX0xq1xAHtTYRjlW9lmmM940rGdUd3O8ZJLI9mHuyThj
	 +xz23U47DJyvN9dVzykeAoRRlyAGDY+vTj0Ki2PsVosUSqHQrTAh9wcJTLN8GadmS03WI
	 mq7zdJN3ckrIOe4Dd7g0VaCFGO3vfs07OsH6Q37oUUCXi6JQXWKidIuAhNSJfq+xkpA/C
	 S1REbv4THy42tfqTYQj6r8kgUBlTfcBkeXFSU/VrA0ppZxfbDIjbd4634XuB9yNhwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJhoOLe0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37635606A326;
	Sat,  7 Nov 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJhoOLe0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9161F0089F;
	Sat,  7 Nov 2026 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794044466;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJhoOLe0x38xEPyFJnbc7HHc8Hhv76w+oeSm0lT0VQre+lc4ua1KTegqQ2KxK/+In
	 Sw3iyh26Amic9hG9qrR5EL6/5qZOyZ+O2HXBPBuvfFz+DjjluGSaJyxF5GCFWhDqGQ
	 nLjm3DH62bl6DN3EToTdP8Qf+UhY4ictRwrAb/nXKbsibcuPbUePNX6pxhcDherYlM
	 5EBX9/F5rILGNg4BIOEmz7sR4zuxNfg3K5AyQfFeWR8SqMgPuiAF9lTpsvI4N60XCG
	 3Bs0nlYz0miXMpsH+yfzUkkdrpJarmpYmncYppwMZI/tjDF7QHGzt5xWtPRGQ8NvEZ
	 3koJzOu/Aa4Ww==
From: netdev-bot+sinfo@kernel.org
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ieee802154: require CAP_NET_ADMIN for SIOCSIFADDR
Date: Sat, 07 Nov 2026 09:41:05 +0000
Message-ID: <179404446583.488859.12789562743053705755@kernel.org>
In-Reply-To: <20261107093601.619363-1-tjdqudcks0424@naver.com>
References: <20261107093601.619363-1-tjdqudcks0424@naver.com>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
