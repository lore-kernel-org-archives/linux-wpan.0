Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359E1531C5;
	Fri, 30 Aug 2024 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042430; cv=none; b=ML4ZzDqdxf/6cFFzDA8Zgs9Zih4DcAKbSO4XT4q4LrsjlImksfjezwm50mjRZFD81Zt0FTwxdMPdEYfTrGvJcuA/ytmTD/oJB6GOdaP1xKSOB06z67Uan0u7NlkJJfsd8AGgg755f+aPEaIHIc8EIzW1r+CqSl7pnt8prKNLtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042430; c=relaxed/simple;
	bh=MmqRpRgJx8EbEV7+1D5aNRQHZXPeAoo2EaUSGYZSw18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npGZDz9dVzvmyZddIPW3rPU5kiJU6ryaTnVi7tBrp6HJev+XDcmNMMDMtj/31XKxFqkkx60XovhTaz+N2Et9ay4DefaD0rtrsv+kShaLRYewyEdLmEt1p2nXICHymHiIF/jMF+W0fx1ZSEyR5l3ZILtgyLQiTpM3R/AUABTNV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+KqrfTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+KqrfTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E166C4CEC2;
	Fri, 30 Aug 2024 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042429;
	bh=MmqRpRgJx8EbEV7+1D5aNRQHZXPeAoo2EaUSGYZSw18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P+KqrfTShgZHHs+Rw6n1YXX2/MZ5EZA6RxUPmaJE+uu7Ho0AVUxr0hhzAHyP9ECIL
	 IabcUD7SyZ0/VoJ4955EvjGrza6czYdhnY6ryc+UChH4QgXoG/0at37UWV5uudhpUo
	 Lgi0zLSMGkG9+P5bfJNhJUsm0bfXRc8F94ie4TBd7oO5hbjHhRGowybnT623seeW49
	 ZtH1Qn9BDpjulWfv/1v+YqAvl34FFytlLNZDVJqZ4SryX1+YTnF+AxcxU5V5BWAodI
	 W+edO2Da8oCSALQrGgMI45Lajr/TyytFpPk8zJh3E5uhSt+aAtn92WfSJqI5+m80Om
	 cIA8kDIt+eGvA==
Message-ID: <b4026df9-059e-447a-ace3-340ba32cb62f@kernel.org>
Date: Fri, 30 Aug 2024 20:27:02 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
To: Simon Horman <horms@kernel.org>
Cc: Shen Lichuan <shenlichuan@vivo.com>, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240830081402.21716-1-shenlichuan@vivo.com>
 <20240830160228.GU1368797@kernel.org>
 <c87f7ab7-2c8c-4c08-b686-12c56fe3edeb@kernel.org>
 <20240830181625.GD1368797@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240830181625.GD1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 20:16, Simon Horman wrote:
> On Fri, Aug 30, 2024 at 07:43:30PM +0200, Krzysztof Kozlowski wrote:
>> On 30/08/2024 18:02, Simon Horman wrote:
>>> On Fri, Aug 30, 2024 at 04:14:02PM +0800, Shen Lichuan wrote:
>>>> Use dev_err_probe() to simplify the error path and unify a message
>>>> template.
>>>>
>>>> Using this helper is totally fine even if err is known to never
>>>> be -EPROBE_DEFER.
>>>>
>>>> The benefit compared to a normal dev_err() is the standardized format
>>>> of the error code, it being emitted symbolically and the fact that
>>>> the error code is returned which allows more compact error paths.
>>>>
>>>> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
>>>
>>> ...
>>>
>>>> @@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
>>>>  
>>>>  	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
>>>>  	if (IS_ERR(lp->regmap)) {
>>>> -		rc = PTR_ERR(lp->regmap);
>>>> -		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
>>>> -			rc);
>>>> +		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
>>>> +			      "Failed to allocate register map\n");
>>>>  		goto free_dev;
>>>
>>> After branching to dev_free the function will return rc.
>>> So I think it still needs to be set a in this error path.
>>
>> Another bug introduced by @vivo.com.
>>
>> Since ~2 weeks there is tremendous amount of trivial patches coming from
>> vivo.com. I identified at least 5 buggy, where the contributor did not
>> understand the code.
>>
>> All these "trivial" improvements should be really double-checked.
> 
> Are you concerned about those that have been accepted?

Yes, both posted and accepted. I was doing brief review (amazingly
useless 2 hours...) what's on the list and so far I think there are 6
cases of wrong/malicious dev_err_probe(). One got accepted, I sent a revert:
https://lore.kernel.org/all/20240830170014.15389-1-krzysztof.kozlowski@linaro.org/

But the amount of flood from vivo.com started somehow around 20th of
August (weirdly after I posted set of cleanups and got review from
Jonathan...), is just over-whelming. And many are just ridiculously
split, like converting one dev_err->dev_err_probe in the driver, leaving
rest untouched.

I think this was some sort of trivial automation, thus none of the
patches were actually reviewed before posting.

Best regards,
Krzysztof

