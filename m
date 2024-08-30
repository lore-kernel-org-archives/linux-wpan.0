Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A42166F0D;
	Fri, 30 Aug 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050692; cv=none; b=MO04a1LLox/7idM012ZULkJSsY+DVrVlmUUsH2DAK7vhmEXTHlnkw+I0zZ0pmMMVW1y/0SAMyUtmUgl4OcEY57vX8XcxFmfwlxq9IXLPlVuDH3af4ybIO2J3VQUJk9NvOCkyJVP+T6NXKemU/rPUOCWXAdiQfTvgiGF4WQGMNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050692; c=relaxed/simple;
	bh=gbsSKK8OZHKf0VMhEm//aTupK7QwVzIkC70uzXeGn3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNvChBXXNDfXiExiHaJZj+IoPdMtn8iNMoWMfWersAizdmRs3/ikuWKZymRBVcB475D32m13whK+Fw77gxKOZ+DNokwme0Q5gqX+n8rQCJktp64GhJhcltfeZWbsSBgA6/RLOR19fdwSp0verNb9MB76HfKYA75uMwBee95mvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=wHh63gdH; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="wHh63gdH"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 35780C0227;
	Fri, 30 Aug 2024 22:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1725050099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2Y0+NJnv+WDhyHNXgn8lTJmwBV6+uwGK96LUIBqTuA=;
	b=wHh63gdHZU6K86MkDE0iABYjR4k6JJbBZPw+IgegPBRidBy1ajuGsaYmG62eGxf5dqj1it
	AGVIMttC5dp3tICM/V1M2VdxEY1lE6Xfk/h1eBIAYkr1gwkR6icuWJuBIxL7K/BCGKyUhu
	c/HTNG7nH/7q2I2mK7Yyh4p0Qx3UaMgUP+rhSjftmexSxfevNA1we5HPoJ2EINirIeFxLD
	ux05k5yCzofHelyzo7Iml6Gt9vP9JLD0yr7wQEC6rsnnaHTJcwM0I3StI9BRhywkOu08GQ
	iwo91e4xxd0Tr8YXpvhwmBUXNlHb9mDwCHu4ynxFNAwT7HlUBAuHFTHL9AUg8Q==
Message-ID: <b1856b58-f098-433d-b0fd-782b24c44b22@datenfreihafen.org>
Date: Fri, 30 Aug 2024 22:34:58 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wpan-next 1/2] mac802154: Correct spelling in mac802154.h
To: Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
 <20240829-wpan-spell-v1-1-799d840e02c4@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240829-wpan-spell-v1-1-799d840e02c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Simon,

On 8/29/24 6:10 PM, Simon Horman wrote:
> Correct spelling in mac802154.h.
> As reported by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   include/net/mac802154.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 4a3a9de9da73..1b5488fa2ff0 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -140,7 +140,7 @@ enum ieee802154_hw_flags {
>    *
>    * xmit_sync:
>    *	  Handler that 802.15.4 module calls for each transmitted frame.
> - *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
> + *	  skb contains the buffer starting from the IEEE 802.15.4 header.
>    *	  The low-level driver should send the frame based on available
>    *	  configuration. This is called by a workqueue and useful for
>    *	  synchronous 802.15.4 drivers.
> @@ -152,7 +152,7 @@ enum ieee802154_hw_flags {
>    *
>    * xmit_async:
>    *	  Handler that 802.15.4 module calls for each transmitted frame.
> - *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
> + *	  skb contains the buffer starting from the IEEE 802.15.4 header.
>    *	  The low-level driver should send the frame based on available
>    *	  configuration.
>    *	  This function should return zero or negative errno.
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
