Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF643AA9;
	Fri,  4 Jul 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638751; cv=none; b=LoWw0BEMH0ChJGrcb9R66vjyGZdK2XzfagRTKBellh2lw73GZYYSWaJRw5bxzodgwbIw6IfowiiLMLuMiHiHKsQQnOPmsQ2OWhpTRJQf0G818FWEj7Q2sgzWU7+nm8a0/UsOrrFy6SCnrz1Gk+tp6V54KeR8dIxXcz70sokBeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638751; c=relaxed/simple;
	bh=8hAoEXeQfeI0J++X+HBkjFGoPL3FPScopH4rKP3MQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRH1fnF0Ay4ih0dqE+bCN1Ul4NuDPXz/qVhmn+8QulkrK1yHtDdGDA7q/ASIUqnMtj+ai6zfg90T/A1qTmOOIYpr0PPVwC0xFhrha2ZFTd/eghQLOUeKrdlI5FP7uKayBccBZ8JBIpI2ImJkRvmrvkGJ/X/dFKVm81+w19cxKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLM7Ow2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLM7Ow2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32625C4CEE3;
	Fri,  4 Jul 2025 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751638750;
	bh=8hAoEXeQfeI0J++X+HBkjFGoPL3FPScopH4rKP3MQE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLM7Ow2tMhcBY451abZn8AucStpGxc/0csjhh9L1vRECEZalAW4JmUVFJAJ0lhoZJ
	 piA2Vo6yPDcrXzob8BrqHSWchMuiWPJwm19AmRv+bGszIsHgzZcpon/+Ur118he3nA
	 9en6svWYew458vIGtN5kqDL5Jkz9AYj1xb3v+qU3kHqsPZhnLxZZdoUufKTiOMEYf0
	 uhaG5V+8lDspszLWtdLvyjkdqIQvBjJVI+RSligbh4UumA1cOL6Iy6iTMg629Q6ikn
	 7ugFGqSlF7x8j0eMBUPvznxLMMRzfJuhnNTTcDCCGQ62WBYF1NoltiPBak7Y1na3mY
	 DcCh/6cIbgAGA==
Date: Fri, 4 Jul 2025 15:19:04 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.aring@gmail.com, dsahern@kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: replace ND_PRINTK with dynamic debug
Message-ID: <20250704141904.GV41770@horms.kernel.org>
References: <20250701081114.1378895-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701081114.1378895-1-wangliang74@huawei.com>

On Tue, Jul 01, 2025 at 04:11:14PM +0800, Wang Liang wrote:
> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
> Changes in v2:
> Use dynamic debug instead of sysctl.

Thanks, I agree this addresses Ido's review of v1.
And, moreover, is a good approach the problem at hand.
