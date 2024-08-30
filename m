Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D541BF819;
	Fri, 30 Aug 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050127; cv=none; b=p41sf/dzrCkimnC3qmjJEp5m4d5wDNDJYHMXZhJ8QmxFZj16RMCo1eXG/KS+rt9VUi1acK6UZ7GXqxWlb9BS/SyghW3ITbWaWfUbonpqFOWcyfhklPJJ6VHdHHp4Y8K5QXYfrQLEA2oPuMJ488L+K4nuIogQDmHHZoJMFiIRZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050127; c=relaxed/simple;
	bh=8FCr1Z8j8HyNnaKfoBvqkPP5DW/x8KkUlYWhvMPZJT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCJ4nesd/dXLhJLhgIOX/LWAzBg5Flr6zSjsJFzML37RCyWKnYbQ4DayQPTa1bNB+Pk05wOW11MNeBNRY4u7182/+Km4Dki6CAWbP+isFX1NC2W5ArlbOLCyxsE0U4ioGmyNPGIcZts3Z/QRF0dBbbNBgJKepX2FWLBmClj3Ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=GM0++EeY; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="GM0++EeY"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C1255C02E1;
	Fri, 30 Aug 2024 22:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1725050121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tn+46Kr3b06tsrlhXAV/Oojqb1oCroARJ+Cr669JF+Y=;
	b=GM0++EeYUiVXsWW106altA9C3EATFjSCGD49KHOsPj3i4EEI5VYPEbVsCgsM4NyYrPxjOG
	InAbWOSWDHXNL56x/9GoBwrWkNnhQWPTjhm42asgBKIa+8Hc37VpcG0pxIvPaYDafrN1uN
	+Z5pWg74jiUsGYj05atT2oRBhsslJhDDcMU9R9JeTz14bfbni8oRHn0TuNOziRYrNbjLN+
	lXJ40YOaBAQcYsK8Kdmom5M5MHvaxzZK8qvjolQdW5DL4JNbjrer3Eh8CTPb59IU1vDIfz
	Lo6IZJ9idL9kMVLWwzi86GfWIFjYF8pyKMJomhFeBRZDuaw1hd9f1KymONeMwQ==
Message-ID: <9f9e14aa-f809-4bcb-98c6-840e41729877@datenfreihafen.org>
Date: Fri, 30 Aug 2024 22:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wpan-next 2/2] ieee802154: Correct spelling in nl802154.h
To: Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
 <20240829-wpan-spell-v1-2-799d840e02c4@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240829-wpan-spell-v1-2-799d840e02c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Simon,

On 8/29/24 6:10 PM, Simon Horman wrote:
> Correct spelling in nl802154.h.
> As reported by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   include/net/nl802154.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 4c752f799957..a994dea74596 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -192,7 +192,7 @@ enum nl802154_iftype {
>    * @NL802154_CAP_ATTR_TX_POWERS: a nested attribute for
>    *	nl802154_wpan_phy_tx_power
>    * @NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL: minimum value for cca_ed_level
> - * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maxmimum value for cca_ed_level
> + * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maximum value for cca_ed_level
>    * @NL802154_CAP_ATTR_CCA_MODES: nl802154_cca_modes flags
>    * @NL802154_CAP_ATTR_CCA_OPTS: nl802154_cca_opts flags
>    * @NL802154_CAP_ATTR_MIN_MINBE: minimum of minbe value
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
