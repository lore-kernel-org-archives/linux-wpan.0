Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3017A55;
	Sat,  7 Jun 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749318438; cv=none; b=syvktjxJyTfY6KrPziuV6lAOM9pEzstpoheYv7sMWHmHsbvMwulsWkj/uyON69jj17Fdt+AQBN7NqLP5CBlPn9StBjmn4t1FXlxyTMZuU3smfVLuw2dT4lQgTl3trW69FJ0jMo1kj965OqoPMaw6gvUyfjiCrDX+jdoyyger1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749318438; c=relaxed/simple;
	bh=U0HtmixaPnq1Qji+pDj7COkdaT233I8i2sd/13Va1Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSg7HX10ALY3/60XZE/GQv6UkMmjQU0GbOMvMz2y0OF5xxrALT2gGZLqGvQ5NNylMv5GJ1bcKbq6CRrRLInJ7t1VKKy0qGWbbuLT6nKGFqP+PaeJcVePZZGgfodcEPcG3eSIwxp1ZLybJ59418ctegQUSXa3I9PFA0z1v3h6IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYDDH2iB; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYDDH2iB"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e5adc977ecso913439137.3;
        Sat, 07 Jun 2025 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749318435; x=1749923235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0HtmixaPnq1Qji+pDj7COkdaT233I8i2sd/13Va1Ag=;
        b=LYDDH2iB7+6NiEaArQn9EQIkBgHGoIcMXyKmrvbPPJbVW1XeOQ2EvLJ23ehg/oISDO
         ouxyV3eiZljpRXRBHIl0Az5dZS9gAM7OTzpemAztaSzC3/FHaFMIr36PZx52jm56//FL
         B6uMXeI2zrsMuWdOjK2bYmhNkGqFkd5Q8+Q5fuStWsPy6EUMJD5Ho2rwRbIxZshhlkSg
         qVd+moY3T+Zd4uP3KaUgf5x5gR1TNbIGSQU2f1ooSbag1Nta7Jns6wc4UGVlFxSMJIHl
         2qF7pSLsRHMrc8wZlYZiE9GxnG44F6CkIWNq5OHU/CasXBXWvsfvJoRKwm5TJU5NwDKU
         uJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749318435; x=1749923235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0HtmixaPnq1Qji+pDj7COkdaT233I8i2sd/13Va1Ag=;
        b=M9zwu1mPZPlmLqsl5XzCI/WcW6UabrhNcNWW0zIC+vA29Rd07DcsAR8OsvzFisxHVQ
         EhxT4izjR/vlmAqd+Y8eQfA6P+bDreuiVt+NJbV6X2EOMPdEM3pqB1voFMoBjo7NNnMg
         s7EsUjdVyOEm5LROy7BJMGYs0px9rB4en5cuzXcpwvLiRcQeub286iFuokGpzTHRYINe
         e/G2A66TWTSmvqfKcydpu2QaOSUnwVI8RQPAl8eq/zHFgkQzI7qBBu1oPdAMTwDqScO6
         GfIh3y/2KGIw7ENPNosd5j9mbxRWkIRGizjFZsKzpkIVcfInMMlig+K0rG5kItReaWyF
         Qpyg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+DKBaBAG/Y7DAHXnNHULNHYOfldfZ1k+VX3Vi5cSfP5WvON9CAgZxe2Br78i8xjiH1pKHjxf+5Yd@vger.kernel.org, AJvYcCWG9TR8AaB/RvUsEANiCCHNAZdEatwgy9aqCbbw4GibyfcpWRdN8rVUXuslJ1FfHgS4jTvah25r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2uJgNa6aTcGD0VkYefGEo/mFbTyEdbhfPgcxasJVtFOi0YcK
	VcMenhozS9Vs7bZs7Od3vFrIp3HQdgZQDFlmf+viGAQS1+Db6I1YRz3sBHNdzO4TyU5bGpOj+/a
	AHHvfnMw2KtoIdlGmMdNWd6qW+Z7rGcw=
X-Gm-Gg: ASbGncu8Eas8bo9uelwvAqWg53dd+Up0sBa7ztSJLwH0/flc1ZRZlrLZEnwHEpqmGPd
	+f05Vt3Gp4RoGP5WcVKuV7XSwAkmSgM9g9kgXWRVgGusZ72NNoSf4PV8i5eR4UK7/fhxs2nKmx6
	vWNMrI8b1jWR/kLSpnhQZVEAMNG64O+eytrynsWcTqWZ7TG5LuD1J/EQ==
X-Google-Smtp-Source: AGHT+IFslCdLEsIhROC3CkosN5qx9XFOcqg5eJG9DqfXn0injx1KGC5W910pNlg0aASsFcFVSYa12/HSxbk/G7rFdFM=
X-Received: by 2002:a05:6102:3e85:b0:4e5:996d:f23c with SMTP id
 ada2fe7eead31-4e772ab6c92mr6710733137.20.1749318435531; Sat, 07 Jun 2025
 10:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com> <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
In-Reply-To: <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
From: Ramon Fontes <ramonreisfontes@gmail.com>
Date: Sat, 7 Jun 2025 14:47:04 -0300
X-Gm-Features: AX0GCFtTtFNgkoP2nCj_twX7DtSTNObcZwPE9UVz9g34KjC1Z0unbD8jqqNihYg
Message-ID: <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Alexander Aring <aahringo@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex, thanks for the feedback!

You're right, using AF_PACKET raw sockets on a monitor-mode wpan_dev
is indeed sufficient for user-space access to the raw PHY, and we=E2=80=99v=
e
also tested that setup successfully for basic communication.

However, if the use case focuses on evaluating realistic wireless
scenarios, where connectivity and interference vary across links. For
that, we rely on wmediumd, which integrates at the PHY level
(mac802154_hwsim) and controls per-link delivery based on configurable
SNR values and propagation models (e.g., log-distance, shadowing).
This allows us to emulate asymmetric topologies and partial
connectivity, something raw sockets alone cannot provide (or can?),
since all virtual radios are fully connected by default.

In this context, wmediumd becomes essential for simulating:

- Packet loss due to weak signal or distance;
- Asymmetric links (e.g., node A hears B, but not vice versa);
- Controlled interference between nodes;
- Link-specific behaviors needed for higher-layer protocol evaluation.

Additionally, by inducing realistic transmission failures, wmediumd
allows us to test MAC-layer features like retransmission (ARET) and
ACK handling (AACK) in a meaningful way, which would not be triggered
in a fully-connected environment.

Let me know if you'd like me to elaborate further or clarify anything
about this.

-
Ramon


Em s=C3=A1b., 7 de jun. de 2025 =C3=A0s 14:27, Alexander Aring
<aahringo@redhat.com> escreveu:
>
> Hi,
>
> On Tue, Jun 3, 2025 at 3:05=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmai=
l.com> wrote:
> >
> > This PR introduces support for use space tools such as wmediumd in the =
mac802154_hwsim kernel module, similar to the existing support for Wi-Fi si=
mulations via mac80211_hwsim. With this addition, it becomes possible to si=
mulate interference and control transmission behavior in IEEE 802.15.4 netw=
orks using a userspace backend.
> >
>
> that is already being possible by using raw sockets, what is the
> difference here? Depending on your use case it might depend on what
> kind of mac instance "wpan_dev" is created on top of your phy. If you
> just want to have bare phy access you are looking into monitor wpan
> dev types and using AF_PACKET raw sockets. I already connected user
> space stacks (only for development) with it.
>
> If you want to have ARET/AACK support, the answer is more complicated.
>
> - Alex
>
