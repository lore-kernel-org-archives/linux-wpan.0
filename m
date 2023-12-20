Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06B1D545;
	Wed, 20 Dec 2023 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GLBUmqPM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D29F6C0004;
	Wed, 20 Dec 2023 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703062558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jIY61KijjJ2vNLa1ITXpS8JKIrwLl179AtUUJno4JOc=;
	b=GLBUmqPMZDyotGZ6JeE+hA5I1T5YZq26MZmBsAsheLlcBVtN96iJXX2b1xKNyh1UwzKBWy
	YMFkQo3aa4j6nSAOCeciWlOYagyQzwdSnFjdTwtLeHmxxBbBuVEBQGKTXfBEYR0KD84TlB
	g6y17BPTN9z7P6smKQoG0zuQxJduLIAgICgRUsdW09/fS3nM7DRdrmTaGnX8dYeZs4lU6Q
	LIIX5dJIf0piuNKdhonW8WV5sFG+cYsZzKu+oUIfCpcNHyfdImmDDU8udDFehfQNx+0nBW
	iDd9DUgc85RdYUrnN0iyL2sngOCiGYirpoh38fPGXGX8mDGkNPpq9VjiwApEzA==
Date: Wed, 20 Dec 2023 09:55:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org
Subject: pull-request: ieee802154 for net-next 2023-12-20
Message-ID: <20231220095556.4d9cef91@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Dave, Jakub, Paolo, Eric.

This is the ieee802154 pull-request for your *net-next* tree.

Thanks,
Miqu=C3=A8l

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/wpan/wpan-next.git tags/=
ieee802154-for-net-next-2023-12-20

for you to fetch changes up to 2373699560a754079579b7722b50d1d38de1960e:

  mac802154: Avoid new associations while disassociating (2023-12-15 11:14:=
57 +0100)

----------------------------------------------------------------
This pull request mainly brings support for dynamic associations in the
WPAN world. Thanks to the recent improvements it was possible to
discover nearby devices, it is now also possible to associate with them
to form a sub-network using a specific PAN ID. The support includes
several functions, such as:
* Requesting an association to a coordinator, waiting for the response
* Sending a disassociation notification to a coordinator
* Receiving an association request when we are coordinator, answering
  the request (for now all devices are accepted up to a limit, to be
  refined)
* Sending a disassociation notification to a child
* Users may request the list of associated devices (the parent and the
  children).

Here are a few example of userspace calls that can be made:
iwpan dev <dev> associate pan_id 2 coord $COORD
iwpan dev <dev> list_associations
iwpan dev <dev> disassociate ext_addr $COORD

There are as well two patches from Uwe turning remove callbacks into
void functions.

----------------------------------------------------------------
Miquel Raynal (16):
      ieee802154: Let PAN IDs be reset
      ieee802154: Internal PAN management
      ieee802154: Add support for user association requests
      mac802154: Handle associating
      ieee802154: Add support for user disassociation requests
      mac802154: Handle disassociations
      mac802154: Handle association requests from peers
      ieee802154: Add support for limiting the number of associated devices
      mac802154: Follow the number of associated devices
      mac802154: Handle disassociation notifications from peers
      ieee802154: Give the user the association list
      mac80254: Provide real PAN coordinator info in beacons
      mac802154: Use the PAN coordinator parameter when stamping packets
      mac802154: Only allow PAN controllers to process association requests
      ieee802154: Avoid confusing changes after associating
      mac802154: Avoid new associations while disassociating

Uwe Kleine-K=C3=B6nig (2):
      ieee802154: fakelb: Convert to platform remove callback returning void
      ieee802154: hwsim: Convert to platform remove callback returning void

 drivers/net/ieee802154/fakelb.c          |   5 +-
 drivers/net/ieee802154/mac802154_hwsim.c |   6 +--
 include/net/cfg802154.h                  |  72 +++++++++++++++++++++++++++=
++
 include/net/ieee802154_netdev.h          |  60 ++++++++++++++++++++++++
 include/net/nl802154.h                   |  22 ++++++++-
 net/ieee802154/Makefile                  |   2 +-
 net/ieee802154/core.c                    |  24 ++++++++++
 net/ieee802154/nl802154.c                | 249 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 net/ieee802154/pan.c                     | 109 +++++++++++++++++++++++++++=
+++++++++++++++++
 net/ieee802154/rdev-ops.h                |  30 ++++++++++++
 net/ieee802154/trace.h                   |  38 ++++++++++++++++
 net/mac802154/cfg.c                      | 175 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h             |  27 +++++++++++
 net/mac802154/main.c                     |   2 +
 net/mac802154/rx.c                       |  36 +++++++++++++--
 net/mac802154/scan.c                     | 407 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 16 files changed, 1227 insertions(+), 37 deletions(-)
 create mode 100644 net/ieee802154/pan.c
