Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D43290DB;
	Fri, 19 Jun 2026 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902444; cv=none; b=iDZhcPDoJT9qROCE4Acceyfjze/rGWRTE06I0cCQqP6FAaIMC7btMOgJ3IIo7sa7SjWXZnzbZmIfIXm593qmCp/A9DPSPHfP0srz876lGt676AacZ3ydcReqK6ppUkxmj55Nq96ZAbTxIy5uKbZLgQPZHu5tNRz4D0gI44J3OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902444; c=relaxed/simple;
	bh=wsKYov9ueDn1RiY/wif6+y1wha8dgovGnU5G9dpRfQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm+SIZ/k+ukw9GRFsaI8i9qIsfoU3DcADI9f3TInIfJ5Bnpteh+tpaMCVeJMebHgA7daa+9rgxVwOijK3ASafOrr5BbcS/nrVw3LNkz/4PBtkXCuk2W/pUBrw1eVCdCosG9HolodgKvvDvHNJjsChOFoWSdvW1lmQHvQI5Y32v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 04A05C0A83;
	Fri, 19 Jun 2026 22:54:00 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: syzkaller-bugs@googlegroups.com,
	Alexander Aring <alex.aring@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wpan@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot <syzbot@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev
Subject: Re: [PATCH] ieee802154: fix kernel-infoleak in dgram_recvmsg()
Date: Fri, 19 Jun 2026 22:53:55 +0200
Message-ID: <178190240273.821068.5734846071151495833.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
References: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello syzbot.

On Wed, 27 May 2026 20:18:18 +0000, syzbot wrote:
> KMSAN reported a kernel-infoleak in move_addr_to_user():
> 
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
> include/linux/instrumented.h:131 [inline]
> BUG: KMSAN: kernel-infoleak in _inline_copy_to_user
> include/linux/uaccess.h:205 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xcc/0x120
> lib/usercopy.c:26
>  instrument_copy_to_user include/linux/instrumented.h:131 [inline]
>  _inline_copy_to_user include/linux/uaccess.h:205 [inline]
>  _copy_to_user+0xcc/0x120 lib/usercopy.c:26
>  copy_to_user include/linux/uaccess.h:236 [inline]
>  move_addr_to_user+0x2e7/0x440 net/socket.c:302
>  ____sys_recvmsg+0x232/0x610 net/socket.c:2925
>  ...
>  Uninit was stored to memory at:
>  ieee802154_addr_to_sa include/net/ieee802154_netdev.h:369 [inline]
>  dgram_recvmsg+0xa09/0xbe0 net/ieee802154/socket.c:739
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: fix kernel-infoleak in dgram_recvmsg()
      https://git.kernel.org/wpan/wpan-next/c/4db86f8ab11b

regards,
Stefan Schmidt
