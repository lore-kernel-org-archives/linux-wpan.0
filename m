Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FE168C4;
	Wed, 20 Dec 2023 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AlXL4G3U"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC4DD240003;
	Wed, 20 Dec 2023 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuxHDbx959XSxmvAZu7trGTApMk5GJ020wwO6Eb9hwM=;
	b=AlXL4G3U9C1OTwtEp7GI63ef2TOC5XP+2kO6DdpNnZK95iopMj42c3ce48ffU8+HPCFhN5
	lDlSH5U5XGpoo7hQqQNknoQyTwYDOPNeQxkG6OhM/dW96EA/DRBBJKPEjfZbvbwUGqq2Mp
	p4s6Zh1liVH9+Slrd572H+ee3WXgOjYWQPhFilgdsR4ta1jqkx/AecSiUUJXZlVkiQoGRi
	M9TGmxcI/g8Q4moR8kLXHENl7jrN1t641HM/G0akCQunM/HDzTN1H4YCLg+IjoEVNedKJK
	pHBuZHELrvXU5DpKs81pIfnAhvdCvWMMBG+TNYm/frZXvOhRMku5HTLtYYd8/g==
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
Subject: Re: [PATCH wpan-next 1/5] mac80254: Provide real PAN coordinator info in beacons
Date: Wed, 20 Dec 2023 08:32:41 +0100
Message-Id: <20231220073241.411025-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'cf1b830e625baaee5bf1ae4ba4b562cbec5ad012'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-11-28 at 11:16:51 UTC, Miquel Raynal wrote:
> Sending a beacon is a way to advertise a PAN, but also ourselves as
> coordinator in the PAN. There is only one PAN coordinator in a PAN, this
> is the device without parent (not associated itself to an "upper"
> coordinator). Instead of blindly saying that we are the PAN coordinator,
> let's actually use our internal information to fill this field.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git master.

Miquel
