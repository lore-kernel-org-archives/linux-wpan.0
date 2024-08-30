Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2A1B375E;
	Fri, 30 Aug 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041790; cv=none; b=Ud20CxH/7h12JR0GDud66evpugop7ddDcrO6/XWtsqqaKoS/Tg9QklXfNRN41SJJuRF2lHZ3ES9pHxiG/2Q7OYE4r7yhiGaJP0K2kkO4RGPALkXrbHDp5ImSwsLcX2ZjtHUvlsT28SkUcOdKV2YZfnHNDuYUpcDBRUOQS0YTLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041790; c=relaxed/simple;
	bh=noFUhXwnrutmqy9MSizoA/UaP/bDMdUHEn7t6e++Qys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMSLEZnI7kCQDRJh56wAOGcwni2fajTStiQ5elKcgjI6xucuHOc006Kyd0CpQs2LTu+HTEivpO7nriej1CI/K1Mwv3muE+n51zIyxQhyhf4TtIRqPuLleKRaDyeqHd6AdrJi2W69WLIzVF3smhj2UYFdkLuF+sm9p7xNJcAaZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9G1Yj1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9G1Yj1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022BC4CEC2;
	Fri, 30 Aug 2024 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725041789;
	bh=noFUhXwnrutmqy9MSizoA/UaP/bDMdUHEn7t6e++Qys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9G1Yj1k1u88KyiGrvBpQeXqhtrL2jsSDLucPVXKVUO8BIYumgKzeLG/25bQEJSTO
	 YButCM8DnKE0ihmqYkOYUUkwXhCBw7+/fZKs15v7vuxkZ75qCSjGFRH5LpIcN/TIK1
	 i268jnDqdOKJpneDMOtgb8+2DqCZj7RY/n1niFS0qT+s/kvb2pVA/6U3USUj47diVQ
	 8v8mKPivWjtQfEnjgNf2c4hw1VffTJlemtjW2CnU5o7mzRFmpy/XgbL816/WVRZwVN
	 MqwJ7Tdo1l0qctzGiVPmz5htlxlz7xBgtjjKO0JOv8gg7PWhf2wfCMANgoF4AGef3J
	 VedgkY/PxjxeA==
Date: Fri, 30 Aug 2024 19:16:25 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shen Lichuan <shenlichuan@vivo.com>, alex.aring@gmail.com,
	stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
Message-ID: <20240830181625.GD1368797@kernel.org>
References: <20240830081402.21716-1-shenlichuan@vivo.com>
 <20240830160228.GU1368797@kernel.org>
 <c87f7ab7-2c8c-4c08-b686-12c56fe3edeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87f7ab7-2c8c-4c08-b686-12c56fe3edeb@kernel.org>

On Fri, Aug 30, 2024 at 07:43:30PM +0200, Krzysztof Kozlowski wrote:
> On 30/08/2024 18:02, Simon Horman wrote:
> > On Fri, Aug 30, 2024 at 04:14:02PM +0800, Shen Lichuan wrote:
> >> Use dev_err_probe() to simplify the error path and unify a message
> >> template.
> >>
> >> Using this helper is totally fine even if err is known to never
> >> be -EPROBE_DEFER.
> >>
> >> The benefit compared to a normal dev_err() is the standardized format
> >> of the error code, it being emitted symbolically and the fact that
> >> the error code is returned which allows more compact error paths.
> >>
> >> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> > 
> > ...
> > 
> >> @@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
> >>  
> >>  	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
> >>  	if (IS_ERR(lp->regmap)) {
> >> -		rc = PTR_ERR(lp->regmap);
> >> -		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
> >> -			rc);
> >> +		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
> >> +			      "Failed to allocate register map\n");
> >>  		goto free_dev;
> > 
> > After branching to dev_free the function will return rc.
> > So I think it still needs to be set a in this error path.
> 
> Another bug introduced by @vivo.com.
> 
> Since ~2 weeks there is tremendous amount of trivial patches coming from
> vivo.com. I identified at least 5 buggy, where the contributor did not
> understand the code.
> 
> All these "trivial" improvements should be really double-checked.

Are you concerned about those that have been accepted?
