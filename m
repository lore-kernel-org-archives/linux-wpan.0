Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8511F95A;
	Mon, 30 Dec 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574512; cv=none; b=rES/nX1EzX+JqGHMKtN72qKSgIkHRX9/c3qnuc4yyoYKXepA4KTWzmmoa/Allz1YWsygRsaDf8s/Dkc6+wbXRyr8srVsCsB9xpzZM7X+uVwuIOlirPZScNA9DkUYLy7utCkecZ+YFppAlAFhl/CyhvXCJewN59Vfzzw5on6EyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574512; c=relaxed/simple;
	bh=upE6mmLGUYBFCCrc5ClABB9Do+//eEgHWdQ0CkA32jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G63xCFxiOpFzFBbKPr71ytOZIzkT8CchW82bCZfsVmvrT8yh7BiG44OIcsDwg4T7m2fE+1E+0G8Nm+az8TLU6ZhEmfUCTIIRbuDOssUPkhKGeA2qQAbcuWB5G+fooIxZGS5svMVmRt3O8rzh7P0GiF0AzmbINNiX00cEP2CxLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C1434C07D3;
	Mon, 30 Dec 2024 16:54:15 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux@treblig.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: mac802154: Remove unused ieee802154_mlme_tx_one
Date: Mon, 30 Dec 2024 16:53:52 +0100
Message-ID: <173557391812.3760501.8550596228761441624.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225012423.439229-1-linux@treblig.org>
References: <20241225012423.439229-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello linux@treblig.org.

On Wed, 25 Dec 2024 01:24:23 +0000, linux@treblig.org wrote:
> ieee802154_mlme_tx_one() was added in 2022 by
> commit ddd9ee7cda12 ("net: mac802154: Introduce a synchronous API for MLME
> commands") but has remained unused.
> 
> Remove it.
> 
> Note, there's still a ieee802154_mlme_tx_one_locked()
> variant that is used.
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] net: mac802154: Remove unused ieee802154_mlme_tx_one
      https://git.kernel.org/wpan/wpan-next/c/bddfe23be8f8

regards,
Stefan Schmidt
