Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941C2DC33E;
	Wed,  9 Jul 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066654; cv=none; b=D84lxd4h76ytqLDXMmq3+yc14siYqzS8DslnLz5/qPhtZgiNUtzGzDt1t8GWT+V3wB+C+mnVKD2j4qSeX0cLOVpF7l9F3+INV+qU42nHtFAzQUtN2dV5mT6qHaGt2TYXsVGChyD98AY/5YopXmgXq578Qd4bLTzIBFhySKgP/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066654; c=relaxed/simple;
	bh=pPubf83pVYobJU9g2Wig0sYU/aPQg0MEVYjmZeTm6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZOPd49JDSd43/2eCakV9u9OB/UkMwqtLmXdW7zCZRCMA3UyxlMWhZPy/clTKxw/FUb7pZ3gSZn00d9LTdInzHsgeu5aIr84Jvqld7SeK/ijEzEIdN+8x0uqP2ZxFK9G6yHMKey7TMc8XU17dPRfSyII1io0//i9a/FlYV1D3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwJvzPgh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwJvzPgh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DCAD1400331;
	Wed,  9 Jul 2025 09:10:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752066652; x=1752153052; bh=NXULbg1haPQDJKrc/iX4fj4gLugfnbyp2M3
	KPHjoCfk=; b=VwJvzPghw3cZybE/ATMrqb3s04CsbGGiFL1U9UqzdE9RYzrlJQD
	mX6UGQEVSu6iTdif6LAfRQQxbsoZP89EgE79D6fqWo860FtR5C6Naz9rtyNBWxEG
	SeA1trX/QjH1FzralUDcc2Xxf3SrBqslxvYnLlnocVzEOoWMgcbzDj4InlGIKS+7
	2DplfbJxWKvsBJ/g7KHrEAGT/85DlaXQtoy4/78kV8jnuRXZP8eZfcbUN7oVo5dA
	wAw0p6Q2H4uidMa1n95CwQjU2SNCu/YsKbPjGcGUaSq3WC2e/vmB3ixFGAUHsuLq
	NRHkUcYUSq9mb7336z8W7sQa3E9jZLdwiKw==
X-ME-Sender: <xms:W2puaLVNUp3NxWQfAAEX2TohnCwulLh4fgODMG8uUlx4m9Lc6vmQKg>
    <xme:W2puaDtFc8kVI4An8BdHipOTcS4eaQsut3yZAWY_VaJ62xj6gmfextC65bfhoGdS2
    ybBlu30WiiBQ9U>
X-ME-Received: <xmr:W2puaO2Q4NlBTKpGYUqMnn9aXZbJV9Nd5OTK0AHtsC5i3hW4pLXcIikoQRjJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepfigrnhhglhhirghnghejgeeshhhurgifvghirdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephihuvghhrghisghinhhgsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:W2puaM5CFVSpUWozHdBmmVMqc83BuinnCzqyAIW-PNmSZD0tcHwnoQ>
    <xmx:W2puaNWpYTwFzRrzPNO0lkT-bLVXq04Sb4K5OFZIcX6F9UEuy7x4bQ>
    <xmx:W2puaMiysU6mub0Ru0xoe5rLHki4-UZy-NUnOreg3Jr8rI1_J2k2Rw>
    <xmx:W2puaFdCU5zdN_bwxKo6A46YgA33vg4OhKruxHEv01U30zhT8lbYUA>
    <xmx:XGpuaPr6wYVUxry38-uc1ZfbmWPJj9sZWaLSMSeRJ4C3g2eptvx-rsvx>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 09:10:50 -0400 (EDT)
Date: Wed, 9 Jul 2025 16:10:48 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
	dsahern@kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: replace ND_PRINTK with dynamic debug
Message-ID: <aG5qWGe8ifY1_JGo@shredder>
References: <20250708033342.1627636-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708033342.1627636-1-wangliang74@huawei.com>

On Tue, Jul 08, 2025 at 11:33:42AM +0800, Wang Liang wrote:
> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
