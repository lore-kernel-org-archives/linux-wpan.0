Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D787233D8C
	for <linux-wpan@vger.kernel.org>; Mon,  3 Mar 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031602; cv=none; b=G2WkYzYdcOZIjOX6R1pVyWWz96GowXSl1WqRexxZjvFk7llvNxgKiz4gDTOFGVJnwNggAac1GE7R2UxzpicpK0qWeztTu3flNxlo1FgNlE+XwnR0foL8YS+rR5H2qKl+4a3+r0nzo2m16sClIobi+lGclj+7zVujRZMqBM73u9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031602; c=relaxed/simple;
	bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxMB3GDflFJOliu/MHCH1HnnQ5Un2v5v5WvunR3NoJ5IoxxM/eHSdfMtAbEiSUEYXgkHp/MGLxSWFDUnhNTMh5NWMroIGZ4gEm79ZjmJ6QdhTfmwmy8yzoZqkXTxcq3PpXe+jo8EkGGz0qYjknfYb2HjXuCnr8HZWQdJw3D7RyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Een/v3HG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Een/v3HG"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30baa27b209so19655141fa.0
        for <linux-wpan@vger.kernel.org>; Mon, 03 Mar 2025 11:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741031598; x=1741636398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=Een/v3HGrIUsxKLvpK/7nPtnYTaacphMIjptWX0/VuJMJD3H070xA1XR6kTs0Mo0Qd
         +NOCoa/Jo/5AUSoG0ChZRnnea9heys6gnguP8YjQSxml+Ytto9mkOmHzgxt8tqb8DhG/
         7PdcgP5XH/C3n1+2dUCQXK/6Qtt3VvGfVnEwPsornhgflN7+XsagEBSyDbK9GSVqwKBd
         ND2VFZW12cCMLJJEbLtbjYb6VZQwXVL+riMPhLNhS5Vw6moP6tA4UagIaUTgb8S/G21z
         c4Q1bGIuFkKzstiXIIcrMMPupvCJy7BXLh8FWHajQnfvUTIxSTQBZ+2YUzsB0kyfS0wt
         GH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031598; x=1741636398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=nn53Nrzi3lL5dSYnfsBTqN9RKS/FpPXisZs6cCAS9nL2wm8Jm3Nt45aTXfx22yIwFp
         DQQzT8JkQ5rd+6N04JSWvxtPN51I3J9V/jjz8N6NJ5oRHCfOfDQJS3KG6epksgkSXKVI
         kvuGR04McUzW33h5PuSd3f5TD8DkzentQuWTpLQTtHAHLJ0NRGSFXdnaTH6SsHwvt4lK
         IneNMpvZiWiZVXbA7jQ+lrr/ZU6N9kpAnTumAU4uXEA+YrdgeuawPTOoHA8TEnjmnVpZ
         bPoUawGAgKJYJzte8xKFppS8txhk26O0FzBcGHA1d24W6wsIiGfeg0WZldVkrFkyf9r3
         YMZA==
X-Gm-Message-State: AOJu0YzJl5wCEi1XzN7HWU4gs58wZGKbJuriWa9KKZDBU5YLbtvdi0gW
	YHu2aEx3VNx3+hx+EUKRGwjpPXPPqUyoTS1/9EqaSGDH7Orw5Ed0YdR4+Tm37Lypilr5A/ZE7Y8
	y48oVwJxU3tWMzJotr7m2sIySokkqeAyl043QsA==
X-Gm-Gg: ASbGncvp9fWUkGNb1eA5nXsDPm4E7XTNI9CtXEu8O1/DH4fNRgRJe8rrg/Irk+xJq7A
	hMMXXcNRlLY/oyehO9BDfmUtMG3Gm2l91ZMqGSuBSHko12ZDemMP8SoAGcHBsd6chrvGos/WCSF
	RFNKQdfZjdWSgCadPrYCuD6yHVwA==
X-Google-Smtp-Source: AGHT+IGAA1jTPTvt6x1HBPDHZpPdg7RIJLS5NDUt79SNfZEN5S213uxZfLpsDGTLhFe/KqTn7rcm59WJNzLGOylvX74=
X-Received: by 2002:a05:651c:1a0a:b0:30b:badf:75f0 with SMTP id
 38308e7fff4ca-30bbadf7dc2mr20317411fa.2.1741031598367; Mon, 03 Mar 2025
 11:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 20:53:07 +0100
X-Gm-Features: AQ5f1JrLhAM1wiHutYCTK7Ia19KZ1ZhoXNrkXyL4siFeXMeh8rxos64YMy1PhkM
Message-ID: <CACRpkdbeTG_55VbH3GBVpB31D9uuLHTZpuzjA3PuxwTB+KEq8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] ieee802154: ca8210: Get platform data via dev_get_platdata()
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

> Access to platform data via dev_get_platdata() getter to make code cleane=
r.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
