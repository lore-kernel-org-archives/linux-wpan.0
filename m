Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03108369997;
	Fri,  7 Aug 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113022; cv=none; b=PvYNk5RRCcItwclGAd+K0i4rzZhM/iET8wiYSHD9bt26KNHrG0ZepEG2BZJQdZc5g8gVFQFq1XVITn+Zvq7eBMwEFOg6pomqRIZiaLIfbNbAudkZgLuKUNquXwyRtvnDfBD5F0QkV+W3jxY6YpsElghZT8o4MJRNNgoRGkjRCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113022; c=relaxed/simple;
	bh=Sfz0rXO0K/RT8cm9HaRQI+hhjI5CfU3sVWSX7zCR/no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUNXTmm3+e5JDUaw1tpRzFo/cp6G13Q92CGAnGwcP9rhYNZpGqEaRyRSEu/YKeKCw2lbGLRQQk2xfH1aWtQ0MBj+A9FKfgrto57wlIERhItFA8SFmkNYHbDTJ5BnXPc11DXgZOS8AKlBa+Fj03Rv/ZiJqptloBtEOmlTPRWqllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEink3U2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEink3U2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA01F000E9;
	Fri,  7 Aug 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113020;
	bh=eIqbvrV0RhZs5drKaoETPXaK47Y+8t0hWFOGGlXGzRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UEink3U2FcY1dnMrTWEDygv1xeY1fwmtqqEOrmfxcNRtE4iHROLA9UuQzOUdbPMij
	 VXtMQ8ZirTIx9ojffXafd0ynmQJp6zJi+6iDXjwjrUc8AXkSN0fV7yAZJnZmgSmzuN
	 AFMH3cG512i6L3D49vnQ7bIqprD2aHzunG5fzAyoNtSw9aBA7zGX5Ee/yvL5lXr+6Z
	 IbvqvKX/S9vJgPeyXIS3t+6oqV7j5YOBKaWRR9J9lfk0pfNARtPX8K7T/WZBOs9L42
	 kAnhrCya1UROCvCdxhbMiE2O1mKNkicbo4tVuqaHuAraauZlCD0vmriY7QRF3/mqzZ
	 4Kk3IMR82YcIw==
Date: Fri, 7 Aug 2026 15:30:16 +0100
From: Simon Horman <horms@kernel.org>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: 6lowpan: fix mismatched comments
Message-ID: <20260807143016.GN51943@horms.kernel.org>
References: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806091045.1701326-1-chenguang.zhao@linux.dev>

On Thu, Aug 06, 2026 at 05:10:45PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Rename @_nexthdrlen to @_hdrlen and drop stale @nhc from
> lowpan_nhc_do_uncompression docs
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

