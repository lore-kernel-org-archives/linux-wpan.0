Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ILYWzC33"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFAA1B5
	for <linux-wpan@vger.kernel.org>; Tue, 28 Nov 2023 03:29:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F7591BF20B;
	Tue, 28 Nov 2023 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701170987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L48v1Q02BYnnfBIkGpR00jADNuLYVR0kvaFaGQLGIe0=;
	b=ILYWzC33Eyc8HWgTtogBxwQ88smTiNMs/ynWWOFQimZSGUFWDrtD8nKplbxhd02lgov6wf
	/5pTd6+OqiPivAfKscVAkB0cszVoL6M1cE5eZx+i3A9GXo+7N+HBd5Ztfk46obhiZpo3qx
	CikAUSzZLfSAUa1qrlIXWZgTIpmPg/1WRN3Uc+Nq4EBUrjGcLv0SlhLpYrI51Rxiw3lHwx
	t+u2oyxzZdzwm3VXRHNQ1qsGBW0CXxifO7uixBbDDnFXbmuirUgOexVCVtWBZ2FTnrn1M1
	H9RuLaHv0vf+PDUFdhU0B5Sp0HmL+3e7HtGV+0b+SlPcd/Xf0ttDA3Jh6wtr2g==
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
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 0/2] Associations support
Date: Tue, 28 Nov 2023 12:29:43 +0100
Message-Id: <20231128112945.509331-1-miquel.raynal@bootlin.com>
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

Associations will be part of the next kernel merge window, so here is
the userspace part to interact with it.

Thanks,
Miquèl

Miquel Raynal (2):
  iwpan: Synchronize nl802154.h with the latest association changes
  iwpan: Add associations support

 src/info.c     |   4 ++
 src/mac.c      | 187 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/nl802154.h |  22 +++++-
 3 files changed, 211 insertions(+), 2 deletions(-)

-- 
2.34.1

