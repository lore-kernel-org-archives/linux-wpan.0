Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24343B6DA;
	Sun, 20 Sep 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909951; cv=none; b=FZwc5TmJHpvcyBMEPyj5Yu4+NJsVHo0GDi31Gnr56xrSWyL3l6Jlh+zAgLcrwnvGeUoV1RmfgQY3dZNuGoqzcX1TfAIYoYzdrfYU8mKmOM7LbQGu+C5BfKFm9mtP05nQhMeYk1dPtVVPTUG5dsZyUDUa86CswkOUIAVjz3wLksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909951; c=relaxed/simple;
	bh=J1jw2xj97EU2/YfhaeKfvRgI0vfJwWsViCQrEwWIzSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdiHIGdOu68Ai4hR/RINd9NhrXirjfrEBn2G2nUZkGMDYDNu4L9qerYrAhhqwDDcuiaXEDjwyg8Eg/rsKb/2VVtXG8phCNmkrEzesbzlBx5761aCb4EJ3NEP9TzvrTTVYrEXLDgXpH2nSNYWe9I9rybtRnZdxPnDw/RBP2q8W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x/yxPlXR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x/yxPlXR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 30DCD4E408FB;
	Sun, 20 Sep 2026 13:12:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00542604C9;
	Sun, 20 Sep 2026 13:12:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA3D9103286A4;
	Sun, 20 Sep 2026 15:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789909943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J1jw2xj97EU2/YfhaeKfvRgI0vfJwWsViCQrEwWIzSk=;
	b=x/yxPlXRzTFzJLjWbfXDGWbD6xEbxDtgIOqpcFZmcC0oxJES6lW2jUbN3f2pb9d3rZZm70
	ajPboLS78YXeHNfFqChFg+TRYEPVGPeoiDyS+mVQ22YW4mTEfkfqYfH4dQiW+OJx730ezf
	MmHMPDVpHc59DPB/i4BZDotUA/B7Jh23dRWIgGZ05r0R8DBCKrADq8fNwr3ne3414t2Iif
	LuOA1i96BtbNwqetE39Au65z91HXafejJsab+fUBqD4/2dNIMRQnh8vftcLM6PWAehC1TZ
	+6CVWYmI366rmk6/iLU9gaZ57WLJBNS0Ja8Zx0Zx/oYwLuGWumgil1iuF/8vlw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: socket: fix shared skb BUG_ON and double
 header subtraction in dgram_ioctl()
In-Reply-To: <20260919212855.3241205-1-benquike@gmail.com> (Hui Peng's message
	of "Sat, 19 Sep 2026 21:28:55 +0000")
References: <20260919212855.3241205-1-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:12:19 +0200
Message-ID: <87jyog9ido.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/09/2026 at 21:28:55 GMT, Hui Peng <benquike@gmail.com> wrote:

> In `dgram_ioctl()` (`SIOCINQ`), the queued skb at the head of
> `sk->sk_receive_queue` has already had its MAC header stripped by
> `ieee802154_subif_frame()` prior to `dgram_deliver()`, so `skb->len` is
> already the exact payload length that `dgram_recvmsg()` will return to
> userspace.
>
> However, `dgram_ioctl()` computes `*karg =3D skb->len -
> ieee802154_hdr_length(skb)`. Calling `ieee802154_hdr_length(skb)`
> re-parses the payload bytes as an 802.15.4 MAC header and calls
> `pskb_may_pull(skb, ...)` while holding `sk->sk_receive_queue.lock`.
> When multiple `SOCK_DGRAM` sockets receive a cloned copy of the frame
> (`skb_shared(skb)` is true) and the payload is non-linear,
> `pskb_may_pull()` calls `pskb_expand_head()`, which triggers
> `BUG_ON(skb_shared(skb))`. Even on unshared linear skbs, subtracting
> `ieee802154_hdr_length(skb)` a second time underflows `*karg` to a
> negative value when the payload is shorter than the bogus parsed header
> length.
>
> Set `*karg =3D skb->len` directly in `dgram_ioctl()`.
>
> Fixes: e1d001fa5b47 ("net: ioctl: Use kernel memory on protocol ioctl cal=
lbacks")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Looks legitimate.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
