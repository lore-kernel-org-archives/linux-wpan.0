Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7915B115;
	Wed, 26 Mar 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008423; cv=none; b=B2iD3KUWjf3XL+ZlVreuspn1kwnII0wrC2L9aT8CxohGq1auJnEfQxT1lsYGJm+jWUHfIYjyKNMHibjCQ4l6PrmULiVO4y6ym5jUQeuS5pDtzSFJZzcl20Xdv8eQW63u4uMsJRcIqFaz/bxWfUCw0+ul/Xiov6csxShzdcgrmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008423; c=relaxed/simple;
	bh=Wg4X9Nbqx6icJd2lrlVGwCoibnEwo7WO4O8AZskjAjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzfePGQbJMQFtZ9C70ufWTrxMZtNlksooLtC51UvyuIqLwmGQRvqfsm2uz/8vJfmnRVa8oRp1Sf6gU5y3OjfHPhhxmYardn4u3ERkfV/Um2b9Td/SzARErgjcqB2k/m8Wp5QoMI2dSC6xvdroKjhTKKTiqp/ZmthXwFTGNaglKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N+z19iLp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N+z19iLp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F7A6442C4;
	Wed, 26 Mar 2025 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743008419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg4X9Nbqx6icJd2lrlVGwCoibnEwo7WO4O8AZskjAjE=;
	b=N+z19iLp+2VlQBDm8iBtVrwZrA+C2h6y8KuVTagCkf/YZo2YxgwbR9dxrqeUr5jz3yw1Qx
	acSxAub7lJUl4GmfrBOJkIqJolkEzol2W3jHo2fSsIzmF3Lb1HUESF4Dh+vIP+c1/HnRRb
	dmz5xS8WUV9YOk+C5MqiWXWaS8DnP0qxJAHkE4CCBxtdhVmV8KgI3I/m9uNw9IGSwYLr8t
	LCYKCbEYpzyNGMOXtCm/SjnI7MagjDTxpiNW5F+vrAWx8RHmib+UEo61l5hSxlW611HmqF
	iWNfTB7fKvZLgEugpZCwjNv3ZnwpyoSJDERvZ2GFZF89j4j38KP5t6gmhlg4iw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  alex.aring@gmail.com,
  netdev@vger.kernel.org
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
In-Reply-To: <CAK8U23Z0fpJ7ogsGvdWjnQV7kEwdgEW8pSQwbjT9UPVzn3LXoQ@mail.gmail.com>
	(Ramon Fontes's message of "Wed, 26 Mar 2025 07:34:14 -0300")
References: <20250325165312.26938-1-ramonreisfontes@gmail.com>
	<87cye4qexa.fsf@bootlin.com>
	<CAK8U23Z0fpJ7ogsGvdWjnQV7kEwdgEW8pSQwbjT9UPVzn3LXoQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 18:00:18 +0100
Message-ID: <87v7rvn2vx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeitdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelveetiedufedugfejveehvefgvefgvdehleefkedutedtffevhfegjeeggfekkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehrrghmohhnrhgvihhsfhhonhhtvghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdifphgrnhesvhhgvghrr
 dhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrrghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Ramon,

On 26/03/2025 at 07:34:14 -03, Ramon Fontes <ramonreisfontes@gmail.com> wro=
te:

> Hello Miqu=C3=A8l,
>
> This PR aims to replicate functionality similar to what is implemented
> in mac80211_hwsim
> (https://github.com/torvalds/linux/blob/master/drivers/net/wireless/virtu=
al/mac80211_hwsim.c#L5223).
> This approach is useful for testing wireless medium emulation tools
> like wmediumd (https://github.com/bcopeland/wmediumd/blob/master/tests/)
> and I plan to submit more PRs soon.
>
> I've started developing a wmediumd-like framework for mac802154_hwsim,
> which you can find here:
> https://github.com/ramonfontes/wmediumd_802154. However, it's still in
> its early stages.
>
> Indeed, I'm responsible for Mininet-WiFi
> (https://github.com/intrig-unicamp/mininet-wifi) which supports IEEE
> 802.15.4 emulation via mac802154_hwsim. Having a wireless medium
> emulation for mac802154_hwsim would be highly beneficial, as it
> enables controlled testing and facilitates prototyping.

Okay, I must say I do not know this project, but it looks interesting.
If the others are fine with this change, I'm fine too.

>> Also, please wrap the commit log.
> Apologies for any confusion. Could you clarify if there are any
> specific changes I need to make in the PR?

Yes, just change:

This establishes an initialization method for perm_extended_addr, aligning =
it with the approach used in mac80211_hwsim.

Into:

This establishes an initialization method for perm_extended_addr,
aligning it with the approach used in mac80211_hwsim.

Thanks,
Miqu=C3=A8l
