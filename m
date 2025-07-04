Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6B2DEA7B;
	Fri,  4 Jul 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647589; cv=none; b=tAJVH7u9n2VnmuW8iYaFhEZ6ygNIWj1eiLyWZfrBKHTmx6LKSvfj9Q/yNfSVxIPSstWpBBP1D2SKw5hCISKUFEnAIva2sFQryvd6DeCE7Ix5sdJb0ENmgwQOekweCOUjtJqP/F3o8WTTm5I8xeGCdrLgFZkhulpTk8LACo/Vnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647589; c=relaxed/simple;
	bh=OPohBrKnAITM+aAWgmMkvXlTHyOCvLEu5b187LOl4TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+d/nUI/1Lj0Lznk2gyIhg5K430c4/++1JIyeQX6+R0zQyQHATY0NlZqa3OXZcmyOOC2c3goXjTYj7ncZcR0asJjZVEbJ1/A4IqLf1jAMdHf//2nqUJijI7YylINlAamh2Kyh+QR47/of/HYScnY0XZXLDFSuSUWjBbhebJHXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKi3gt4d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKi3gt4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42005C4CEE3;
	Fri,  4 Jul 2025 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751647588;
	bh=OPohBrKnAITM+aAWgmMkvXlTHyOCvLEu5b187LOl4TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKi3gt4d0wzXA1Ri/K5ySvQImLczX2EvCkKGn5b5DaURYQBzhsE2UtsKIISxSsJS9
	 QvLK0PCamBPKwzyOOmLN49kkZl0S09fa7A1sSa8RizeSXe3QQmdNiPAiW/+Dg9rhqT
	 i10XZksjYhwiMfwzGukN/1ZfCXLuHlU3k6+WLV/bbDwDU4oWvJlrPgm9YTBpvzBDtz
	 CzBVTcGM0OuVjbdoSs+KWj2VeYIOc7RvEwUXMcKq/CVyGDRDB4iVwXADaGryIv4kOh
	 xRLRUWEN4ZQG8+MLpke+IpvN3ST4EgYL8OfkVEAX4hlcyB9/p7frJrDC50tqyBqXBr
	 pf5hfTsQtGTfw==
Date: Fri, 4 Jul 2025 17:46:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Wang Liang <wangliang74@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.aring@gmail.com, dsahern@kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: replace ND_PRINTK with dynamic debug
Message-ID: <20250704164622.GA354404@horms.kernel.org>
References: <20250701081114.1378895-1-wangliang74@huawei.com>
 <aGf8_dnXpnzCutA7@shredder>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGf8_dnXpnzCutA7@shredder>

On Fri, Jul 04, 2025 at 07:10:37PM +0300, Ido Schimmel wrote:
> On Tue, Jul 01, 2025 at 04:11:14PM +0800, Wang Liang wrote:
> > ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> > phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> > net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.
> 
> One small comment below
> 
> [...]
> 
> > @@ -751,9 +747,8 @@ static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
> >  	probes -= NEIGH_VAR(neigh->parms, UCAST_PROBES);
> >  	if (probes < 0) {
> >  		if (!(READ_ONCE(neigh->nud_state) & NUD_VALID)) {
> > -			ND_PRINTK(1, dbg,
> > -				  "%s: trying to ucast probe in NUD_INVALID: %pI6\n",
> > -				  __func__, target);
> > +			net_warn_ratelimited("%s: trying to ucast probe in NUD_INVALID: %pI6\n",
> > +					     __func__, target);
> 
> Without getting into a philosophical discussion about the appropriate
> log level for this message, the purpose of this patch is to move
> ND_PRINTK(val > 1, ...) to net_dbg_ratelimited(), but for some reason
> this hunk promotes an existing net_dbg_ratelimited() to
> net_warn_ratelimited(). Why not keep it as net_dbg_ratelimited()?

Indeed. Sorry for not noticing that in my review.

> 
> >  		}
> >  		ndisc_send_ns(dev, target, target, saddr, 0);
> >  	} else if ((probes -= NEIGH_VAR(neigh->parms, APP_PROBES)) < 0) {
> 
