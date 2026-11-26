Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684558;
	b=twHaO9Pmx8732NcGVNQMGRhKFJqo4FEeTZdJPRJ8mOsXYV5FstD2k6x3L1TKiBrNKnvQ
	 RjLXv1yAl2sXkLi9oaF13a+Ropirxt2g/Yzr0ciHdVYaX8PQwyYJ9jiaC8V9u0qdJUJ76
	 +/4SawJuYzZHra4mQBwE6ZNX6kP0iW8K5nvj/UaNlTXVyWawToRc/T+fJfcScOWsDzG6j
	 H7bh8Rmm+XhRKktodZ1hJABkiumxvClZP3F6CGhZzdI4rGuquiru9Kf8nbBHNECPbtr6z
	 17WzT/Ap26AR1UiBXaD4oE0igEOb1JoeU47WgYjsRE/vUb4AJ1RXwIRzbjmiMJxdrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684558;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7jSrQRRcBQPkSXCULGpxKEJk5ZBmaZCQEDccZmwwGdY=;
	b=E71nNTaHwaa+D7nnPzWJqFeCSDo58we+12kMH3Ck/KJX4T0XWlF5N1Vq/AItEQmt2Oov
	 sywGvPBluTFs5zUsORCi1ApwGKOalKT6Vc2DX7u6ekMZbmBirWrKBM8B+zYsCKuUv7X96
	 HXo4eUsd7tmi6zDidiAmVy+Lhp0pFAGOrffN+xwN+5Rs3xQHp9LLFYTucP0khABBBwx1/
	 zf7wJ5E5bGVAGeWWs1+jD4P2NwhiSnORWfK9yCz5WeGktq10MKUEA3JTslh6QzOCe6E84
	 KX2XhiXp+ZfRvEPZKzH7z2dnKmUrJDQwwQzXfmnmu1z2OmXLHhq3W8Xe0Wj/ZwHMlmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F56606A32C;
	Thu, 26 Nov 2026 09:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F56606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 76E1BC02DA;
	Thu, 26 Nov 2026 10:15:56 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Chandru Gopi <chandru.gopi.dev@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in the caller's netns
Date: Thu, 26 Nov 2026 10:15:50 +0100
Message-ID: <179568454485.1932185.9237357328729820521.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261020065125.896530-1-maoyixie.tju@gmail.com>
References: <20261020065125.896530-1-maoyixie.tju@gmail.com>
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

Hello Maoyi Xie.

On Tue, 20 Oct 2026 14:51:25 +0800, Maoyi Xie wrote:
> nl802154_dump_wpan_phy_parse() looks up NL802154_ATTR_IFINDEX in
> init_net, while the dump only returns phys in the caller's netns. For a
> caller outside init_net, the result depends on what the ifindex is in
> init_net. If no device there has it, the dump returns -ENODEV, even
> when the ifindex is one of the caller's own 802.15.4 interfaces. If an
> 802.15.4 interface there has it, the dump is empty. If any other device
> there has it, the filter is ignored and the dump returns every phy in
> the caller's netns.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: look up the wpan_phy dump ifindex in the caller's netns
      https://git.kernel.org/wpan/wpan/c/680451326592

regards,
Stefan Schmidt
