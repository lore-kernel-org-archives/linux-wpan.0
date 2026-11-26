Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681590;
	b=hLjGBU5m4mgb9jawHiXWlyNZ5tuN/xeFN3Fbhsot5URSnkBausjzKJaSkd5zUK5vwkFU
	 GnVcEvPOEM1xLelWYK2YUVnxZqPiqMso36GcT7HNJs1sjt2BxxiXzisGAa9YcA00Yxqa/
	 D7sSv9OVUr+lG1rDqlOv6eW2Rbbi6UNvMJEVYNptRt8xoRAEkIXDQM/yN9PogUdQ6di0C
	 VV3ihUcybbr2omqzcKPAR8iONtTGT+EHDiRctAGC/vnN7ItQeZUVxFtFlujX+JfQrcJSU
	 xcZoeyXEviB8qV4+k4cVkQL93mxxU/ot6yds8vI5IH3P2c/QLkxufNr76oCKrZ2j1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681590;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fUsgAvLEngpJecrlankZZHVktfcYHXm5rWrKm5ruiN0=;
	b=V6IsigBz3alq6ZXjAjk086PA2JK1tPiMsmbJXyFnwTMGM+QaGYFysWSWVCJvKcvuUMmU
	 dkb46aDOk8vkseHP0JwiL0wUmc9wMFYmCnNAunPNR4KB1E/xk62Hp4XAIxVsyzf5m4yLY
	 egdQ35Qns2LlqnDgciS90GpUiddwNqyjAMKmiChbDmAUBUeHYUIgd7T7UP1kRyw8hX89z
	 Ucs9a26AQPE1c/NeqGRQttP845WA6R2vJ3pAT5cdBAr7mTg4f0CJo0YgqkjAJIQhHhsXs
	 73CsL9fpKpiG4QkZcSIkMZbEoZi6ze4r2wkaYgHZLcnMrvGhswn3AZLo1FFNAgjEKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEF606A321;
	Thu, 26 Nov 2026 08:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFEF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id B5A50C0368;
	Thu, 26 Nov 2026 09:26:27 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Adi Prasan <itsadi2409@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	alex.aring@gmail.com,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mac802154: fix race between slave_close() and in-flight async tx
Date: Thu, 26 Nov 2026 09:26:18 +0100
Message-ID: <179568157201.1896265.9428141805092103350.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261002144827.3479-1-itsadi2409@gmail.com>
References: <87ik3tn1nn.fsf@bootlin.com> <20261002144827.3479-1-itsadi2409@gmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Adi Prasan.

On Fri, 02 Oct 2026 14:48:27 +0000, Adi Prasan wrote:
> netif_stop_queue() prevents new packets from being sent to the driver,
> but it does not wait for a transmission that is already in progress.
> 
> drv_xmit_async() can still be running on another CPU when
> mac802154_slave_close() calls drv_stop(). Stopping the queue only
> prevents new transmissions; it does not synchronize with an already
> running tx operation.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] net: mac802154: fix race between slave_close() and in-flight async tx
      https://git.kernel.org/wpan/wpan/c/8f382e9fe920

regards,
Stefan Schmidt
