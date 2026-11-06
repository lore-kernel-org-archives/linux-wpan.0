Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006152;
	b=cI3IktNReVZQLnqTBPO670UVnH1ggD6N+RBKm7DeUoNcgcSOu/B96uyAFLsHOfCmgVW/
	 7KlJdw2Lt6KfixrpTuXZdxCP/FWAXKHEoGIbjNSPEzn0fF+LdywzaRff0fNk7naI983Nu
	 IsBOKd7IubcI6H77l6vCQEBj+O6ZwBJGA189Dn0LjWLKGxgPRlxSzWKe1A+ZYzHPZu7z7
	 XJhCfoyHw6+SQglJOYBQLC6IMFr1OESt/FgND2UcVz6m3Kq3jRZvmsFVTd3wh7VMTqqwr
	 upMesFzTGk9liD/Dw9NZ80LUjJzpZNtTStTpbeKlYEiUEGpdKHLLG5FEof3PWVCwaCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=oqgMYr5GbiUNXxJPaMXA+XsuVQeT8WzLe78vOMIy8hemD7A6ysRQR6YZUIRYyqOOu6VB
	 v2vmyT8FozZe0rMlOdF4ktOcWOFMrj2Lyw811r6/X5yi+EYsmR64giG2oX2CElpvSHbhI
	 uEPDOcaLRPdEurYdK1HyP29iIoSBWsAVsGD4b1JdMFdqDn4gzBDJi/ab7mGC+qvvSykQw
	 aA3RapIqTHVL5fASCnJeVAaZTLpI5jA+wmjteTKjbt9WU/r9DIoNtmEx66cVMtseU/qMA
	 ytdhzIoixbBuoDxmIPNSojEbb+Wgde82lpKRmY0/ts4rd4keLqW7cx13GOMGh0ELE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pg3OaeYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AB606A32C;
	Fri,  6 Nov 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pg3OaeYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C91F0089F;
	Fri,  6 Nov 2026 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006151;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pg3OaeYk8UAvEDDra2mR82CmB68rHS1JwVmlu842OJsrQzbEIkLKYpOiED42DLw/R
	 74ht3VjDwHyaYlCAMqF4GPHEfqDGKHbpXDBJadF8d2WSqiWzLCb6wa4mcXM9lXyk/c
	 sCAtNRBkCyR04R+YyKuOinkVYH/CLC/isjA3l6L7vxoJZeVk9Zwk0ayTAKVR2jlX4G
	 36AZxD6KP1c4tTi1rlD421dE3NuscB48qzEF63w1N5rfVjPvGz2e+CeUFnpD8dNNJf
	 YoGoZyjVSCO/BOByIEaEzTJhr/39Ni3+PxI1kpvmGQThLf1XUtKa7gFh6NgO77uCHW
	 Slu/mDhSq00eQ==
From: netdev-bot+sinfo@kernel.org
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] 6lowpan: fix netdev_priv() type confusion in lowpan_event()
Date: Fri, 06 Nov 2026 23:02:30 +0000
Message-ID: <179400615048.488859.9102835578031186781@kernel.org>
In-Reply-To: <20261106225930.1379968-1-roman.gushchin@linux.dev>
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
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
