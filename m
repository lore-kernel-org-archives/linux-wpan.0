Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335281DE3AA;
	Mon, 28 Oct 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131440; cv=none; b=lwBuihLnQTdGIGRdvhz6AgzoG+2H6d7PgmjaGkigcsQc/y7kb2KQ3gKdCX6TA6B9lzCN98OPl/jP0ymAMXk5wpzdck+1ZckSBxZH4KPYlurIyBBKkgZ1kbBGOC0CXB5oALbzt5bytzFj75toWU3innwsw5loGhDjXpVP66/scFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131440; c=relaxed/simple;
	bh=iqAt5kPaiik/FTMLxs+mzA1+GtcB8VmPvoB+rHsp0m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH864kE+g9Wnrz3COHWfNvQ+tdDu3PZZE1uIMXgWJjCuNktJfliRU/dH8muhiXAjR0JKz8PulIDztXQYRiuCAzDY5VZhEas7LV09ysQbrLet+/I+/tXXdhYc2miFKNnN1LXbgnxCgJLhphbF8KOQll+Zyxsx7e6dZ1Nkvhyhhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from localhost.localdomain (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 3E274C0865;
	Mon, 28 Oct 2024 16:57:44 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with str_true_false()
Date: Mon, 28 Oct 2024 16:57:11 +0100
Message-ID: <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020112313.53174-2-thorsten.blum@linux.dev>
References: <20241020112313.53174-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Thorsten Blum.

On Sun, 20 Oct 2024 13:23:13 +0200, Thorsten Blum wrote:
> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
> function and remove the macro.
> 
> 

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: Replace BOOL_TO_STR() with str_true_false()
      https://git.kernel.org/wpan/wpan-next/c/299875256571

regards,
Stefan Schmidt
