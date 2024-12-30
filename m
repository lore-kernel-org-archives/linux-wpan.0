Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4DEDE;
	Mon, 30 Dec 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581646; cv=none; b=XWr/fjgznZTQLqTLx7KuxqS7DozJL69GlBu/o3+lAYBwDWORZB4qwcKuMtAUraSJvIPYGOyzWG9NlNPGlXztd+VYHh30rh6/8ARFCkrDNqYvMXQXlBH+W0tR8IlNUTBwzPasMOilYKpBuoLo/bjKXMzUYXQEkxW6ADK9bN7FuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581646; c=relaxed/simple;
	bh=nCSVuLi1e4KlnhBUVOrZvlW00F49uB7YuVFoc1pMptY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRMjAv1uSpJb1mqrGPiyk7pRwm5Iio4Q1yQDjSWCOEoJ+on8776WN7cJ5/nEMubCeHdMXtPCMfgjqVy0xDGuIwmxCiBDj5I94InTNF37mxpo9InyLxU026/pXnoSdO2ByNyoe6n9yTmfHzUhoRnXtotbnT9gXma0/mrFyzuuIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=v6qJhRce; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="v6qJhRce"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 99800C04E6;
	Mon, 30 Dec 2024 19:00:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1735581638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XobvmJEgKvCDi/6IKOtxB0es852wClfUk/6TwybrxgA=;
	b=v6qJhRcelBWdTNfX8QPhbQPtK0sfnOABY6iLriyxqwB4X4onE1DjaHe/XKWJ4TlSkBuHG4
	l0G1C3GS7Z0pYF10+22XXAU+1dvBZtX/t+LzyXUm5TQFfIDu8eoJhHI70jAm41drNqEuyu
	DX/H4SLXc+dOxq557+6rmkbFo1e0MiGpGSItf3/YnZphsYMbj2APLDESWJAmg0HOWJ5l9W
	XrMmhNZ3pYg9R1kr5WPBQe+deflO/NnO12FpIz33iFgTjNhN7lvqTcDaHEFaKhNVIqZQFD
	QWHt/p/KWhmoerXv9wQDN+HkAT3q0vQuxt/lLvd50XVEiet75xRPr/ux5lF30A==
Message-ID: <409c1c7c-dbee-4c10-acbe-4aca98ac720c@datenfreihafen.org>
Date: Mon, 30 Dec 2024 19:00:37 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next] net: mac802154: Remove unused
 ieee802154_mlme_tx_one
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241225012423.439229-1-linux@treblig.org>
 <173557391812.3760501.8550596228761441624.b4-ty@datenfreihafen.org>
 <Z3LcEIO8cRAHUUsG@gallifrey>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <Z3LcEIO8cRAHUUsG@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dave,

On 30.12.24 18:44, Dr. David Alan Gilbert wrote:
> * Stefan Schmidt (stefan@datenfreihafen.org) wrote:
>> Hello linux@treblig.org.
>>
>> On Wed, 25 Dec 2024 01:24:23 +0000, linux@treblig.org wrote:
>>> ieee802154_mlme_tx_one() was added in 2022 by
>>> commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
>>> commands") but has remained unused.
>>>
>>> Remove it.
>>>
>>> Note, there's still a ieee802154_mlme_tx_one_locked()
>>> variant that is used.
>>>
>>> [...]
>>
>> Applied to wpan/wpan-next.git, thanks!
> 
> Thanks! I'd been thinking I had to wait for net-next to reopen.

It's in my wpan-next tree and I will send a pull request to net-next 
when it opens up again.

regards
Stefan Schmidt
