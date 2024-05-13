Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCD7D3E3
	for <linux-wpan@vger.kernel.org>; Mon, 13 May 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630881; cv=none; b=L3rxoIk1dKHryrIIgsevFnhQfxK/J6xiqpNJL3RYeasSGKzCtgOLQQqC4otOPlh/kD6gzBsRBmxWlPrS7SFl+7DJgNfsa/r+BHxMtE+QyUEnXIfzn/59SWTFFwnnygWB1QutTA5sRSie3bmyqX/NcRQQ7LyBvkA3TJEnS5lsmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630881; c=relaxed/simple;
	bh=Itr+rgZVfaEJUn0PHXqy3W21wNH4hkgjJSk1efPBA/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjfrnMsQ8Lk55jx4YwxNFB7yXZdmDi/K3Bb+IEDz6CvPzDMDtLatgQSW/Zf1+Sw/irUQ26yFvHk13VP09RTKn8B3lXF6vpWKm3qEqKeTnmbJTi4FHVQdQCXnFmnMUFgD8HGWa6pVVd6U50OtF+tdy6Vh8/SH6OZEXuYoQIPT+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XryMFq5y; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XryMFq5y"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f63961bed8so1474824241.1
        for <linux-wpan@vger.kernel.org>; Mon, 13 May 2024 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715630878; x=1716235678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ6UXUwM03petvH7pYVJ7yCbJNi7YihCgxWB1WDdoC8=;
        b=XryMFq5y9xJAk8E5YvG+CJg6Tv+MwcPgRE047RReF6+n8vgM2K9fZ9nDgf+NMFbcjt
         Fu4v0mMXhDr89KMh7xayIuUi1d0IR9l8Y45ZypFdX6j36kXIwrYtLgalBN9FdlNDL4vR
         Doo5/WDzGq4ci9l9tlQWNrlEd5vzzBiZbCIBm4QUUFgWYQJBuTYLrYqBLtKvRpWaOu+U
         d1uVHDXmW9x2ewa0dfui8gXSn0e7lnaHezCn4F8TJFy+UksAvmKVGQk/2AFncFQDDjPH
         qh8NvUD2eCuz1YyptFQ91ZCD5z7IHJuNl1LD0ly18wU1urGiib9AcsoutzdEYpWiwjzH
         C+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630878; x=1716235678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ6UXUwM03petvH7pYVJ7yCbJNi7YihCgxWB1WDdoC8=;
        b=mFWx0+OUbPvTpLDGGFHn3ZiDcIOPA4oIss+amyA0LFLKC6ejYfDdxiEiPDSd84Fh1H
         TLHueAuqRxwzQT5mdCvhfsP7EtxlX34DJ12hXqECUSww3BhQKVnuHFBenGopCt2O3YMz
         MnP+p1mA32WK2yYCBQljj4m/NQOC5SP12PCZVk/ZqxrWWgZ/6BEGIjeCrOjjx/vRzqT0
         e2/B80tII7j1wLvLotgfWqbf99s0uE+yNo00v4upOhC5kmmQAbhHk9vu3niFY4jhlMf/
         j8mOx+oulFqAFa+0Fr/Cc9Or+aEEIKiB8cr25LBhOREAZ2xtT/xm5Qc39/Q9lWS/XfXU
         8P7w==
X-Forwarded-Encrypted: i=1; AJvYcCWCv3V4nzbXcsr62AJETwzgvCPjV6ajpP298yx8f0A8xax+zq30HsOiVE4dL6dC0oD/EaG81bGrKyYsYY9gTafokO36Uh3aL5CkKQ==
X-Gm-Message-State: AOJu0YweV1leNZtoxWtNIAkp0mRHN546m2pBP4tFv04xX/wdFUVFEFLw
	PYvON55LddA9yCRv06doMwfDJEoN3Bar5GM0Urz29Hbf1c/8Kx5PtL4LqFY5tSjG8V9cLXRp3ah
	DwlhhwQ0pDj5qMCDF7/jASSdp69Q=
X-Google-Smtp-Source: AGHT+IHBkCyrL6DFMxa9zWZlShE5wpZRsa+p6tls8NOcZjlg+aKf+TLpsYcK8xTGSeKRE20nIuFXwPNnQNVwSvDWtsE=
X-Received: by 2002:a05:6122:da3:b0:4da:9aa1:dd5e with SMTP id
 71dfb90a1353d-4df8833c22bmr8778544e0c.10.1715630878127; Mon, 13 May 2024
 13:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508114010.219527-1-dmantipov@yandex.ru> <20240513090902.2d61ca02@xps-13>
In-Reply-To: <20240513090902.2d61ca02@xps-13>
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 13 May 2024 16:07:46 -0400
Message-ID: <CAB_54W7KaG0OQkq7Kc-KG4Av6p9SEA-jhN4d_b6Z8_=ob6o7aA@mail.gmail.com>
Subject: Re: [PATCH] mac802154: fix time calculation in ieee802154_configure_durations()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, linux-wpan@vger.kernel.org, 
	lvc-project@linuxtesting.org, Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 13, 2024 at 3:09=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Dmitry,
>
> + Stefan
>
> dmantipov@yandex.ru wrote on Wed,  8 May 2024 14:40:10 +0300:
>
> > Since 'symbol_duration' of 'struct wpan_phy' is in nanoseconds but
> > 'lifs_period' and 'sifs_period' are both in microseconds, fix time
> > calculation in 'ieee802154_configure_durations()' and use convenient
> > 'NSEC_PER_USEC' in 'ieee802154_setup_wpan_phy_pib()' as well.
> > Compile tested only.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
>
> Requires Fixes and Cc: stable I guess.
>
> Otherwise LGTM,
>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> This is also a candidate for wpan, so [PATCH wpan]. Stefan, Alex, who's
> handling wpan this release?
>

thought Stefan handles still wpan, -next we rotate?

- Alex
