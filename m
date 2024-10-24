Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A81DE3A7;
	Thu, 24 Oct 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776405; cv=none; b=KObNf0y6tpwPBMAGlLH1DsHPaP4Om5s+KqCQ8ArXq4S+UYrZHkkKBhnmhxNVGaj7wNSvXEn1dTUvuCsJUYqA8Qhh8L+eryTlobFAGEOTdTqL99yARiekGAXEQISKt21tnGtvm3cQREDs4iofhtDy/LDP4PSa15FGGTEmMxpCrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776405; c=relaxed/simple;
	bh=N02KLalnFfK2sBXLQ/nfUr62rghqvQamE1VIJktqfRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpfawIY2EyrKEqTcJuZOlA+vN+JMvaN4cWm16XkO+wX+szpFsMEdHFfOVkkXc2Qw3D9wPqMiDAXl8galMN1s45I9+7XxtduXFL/qlQk/6YwErgrQ3O9iwqldUQ/ZNO71Oy9LG6lNBINWDdJoe2bvlgaLwOVwiswsoYFwFh0VafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBSmSVKX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBSmSVKX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e52582cf8so663823b3a.2;
        Thu, 24 Oct 2024 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729776403; x=1730381203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjjBzzaMsD7ekSq9QbaIBqsDXujNK7HZAFR9ub3RTXY=;
        b=nBSmSVKXihhxypOohN3Y/idJM+8DqUbR0Z2wkwfc+bMOPoD2mtbJ79pQA+A+0x39VW
         sD5cKPQ/3vqU2mW7AQ/XwfA64PqV1cc7OfxLsUcjUlfg7VIEIlWkmOoPwfCw7pZQATO1
         JQM/iyXfyZNXeVErXP1b4suN3lhmwC40XS5WD5o8QGgeMw7ZpYXY4mQ/mWtc0Cd59bKi
         WvRk0W1aGRw4Yw03OLo6TLEGEy/uHLEzaDlfk9QqPYneW3bJIMBZ3GMO9GSHtACn074a
         m5InubJwDftX52HBcePUbSXlG/lkjQfHN0S9F7Y3xkqJY1RaFrskP2xfMRA9JCiX0EpS
         47BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776403; x=1730381203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjjBzzaMsD7ekSq9QbaIBqsDXujNK7HZAFR9ub3RTXY=;
        b=SxqptElB/QlC8pp6PZ77bxPGT5QGHwsRgDwZxQcnQzlCMgcH0S/5q+cxx3XfTYiE7W
         ukRRh027XJxmOZGj34rqUmgfdBnCYDixyXdtt8bukVZxVibih6v9B/NDt3LyLERYM76+
         kV2hf8WFG8eVoq5AnXoOVq+TWs06kNecR6x3ZnhjhYZ5qJUku+5eRS3FnVeIrHQIPUjQ
         iHoO0X5zwr+tpmn1CkeodEVOD+WupreYP2zy5hcpIxJuiW+NyXczIfUO11+39KWnSlNA
         sLVBTsRszOEswbJO2KadhC/3lNeJ+HJd54O7jMareEKSO/Lp6jwnXir6NPjnjKxbj3hk
         idGw==
X-Forwarded-Encrypted: i=1; AJvYcCVl0twZWULdRA5V1W+o/EX5PPLXYqQeMH6cC7NEEtOhIsJEAmEHneEqV0gZbXpFUxegz0+m5g60@vger.kernel.org, AJvYcCWKuMbSmMvere4oxQ5qEyLdvNr1Tn/j9QJthYJ0FgNgFXMqyhkwjeA9IfoouKUL4tGrk721ffVH9uc=@vger.kernel.org, AJvYcCX06OjLxQka0lcVTSMR1BvxHqmqvEPtbMJVrA+O8krVM0r6rFSS/m754uN9F5y0vZ+JSKvvAtzOMjbnS4tH@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDGi7tqeAmatNAh6w81izQv09BTEhEXjKBGkLUzlxZ7BWIunI
	+sAhkC3cqn1RPxFe4Oj+xjAozNt6Ae9m7bP0ChnVWHVnzGTvzRit
X-Google-Smtp-Source: AGHT+IGMpqU4C7guMpwzMgTNyv0OP9IkXjIzxG+eKhzbsqqfYfm1VefGOOKSHC3CW5cb28iw9Kjucw==
X-Received: by 2002:a05:6a00:1892:b0:71d:f423:e6cc with SMTP id d2e1a72fcca58-72030b9b77emr8940005b3a.8.1729776402953;
        Thu, 24 Oct 2024 06:26:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb8423sm8622500a12.71.2024.10.24.06.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:26:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AA3ED4416BFE; Thu, 24 Oct 2024 20:26:39 +0700 (WIB)
Date: Thu, 24 Oct 2024 20:26:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Leo Stone <leocstone@gmail.com>, alex.aring@gmail.com,
	stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewmail@gmail.com
Subject: Re: [PATCH net] Documentation: ieee802154: fix grammar
Message-ID: <ZxpLD3_oXlO1Ucb7@archie.me>
References: <20241023041203.35313-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64dUHzb4GG9D5Dkz"
Content-Disposition: inline
In-Reply-To: <20241023041203.35313-1-leocstone@gmail.com>


--64dUHzb4GG9D5Dkz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 09:12:01PM -0700, Leo Stone wrote:
> diff --git a/Documentation/networking/ieee802154.rst b/Documentation/netw=
orking/ieee802154.rst
> index c652d383fe10..743c0a80e309 100644
> --- a/Documentation/networking/ieee802154.rst
> +++ b/Documentation/networking/ieee802154.rst
> @@ -72,7 +72,8 @@ exports a management (e.g. MLME) and data API.
>  possibly with some kinds of acceleration like automatic CRC computation =
and
>  comparison, automagic ACK handling, address matching, etc.
> =20
> -Those types of devices require different approach to be hooked into Linu=
x kernel.
> +Each type of device requires a different approach to be hooked into the =
Linux
> +kernel.
> =20
>  HardMAC
>  -------
> @@ -81,10 +82,10 @@ See the header include/net/ieee802154_netdev.h. You h=
ave to implement Linux
>  net_device, with .type =3D ARPHRD_IEEE802154. Data is exchanged with soc=
ket family
>  code via plain sk_buffs. On skb reception skb->cb must contain additional
>  info as described in the struct ieee802154_mac_cb. During packet transmi=
ssion
> -the skb->cb is used to provide additional data to device's header_ops->c=
reate
> -function. Be aware that this data can be overridden later (when socket c=
ode
> -submits skb to qdisc), so if you need something from that cb later, you =
should
> -store info in the skb->data on your own.
> +the skb->cb is used to provide additional data to the device's
> +header_ops->create function. Be aware that this data can be overridden l=
ater
> +(when socket code submits skb to qdisc), so if you need something from t=
hat cb
> +later, you should store info in the skb->data on your own.
> =20
>  To hook the MLME interface you have to populate the ml_priv field of your
>  net_device with a pointer to struct ieee802154_mlme_ops instance. The fi=
elds
> @@ -94,8 +95,9 @@ All other fields are required.
>  SoftMAC
>  -------
> =20
> -The MAC is the middle layer in the IEEE 802.15.4 Linux stack. This momen=
t it
> -provides interface for drivers registration and management of slave inte=
rfaces.
> +The MAC is the middle layer in the IEEE 802.15.4 Linux stack. At the mom=
ent, it
> +provides an interface for driver registration and management of slave
> +interfaces.
> =20
>  NOTE: Currently the only monitor device type is supported - it's IEEE 80=
2.15.4
>  stack interface for network sniffers (e.g. WireShark).

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--64dUHzb4GG9D5Dkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxpLDwAKCRD2uYlJVVFO
o1vFAQDnS0KV+5nUy5e7/Rdht7dETYJjXfDQpb6+ahzJab1nigEA0BOTsZo43ARS
SwdGkpmbt0o19oU+WpNnk+e5iDgIkww=
=/eWu
-----END PGP SIGNATURE-----

--64dUHzb4GG9D5Dkz--
