Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AF1BF7FD;
	Fri, 30 Aug 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050209; cv=none; b=khIS5SPGj1JJwzGQToLHVhfJEdX8QkycxgQQr8QnH1v2t/dH2YYkeO5UCQ6U+9WUEEYBzqCgZxfHXjMfpWar5rU44A9AxGD33Otro4w7mkvquiALwTMxZ9QZfH5UDvGdn6rVlk+WZ2MVg4k0H470mwEufticjpv849BELBUyuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050209; c=relaxed/simple;
	bh=YuH8652EJs6GXuCAZwbbuS8aNoqULdx6cDwGx3UQe7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7UAp8rGIo1mZvq/EKAy3fF86xi2qqbtvWtbA9b/tPYwXnALbrE7x7/KmOymUINgpmX5pvONm+IZGdr80ARLIZtEcwNN6etB3XqtpDabDxP3kAewnyzgDRdvRyfOQ3O5w2UuAG/pHBwZy4q0Mjk6nea8ZGDjEho+FqzEV27JTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=l0KRoG+E; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="l0KRoG+E"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 13AC7C0A0C;
	Fri, 30 Aug 2024 22:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1725050205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6M2D/GrZpUXThIyCGmLZ6PJRipZTZQOfWBRSqkGBBw=;
	b=l0KRoG+EnkTwPKaTdURRMr4VueC80RuzsVgi85rABjRyetlTrm/MF3hk6rZ+P6fbPAgFFV
	4KMf/n94gFvvVYenBgDo5QNYdAiwhYujHYtklXZKQVushQi8Mj3vJXJhyxMK3efOer38MX
	Z/F0uO+IBNbYe8Q9eFPITXg1ZDzPxe/xHoqXsPW9qO11syAQuuYvRUi15ts/p1Vc0PsbOc
	NZ6EXt89I6Nbe/hMd+5pRTkxfuDXWPRsczZxZXXl686vHYf58QTnq+gxy5zjm7xgRX1qjK
	cSWq0wU7UG9Gy7I80BcbfHdAmoYFj2uuULfrIS8DOoxVDAxUjMbZNjp2VUrdOQ==
Message-ID: <7def0a1a-5aa6-48e6-96d9-0957ea44ef04@datenfreihafen.org>
Date: Fri, 30 Aug 2024 22:36:44 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
To: Shen Lichuan <shenlichuan@vivo.com>, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240830081402.21716-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240830081402.21716-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Shen,

On 8/30/24 10:14 AM, Shen Lichuan wrote:
> Use dev_err_probe() to simplify the error path and unify a message
> template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>   drivers/net/ieee802154/at86rf230.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index f632b0cfd5ae..3fb536734034 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -1532,11 +1532,9 @@ static int at86rf230_probe(struct spi_device *spi)
>   
>   	rc = device_property_read_u8(&spi->dev, "xtal-trim", &xtal_trim);
>   	if (rc < 0) {
> -		if (rc != -EINVAL) {
> -			dev_err(&spi->dev,
> -				"failed to parse xtal-trim: %d\n", rc);
> -			return rc;
> -		}
> +		if (rc != -EINVAL)
> +			return dev_err_probe(&spi->dev, rc,
> +					     "failed to parse xtal-trim\n");
>   		xtal_trim = 0;
>   	}
>   
> @@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
>   
>   	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
>   	if (IS_ERR(lp->regmap)) {
> -		rc = PTR_ERR(lp->regmap);
> -		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
> -			rc);
> +		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
> +			      "Failed to allocate register map\n");
>   		goto free_dev;
>   	}
>   

Please take the review from Simon into account here. Dropped this 
version of the patch from the wpan patchwork queue.

regards
Stefan Schmidt
