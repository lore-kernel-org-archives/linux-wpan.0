Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FE3BB47;
	Mon,  9 Sep 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910866; cv=none; b=N1tokSKW1LljzVqgodPrpra67hbvHcrsG5Aq0vCt4DMvGnWkvU/buTWlU7m4zcYOdqIxNL4FY7Apnswht4gQG0kyQtoz1CWuqRWOjOTDNxJ8btR16fkeu3yjqRlFI+uFxa+uEihJEyXZxb2ojjP8nW6VdYY2X88Xp5VXlEsa0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910866; c=relaxed/simple;
	bh=1i7y9HGuAGumMZJjH5rcHVo7M235u278917IPiUAFxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpT5/EtKz7+xILAz4LIcRWmdp7iC7z/57sgEiP9Xk1XIHJE+68gmtUUjx4RPUYYfUNNjmpNqiG8wGWaoYNQ9h0iUBAxBLuvAu2Ad8pRsExdCT8Xj5rB6qq8d6HAKZ178342SlcTIvOQWvcr08seWkGBBRpteoU7gS6kURwAlgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 97B22C07D3;
	Mon,  9 Sep 2024 21:40:52 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuxuenetmail@gmail.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ieee802154: Fix build error
Date: Mon,  9 Sep 2024 21:40:04 +0200
Message-ID: <172591052663.45799.15009721032954430797.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909131740.1296608-1-ruanjinjie@huawei.com>
References: <20240909131740.1296608-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Jinjie.

On Mon, 09 Sep 2024 21:17:40 +0800, Jinjie Ruan wrote:
> If REGMAP_SPI is m and IEEE802154_MCR20A is y,
> 
> 	mcr20a.c:(.text+0x3ed6c5b): undefined reference to `__devm_regmap_init_spi'
> 	ld: mcr20a.c:(.text+0x3ed6cb5): undefined reference to `__devm_regmap_init_spi'
> 
> Select REGMAP_SPI for IEEE802154_MCR20A to fix it.
> 
> [...]

Applied, thanks!

[1/1] ieee802154: Fix build error
      commit: addf89774e48c992316449ffab4f29c2309ebefb

Best regards,
Stefan Schmidt <stefan@datenfreihafen.org>
