Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAD43E074;
	Sun, 20 Sep 2026 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908903; cv=none; b=TpEVL9EUlosfsAKQ1+/6BIoO0x31k0xKzECmDR5DK21+muY8TSpwQYmZVpFJaZpnXZmwDMB3qaOiRZHLvIrKW4alQ4qKE3O4iQbIFFHBrUpzNScDD02z9tJIx2LGXayMqZd4srKdqOhRBSvdEvQ6NH9YxmifgkvMGTLxMsg36ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908903; c=relaxed/simple;
	bh=o/cKM876TX9eiQRBeaAvXxN4Mv+kMLn7zpTqzr5nFMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kv1aUNlTXsFtsgBKrvnYbKFAW6s3EJUWzp9Ad6pC9G7qncbJMMML3O2pcndoORp/QMHtHADqku1I0xGq3WDbXxDThf3pcu9vCzD1SO9WvayMbQkthFKvhKgnpTMNEmOskyUFt4i6ZOCd9sfli12fw6vgBj+mqIKvGfKGxKvAcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rdt2s3Q0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rdt2s3Q0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 19C611A0997;
	Sun, 20 Sep 2026 12:54:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D44FF604C9;
	Sun, 20 Sep 2026 12:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A40B1032829C;
	Sun, 20 Sep 2026 14:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789908875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qYf5sfpsF5+ikP3rz8etRrzQyPAwoJCwt6EL+6o1iu8=;
	b=rdt2s3Q0OH1e32XrUcArMpHns6GKnGqYJNDmJvABuzVvT5IgWZdLlcaZqolvsrBS2EYuud
	mHd/b1O2gISgOl5GV0E97xY/yc2XDlKI08ReUzgiivLP7uN097I9c793dYEtaGqMM6kEXH
	u7xJg4q1iJfRt6Nou0fPPfDGDEGLkfetMcBJMr9jkyVaJt0DKNH04SJz9tVgncUjijutnc
	XfpZnO3MNlSSlM5PcNaD1jVdAXoEVN1jnsq7FHJ3Mtc20hDDZu3icsIqPp4FiDKSwMIGyQ
	VCeOqWZX4s8lZwocN4Wsx7stN4IzP2me7hzzHboBN51lP69ra0p+uVp1gEy9Mw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: cc2520, mcr20a: reject invalid RX frame
 lengths from SPI FIFO
In-Reply-To: <20260919223437.3883127-1-benquike@gmail.com> (Hui Peng's message
	of "Sat, 19 Sep 2026 22:34:37 +0000")
References: <20260919223437.3883127-1-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 14:54:31 +0200
Message-ID: <877bkgaxrs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 19/09/2026 at 22:34:37 GMT, Hui Peng <benquike@gmail.com> wrote:

> In drivers/net/ieee802154/cc2520.c and drivers/net/ieee802154/mcr20a.c,
> validate the RX frame length byte read from the radio FIFO before
> subtracting the 2-byte FCS or allocating/trimming the skb so len < 2
> cannot underflow.
>
> Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio=
")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2=
520.c
> index abfcfe07246a..d2c8484d8fea 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -482,8 +482,14 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *=
skb)
>  	 * values on RX. This means we need to manually add the CRC on TX.
>  	 */
>  	if (priv->promiscuous) {
> -		u16 crc =3D crc_ccitt(0, skb->data, skb->len);
> +		u16 crc;
>=20=20
> +		if (skb_tailroom(skb) < 2 &&
> +		    pskb_expand_head(skb, 0, 2, GFP_KERNEL)) {
> +			rc =3D -ENOMEM;
> +			goto err_tx;
> +		}
> +		crc =3D crc_ccitt(0, skb->data, skb->len);
>  		put_unaligned_le16(crc, skb_put(skb, 2));
>  		pkt_len =3D skb->len;
>  	} else {
> @@ -1147,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
>  	return 0;
>=20=20
>  err_hw_init:
> -	mutex_destroy(&priv->buffer_mutex);
>  	flush_work(&priv->fifop_irqwork);
> +	mutex_destroy(&priv->buffer_mutex);

What about this?

Thanks,
Miqu=C3=A8l
