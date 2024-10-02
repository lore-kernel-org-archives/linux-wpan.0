Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5B1C2E;
	Wed,  2 Oct 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846116; cv=none; b=ZTjZ20g3iKlRzhvb/FMgXi+cKwmJYHUlT1RwbWA9DY6uBttNQFZbOe2UcUv2Gxdzf/5yCKLMQ/m1QTPMkWc3g5cKsxrko6w8AJr/pvnYy8iw33UfwCd9p/EWVhXcGUBzoJn2fYmsooLRXPMiFItDMyrW17862BzqpFyN26R7UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846116; c=relaxed/simple;
	bh=WLgg/6XG9mikRDcfbyYLbCmZXDde7qs3HILkhpKd7Hs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mbpo4cRjLE9iQ+lmxJY2GVJQZ3KquGkwA9RIzajI+HwO4ljYMad0aiocL6adG9Bj95D3qwD5FdL6FSXmMB1gx/esa9ZGWRJY1LysDI+3nuqbySUS5FYTXXEC3DpJkJHkBOZmKwI/D2QTLRnSuX3Ob0vP3JiJ7MnXd9mxDKhMoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=ZSiQtT4X; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="ZSiQtT4X"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C1AB4C03B8;
	Wed,  2 Oct 2024 07:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1727846102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFTBBjBc00H6JnMcS0A9m7YSSBvWxNPUeLPq7pDs/80=;
	b=ZSiQtT4X3+34bgPiTSNkcdhPT6vY6kkq6QL9eM2n5SkxnKMH/+Z3QqE3rpbDLjuaWbTcGi
	Pg/UQKY5G7E6hzadpPiGu/b5OXMy0uNiInfWwPZdF8iSMWP7GIkJYAH2wOjtW97963+sLK
	7Oj5rFICof/fyKsgEKk+4n14IQ23no1N+VLwr4XDki6j5e/6gX678fyXGR1BJepCgK7EG/
	Fm0ObptZIXviGYZxOJdO36+RqoehlnvC0LzZsTwx1kuNa76Psxxo330CRHmZW3SFKc6a2D
	gxwky4B9VBAazwMpjmw+EaZsOWVtSQByxUtLbH4z/bTjyzRIlCNDPWhNPMP+JQ==
Message-ID: <6dfc9d17-4844-4cf6-bd13-70f15d8ebd71@datenfreihafen.org>
Date: Wed, 2 Oct 2024 07:15:00 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154 for net 2024-09-27
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20240927094351.3865511-1-stefan@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <20240927094351.3865511-1-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 9/27/24 11:43, Stefan Schmidt wrote:
> Hello Dave, Jakub, Paolo.
> 
> An update from ieee802154 for your *net* tree:
> 
> Jinjie Ruan added the use of IRQF_NO_AUTOEN in the mcr20a driver and fixed and
> addiotinal build dependency problem while doing so.
> 
> Jiawei Ye, ensured a correct RCU handling in mac802154_scan_worker.
> 
> regards
> Stefan Schmidt
> 
> 
> The following changes since commit b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728:
> 
>    net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD() (2024-06-03 11:20:56 +0200)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2024-09-27
> 
> for you to fetch changes up to 09573b1cc76e7ff8f056ab29ea1cdc152ec8c653:
> 
>    net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq() (2024-09-27 10:47:53 +0200)
> 
> ----------------------------------------------------------------
> Jiawei Ye (1):
>        mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
> 
> Jinjie Ruan (2):
>        ieee802154: Fix build error
>        net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
> 
>   drivers/net/ieee802154/Kconfig  | 1 +
>   drivers/net/ieee802154/mcr20a.c | 5 +----
>   net/mac802154/scan.c            | 4 +++-
>   3 files changed, 5 insertions(+), 5 deletions(-)

A friendly ping on this. :-)

regards
Stefan Schmidt

