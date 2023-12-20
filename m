Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1ED15AF7;
	Wed, 20 Dec 2023 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q+SrvEL0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D621060004;
	Wed, 20 Dec 2023 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4XMens6aNsPG8lAWDbKEDVeyWmloh5O5/mH6/T2CS0=;
	b=Q+SrvEL08iMXsLMEm4TnWLAxHfL91JyiaqqsNsTr0EG4e7InudoLvvuL/h31troqMP58w/
	IBfnnFj2JzHQQuvPZYJ+1IWJ21Eg8omXFoupuOPXYboAHRz1sawfPY6MDyY9TFyVzRCLvM
	vNQNeoSoyG+kBKVtUu1nT3LEKMYXFewX63HyxyEwon610WXxN+iP96uoJZ+JX76TP/jG6a
	q4oZjOP1wUSQuQDVFJmayA+SdrpOannke9rX7/ltR/uLF7BsCbMtcsKqPV2xqy+PnLoHDL
	yWQ9mTC0AIDbbXargp7NMLeEz34AYU0F5R1Ar1zkxt/+jW4BKeq09Vmh+y8aMQ==
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
Subject: Re: [PATCH wpan-next 4/5] ieee802154: Avoid confusing changes after associating
Date: Wed, 20 Dec 2023 08:32:29 +0100
Message-Id: <20231220073229.410913-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-5-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'b720383ab1cfd584c8c0d9fc7b8cc541ed76dba5'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-11-28 at 11:16:54 UTC, Miquel Raynal wrote:
> Once associated with any device, we are part of a PAN (with a specific
> PAN ID), and we are expected to be present on a particular
> channel. Let's avoid confusing other devices by preventing any PAN
> ID/channel change once associated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git master.

Miquel
