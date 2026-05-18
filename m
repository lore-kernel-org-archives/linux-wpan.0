Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907463E9C36;
	Mon, 18 May 2026 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100775; cv=none; b=rDbksNkLBGnCsL7J8nNY/H4sriffnbH4NIBf1N3Psg4Lm8YV6k3V3wC3PtiMscpFsqaj81pL8k5EEAsAWG7UMJsywMo8y7ZBGnjnmXKnId2WUObUoPUH7dK1pZARslw3TRpbAUyynlHd59cS/H2zXgBvmP3hyGWhLguZb3Qon8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100775; c=relaxed/simple;
	bh=1OTfVa9O7Ad5uglU/MtCUofSTebAW0WnF8gjfSPLVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfANN3wfeUUOJqLSGT6zODYQEyf6cJRcLdlbVMnwEd03pp73yI9X7dMKrHkYcSHdHqOJUSJ1bFR4jztSx/7iX3SNGE1tThjjKVPvcZZQ3Pjfuw6Z+bbSJpEzH25XAZPKujqr+wMHKlRtXcUKTr0t5G3VPfehP0sKYX5mquqN7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKNurMN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKNurMN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE72C2BCB7;
	Mon, 18 May 2026 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100773;
	bh=1OTfVa9O7Ad5uglU/MtCUofSTebAW0WnF8gjfSPLVpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKNurMN8L+X8vu9p/+JNJngFzSzhbxN4iYoQPke4r89tRaQLA2bYsNe5fsROt14I7
	 tFEbwtsssEwhfAVaL7C4tyr9rO5fBVBmSIftOGrJmGv6CqJOtYuNnoFNaoZlkWtylq
	 DYuPrM++IjThn/EccN+VllX3tow3vWUu5zkf8o+nGqzFMvVhGJjBhxbgQfgfCxXH0Z
	 QbF2IwoesuZ6F9sHk5x3qAXdEYHJBVo4oE5Jgo5N87wbTJjixsI6a1+jtEnmvWl+zG
	 DLePIdVXK6O5qMTspLOFD8ueIfzvaj+qku1GJYVd+rldxa7O8mICpnKl7zoY9L4tbq
	 gasiGxvTDslPg==
Date: Mon, 18 May 2026 11:39:28 +0100
From: Simon Horman <horms@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in kfifo
 on 64-bit
Message-ID: <20260518103928.GD98116@horms.kernel.org>
References: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>

On Wed, May 13, 2026 at 09:04:12PM +0530, Shitalkumar Gandhi wrote:
> ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
> a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
> '4' as the byte count to kfifo_in()/kfifo_out().
> 
> This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
> low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
> then reads back 4 bytes into an 8-byte local pointer variable, leaving
> the upper 4 bytes uninitialized stack data. The first dereference of
> the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
> address and generally results in an oops.
> 
> Use sizeof(fifo_buffer) so the byte count matches pointer width on every
> architecture.
> 
> The driver has no architecture restriction in Kconfig, so any 64-bit
> build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
> been latent since the driver was added in 2017 because it is most
> commonly deployed on 32-bit MCUs.
> 
> Found via a custom Coccinelle semantic patch hunting for short-byte
> kfifo I/O on byte-mode kfifos used to shuttle pointers.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>


Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI-generated review of this patch available on sashiko.dev
However, I believe the issues flagged there can be considered in
the context of possible follow-up. And should not block progress of
this patch.
