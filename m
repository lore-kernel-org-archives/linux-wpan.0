Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FB1B86E6;
	Fri, 30 Aug 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033753; cv=none; b=iOdxGAQvONTNMt19P4AEssvMjz+xOn9iVr+b6RsaMzxqkQ+16tnhgaPIIXveIow6lRZnM7yUEo9YBFdGDksZndQDc3AQFXjYrKFnwmO65QDtaQ5/kPYogHTDvvCtSbhffhXx7Jb/EjHEITYr2b679vVN3O8VtROHiJ8JLYzH5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033753; c=relaxed/simple;
	bh=S8HKI+dh64VVg7YTa6VZ40u+1y81J9bN2DoysdYC+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUo3PwTaqEskuCAE8CYZu8mvQSLahJGEtLS1GM00xjRdFrwG9JRSVxYISfBklLrCEnoqhuWXHX7IW2x48lqtgyeGGRNX1w/9VJkYIM969SfTaB/Mf2UuQOZ9kq2oJcRrbUA3yGsycUBnQtkQZT5Uh9VkeQF6SnU7e4uCQpLckR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHYpTZD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHYpTZD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDFCC4CEC2;
	Fri, 30 Aug 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725033753;
	bh=S8HKI+dh64VVg7YTa6VZ40u+1y81J9bN2DoysdYC+0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHYpTZD5tidX9dDfW5b8mPMuuzm1ZclU4ALrbRr4kj89zWOnCNBEprPGQemXAUWaL
	 kGRtPOcvsWc0EOaSf+W+tUEv3C38iuymGu/vLjPptfPSY7fmcYUuf/pTdVU+wEivVT
	 oPJynAhRWjMvjoHVqKpWUkf9NoyquMZ9MisKr94aOtPReml/FKQYXPzgWDc04BYMUQ
	 CVACFGbb8CuiZhAMyl5zVfnFIeGwu+kFZSfkyKJi/38RuyieejAzlMsS8FALc6bPPq
	 D0Kr1Q5/8agrShYZKBI6DSgIBNZCt9flUoR8+JOqu5ZxoFbvPetF1ebjycJNtMtmch
	 DkNf6IOjPZZGQ==
Date: Fri, 30 Aug 2024 17:02:28 +0100
From: Simon Horman <horms@kernel.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
Message-ID: <20240830160228.GU1368797@kernel.org>
References: <20240830081402.21716-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830081402.21716-1-shenlichuan@vivo.com>

On Fri, Aug 30, 2024 at 04:14:02PM +0800, Shen Lichuan wrote:
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

...

> @@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
>  
>  	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
>  	if (IS_ERR(lp->regmap)) {
> -		rc = PTR_ERR(lp->regmap);
> -		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
> -			rc);
> +		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
> +			      "Failed to allocate register map\n");
>  		goto free_dev;

After branching to dev_free the function will return rc.
So I think it still needs to be set a in this error path.

-- 
pw-bot: cr
