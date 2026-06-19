Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641A284662;
	Fri, 19 Jun 2026 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903227; cv=none; b=dZReluwmlztoRB0sIo7hW5AqkEeNmjncUbfSalzNnUEkbMCrJcrxIKIBgFPCNDlDE4Nl3mBQrDDVJLkPDokeLYJs48IEo5a935iN04mada3yTi0EEjrve6DtfDbH/6x21UZMzZUNz8swYtoLDAfuTWAdrD5pOq+6EIw5XZA7NJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903227; c=relaxed/simple;
	bh=1k9ELk7quM4xvcJHrV2Aql3FZKjVK8jJruhrqRz0YhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubIKBT1XTn4lPJdJVfEdYsmbYo4/WLDqyba/FvbuGPF1zL42ggJVSTBoEWSc4aDG8pjxGIbj913HFHra4R3BZDULLhowBWJgqQf2KiITxAu1DGjkTdFAiRB6uuTAzHD/oQVIEohDdAsQY2quHJNfljW+Uvy/M6OouYJbkvzIYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 795B6C0A83;
	Fri, 19 Jun 2026 23:07:03 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] ieee802154: admin-gate legacy LLSEC dumps + un-deaden ADD/DEL
Date: Fri, 19 Jun 2026 23:06:57 +0200
Message-ID: <178190320623.837980.8473930233831307343.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520141640.1149513-1-michael.bommarito@gmail.com>
References: <20260520141640.1149513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Michael Bommarito.

On Wed, 20 May 2026 10:16:38 -0400, Michael Bommarito wrote:
> The legacy IEEE802154_NL family (net/ieee802154/netlink.c) builds its
> ops table from two macros in net/ieee802154/ieee802154.h. IEEE802154_OP()
> sets .flags = GENL_ADMIN_PERM; IEEE802154_DUMP() sets no flags. Among
> the IEEE802154_DUMP() consumers are four LLSEC dump ops (LIST_KEY,
> LIST_DEV, LIST_DEVKEY, LIST_SECLEVEL), and the LLSEC_LIST_KEY dump
> handler at net/ieee802154/nl-mac.c emits the raw 16-byte AES-128
> keytable bytes (IEEE802154_ATTR_LLSEC_KEY_BYTES, .len = 16, copied
> verbatim from struct ieee802154_llsec_key.key) into the reply skb.
> The modern nl802154 family admin-gates the equivalent reads
> (NL802154_CMD_GET_SEC_KEY at net/ieee802154/nl802154.c:2978 with
> .flags = GENL_ADMIN_PERM) so the legacy interface is the open side.
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/2] ieee802154: admin-gate legacy LLSEC dump operations
      https://git.kernel.org/wpan/wpan-next/c/9c1e0b6d4947
[2/2] ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      https://git.kernel.org/wpan/wpan-next/c/a6bfdfcc6711

regards,
Stefan Schmidt
