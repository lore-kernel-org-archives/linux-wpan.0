Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684320;
	b=wOfx1HN1CbVgdSTlm8lAe2BhV2WKlh8UQs3Wu7Mj4sW1BZgXTmd3Uqgoo+O2OMGPr4iA
	 FNl1cjO/+MHFiroe76XheA0bnnZJAjtbdGY24whfb7R2ElZ2Y7F+77crgPQpLNnDgN+Ni
	 KBlAWhQbdguLh/nTBz+mlwmkf+5q32UHVzuyP2qwlXzMp3zTKIJ7VUJtRPZPW23ZB4m2x
	 BECzWalBSyY53f/qLQGIKYIVbp3OpEgWVWiwXUQG17BqSTDCbNMCDJeWKYjT4a4nneLIb
	 MLsBmOgkBEHqkKNbxnRVfUfYBKZVyTY3cer0gFM4E4+6mHcqsXO4hcyI+HK7dJ2TExA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684320;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xlPXbBzk6OAyHCSpIb7JT+SULbnTMe1cN5htl76U4AY=;
	b=ze+JEKZmYyZ7LzM/uRpGi3L6nTl4tgad9lAKnvGfbsbJjlCJ1Fzxhsv76TQKad+JiYYN
	 vMqBESLSbAp9QLAsdsAVfQ2D/fDD/F5PLcoNrIIB9Vo2qqVFIRoTxMtGesoDtuehbDMvQ
	 8HUmh02cWb5h0Ce8ryVlBxMpBgvGxjKgsrMYyYv3CIT55w02ZIAxHjLFaS96u6WSU6mrZ
	 qB25IHjqww6ipsDtcXISqRFZdxzHrquDaRtu7NgfRug6IaXCbANEsvqIFXDZN5js0X788
	 HllURwppYCgZ2DWuaDAOCpuMawcvkYETCsT8dMYZWgw2H5CfDpRbPeIWp8OVZF2tCFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39677606A321;
	Thu, 26 Nov 2026 09:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39677606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9350CC0270;
	Thu, 26 Nov 2026 10:11:56 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix netdev_priv() type confusion in lowpan_event()
Date: Thu, 26 Nov 2026 10:11:50 +0100
Message-ID: <179568430273.1923641.1345266046368621519.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261106225930.1379968-1-roman.gushchin@linux.dev>
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Roman Gushchin.

On Fri, 06 Nov 2026 22:59:30 +0000, Roman Gushchin wrote:
> lowpan_event() assumes any netdevice with dev->type == ARPHRD_6LOWPAN
> has a struct lowpan_dev in netdev_priv(dev). However, non-6LoWPAN
> devices can also have ARPHRD_6LOWPAN, e.g. a TUN device via TUNSETLINK
> or a bonding device inheriting dev->type from its lower device.
> 
> Bringing such a device up or down causes lowpan_event() to read and
> overwrite unrelated netdev_priv() memory. Since unprivileged users can
> create TUN and bonding devices in a user and network namespace, they
> can corrupt struct bonding and trigger a slab use-after-free.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] 6lowpan: fix netdev_priv() type confusion in lowpan_event()
      https://git.kernel.org/wpan/wpan/c/092207b6f1b6

regards,
Stefan Schmidt
