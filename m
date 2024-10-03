Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C01C32;
	Thu,  3 Oct 2024 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939566; cv=none; b=GuPm0nlVrphRU7BV13AH6KqrOqrU7m75ccl9/LO3QL3E7HAXIyaEf5mDSxcddVVyUvWcVK7ue8V7rTXuay0Wa+vJocNn4yUFDNNoHfPLch7wlrFQ/Xsq7YEDwcg6BL82wlXFKNWapGJoS6Xw9eBuyKrD3P0CYmpYrK7FRox+NZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939566; c=relaxed/simple;
	bh=AbxBJ8jQbUTVnKA3XMDHmLQwB5GMdgU0fC03kqEvmOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlKrIGkLFxwrakbe8vUuwPsQJmKUtSIYjWtNFpV99ohcr0A87j5GvErCeA8B6c7M7cfd1zB6ChTZWEkrA7mkHZVcK2ryTTq/Db0jN7SPKIQHyIcuy5jFEhO0P30iPieqsFyq8zGMI3pcuJw6D3KFax1u/Wf1WeUMEngN/Czh9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=gCruPBG0; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="gCruPBG0"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 1DD0BC044D;
	Thu,  3 Oct 2024 09:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1727939554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0dsqakMl0Qo2qi7ICa5Db++dTZCWUSpG9tmMvl634U=;
	b=gCruPBG0jyZctBiJQkQaWgoENu8opL5kB2de4gvNujfeEagiTipzy6ykvwAF6b/PMBch7G
	4ZtPc/XaITXEDdo+O7is8xNQ8VzUJZKILikbw/+oAC0Uyj3JItVoPDwiI4E+gJb9DHvVDM
	RE1DNI4sR5/8Mh7hwyQ9HFu/3Qp/HXv+PHD2skQqvgPWTPN5e3G2Dsr6uUwSmF35p6VtYN
	CbmlBqffKENgSI7opKjLNnipSHE/RXDibNO+vo9VbUdN2U5/Fk488D2kzrKQj+BXQw/bp6
	XtGkHhIE6mGMT0vnSDkWxUHoyCMcVPD9rKNH0hQqTtGjSkeaBv+lPWN2knVupA==
Message-ID: <2f0f000d-412b-487e-b416-cb10eb04be6a@datenfreihafen.org>
Date: Thu, 3 Oct 2024 09:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154 for net 2024-09-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20240927094351.3865511-1-stefan@datenfreihafen.org>
 <20241002170814.0951e6be@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20241002170814.0951e6be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 10/3/24 02:08, Jakub Kicinski wrote:
> On Fri, 27 Sep 2024 11:43:50 +0200 Stefan Schmidt wrote:
>> Jinjie Ruan added the use of IRQF_NO_AUTOEN in the mcr20a driver and fixed and
>> addiotinal build dependency problem while doing so.
>>
>> Jiawei Ye, ensured a correct RCU handling in mac802154_scan_worker.
> 
> Sorry for the delay, conferences and travel..

No worries, just wanted to make sure it did not got lost.

regards
Stefan Schmidt
