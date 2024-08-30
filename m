Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021E136353;
	Fri, 30 Aug 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042822; cv=none; b=cUKRRPjFT9UXEw9UhW19oWQcKWQjPmGY1M4367RjhA1Ci/I8Fyh90nC4LZS6kulKdppfaRQQCD8utgZuBAL5lcl36YSY25fViGgQBalWL2Pk3H3/C/WqM5ulii2ab5ypUyxKi38gigDkyjZISmAuMN+9/G8NKPReXr3rayq5nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042822; c=relaxed/simple;
	bh=jyNW/B6IwX0dc05FsIycRog/dbgRkTJ8KMkJ+70Y+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/wGHiK3k7KdbCzYtNOAyFS8Acan5UB9pK4tsDkXZLR4WPiOpo6VDx59H8NNEFjwMlhCVaBSjzZUNX3KnjkkbtyFtFN2CwZWint1b5/WIb7QC9GBhGkQGgCIqrx63MHNC6lQ+V5nJ4dMOh9lZR4swpOGpqgmio7cAazJIDIBRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEr97Gw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEr97Gw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBC9C4CEC2;
	Fri, 30 Aug 2024 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042822;
	bh=jyNW/B6IwX0dc05FsIycRog/dbgRkTJ8KMkJ+70Y+RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEr97Gw297SQrBxo6TEztgHZWSrTFaBhW65TOIw0M+eje04S5x0Fehr9EIsfNu/Yo
	 cAKZhGXb2bX4V+YXauvKvw+0cXTlAmsnmkDjCelW8e2JeZ39yE/GzaGNsRG5uGVrc7
	 v8U1wRrLBlE+emqEVVzHzS1WFD2um+aCoZ4aPldtzK76vjX3uApmNuRKOtc6GOjarG
	 8EYre9NvXdhRkmQpgru+kK1p+1/4llfLQA6Mcmr8tV7sH/+MKd0rKK7HIRpaJnRWjV
	 JvFEFPLxTHl4M7PN1vfR0MDykkCRMmRzNrdN46Lk8cMQGfFWhG9PSSKFiPC9kZR749
	 j4VzuC33+ti/Q==
Date: Fri, 30 Aug 2024 19:33:37 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shen Lichuan <shenlichuan@vivo.com>, alex.aring@gmail.com,
	stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
Message-ID: <20240830183337.GF1368797@kernel.org>
References: <20240830081402.21716-1-shenlichuan@vivo.com>
 <20240830160228.GU1368797@kernel.org>
 <c87f7ab7-2c8c-4c08-b686-12c56fe3edeb@kernel.org>
 <20240830181625.GD1368797@kernel.org>
 <b4026df9-059e-447a-ace3-340ba32cb62f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4026df9-059e-447a-ace3-340ba32cb62f@kernel.org>

On Fri, Aug 30, 2024 at 08:27:02PM +0200, Krzysztof Kozlowski wrote:
> On 30/08/2024 20:16, Simon Horman wrote:
> > On Fri, Aug 30, 2024 at 07:43:30PM +0200, Krzysztof Kozlowski wrote:
> >> On 30/08/2024 18:02, Simon Horman wrote:
> >>> On Fri, Aug 30, 2024 at 04:14:02PM +0800, Shen Lichuan wrote:
> >>>> Use dev_err_probe() to simplify the error path and unify a message
> >>>> template.
> >>>>
> >>>> Using this helper is totally fine even if err is known to never
> >>>> be -EPROBE_DEFER.
> >>>>
> >>>> The benefit compared to a normal dev_err() is the standardized format
> >>>> of the error code, it being emitted symbolically and the fact that
> >>>> the error code is returned which allows more compact error paths.
> >>>>
> >>>> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> >>>
> >>> ...
> >>>
> >>>> @@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
> >>>>  
> >>>>  	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
> >>>>  	if (IS_ERR(lp->regmap)) {
> >>>> -		rc = PTR_ERR(lp->regmap);
> >>>> -		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
> >>>> -			rc);
> >>>> +		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
> >>>> +			      "Failed to allocate register map\n");
> >>>>  		goto free_dev;
> >>>
> >>> After branching to dev_free the function will return rc.
> >>> So I think it still needs to be set a in this error path.
> >>
> >> Another bug introduced by @vivo.com.
> >>
> >> Since ~2 weeks there is tremendous amount of trivial patches coming from
> >> vivo.com. I identified at least 5 buggy, where the contributor did not
> >> understand the code.
> >>
> >> All these "trivial" improvements should be really double-checked.
> > 
> > Are you concerned about those that have been accepted?
> 
> Yes, both posted and accepted. I was doing brief review (amazingly
> useless 2 hours...) what's on the list and so far I think there are 6
> cases of wrong/malicious dev_err_probe(). One got accepted, I sent a revert:
> https://lore.kernel.org/all/20240830170014.15389-1-krzysztof.kozlowski@linaro.org/

Thanks, I see that.

> But the amount of flood from vivo.com started somehow around 20th of
> August (weirdly after I posted set of cleanups and got review from
> Jonathan...), is just over-whelming. And many are just ridiculously
> split, like converting one dev_err->dev_err_probe in the driver, leaving
> rest untouched.

Yes, I have also noticed a significant number of patches.

> I think this was some sort of trivial automation, thus none of the
> patches were actually reviewed before posting.

Interesting theory.

