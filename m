Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1E18AF6;
	Wed, 20 Dec 2023 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KXg17+zS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6F5CC0002;
	Wed, 20 Dec 2023 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9Hk2iDoZ7tBSmSivGOt3e4dGGfzGi9CPmxUVU7yWNc=;
	b=KXg17+zSxSIW3kK1KbfIPI6lbpuf8qAMRLirWE3vi/gI9ApwO5c0K7oBij9Kx06lMmKBAf
	2RzUwCe+Fg88ZhK9iUV9hLJxydkAnFbVF54dAAGRVt5NMB1vxHVKY5v3PUR6lnCPKq7fVq
	HQVetf8ndDrNQALpbZcANp3z/fORqwd9C88xSpHpTawMp+tVDA0a0C3MOXOnHAVbJJvUkl
	w5iIlyyF9UqHtnkOzTBClyDV7ctV/galACPBIdqtxdRq5/m76Xw/moT9AnAMX22dlnSyph
	nVKezYE6gQL9ggV9MkYZbYHkRooCNdRrk8EjFymeoFkytlOF6HsodJxVGSaL3w==
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
Subject: Re: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator parameter when stamping packets
Date: Wed, 20 Dec 2023 08:32:36 +0100
Message-Id: <20231220073236.410992-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-3-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'e9dc1bc9b8dc3aa5380678c5a60593fb6abac68f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-11-28 at 11:16:52 UTC, Miquel Raynal wrote:
> ACKs come with the source and destination address empty, this has been
> clarified already. But there is something else: if the destination
> address is empty but the source address is valid, it may be a way to
> reach the PAN coordinator. Either the device receiving this frame is the
> PAN coordinator itself and should process what it just received
> (PACKET_HOST) or it is not and may, if supported, relay the packet as it
> is targeted to another device in the network.
> 
> Right now we do not support relaying so the packet should be dropped in
> the first place, but the stamping looks more accurate this way.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git master.

Miquel
