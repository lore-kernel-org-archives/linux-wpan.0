Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02F3644AD;
	Fri,  9 Jan 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979461; cv=none; b=dFpEk01FmquUGdY1N4TPrZtfrBqgnMrmfiPsVdRtQl8vCDVwMiPTMxT/UNVEKzRBS+PqGCf4oMoSKnab7/KQ3XLW3WNGbI4dY/pBI/pnqQybyC/MUnm8Ez2APALY7nlpIo7ytDOaSIN8ButhQ7WA7lblR0bSTg4twuAT/ZQCdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979461; c=relaxed/simple;
	bh=qIlSLo7iU92q2mO96o4Ka/a9fgEA70NMD/AEmqj7Ykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thedlNCGXtpkp8pM2M+Ep91rOztgcFOTPlDsCEnkmSV9L7Ru8heVgTzZsVyohc3GWfW5IPcx9Jp+7cVPCRUfDVg6TYDtv3A1Y6z9iAqO5unSuF2CGKll/I1A49PmwBpONJHma11D7xAPtE6Y/mPySjnb6mhxWXOWAu+61pDbyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+NxnrKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+NxnrKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4479CC4CEF1;
	Fri,  9 Jan 2026 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979461;
	bh=qIlSLo7iU92q2mO96o4Ka/a9fgEA70NMD/AEmqj7Ykk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+NxnrKvPcp61Rz+8EcVnowYYxEvGKANiZc9dpw2VHHBU4ufi54YUcTYzqpZKxz+v
	 84QPq5ZmAz8SwUSvxuFoaqyAG2Pe3LeW+gPRz5hkGesAhog1nlKgGF2cqsfcdgtiea
	 gyIt/ts1629tMUWGz8dszObqJQrXVkh1d6zYp8pSSz+KTCsClxQDQFL2Z5wPogOm4X
	 uRnHQRmCYddFE1dSB/frgzipJcruDxgNsgGb9AG682B2QgCS1Zolh6Ae/X6oobZGb1
	 gLVzdBu16+PSGPanhJ0TtigOkrQTXOUu9EYrQQoxN67bbgvYn5GT8vuF2ytt/1Xhjp
	 4Xxa2Nh/A3T6g==
Date: Fri, 9 Jan 2026 17:24:16 +0000
From: Simon Horman <horms@kernel.org>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: 6lowpan: replace sprintf() with
 scnprintf() in debugfs
Message-ID: <20260109172416.GL345651@kernel.org>
References: <20260106171610.124138-2-katharasasikumar007@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106171610.124138-2-katharasasikumar007@gmail.com>

On Tue, Jan 06, 2026 at 05:16:11PM +0000, Kathara Sasikumar wrote:
> sprintf() does not perform bounds checking on the destination buffer.
> Replace it with scnprintf() to ensure the write stays within bounds.
> 
> No functional change intended.
> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
> v2:
>  - Updated commit message wording
>  - Targeted the patch to net-next

Thanks for the updates.
