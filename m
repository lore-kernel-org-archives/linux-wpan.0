Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD91D9346;
	Mon, 31 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408928; cv=none; b=l7dLpPvwzij4jm5E03ycl5pUn6PI+IqOdpgl5vi15QHIxiZ7zBtQzmNkyTGwmfR8lt5VDXYD8ZNysIqsZFBIvaORsdYbge39v/wEyxVIVHVYLjnD/FUi0Woq1gN9kn+YpkxA9pHita++JIP5EXHRkbPZL4ftIRVHoyZpYiD+iqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408928; c=relaxed/simple;
	bh=xzbSJmbHVYXKp1qf2mYjMMKjNPel1AyBFnmhuaRVVU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGChyhsn3IP/7oWGbItiaRh9GAhbR/GIGQB7v7vy+bo3EMpgDopwy63ir0a1lFO5IyoVA8NidUVMFS/xPvmbBl4cYySpSa0Dde2QljTBgeMof4etrOm5VVcvDLBEss99KgFVeHrDE0wsly7QplJLsrHT6QpleuBxH2T68JLbxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YWyfjeQn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YWyfjeQn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16BCB2047D;
	Mon, 31 Mar 2025 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743408919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzbSJmbHVYXKp1qf2mYjMMKjNPel1AyBFnmhuaRVVU0=;
	b=YWyfjeQnegVXG+txds2vC2URQ2KLVLenBDymSpEYGduB/CfYHUzsXhUFEa5JUlOh0Qi5Iw
	XExwAoAV8kpeKKCRUqRv8Ge4l+p4CTdW50v3tNDA6hovGjiyFcu5PdcErpvIv+BK+Vabv1
	97T+ige/o7SLOT+gl9TB7wlSIjLUMWGviVpLlGE7qTZnCiuHroBWlqQepHWU9F5zSp7Up3
	GKcH3N/t8WCfCjfO68PHgbOxtaQnrI9WhLf8YF2hJiU8soizKQvQ3T8ycKcUJPNFViRVr3
	B5+ete52oh89LiQ6g61hcaQrU/l5olBkNHsoH7Bu89tuZcOrGlJrOs/Z/5+ijg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  alex.aring@gmail.com,
  netdev@vger.kernel.org
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
In-Reply-To: <20250329142010.17389-1-ramonreisfontes@gmail.com> (Ramon
	Fontes's message of "Sat, 29 Mar 2025 11:20:10 -0300")
References: <20250329142010.17389-1-ramonreisfontes@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 31 Mar 2025 10:15:18 +0200
Message-ID: <87bjthwr8p.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeelvddrudekgedruddutddruddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddutddruddvfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehrrghmohhnrhgvihhsfhhonhhtvghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdifphgrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egrlhgvgidrrghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 29/03/2025 at 11:20:10 -03, Ramon Fontes <ramonreisfontes@gmail.com> wrote:

> This establishes an initialization method for perm_extended_addr,
> aligning it with the approach used in mac80211_hwsim.
>
> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>

Yeah, that's simpler, thanks Alex.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
