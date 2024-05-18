Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C6DDA6
	for <linux-wpan@vger.kernel.org>; Sat, 18 May 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069297; cv=none; b=kyMr8eHAsvKqHIowxk1lJsjFr7rSvRbEJYBZYNWnSfLpbnej1jGci5rCgd+flzl8HXUjjL3THwqPSxSlcO6ihMLMa9ol7cLK0kReKrrtzy98uX6uxJQjYPLJdyDqwowvgUklcSMBF91tADDcMl989YH7zKfQwxBqNWQrjHFznFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069297; c=relaxed/simple;
	bh=UtGMvVghZ+z1W5Ms64TwgYzM7WgThLy/1gHebR53mSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXTNu7/CmbjuvVsiPl/SgogjAPBjOvc3tNWJ4gZ4b2K6nr6K/MLDTv+SWEw1V97Era7d5sPSAU6h6o6BVsoREgCDb5s6rXWRZQvVoKYLl64uCc7oWOAqkC0C5HS4RQQ1B7JKkc4d0RxUY1xqRFXRPf72Hbqn6w0jWGlbKZ/j8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=b/9xBVgj; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="b/9xBVgj"
Received: from [192.168.2.51] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 5FDA4C044D;
	Sat, 18 May 2024 23:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1716068937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdCYnDZAV1N69k7+FU6fOqlt3H2UPuvcQLF5P0qUZn4=;
	b=b/9xBVgjqgzA35RomvCDtYFVkk+9xSIcWKnqUdOj7zgRRdZSPY3CpNFJ+/VoJ0K271SQh7
	evPsuLzaFz0H87NG7iBbuGwBOPsaD6HKE4EfHuaiuhuJLzPA3dnT7i8cVu+kZR4XBSOhne
	uiWtibF8okcXUoO+o8qWQqDoUaWvBU4RQTo1yqINEv+Pc4oCMXSdVpI7gc04gNuLwrz4x9
	hji4o2B2OkZB7qERTYwVn3ywkCz3GiMtexvvr7oS/e7weD3WSid0nRDtxl4P8szjREXpLD
	JWuGevydrnG1XuVVeWujUD4z0+ua8vBYRhTmZ+rmt9YKZt/Mv/gOgDcT4o5plg==
Message-ID: <6d3eab3e-7fa9-45ca-a02a-312f8be2af37@datenfreihafen.org>
Date: Sat, 18 May 2024 23:48:56 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: fix time calculation in
 ieee802154_configure_durations()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240508114010.219527-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240508114010.219527-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dmitry,

On 08.05.24 13:40, Dmitry Antipov wrote:
> Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
> 'lifs_period' and 'sifs_period' are both in microseconds, fix time
> calculation in 'ieee802154_configure_durations()' and use convenient
> 'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
> Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   net/mac802154/main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 9ab7396668d2..21b7c3b280b4 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -161,8 +161,10 @@ void ieee802154_configure_durations(struct wpan_phy *phy,
>   	}
>   
>   	phy->symbol_duration = duration;
> -	phy->lifs_period = (IEEE802154_LIFS_PERIOD * phy->symbol_duration) / NSEC_PER_SEC;
> -	phy->sifs_period = (IEEE802154_SIFS_PERIOD * phy->symbol_duration) / NSEC_PER_SEC;
> +	phy->lifs_period =
> +		(IEEE802154_LIFS_PERIOD * phy->symbol_duration) / NSEC_PER_USEC;
> +	phy->sifs_period =
> +		(IEEE802154_SIFS_PERIOD * phy->symbol_duration) / NSEC_PER_USEC;
>   }
>   EXPORT_SYMBOL(ieee802154_configure_durations);
>   
> @@ -184,10 +186,10 @@ static void ieee802154_setup_wpan_phy_pib(struct wpan_phy *wpan_phy)
>   	 * Should be done when all drivers sets this value.
>   	 */
>   
> -	wpan_phy->lifs_period =
> -		(IEEE802154_LIFS_PERIOD * wpan_phy->symbol_duration) / 1000;
> -	wpan_phy->sifs_period =
> -		(IEEE802154_SIFS_PERIOD * wpan_phy->symbol_duration) / 1000;
> +	wpan_phy->lifs_period =	(IEEE802154_LIFS_PERIOD *
> +				 wpan_phy->symbol_duration) / NSEC_PER_USEC;
> +	wpan_phy->sifs_period =	(IEEE802154_SIFS_PERIOD *
> +				 wpan_phy->symbol_duration) / NSEC_PER_USEC;
>   }
>   
>   int ieee802154_register_hw(struct ieee802154_hw *hw)

I added a Fixes tag for you here before pushing so stable can decide if 
they want to pick this.

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
