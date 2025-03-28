Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E72F30;
	Fri, 28 Mar 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150589; cv=none; b=fm6boX2/3F3dXM94nY5DGAiW58W/kS0UxGpCi92lakSVFwfHF2c4sMe48IM1DTERsO5RolE3ipgRJM1ceZ7zCw5V87Pjlhlwng46v+ayoBO1Ry8EJh+UDz6XLsa9kLprW8ovMdq3uaOKN3MSE8H0RhH11grL/bOWDVMEz4gcSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150589; c=relaxed/simple;
	bh=V3hQ4OQdrTiJeOLn3coWnJr02emFD/LESeuzBKknGwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sG3WGJxoywGo0qYTbKKkuQQbH4+BbVE865ifWjWxa95LasXwnqIQUku/kWpgknKAbG+Hzz5F7lnmDOks6xCTZz/TSpz+Qyu8AMrKE+arziGCHZLdwct/EM4KbdoHO4rK4n8HLCtAEtuQzHfeXKSiJFyaPd7wdGzQvuluCt2T+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LoVXzkaj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LoVXzkaj"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42105441CE;
	Fri, 28 Mar 2025 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743150585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3hQ4OQdrTiJeOLn3coWnJr02emFD/LESeuzBKknGwQ=;
	b=LoVXzkajv1XsjWNcSJBMHp9FgRS2O+tOqt7BqL/U8WZBPUAAYnOueN8qyfciXsiMSIHEdC
	i/YPAxTidWA5n+AdaR+JNBYO268I8vQV/YIc6OcKn2hVqKZkTLbpjxqBwUrULidoki7K+w
	RRQ47u7+oQyfyhKECBybtHv86K427Q3Yof1Io7KezqM/26kLmB+Qj1SdDcnnIMeLSzls+s
	Q7Vj2Y7WtyuKIRWR/gQeCM00Rlv7e2mrMXMULtS50f9Phj0Zc6LCghKTRcS1dJRUibt1ew
	HWEIZeQndU2spcUBbr4FYd0viFAH16m2hGFPZPqcZCGrExI8GGJtUr2Omi54gg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  <linux-wpan@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 0/3] Avoid calling WARN_ON() on allocation failure in
 cfg802154_switch_netns()
In-Reply-To: <20250328010427.735657-1-i.abramov@mt-integration.ru> (Ivan
	Abramov's message of "Fri, 28 Mar 2025 04:04:24 +0300")
References: <20250328010427.735657-1-i.abramov@mt-integration.ru>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Mar 2025 09:29:41 +0100
Message-ID: <87zfh5lfre.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehirdgrsghrrghmohhvsehmthdqihhnthgvghhrrghtihhonhdrrhhupdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrghnsegurghtvghnfhhrvghihhgrfhgvnhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghom
 hdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Ivan,

On 28/03/2025 at 04:04:24 +03, Ivan Abramov <i.abramov@mt-integration.ru> w=
rote:

> This series was inspired by Syzkaller report on warning in
> cfg802154_switch_netns().

Thanks for the series, lgtm.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l
