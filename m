Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497409;
	b=1n7M+AfE/n4uKR0v+HrkJKqvySO/kCkK4PFK/oomPfMqediytzvlYwRBJ76nhJOnrMYK
	 8MpVDvD7RIaFwZj7vTwiIE8GI+iA2CVarLk3fizBILVMmBhYemkMX5FtsqTcCbiR+CHmK
	 H7aOvYdvbYCrVFBfCkV/2zuFwFUarSue/0Rfz8rHmQ4+gzhGdal3UkcJgL0QudOhWZusQ
	 Mvo4UAWkRNyuyIVxZSy1BoSZoOhPzw2or+SmMZFtFgNQlqWwsK0nI9HfwZKnZ08SaL3YT
	 kyJDw8SzidRAZ2/MApDM1CPr0J8ipL9a0Tc3mmQlhLmDFBEA49Y1vV3leeUsARPbtVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497409;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nE61lgnSmGjC8nW6hnP7/bxhS7rbX6LQQlXmuayarqI=;
	b=DEI+CP000uRNGmJzkLgR+4C5BqUPAnsWzus4E0Up37u3MzTo7Nm3hx+j2r8MlonHBs8r
	 1eEuWFSC3acxzwUCHl9oD8H06VkfA5FsDydDAalSTV2H5HMkr1giV9gk9g2lGyNnBkjc7
	 aBAI8VUi8EqD658Qc/Mx7xaFmSQ2xYIcXtLbwoZvhRmcsm2mBx+KkF+L5sTUtwQASClN5
	 qT++SPStcyoyhGb7tkZMChPRzFnXCxAgkIa8pOM3R5qkaWBNugayCCGIHI6DEBtGaC+zd
	 2FnNx/+uIydfU4afWwj5WzKOZ17P3iyCeXVu6enDXQyfxiPUkNnQAt+lUANx4c/Upww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=keFuLFhI;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28275606A894
	for <linux-wpan@vger.kernel.org>; Thu, 12 Nov 2026 15:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28275606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=keFuLFhI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794497406; x=1794756606;
	bh=nE61lgnSmGjC8nW6hnP7/bxhS7rbX6LQQlXmuayarqI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=keFuLFhI1VNM6taMS8i2Zndz+isGvtOkE33PmBwMGwMP9PsTjChG7cshgZu7PvsSe
	 8XVyV1tRjr+TmsFiuwf562ZZmNO4fOOy2SusUnV2Fn+mlmjdf2RGJSI95v+6bWhAnH
	 1ccnSs/Pqusb+vAjRUc7aINTNt8DukozpTsQ0/wvJIwhu85x2lDrQlhC2WdEYrOa+N
	 Z0NCC5rwrmLeY+s1ziWtK+Tb6OT5kMnT5vXPvJQIjxkq/ccK5elD6MWjSMHropehWs
	 jjwyx1iwjknkSsokY0Sl5sIZ4e96fu/hEa/2T+Cri2UHRtM7uJT1KKsTSC37nEp5OC
	 1QjCkWjLcapgw==
Date: Thu, 12 Nov 2026 15:29:59 +0000
To: netdev-bot+sashiko@kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Ryan Prinz <rc4d5a@protonmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH net RESEND] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261112152819.1014850-1-rc4d5a@protonmail.com>
In-Reply-To: <179447431152.2199510.14609873818368730049@kernel.org>
References: <20261109090226.799973-1-rc4d5a@protonmail.com> <179447431152.2199510.14609873818368730049@kernel.org>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: c8098364fd82731015df70d6e1f0daba905de77a
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review! These are fair points, I'll respin.

- The accepted offset range has a closed upper bound (offset + length
  =3D=3D d_size is allowed, as needed for the final fragment, including a
  zero-length one at offset =3D=3D d_size), not the open [0, d_size) I
  described.
- 802.15.4 has no source authentication without llsec, so this bug
  doesn't let an attacker impersonate another sender as the message
  implied. The real effect is an attacker's fragment getting spliced
  into the reassembled datagram in place of a legitimate sender's
  bytes for a given span, via the overlap-eviction path you described.
- The CVE-2019-8359/Contiki-NG comparison doesn't match. That was an
  out-of-bounds write into a fixed buffer. This is a reassembly
  data-integrity issue only, since inet_frag_reasm_finish() links skbs
  by pointer rather than copying into a computed offset. Dropping that
  comparison.

Sending v2 with the commit message corrected; the fix itself is
unchanged.

pw-bot: cr

