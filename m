Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q5BZDqSL"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24ED6;
	Tue, 28 Nov 2023 03:16:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3C56C000A;
	Tue, 28 Nov 2023 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwSOSEy0Nrk7Z4MK3Ma1HzJQsew5/R4JHeCSbA3yyO8=;
	b=Q5BZDqSLz7xhixGnBCM0LOgKnq6NyEhMY7yz879MzB4Vk81GOWtZ7HsYzHz+yb6/oBs+v1
	N+2MhoWtXw0cHQ5C4vv11n0dGf1WdNCzyiEo0c5CmEcg9M4xmcX6qbfhdTw6h9zNDh5YH8
	aEQYbcbrxHEJyy2lbAFNCxUTnca9Fq3oNbxfmeyE7H0PBUHqwAYQPOlih+v5cLRftUgehv
	VOv/U9q0brUgxZm/Uu9PEwyAOgN4+qt0lTVvGNqy1Ejuv8zXE31vxV5ctb/BIy6G682Sqi
	N4/Ko/pwp8S5Vp/6eAq8aznHim8Mn1H9xBFa1ffEo3tRnZ0aXi+RubA8/y/kCg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <alex.aring@gmail.com>,
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
	netdev@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next 0/5] ieee802154: Association tweaks
Date: Tue, 28 Nov 2023 12:16:50 +0100
Message-Id: <20231128111655.507479-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

Last serie on this area to clarify a few points and avoid to confuse the
network too much. I believe more will come while using this stack, but
that's a first round I kept aside. Nothing particularly problematic
here, just a few clarifications.

Thanks,
Miquèl

Miquel Raynal (5):
  mac80254: Provide real PAN coordinator info in beacons
  mac802154: Use the PAN coordinator parameter when stamping packets
  mac802154: Only allow PAN controllers to process association requests
  ieee802154: Avoid confusing changes after associating
  mac802154: Avoid new associations while disassociating

 include/net/cfg802154.h   |  4 +++-
 net/ieee802154/nl802154.c | 30 ++++++++++++++++++------------
 net/ieee802154/pan.c      |  8 +++++++-
 net/mac802154/cfg.c       | 11 ++++++++---
 net/mac802154/rx.c        | 11 +++++++----
 net/mac802154/scan.c      | 10 ++++++++--
 6 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.34.1

