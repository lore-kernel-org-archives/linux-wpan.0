Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC961CAA9;
	Fri, 22 Dec 2023 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wef2cm+4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 975E01BF205;
	Fri, 22 Dec 2023 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703254820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8v0ZRZbQR1r7C7SaU9ezT/AC4DOGwUcA3CO/VkDYWVc=;
	b=Wef2cm+4Qgh4wa2dGNodZP9NL3G73tslcW2awxOTiAgSwiVl371UCcQbWqPMoQrbajzy8I
	fzfqtG88X8YwHSpR2WJVis+ryKVVxRKFLccLehp0/SRP7UeC1AWgh7nBjpbmlt3C+U5Mvd
	Uqzxb3RAZbvHDARdRtKMfKc7xYq2xRcZq4rGDPv/I54sigCbxPMMG51l+SN1vsIqUmTJxs
	WdcP+OqT6UN6L4F/yu2AGnOjWt5XiHNnYGYd5BnouA/ItqT+l8I6YKZOpA06GYPRouaOLc
	H6kQrD6p0tub5n2HAdtz4AHzUP76RxFE5NGC9Isz121reZ2E7lMB+HuSfMiNEA==
Date: Fri, 22 Dec 2023 15:20:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net-next 2023-12-20
Message-ID: <20231222152017.729ee12b@xps-13>
In-Reply-To: <20231220095556.4d9cef91@xps-13>
References: <20231220095556.4d9cef91@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello net maintainers,

miquel.raynal@bootlin.com wrote on Wed, 20 Dec 2023 09:55:56 +0100:

> Hello Dave, Jakub, Paolo, Eric.
>=20
> This is the ieee802154 pull-request for your *net-next* tree.

I'm sorry for doing this but I saw the e-mail saying net-next would
close tomorrow, I'd like to ensure you received this PR, as you
are usually quite fast at merging them and the deadline approaches.

It appears on patchwork, but the "netdev apply" worker failed, I've no
idea why, rebasing on net-next does not show any issue.

https://patchwork.kernel.org/project/netdevbpf/patch/20231220095556.4d9cef9=
1@xps-13/

Let me know if there is anything wrong.

Thanks,
Miqu=C3=A8l
