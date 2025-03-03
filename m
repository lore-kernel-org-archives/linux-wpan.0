Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE03BBD8
	for <linux-wpan@vger.kernel.org>; Mon,  3 Mar 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032054; cv=none; b=JRuy7bdZjGLbrglBcz9Xa2JWVVJFv+e07flEucPW2stIt9w+Btw04TQxxPEDAN6cTX2agmyfyMjlcnLu7PofxQaDdXnXVrC8NPCWbw4zJ7NnMp0JXGNzFv88sfroXIb5/SYuS47wDm4Ll6J7jd3RTxWpOZllSW8eYqDP26nE6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032054; c=relaxed/simple;
	bh=XbbJ8meiSGyYH6OwHoQ3kYQ9Z6S5UvDDWGLBxmPvAmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idjooaA/7onc3yKyOffIt+09zSabOByv6zeMGWEHXGZ4G3tcHgeLpDicjXHh0qfesog28hqjuNYq8EzHUBOiEVYiB8pLzkR1vev8mLIPAc81rnXZyXlCT1lO6q0tUIshXokGNfPqP3fBeqf9mysn1G3RuQhRxM+eTOhlsHBp2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgesB6zs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgesB6zs"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54957f0c657so3259924e87.0
        for <linux-wpan@vger.kernel.org>; Mon, 03 Mar 2025 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741032050; x=1741636850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIobnHJoMiJmgICmS6BIagkd52MyMq9ZRNlSypEhZx0=;
        b=wgesB6zsl2c/nwp8YgLBRW5EjpfK/i+/RPYBkc+A+ql8EZ5Ey60K3jXEUFjSGRB6Ly
         E3rbk4Ge7WK+ZPWogj2I1uaZMQyLPMhY5rukyPNsq/k3Cq7skj9fuBSCok2sxNLTpBg/
         gqPN7FvyK6oB74ac/Ve/iyerB69btpnLFgaLE0DwXMC45DlmuazcljMwukgd/Ungqd5O
         gTms5km3lurkHibIQjsEaVIyIN5QCxGJgfEHpzB2NiqJfUElYXoDH0ctpytY8Vm4UYqj
         iWbsZhdhuuW2LSvkuftVKTKtrWL4arKr1eVIt8Jy+ueeCnfPDLv6D4/NzHSMtAbs2ii6
         hPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032050; x=1741636850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIobnHJoMiJmgICmS6BIagkd52MyMq9ZRNlSypEhZx0=;
        b=Vp8aYDPJQL5NPnblBds6V4+Jlfib91iCQKeKlWGk77rg3k2mjvdh4+UYs2lWMDMHdF
         o7l6nj3amhsCIjTlafT0DTcsCy8AKIUEEQan4rmXBOMkmspaWg4KGQ3iF3VeCtktkBSG
         3DzbdfjWsZ33NWT+uVyDSJRN+y0Q9TXav5LVcxD0BTH+jZzwk0JYn96BHgTl1zYBDo84
         fCvTdYnuSTKlo8rTEESd7tVoc087r88SdkBuNnKU21yALuAJ2N6btdNHvj15+7aZ1RtY
         yGYmWvoip6qLG96Hmbcdv/hv7VChpzK/U5c8s+5bkFw9FGcDTvL578vA1HuAXYg0G0Dk
         QCxA==
X-Gm-Message-State: AOJu0Yw8cDdknwmptBZr3hN6uZNd0b7nBEkCA8aGs4w8UkbOdxsmDfaV
	ZQVqQA6WqG9QeXcY5mmsGOC36Q+6W73VR6PaiQJTJKxo/jkGzBgd5aWAMIkslXChVS33JA783vZ
	EHwLMQB/Ulk5FvZ9Z4qGdadnvdN2bIOfm1GE3Ug==
X-Gm-Gg: ASbGncshm3i6A1MqV/0sJOgWm61ssum7c8v2xYnzi5zLQ1iEBt6xsYApDYs7mNVwO6x
	NOplAx3wCzzOAuw/chFvon/lmEYhWcta8WoMSK5FRpmuJFpufaEXvonQ2W2t6Vt78qoDyf2lLLM
	Y6rutEf57GLS+T6FdVvb6wvtkBEw==
X-Google-Smtp-Source: AGHT+IEHC8551GBjOPpUxphatF0L4EWvTZV1kdNfG9x3/0VKhOjGpHpEdRbBRyV3NGrevE8NCqhrlfkAk7EBNemkkKU=
X-Received: by 2002:a05:6512:31c6:b0:549:39d8:51e1 with SMTP id
 2adb3069b0e04-549756e259cmr181874e87.16.1741032050322; Mon, 03 Mar 2025
 12:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 21:00:39 +0100
X-Gm-Features: AQ5f1JqhI495QPwjnNSA_U0-FZLtnDrmj_TbAAs84iyjJp_ZDYFgar6ptgKX_Fk
Message-ID: <CACRpkdbCfhqRGOGrCgP-e3AnK_tmHX+eUpZKjitbfemzAXCcWg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] ieee802154: ca8210: Switch to using gpiod API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

But note:

> @@ -632,10 +630,10 @@ static void ca8210_reset_send(struct spi_device *sp=
i, unsigned int ms)
>         struct ca8210_priv *priv =3D spi_get_drvdata(spi);
>         long status;
>
> -       gpio_set_value(pdata->gpio_reset, 0);
> +       gpiod_set_value(pdata->reset_gpio, 0);
>         reinit_completion(&priv->ca8210_is_awake);
>         msleep(ms);
> -       gpio_set_value(pdata->gpio_reset, 1);
> +       gpiod_set_value(pdata->reset_gpio, 1);

This drives the GPIO low to assert reset, meaning it is something
that should have GPIO_ACTIVE_LOW set in the device tree,
and it might even have, so let's check what we can check:

git grep cascoda,ca8210
Documentation/devicetree/bindings/net/ieee802154/ca8210.txt:    -
compatible:           Should be "cascoda,ca8210"
Documentation/devicetree/bindings/net/ieee802154/ca8210.txt:
 compatible =3D "cascoda,ca8210";
drivers/net/ieee802154/ca8210.c:        {.compatible =3D "cascoda,ca8210", =
},

well ain't that typical, all users are out of tree. The example
in the bindings file is wrong, setting ACTIVE_HIGH. Sigh, let's
assume all those DTS files somewhere are wrong and they
didn't set GPIO_ACTIVE_LOW in them...

Maybe add a comment in the code that this is wrong and the
driver and DTS files should be fixed.

Alternatively patch Documentation/devicetree/bindings/net/ieee802154/ca8210=
.txt
to set GPIO_ACTIVE_LOW and fix the code to invert it both
here and when getting the GPIO, but it could cause problems
for outoftree users.

Either way, this is good progress:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
