Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292E41A551;
	Thu,  3 Sep 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423877; cv=none; b=i7N+7y8QWsoB3LcFTvdMKUomyU4pG8oBlDbMghDtMmDl9kRQ6ZxzLU07lHbNFfrPvek1kTyvqnTzfLbZ0Tm0hzYF4jIxL40vb2TfMG4mt7C1EXupnZWXz5ENibT8rEJB/7PtCOi8fvbfSBs3XfmjZY7TDzXqyJOrTZNedYnHKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423877; c=relaxed/simple;
	bh=/4ofTCG2NVMFb6FKVsozmWjPggUdTp0yLcM+hSx8eL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTr2xQRcd4TPouAYFQuANTs0AaAg148nX2CPi0Phhli6lqWjV1vM5Cs0w+8VARjBxfpn7JU4kALjsRWiWymFbbyOsqIJpcv9GKE4TxRDyirJKOGFwttKb27fySUTGOKajcJXKW8irvadqLPQSq1M71X1iMyhnJX+niZbyJr4j/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=tWA1+khu; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="tWA1+khu"
Received: from [192.168.2.30] (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 14FAEC06F3;
	Thu,  3 Sep 2026 10:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1788423863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrOYGWsxY8Snq+GlopKVIC3cp/KQrNmWAj9PJHhAtuE=;
	b=tWA1+khuZZZ20PEBmsehdaG8Z6/OzZHexQma4N/X5pOMa4Wxw7kYVEK7m8MYEygD4JHfjV
	oWzDbNJ8ajoIUidelQsyPdGqQlzgLJ2vv3ZC19+0ltXSRfsgkSrwTl9uWI+zrJZEXdwQyB
	dI6TE2lcfKn9UMP0hWO+ZtKnDwA1TyKHRhmImicUaQp6R0B77H+8f1w0xDMf6CIwYCWlkB
	QdtPTWGp5OYnesC9fL4Z+ahLFfKX9byNJw/Rj8y5nKBZX8KA7wQXYXMRgZO4h8tkIn1g+G
	Hf7DgDTXLJRYiovVCWQaNkdlcXZSAtEFBoHcm2r0c6o5Dzso73ccKgzVqulDow==
Message-ID: <829f1632-07ac-4bf4-82f9-0335ca56d668@datenfreihafen.org>
Date: Thu, 3 Sep 2026 10:24:22 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon
 worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: zihan xi <zihanx@nebusec.ai>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, david.girault@qorvo.com, vega@nebusec.ai
References: <cover.1785596603.git.zihanx@nebusec.ai>
 <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
 <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
 <CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
 <ceb38e6c-832e-4345-bbc3-52721aa4b6c6@datenfreihafen.org>
 <20260902175643.709fb711@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20260902175643.709fb711@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 9/3/26 02:56, Jakub Kicinski wrote:
> On Wed, 2 Sep 2026 14:35:23 +0200 Stefan Schmidt wrote:
>>> This change already landed in net.git as 5f26a690e8ef
>>> ("mac802154: fix netdev use-after-free in beacon worker"),
>>> applied by Jakub with Miquel's Reviewed-by.
>>
>> Ah, I missed that Jakub took it already. Thanks.
> 
> Sorry about that, vacation season, I wasn't sure if you're AFK.
> I'll try to avoid taking mac802154 directly going forward.

No worries. I was taking a long time to get to these patches so it was 
appreciated if you picked them.

regards
Stefan Schmidt
