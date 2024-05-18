Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632853FB9F
	for <linux-wpan@vger.kernel.org>; Sat, 18 May 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716068989; cv=none; b=HDkTqH08nMsIM1wYA2LyjFlkaYOo0W1bcIg7JzWL1KsBpIzxCLN78H/1ScE9335FQNDEf0ZG5cRIQRsdga9GS01JY1OuyR4vIpEriOIg60ER7mXEuWW8xOsbPt47Dpu9f6GpVwg+2crCx3Xgnsl6yiOb/IkW7LszhSuy5sQOh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716068989; c=relaxed/simple;
	bh=y+3z/0SImEatttbQhITqfCW09q4Zp7imB/p3uFkwFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OahdHzG+TJa8buv7bGQjMZOU94zc19UQP07/5xWFdSjdMPMLRMqmLNdq7Bb5vpaT3r4Hz9ndXC+DwM+0xUiny+g59FkvoEDr6z+0q6LqUZfW0JuhYXYY+zKFpYj9HpMlDv7zMqfVpd0dgO3fmvKDLFJrFP71+LDQnjb5hwVYPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=H/n9r1mR; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="H/n9r1mR"
Received: from [192.168.2.51] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9EB9DC0221;
	Sat, 18 May 2024 23:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1716068981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PCHHEMOb8i3hUZ/FWEtsjaH2np1ZTMEfKL0DAyC66Q=;
	b=H/n9r1mRNNIC9Gaj0FEuqYY4YlkH5nNcZ9W3H8M99oDrDmLJiMW9ZcHoX5v1Fl2iU6DsWN
	luladh3bHlTPDIiLMDEDKKvvVVLH1h6PiRTDJw/PRCVoeRgaSvXa+2+mioUSG5F7Sms/q7
	XqmPkPzEu5gH4kv/jNymZaahA1HZ4I2BtZrrCinGOi2L9JyC2/8YCpoIIRuKoxKRuxXjhq
	WcJZVhEHbjpBVz+VxoWUFwSAHP6GZiPj62HDaC+B/cWJtCrF33qaX/uJhBqDrDtqv7/iEE
	2YZBe+M1NOpG9+moy9OccPh47kx6TAm3uF5KFJuZH3xxfy8iYVjCItNd92DWXQ==
Message-ID: <ea13c022-11f7-4474-88f3-9ff9169600f9@datenfreihafen.org>
Date: Sat, 18 May 2024 23:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: fix time calculation in
 ieee802154_configure_durations()
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Dmitry Antipov <dmantipov@yandex.ru>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240508114010.219527-1-dmantipov@yandex.ru>
 <20240513090902.2d61ca02@xps-13>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240513090902.2d61ca02@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Miquel,

On 13.05.24 09:09, Miquel Raynal wrote:
> Hi Dmitry,
> 
> + Stefan
> 
> dmantipov@yandex.ru wrote on Wed,  8 May 2024 14:40:10 +0300:
> 
>> Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
>> 'lifs_period' and 'sifs_period' are both in microseconds, fix time
>> calculation in 'ieee802154_configure_durations()' and use convenient
>> 'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
>> Compile tested only.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
> 
> Requires Fixes and Cc: stable I guess.

Fixes should be enough to get picked up. Added before pushing.

regards
Stefan Schmidt
