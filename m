Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34531AC88B;
	Sat,  7 Jun 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749332543; cv=none; b=Qig7cpMZ45KH3+fM+EFuatuwT21WQbgXBQQnzgXl3RT9C4XGjF7fkMQZzfwLN/r2iwceZPQJccCsBGegI9CYM5LgkUMiDPkOnuiQKgebsiRAZkhlfhBhxUC3tZav8cJZAthb1Z9wsbf8mOELURMXDwRwRJ+x0eo0ZG3OS/70orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749332543; c=relaxed/simple;
	bh=pauCeS0EJZD/FTktO7RvGI9OVXfyv3h41pyC2H2w2cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiVcemBAO7aGCWZn1J4YljjX+pbOfrt63J5O6FKQX+wM936lpM/fPWBPgwc32KCz1BiQVxM/z6boOX2xm06D3Enbyy50Z62Jn2yPdQ5m4S/6nSpiyoM4wTujCPFLD1paNdcHbY2Rdo7Lf6zlf2y6hG6ZGD7VBvY6N8iHSaKBLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyRxrc5r; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyRxrc5r"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e592443229so1017459137.1;
        Sat, 07 Jun 2025 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749332540; x=1749937340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUEFTcUbSkQLJ43hZPLV+2GZum/ztVJHLmBcrHIjKsc=;
        b=kyRxrc5rXJcG9CXbxSEEBA2RW5td+IApQKNdus0hXtKUV/pPrlwjyxGz/QXIhU/kuC
         hDJGw5QRkDrrPOUtjt2Ia2rLM1YLrQHN3jP/LkplfphtUTrYD3zYvetpL2dhZwYX6GdN
         WPb7yr7cJ2spXgZfS5NnY/8wxD3sYwwSqgf86ua4mopDkt/5CwlrXuvZ1vBePDf2c0C+
         vn03hePQeHK8U3srgcnq4AwGJkxCAnaKL1YovHIOWtKrFANVkkqGYQeOXjI8y8m1Rnug
         RXO+qGWk9hal67HxDmfbGLkQZEmKERdgKW7w+Lg5Pjnhe7cjuzhPmAYzUpyBXO7E3xIY
         WWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749332540; x=1749937340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUEFTcUbSkQLJ43hZPLV+2GZum/ztVJHLmBcrHIjKsc=;
        b=Aj+dsITrPRdFv5oE0jAXaOTx5E6rPAdannimgb+3ymwJAfVvAVfQT81xiRspbo7GNK
         zAdezwvK38K6yhvxg/EfbNBFrjVKnsf53roUKnqTws9CI0AHy+5dZAgQP584H47a2ZKg
         01OKb/4FKQMUtKhTGGrCvOTEIrxYUQer6Tphk/bHPooHthlsQ8Hc9dSSa/LyC4/e0fGz
         I0FFZLfq+Hsm+4Uq1D4tAgC2hbIf2CLev1WxqYb+mc/M0XE4nWBsURt2zzK7flIV+Lfn
         OoFJr1cZbnjgEAWHvQ0/honm4CIQw1XIIfCVul15Gddw9yCAizr01IIorhBn98JdT0x2
         evYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV81n15bmi7qx6uowgkJRHkcFrq5m5Y2u91E4dUbLRp/Yc3pkdP6loyBiU7sHZ7CJ2x4miiTEja0LTA@vger.kernel.org, AJvYcCX+zZGK4RUl2fq4PS+BMukLsXnGtcsaIDooqqshu2zZ2eD2es1cKwU3k3XoTNTMgnfnq8czGA6h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eZ7lnzJVIcfxMuMmZYTJmieddlv9+ukgiUVNa31ptPR3AeZi
	tztM/DKahk2zvzbsiSwbZPBKieLqC9eOCaU4Bu/kAcQznSBQ2kvmTkx79yCnT5zwcg3XPo4SkbU
	IS5yp8sh9xXGvE4qcInVrcAUs90RCgik=
X-Gm-Gg: ASbGncvhZRJGrxYZFxDm81fUa6uphriJLHZGZfrMDt+GvA9GI5N2pkv21A4i53AtUrz
	/Nna9RAS7RV/i0lBMGLVbDKMKr8tQCPx+/7LsqbsVYdwn++GZqSGDKq91r0rzYTf58a/fqJW/6F
	bt0U0T5IYS1llw0se7cVoeqHxbfU4ttg9vUlgRjcxwwpk=
X-Google-Smtp-Source: AGHT+IGyP2aHnlSuagxZ5yttUXL8obOQtZvYrGkFDANjroqpvNljK8OXHZR7vtLSVLO5eAKOCUojDwR4d2nFrx3UTAg=
X-Received: by 2002:a05:6102:c12:b0:4b1:1eb5:8ee3 with SMTP id
 ada2fe7eead31-4e772ac55fbmr6961789137.22.1749332540514; Sat, 07 Jun 2025
 14:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
 <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
 <CAK8U23YF53F0-zMbq5mk2kY4nkS1L0NH9j-UJrdaS5VUZ5JZdA@mail.gmail.com> <54980160-6e46-4ac4-b87f-41b7dccba1d3@lunn.ch>
In-Reply-To: <54980160-6e46-4ac4-b87f-41b7dccba1d3@lunn.ch>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Sat, 7 Jun 2025 18:42:09 -0300
X-Gm-Features: AX0GCFvsXSWU3mlKCe2to0Ib9H8Tz-A6j5lcYINHQaAgHERqjFxX3aSXi2LiS6A
Message-ID: <CAK8U23aRrvC4wC6WvcBRPA4YuyC1MPvOj8FO=cWfi43_Fdh4Zw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Aring <aahringo@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-wpan@vger.kernel.org, alex.aring@gmail.com, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok! Just a last question:

Shouldn't we define a maximum number of supported radios when using
unsigned? A value like -1 would wrap around and result in thousands of
radios, right?
That said, wouldn't it be simpler and safer to just use int instead?


Em s=C3=A1b., 7 de jun. de 2025 =C3=A0s 16:22, Andrew Lunn <andrew@lunn.ch>=
 escreveu:
>
> On Sat, Jun 07, 2025 at 02:54:57PM -0300, Ramon Fontes wrote:
> > > handle as unsigned then this check would not be necessary?
> >
> > Yeah, it does make sense. However, I have a bit of an embarrassing
> > question. How do I submit an updated patch in this same thread?
>
> You don't. You should submit a new patchset, as a new thread.
>
> The CI tooling works on one patchset per thread, and if you deviate
> from that, the CI won't test it. And if it is not tested, it is pretty
> much an automatic reject.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> It is also the merge windows right now, so anything you post will get
> rejected anyway, so please post as RFC.
>
>         Andrew
