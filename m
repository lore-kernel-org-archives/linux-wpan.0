Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895B165F16;
	Mon, 21 Sep 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007706; cv=none; b=HCZ9KYcIZNKCf9PwY/9g/JdlQINf3IQtEAR7WPxE8eGc7zSmrdA/KEBhPXmjeStq2vNHETHP3gyTpCFY59f7f/nwg5tp3abf77Bb2shd3kvlJfJBX7KIUQafCcskyCrxfMHarf0BUibRtiRxqCdjEUvUOm9rgUZpeNyYCwpBh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007706; c=relaxed/simple;
	bh=dWJSpmBmlNc1HD+Rs1FKxOP2FfJMXbHmFczCZWSCJvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuOSn9Xf/MrtxWiuR7+S9lRfzzGPg3sZjzTsE9C3NlawppY1inrfB7M/XIhyfhqoeGq3SAiqfPbwhuU5aTVsELo4IKmtaKvT3DbuCIf2Gyz9YBjnMiRGpw2A7Q8AqZV5fID4I421k48YrkZx0/D3aoGCkJGppsyxigXZbAFuU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzutaYCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzutaYCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B12A1F000FF;
	Mon, 21 Sep 2026 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007705;
	bh=zpMsW14zEakhSJaSJVRCgedXpLvn9qydb1+Nz4DxJNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzutaYCgNj99IrvDIPfOyPcIf0zQf+DG/eYyqothuLArEKaLnfeMSV4zSvb54Igxs
	 7THBqu2G26Y42amLyWjplV/tkKhgSEgGkVF8XgOsEA3s88IdOdWtiZUmvHm3U1W0GB
	 FjgAK2pXysfh8HJSZxIDxgf3qobdd6Tgawwb5Ul5mLsn9M1rVjKaA35E/WFqbAe8n0
	 ws8Rc2KdA4kl1QF6jlzcpGDFKA1gvsQg9HKHXb3xvRiYrxKxNWEaM3o/PZlxs87jw2
	 ql1NtTj1VFtTm/48x7YFi9BhC8Z0GQiJXJaC6+1o2d+aq36vWhxBCh4ua6i2nipTo6
	 3IWJt7laVgFDg==
Date: Mon, 21 Sep 2026 17:21:39 +0100
From: Simon Horman <horms@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-x25@vger.kernel.org
Subject: Re: [PATCH] net: protocol: use assign_bit() where applicable
Message-ID: <20260921162139.GW13925@horms.kernel.org>
References: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022745.3145847-1-peng.fan@oss.nxp.com>

On Sun, Sep 20, 2026 at 10:27:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API. Where a bit is toggled based on its own value, use change_bit()
> instead.
> 
> Done with Coccinelle semantic patch:
>     // set_bit -> clear_bit => assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        set_bit(bit, addr);
>     -else
>     -        clear_bit(bit, addr);
>     +assign_bit(bit, addr, cond);
> 
>     // clear_bit -> set_bit => assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        clear_bit(bit, addr);
>     -else
>     -        set_bit(bit, addr);
>     +assign_bit(bit, addr, !cond);
> 
>     // __set_bit -> __clear_bit => __assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        __set_bit(bit, addr);
>     -else
>     -        __clear_bit(bit, addr);
>     +__assign_bit(bit, addr, cond);
> 
>     // __clear_bit -> __set_bit => __assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        __clear_bit(bit, addr);
>     -else
>     -        __set_bit(bit, addr);
>     +__assign_bit(bit, addr, !cond);
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

