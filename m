Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD06BA53;
	Tue,  3 Sep 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389538; cv=none; b=aDIOzLfr67aEmUnJc1PJtztuweX3b4wrILPnr8k9rnuEQH2GKZ88M+ij6utE+z9zau5b3f5ErFttxj4zf3zLpJFI8LOz77d5ATaT5CjK1XJ+f5i1b6XsAXJhDuqBT2PlJXE0eTLp0EWqEEjeSUcOu5/kAIE62bOINRZqLter1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389538; c=relaxed/simple;
	bh=ffplWhuK3ET293+A1hXpwhHUPquZav93WC/csF5xBcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBpP7CIolEvYDBxFdyLpeKyJ3kupLGhJkFis983TjZbbxUbt5BOBYU7eujW2WcCHozIAId577DKF4g0tRsKLVFcwA9bruwuZy/8kPpvA9bNbM2wADFa62Hs+GK5fm9c3/dPP/6KDAz2AakyD/1fnL+eQ6xQJ7qmQcmwt/N6mII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=s0Ib0mV3; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="s0Ib0mV3"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id D141AC0227;
	Tue,  3 Sep 2024 20:52:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1725389525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7w2SMbBL1iV03a0jDO7CRGlR/QttdjqKlEF+SWInx78=;
	b=s0Ib0mV3KcRGqMU9BRe8tT1EygiGM7jUN8aXjBC+9mBYo3KKRigOa9rfR+O+oHfMw/z7Ol
	XFJuUez8/e8rclfpOfQzzfFvnQbwt7W3Y3Zpm/ZdzkLr5Dv3kbYGtkmKZiiIK32E/fCHQp
	HoNqvg/snsZGugz8G5hRGjme5WUm3Gz5gPl8ORZNF4A4ac53v083MYBf/OVfUqj1mk1c3e
	Xits3WM8P4MgYyUzD9MeJwMOCNVwNgncySSYL2oljb5ZXJglDKzfAFZwLOBxY/iZNgrjcZ
	8FYyGDSQvznJH11SHYv+DkXJ8QMLk+ljLvQ1stGCN6+uqHtnJIIEmxO+BR1vXQ==
Message-ID: <750caf49-c4e0-43f7-a89f-5b9af96fc0f9@datenfreihafen.org>
Date: Tue, 3 Sep 2024 20:52:03 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154 for net 2024-09-01
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20240901184213.2303047-1-stefan@datenfreihafen.org>
 <20240903114257.7b906da2@kernel.org>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240903114257.7b906da2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 9/3/24 8:42 PM, Jakub Kicinski wrote:
> On Sun,  1 Sep 2024 20:42:13 +0200 Stefan Schmidt wrote:
>> Simon Horman catched two typos in our headers. No functional change.
> 
> Is it okay if we merge these into net-next ?
> On one hand they are unlikely^w guaranteed not to introduce
> regressions, but on the other such trivial spelling fixes are
> not at all urgent.

Sure, no problem. They just landed in my fixes queue and thus wpan. They 
can easily go through net-next. Can you merge the pull directly or do 
need a new one against net-next?

regards
Stefan Schmidt
