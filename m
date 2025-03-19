Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1F1E520D;
	Wed, 19 Mar 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403389; cv=none; b=Apb+2mnUM8LL1bBsmC+uzG6Tg5YMZnhHCKeiDKJVQaDlRNl6H8u542vNzJ9qkGDNNv71qVxK8M4KnrMFWZeHMaWFsDxJkZeJNH8qUvcb4OuZDVihLGplZ/0qpxPc3iU/Nwpzf+/NjlG5UHt9nOa+T4bjiWynDPDwWlMRqJ7RC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403389; c=relaxed/simple;
	bh=RwMY2A6TE8KPkV9oIN0tHDRAPp0fPsCc52F7JIiKjW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpRHz5XWeJ+3oN35gropBwa9Ye9HFnAWaNipuZm2Ey87mW9PQq6EbGV70j8aK/UidjwZV91F+2ZfTcixVRhIqppsavOmbxgBZiVidbQNjhk0TF6i4PNbdaTps1izKdRk/aX1ZtgFvllkWD3sXUiUyF6a7P63zi7KB5PUu+LYvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=sHbyR/WS; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="sHbyR/WS"
Received: from [192.168.2.30] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C1E0AC05A4;
	Wed, 19 Mar 2025 17:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1742403377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcgptT5JlLGVr/LMQ37kerorcLQmJz9N3ply/i/XhCw=;
	b=sHbyR/WSgOE4AJx5+jCEj7yNxufJN4XS+iQs/XCuQrWNFrLFyFD9DQNHQ5Yo49valJxwIj
	TDS+gJ35A+YppuWfNb0FpsamYvm/LhhjVQrHINStskgqHDn9O9CzFZi0vKflYBFPPQmLZt
	TRDUbx3WaXIQ9ClDp0rZ2lwEkH8NLyIa3fGFvqsFrS9vTnprQSTnj022R8LUnXJByhRCAC
	Bxb6UbnbIDX2pkhenYUCb67eMPaTE/AEsSjxjNOQY3FGudFHJiGL8XgXxzRP8/nfQunwai
	D6wnkM+4eV6bEP4+nDu3TTepvfmMLBiLveSBJUkoAUAq9qRsnmBUYAy/tr5ATw==
Message-ID: <ca515b13-f48c-43fe-b1c4-3fd2d9506083@datenfreihafen.org>
Date: Wed, 19 Mar 2025 17:56:16 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ieee802154-next 2025-03-10
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org
References: <20250310185752.2683890-1-stefan@datenfreihafen.org>
 <91648005-0bf9-4839-8b8f-5151056c9f9a@datenfreihafen.org>
 <ae626131-20e6-4d7b-b5ec-5a9804917e51@redhat.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <ae626131-20e6-4d7b-b5ec-5a9804917e51@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Paolo,

On 19.03.25 17:53, Paolo Abeni wrote:
> On 3/14/25 7:37 AM, Stefan Schmidt wrote:
>> On 10.03.25 19:57, Stefan Schmidt wrote:
>>> Hello Dave, Jakub, Paolo.
>>>
>>> An update from ieee802154 for your *net-next* tree:
>>>
>>> Andy Shevchenko reworked the ca8210 driver to use the gpiod API and fixed
>>> a few problems of the driver along the way.
>>>
>>> regards
>>> Stefan Schmidt
>>>
>>> The following changes since commit f130a0cc1b4ff1ef28a307428d40436032e2b66e:
>>>
>>>     inet: fix lwtunnel_valid_encap_type() lock imbalance (2025-03-05 19:16:56 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2025-03-10
>>>
>>> for you to fetch changes up to a5d4d993fac4925410991eac3b427ea6b86e4872:
>>>
>>>     dt-bindings: ieee802154: ca8210: Update polarity of the reset pin (2025-03-06 21:55:18 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Andy Shevchenko (4):
>>>         ieee802154: ca8210: Use proper setters and getters for bitwise types
>>>         ieee802154: ca8210: Get platform data via dev_get_platdata()
>>>         ieee802154: ca8210: Switch to using gpiod API
>>>         dt-bindings: ieee802154: ca8210: Update polarity of the reset pin
>>>
>>>    .../devicetree/bindings/net/ieee802154/ca8210.txt  |  2 +-
>>>    drivers/gpio/gpiolib-of.c                          |  9 +++
>>>    drivers/net/ieee802154/ca8210.c                    | 78 +++++++++-------------
>>>    3 files changed, 41 insertions(+), 48 deletions(-)
>>>
>>
>> Friendly reminder on this pull request. If anything blocks you from
>> pulling this, please let me know.
> 
> I'm just lagging behind the PW backlog quite a bit. The PR should be
> merged soon.
> 
> Thanks for your patience,

No worries. As long as I know its in the queue and not fallen through 
the cracks I have all the time needed. :-)

regards
StefanSchmidt
