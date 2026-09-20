Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863234040B;
	Sun, 20 Sep 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909225; cv=none; b=eR7OYBKJzFFoMpeja0+1+ze8TptaxTKoO1QFHumbPJIp2EE5w/4TluHyPVHe+HEGjhy/glmlp75yO4o8yKtoGQP+9zqFDRWxgw7jtp+BQeZ1Q/obeUW0kAgEWVbMZikzBV7RbyKaDY8ec5AISjtozU1L1lkjJi6+SsoAGjmM6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909225; c=relaxed/simple;
	bh=lasNI0XF6JQD/sxcfxiUiaLUADu8T8rlWTae9vYrcGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pR4VJkGkacZvA/2o6cIspgYHWwI64pBljlFlQbl7LwZV/cCDI6FBwWpzC+k2j2/0Wcp3OMpl3GdELPl431+Zm/fGxoZw/5l11zLXWsGKxPJiQRLbr1+C8l3ZlnHP8YLXX3iqZ7+9nHlZhu1lbD0x2WN0fWjAWZRMt6twIhrSFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PK+DIE8T; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PK+DIE8T"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E33B81A0997;
	Sun, 20 Sep 2026 13:00:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA750604C9;
	Sun, 20 Sep 2026 13:00:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C281A1032829C;
	Sun, 20 Sep 2026 15:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789909205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9TKSJfQc5b6cSU+h80ax1oyCCZdgJqDQrglH9SNhSOE=;
	b=PK+DIE8TDuao7ZdekR6HnYYzlR+lGtEsb3LlztY4jCesWUcCEBsWDtqkVpTAQMBoOZVcWY
	tGannpgCgMuLeCJFibWR/VmUQtbwiso36aFKj7miWTkv/TY53wES6J048K4+J4vgkKCQMz
	LVr4Ek57U7vUVpz3y3LKHRkaBoxH6uY54a4CadteofVsX1aLNnFtx1Pt5RdBVuHqtyYovL
	cVlSv+8miZZo0EIAeM4N1lfw5yeT5ZFNyXibrsIQLvyH8KoO7hVGcgeqoNdV2n0ELLagv4
	N9X7KeMK9FumLVVOtyAZCkvchQaHk7de4GhtpVHdBeo9f5AwB7olAvz+iPbCPg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui Peng <benquike@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: fix SPI RX length validation and
 FIFO out-of-bounds read
In-Reply-To: <20260919223435.3883048-1-benquike@gmail.com> (Hui Peng's message
	of "Sat, 19 Sep 2026 22:34:35 +0000")
References: <20260919223435.3883048-1-benquike@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 20 Sep 2026 15:00:01 +0200
Message-ID: <871paoaxim.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

Hi Hui,

>  	u8                    *data_ind
>  )
>  {
> -	struct ieee802154_hdr hdr;
> +	struct ieee802154_hdr hdr = { };
>  	int msdulen;
>  	int hlen;
> -	u8 mpdulinkquality = data_ind[23];
> +	u8 mpdulinkquality;
>  	struct sk_buff *skb;
>  	struct ca8210_priv *priv = hw->priv;
>  
> +	if (len < 30)
> +		return -EINVAL;
> +	mpdulinkquality = data_ind[23];
> +
>  	/* Allocate mtu size buffer for every rx packet */
>  	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
>  	if (!skb)
> @@ -1770,7 +1778,7 @@ static int ca8210_skb_rx(
>  	skb_reserve(skb, sizeof(hdr));
>  
>  	msdulen = data_ind[22]; /* msdu_length */
> -	if (msdulen > IEEE802154_MTU) {
> +	if (msdulen > IEEE802154_MTU || len < 30 + msdulen) {
>  		dev_err(
>  			&priv->spi->dev,
>  			"received erroneously large msdu length!\n"
> @@ -1787,6 +1795,10 @@ static int ca8210_skb_rx(
>  	hdr.sec.level = data_ind[29 + msdulen];
>  	dev_dbg(&priv->spi->dev, "security level: %#03x\n", hdr.sec.level);
>  	if (hdr.sec.level > 0) {
> +		if (len < 40 + msdulen) {

Can we have only one place where we make all the checks?

> +			kfree_skb(skb);
> +			return -EINVAL;
> +		}
>  		hdr.sec.key_id_mode = data_ind[30 + msdulen];
>  		memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
>  		hdr.sec.key_id = data_ind[39 + msdulen];
> @@ -1801,6 +1813,7 @@ static int ca8210_skb_rx(
>  	hdr.dest.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[12]));
>  	dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
>  	memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
> +	hdr.seq = data_ind[24];

Where does this come from?

>  	/* Fill in FC implicitly */
>  	hdr.fc.type = 1; /* Data frame */
> @@ -2028,11 +2041,14 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
>  	u8 lenvar;
> +	u8 buf[sizeof(((struct hwme_get_confirm_pset *)0)->hw_attribute_value)] = { 0 };

I'm not a fan of this. It is totally unreadable.

> +	u8 status;
>  	struct ca8210_priv *priv = hw->priv;
>  
> -	return link_to_linux_err(
> -		hwme_get_request_sync(HWME_EDVALUE, &lenvar, level, priv->spi)
> -	);
> +	status = hwme_get_request_sync(HWME_EDVALUE, &lenvar, buf, priv->spi);
> +	if (status == IEEE802154_SUCCESS)
> +		*level = buf[0];
> +	return link_to_linux_err(status);
>  }
>  
>  /**
