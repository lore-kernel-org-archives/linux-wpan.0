Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F81F60F;
	Wed, 20 Dec 2023 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dWc/tZ5Q"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A90F91BF203;
	Wed, 20 Dec 2023 07:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703057548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65s4EFGxu/rbQGMAygx8qlLdfwDkT4llBT4SYZ4E8FY=;
	b=dWc/tZ5QlV58M5AFOGNLp/lHJ2esN25yKHLgodlpqRUuXep0F4TmVg4JbpchunCC8RaQ/w
	+KkSQQYfDSq8J06fHLmCcnToHYeldgm1pj42Oiiy8FEovNlfn/73IBkzrl+q/VB9J6i7n0
	U8c7DdzJsdLh4FOHuM2aLtC23sU9JNVmkW3GB/bUOiDFj1xCjJmYBaoxbU4Qd3eOX/eNW5
	0OtO+PsnwRAXI1iODSr9CRTncLNIzdJDKWb2SeXDCMwX8FC4ACu6MXKrbs0BTpOGzQhYio
	C2uryu26gCd9B9p6v/DBjmAUmNlxa0NcQH8lP1c3I6sNAXCnBK0VGI+A2UIR7Q==
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
Subject: Re: [PATCH wpan-next 5/5] mac802154: Avoid new associations while disassociating
Date: Wed, 20 Dec 2023 08:32:26 +0100
Message-Id: <20231220073226.410884-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128111655.507479-6-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'2373699560a754079579b7722b50d1d38de1960e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2023-11-28 at 11:16:55 UTC, Miquel Raynal wrote:
> While disassociating from a PAN ourselves, let's set the maximum number
> of associations temporarily to zero to be sure no new device tries to
> associate with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Alexander Aring <aahringo@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git master.

Miquel
