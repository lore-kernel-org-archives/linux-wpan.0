Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686402;
	b=BVPPYQ/GlN3PtlIN9RA4gBihNwr6SMH44EwisDzoVY0yQ1XLfA4B76bFjQ/Ivb9EnbZu
	 2ueCWNqSSStT8iui1kOToBz4LDjQkLMIvItvRzEkbm4xHobhSFkvidU1VyPNnvUWokB9k
	 fKbJa9BR0DPYztgaWjg8+P+7HFaVimCLKCeNaRM+DvevxLaqnTowa6hGDDhiWdpFyH74E
	 CY3Ou3RAa9AHmKt8YOtVYRWeHXUu26muMiE1jQR48jbll10cIVfFGcmQ2yY5v1ybYtnPi
	 Pt1bFGG9TTHPkTkoXniRtrT9o0+ALSlWPdoG0dpy0pbuZFzCHgZkqOPqKq3uu2XKUoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686402;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ihRZPKwwcBwnL82bvvJhpAYLTjYeEr2UUurenFP8Sg8=;
	b=TG16aA8KZDbHXyaD2lAuKn9TW4rEWOpv0/t83qDZ0dRfaTer29G6PHvY5rAwUcfbjSch
	 Hy+3K1hyQTiyCDigIBlDNewgmDf5cqrfnOUmizXAC7zcNR9LrNUpIsmrd0zOerBApppos
	 dazNaMj+Quy76tRLTZigck2Lp+gYBjx7pcUXA08OGRgPr8R+hyJAr7ihL6reMgcC7tygV
	 dBz30NgZXv5ESeaVlpRcAJlbqSU1OQtngrPUhyYXx+oLQFErfp4Ajq05m/nuNUVQGP3zo
	 clYSxHbmYqkfLFwjq3vLVfPNS/uctXcxmC4XkLhiqxqP67iTZG/2EcWN+z52GbhMs6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E838606A323;
	Thu, 26 Nov 2026 09:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E838606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id E6AA6C02DA;
	Thu, 26 Nov 2026 10:46:39 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Lee Keon-Hyeong <leegun25@proton.me>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] mac802154: free a replaced child
Date: Thu, 26 Nov 2026 10:46:34 +0100
Message-ID: <179568639028.1969825.16464730477655114016.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124085905.710751-1-leegun25@proton.me>
References: <20261124085905.710751-1-leegun25@proton.me>
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

Hello Lee Keon-Hyeong.

On Tue, 24 Nov 2026 08:59:12 +0000, Lee Keon-Hyeong wrote:
> When an associated child retransmits an ASSOC REQ, the coordinator
> removes the old entry from the list but never frees it.  It also
> increments wpan_dev->nchildren even though the number of children
> has not changed.
> 
> Free the old entry and increment nchildren only when adding a new child.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/2] mac802154: free a replaced child
      https://git.kernel.org/wpan/wpan/c/4022afee3116
[2/2] mac802154: look up children by extended address
      https://git.kernel.org/wpan/wpan/c/b6148aaa5eb5

regards,
Stefan Schmidt
