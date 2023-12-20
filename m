Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E9168D1;
	Wed, 20 Dec 2023 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WQFE4Kwg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE0791BF207;
	Wed, 20 Dec 2023 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVd/oo80Bpx4SsSIr5c4398l/h6I/PyRwlRGETeJ1Ng=;
	b=WQFE4Kwg0OeEmX4xJNL6JgEreyKCqbVkQeNo6+Wh7Qxa+0GBm9e00IHiBP6yhDiB22Ui1j
	2bKorKiw4vQGOT7MBBfGuOhKmDgWQybb5/S7l7H/KYFPsSjyrGSkMqnFGpOX2RvCAsdaWJ
	smgdyTtX/kLDmWtnkQX2q9pCli/xkienGqFGuylQXy53/heabDt23igBgp507mKh3bWb0A
	SKQmc68eF8oePb9V7dWpK3B+dBSqFUYgBre7QlsPrHczsvEqlBJTq1sqlHd3MqU5mw0/QB
	OftLhTS8gnWk48/ZJpw+f4YKMz8qHLUBWXoWPwmNrWxJGpGl2P8Pq7fKxwVheg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH wpan-next 3/5] mac802154: Only allow PAN controllers to process association requests
Date: Wed, 20 Dec 2023 08:32:33 +0100
Message-Id: <20231220073233.410942-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-4-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'95d92505b6063896d7a1e6fcadd07e8552653cfb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-11-28 at 11:16:53 UTC, Miquel Raynal wrote:
> It is not very clear in the specification whether simple coordinators
> are allowed or not to answer to association requests themselves. As
> there is no synchronization mechanism, it is probably best to rely on
> the relay feature of these coordinators and avoid processing them in
> this case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git master.

Miquel
