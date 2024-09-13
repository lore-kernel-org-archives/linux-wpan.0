Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BA15575F;
	Fri, 13 Sep 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212550; cv=none; b=okBezl7bXnIhmm+9ixsI+XYKatTn2fVoArP4m17R06M18sU997y6WMVwErR5TjIvKKyk7QvjP43wuD8NxddI9+inwo0nbIm5dFs3PLyZxlY+57A6yxLL2GmId/geVFH8AnEt+M62ncQlMNtoeq58wOon92S7m0f3TzA8hRk1CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212550; c=relaxed/simple;
	bh=ZceMZTXtzNrxMPQ12iF7j5lOAcGLnvH6tG6W7ZnyJRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dF+tEB018k4IRoOP75X6YB6hs2iS4EBt8h7oU5Zi9Yz/EGklMCqJhgnbNcnl3p38333e7byZepdQT6JtQmo/KCl9UIJkPyPtqeo679iroGr5lml/krDhuvR1J8ELLipP+t5gWmTa3jWpfd0hA0+R95mQmW+hubXyOjMjli9lW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 4A2ECC0712;
	Fri, 13 Sep 2024 09:28:55 +0200 (CEST)
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
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH wpan RESEND] net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Fri, 13 Sep 2024 09:28:25 +0200
Message-ID: <172621171581.1193568.18321906806528077380.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911094234.1922418-1-ruanjinjie@huawei.com>
References: <20240911094234.1922418-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Jinjie Ruan.

On Wed, 11 Sep 2024 17:42:34 +0800, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.
> 
> 

Applied to wpan/wpan-next.git, thanks!

[1/1] net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      https://git.kernel.org/wpan/wpan-next/c/ace2b53313556

regards,
Stefan Schmidt
