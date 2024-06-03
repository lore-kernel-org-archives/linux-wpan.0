Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8B84FD8;
	Mon,  3 Jun 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407632; cv=none; b=M3iW45BqTi6pwt2iRVxz1ZLBs4CarQZp72eJa+s5r84/I0p4fe40fDCnel3eYR3i0fyuNvGLHa3P1e9MAXIn7bb46XySjtXustfCKT9XxduPkHJr606XyFHijYr+rSjCuYk+Y4NPGQVOrIUwvGDAhV9h+YwA523SSRIWg7fBmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407632; c=relaxed/simple;
	bh=oVDr4kqufAv/dxzz5Lxq0u/Ascj3+Nvd6O3eZYaIXi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKzkhEnMlebmBVJQ9G5Oj5rCk+kNf8VvUW9bQJxCfHa/HG6vr5tm/3Gmdx9BuqmBGaTixV6+bU9K51mikxXI+wnx8B7FxtFe3fodVilJdm8Qj92ddL1Uz2BzJ3+WL/sIFcPkQTxBfrsPWia8ALxBX/Gr96R/YgZ9c/nHq/4/vEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=EJ61GY7M; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="EJ61GY7M"
Received: from [192.168.2.51] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id D8BCDC063F;
	Mon,  3 Jun 2024 11:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1717407209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nWKy6AKKd5kBCqS4Y/8g3wOqFQkOvvYM77V/sj1yk4=;
	b=EJ61GY7Mjdnz4zlqQCfRKO0kKsMMgfxuNIV77s8WH2+buDVSdhFI9jBEksT4vaHhzgSTU8
	M+CCD72vV+LLeHk90K2xcf9/Uo8oLScKiaU5d9QPJBDMPymDXjhbQcEYUpVgKM2ejD8wnK
	+cS2KGFGquZtu1UrFPmviX332DzaRqpyRU5d77CgkL+H5T/h498dQ34qQrmVBm2YP9Ce1s
	5LGnkbhY3ElztedPf86I09ypKV1JoGl3C6U93c3YGz7GxHV9dn6fsj4hns8retU3z3gc07
	FYpZOvZohcH1Y3+vGTu5X6oS586w68ltei+5vdJLK3oGQvAhEJLFGlFighqv1g==
Message-ID: <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org>
Date: Mon, 3 Jun 2024 11:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
To: Yunshui Jiang <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, davem@davemloft.net
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 31.05.24 10:07, Yunshui Jiang wrote:
> mac802154 devices update their dev->stats fields locklessly. Therefore
> these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC()
> and DEV_STATS_ADD() to achieve this.
> 
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> ---
>   net/mac802154/tx.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 2a6f1ed763c9..6fbed5bb5c3e 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
>   	if (res)
>   		goto err_tx;
>   
> -	dev->stats.tx_packets++;
> -	dev->stats.tx_bytes += skb->len;
> +	DEV_STATS_INC(dev, tx_packets);
> +	DEV_STATS_ADD(dev, tx_bytes, skb->len);
>   
>   	ieee802154_xmit_complete(&local->hw, skb, false);
>   
> @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
>   		if (ret)
>   			goto err_wake_netif_queue;
>   
> -		dev->stats.tx_packets++;
> -		dev->stats.tx_bytes += len;
> +		DEV_STATS_INC(dev, tx_packets);
> +		DEV_STATS_ADD(dev, tx_bytes, len);
>   	} else {
>   		local->tx_skb = skb;
>   		queue_work(local->workqueue, &local->sync_tx_work);

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
