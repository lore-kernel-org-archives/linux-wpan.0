Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB952673B0;
	Sat,  6 Dec 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029446; cv=none; b=EcoyLImq4XfVfGzebIQ2DvsIC6tuGn/Qp0c6FBR6q9LXuWKxLLBEVnSwfvSNbzPNdae8ojujk/64I6Sue6trcoVq7hFXYb66Of3EnBeMUQuZlj8SLtNkObPmDvf4/YwjqagHXiO36XjFadoMtT2JgXgBAiCZYuHWEiE4+K7te84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029446; c=relaxed/simple;
	bh=yikHQvLuW4fiLZzY8f2vWSQGxUDyJrhZHn3RzNeYKck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7jioNpMn4YE3p8G1D3dY4q+d4N1bT3W1P00F/egpSpEhPQ858FJwtfL6JNSxURwU4bfF0BPLvajOu5NIRFKl+8umwfLH0SziJ8AzaCeOFYjQxZ67E0GTnGqv/N4JnzsJciwljba9LRMmanvBRDCAjPpi/yOKDDSI9hwzkjK+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkHlRLKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkHlRLKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651F4C4CEF5;
	Sat,  6 Dec 2025 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029445;
	bh=yikHQvLuW4fiLZzY8f2vWSQGxUDyJrhZHn3RzNeYKck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkHlRLKMHCion6tT5sDr9zYTpUcrAqIdCY3ddBe59Wns3icivmB7F1IzMAiDkWfH0
	 G24hZip9QtnhUlMRr4+QuQhYIlXdXHs3wCZYrBnacosOzgiZ7FxbtpY16vWdaKzFC4
	 ink63onse23d4gO+IR+Xi9QHuzheoy6AQcZq8YUGhFO7Czq5o/LAsyCwij7A544uBy
	 KsZodGq7CHKZJd41RVXIZeGPZ1S05ahSGqv+sS2i8boXYyhYnJ/jXSU/+WyItQrCzw
	 S8yzERkzB5nnXRm5/Xpnmgg8GNGQc4b6F8BdY4QM0zgoGnhKDQcoeg0wnvdcmyRHan
	 +ec7pw4J49hrA==
Date: Sat, 6 Dec 2025 13:57:21 +0000
From: Simon Horman <horms@kernel.org>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, david.hunter.linux@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] net: 6lowpan: replace sprintf() with scnprintf() in
 debugfs
Message-ID: <aTQ2QQKfzekZEduc@horms.kernel.org>
References: <20251205175324.619870-1-katharasasikumar007@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205175324.619870-1-katharasasikumar007@gmail.com>

On Fri, Dec 05, 2025 at 05:53:24PM +0000, Kathara Sasikumar wrote:
> sprintf() does not perform bounds checking on the destination buffer and
> is deprecated in the kernel as documented in
> Documentation/process/deprecated.rst.

Hi Kathara,

Thanks for your patch.

While I do see this mentioned at [1], and I do agree with the approach
taken here, I don't see it mentioned in deprecated.rst in net-next or
Linus' tree.

[1] https://lwn.net/Articles/69419/
[2] https://lore.kernel.org/netdev/20251017094954.1402684-1-wintera@linux.ibm.com/

> 
> Replace it with scnprintf() to ensure the write stays within bounds.
> 
> No functional change intended.
> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>

This patch looks like it should be targeted at net-next,
and that should be done like this.

Subject: [PATCH net-next] ...

But unfortunately net-next is currently closed.

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: changes-requested
