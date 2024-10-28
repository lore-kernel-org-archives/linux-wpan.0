Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59B1DFDBC;
	Mon, 28 Oct 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147533; cv=none; b=e+WzFXLIy+3KdGR1BC26LpWrn5oESmszXhEi0GrNATB10lRecCg9N05U2J19+NZmnA88aZmBVYIMyCIYyAvJ4SonQM77tkNja+trqNs0mw38mkgrOkEid/xptjo0qU6WLGECpkcDfiRDR2Xa6PKbYoxtBL5iRzY56CZgFFLX2LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147533; c=relaxed/simple;
	bh=B03hKLCQchsjbEUpRDLfNEIUpnyC8bh4CRuEWCxJMDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx1bFT5wEgtGzLg16+N63aZPTJ6ZAef5lzADaZuKUxTRkqaXUtE6brAJeqxLHIhGoIPHionZpNphUTuStGfcllrFz8QmY6m4hm0Gaqg9m0WADSu1Le8PYpANz84c8ginZLY07BvLLDM5mBJNhdvJj7MYJuHDoST16QMCikfkLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=v2cEml09; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="v2cEml09"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 95F4BC0488;
	Mon, 28 Oct 2024 21:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1730147525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpysltlm+Ryy9ZImoE8gVLlSmjcEYUS2RlrIIiDqopc=;
	b=v2cEml09C8/X/dT7T8REgcx88HzF/d/7w3FilCj+mfohlYXCe0xOj5vILqE3bNlN763y+L
	zvWvvd6y4UK381ZfX5w2K6YH9FmcWjlnOmzWvYqlUIF3Gs6f6m4rBFGgQJLdQ5ZB0aJMNE
	7fZV66DApmbzd5qYGV86la2CZGcwr1wJB+vrmsgLyrVt3r1Gqt08xNyQxzx9IEEN8v3jha
	DGpzibhsm2+0eGez8xFUsoOxIMT3amFBaoubyZLD8JA2Wfdvz4QNY8PR9B7+SI9B0RYKwb
	uLmMCP7rvapz1V45DALQDH28+ucOl7PCMEl+7RvJZq9D/al3sLyMbu3y0OzQUg==
Message-ID: <b701a9b8-173e-4afb-9e94-78995fd23621@datenfreihafen.org>
Date: Mon, 28 Oct 2024 21:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with
 str_true_false()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241020112313.53174-2-thorsten.blum@linux.dev>
 <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
 <3B24A2C8-B684-4A86-AEC7-198891897F56@linux.dev>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <3B24A2C8-B684-4A86-AEC7-198891897F56@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.10.24 17:42, Thorsten Blum wrote:
> Hi Stefan,
> 
>> On 28. Oct 2024, at 16:57, Stefan Schmidt wrote:
>>
>> Hello Thorsten Blum.
>>
>> On Sun, 20 Oct 2024 13:23:13 +0200, Thorsten Blum wrote:
>>> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
>>> function and remove the macro.
>>>
>>>
>>
>> Applied to wpan/wpan-next.git, thanks!
>>
>> [1/1] ieee802154: Replace BOOL_TO_STR() with str_true_false()
>>      https://git.kernel.org/wpan/wpan-next/c/299875256571
> 
> I'm actually not sure this works after getting feedback on a similar
> patch [1].

That is unfortunate.

> I'd probably revert it to be safe.

I removed it completely now, as it has not been part of any pull request 
yet.

regards
Stefan Schmidt
