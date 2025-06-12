Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2B18C91F
	for <linux-wpan@vger.kernel.org>; Thu, 12 Jun 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730842; cv=none; b=kAKSbPkcGkQrRBrrCKgclHcU+Z8oQDy1bgKg/qzyZ08/FSZVdMvuu1oJQu00uP7L2l+lVnbU+0srB0pRGgowLGIM0LoGCKcaCzoAu0BB5qE1G/lzecAvwL6GkeMV5HRkqqBNLVgJHytLHR9rsS8N7z9cAtKv2bAYdE0JyCpjKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730842; c=relaxed/simple;
	bh=5bRrnNEVmzlKHFuvGJz829HCaC9P8gvdVF/SVBGl75A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB+9smRP69pbeXIOxxFEUD+kLdcsIYqLG/aa/qWGSKdtAOr2Pf8xoirCyzG3r+v4h57eIebyjp4SaK1jvK3/6oeY+tX/BOT7bPSagiKjyAHpKiVkVjj81ssTF91/7C9M+TUWZ9SLuH+dBA8GgVbAkpUbTdu0qdzWXAW+eZ+v4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPVFUpT9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPVFUpT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749730839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPfKLRrYHfLESVYSuhn1tsLnMTuW/HBaOWGxzDd/vYM=;
	b=CPVFUpT9mvqPlZ6feu4S4ReUXG1tng/nR3bv5AaUFNL/voUI71QK7qJTMWFnZSn/Mbn9KY
	Lmoilbh0NMgrKCObK1vW+k3T38g/acF2GciiI+olOEFRqUKNStssp85lm1L5o6KF2KCzf3
	vS5do7WPgFtS45THnbutJMUccEb8K68=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-n7nqUstuO3qeDNTrg4H_LQ-1; Thu, 12 Jun 2025 08:20:38 -0400
X-MC-Unique: n7nqUstuO3qeDNTrg4H_LQ-1
X-Mimecast-MFC-AGG-ID: n7nqUstuO3qeDNTrg4H_LQ_1749730837
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32ac7176fc6so4350701fa.2
        for <linux-wpan@vger.kernel.org>; Thu, 12 Jun 2025 05:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730837; x=1750335637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPfKLRrYHfLESVYSuhn1tsLnMTuW/HBaOWGxzDd/vYM=;
        b=tvlVakugch1brO5JcUdCzGI3g668n18puDLzgrMybTSy+DDW/AyeLHc3Qy3+7zlshK
         2OuN3nkmmDujehC4wL9IODQd5Do5C9qQZ3Uymqkt1M2nIW2OlYmUBAl+7mbxQ3Jvo0SQ
         d2mkM5Edp2Y/svAjbnXhU0TlkQXOQEnYGLwtUUfkl+Z+9Wz8XRsCnxtrk9b1+Zy9ICvM
         hHO0Juso8mqMd/LyKALCzx5aIDj6BMMZ0Yt1ef61rsBsk66htkNCfzgxRAWTV786/DDE
         vH/qd0q0wlSLSYMV4yadfrRaWRRmDDUxB+HwcZCyEI7AjjGCZi1FRPQgDtb0381eduH+
         bA/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbX1ty9315XPXjT1kdq44NACceDJXdz7qA8RjIwshIS++en1PMKF52w4VxQL/bYIHUSE0fYWrAcZ7w@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhqSHTqA7LdzoiVDJ96UQZre4VZH7qJwgY+/c7aBiGdX7epa7
	2V7j9NaYs7+10iEaADQTT6X7r+0U0zkQXEpAvnqip0K83Ax4vAXCHmjXU8K+rAd8kTvHrS9qsQ0
	r2/xmEAjW00uTNJvyiDFqo4298UFEqnoA6AUHSz4E772MmtX+OvBinBUQWO1wKXrxAakp7suJLm
	TL+u5C6KiZptY6wGAWuuSiVLYQ0HKcda8jTEoeDQ==
X-Gm-Gg: ASbGnctukWMLOkJ/IFFyPy8bC55ULEjZc+EPFEVV50/a1CYCD0I6LzqYogOBvmd8JYr
	5wIyZHkVRZZInKRr7jv+pqVA1zzq/djbNGVBjj5/0GP/5yuyrJQbbMAkxO80xv6UHbNxPCnV1fu
	KkD1nkoT6Uro6pa7zGvhwrpRJa50nyUTvxJvI7
X-Received: by 2002:a2e:bc06:0:b0:32a:8764:ecf1 with SMTP id 38308e7fff4ca-32b305a2930mr8945091fa.4.1749730836609;
        Thu, 12 Jun 2025 05:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/BRLhB+dI1MyJZUrONMgznWLw3sFvTM95ZQN6Otaa7RRDpDwmHoTs3n884g8T5EAi+/5hXHBR3+PFLpM5qLc=
X-Received: by 2002:a2e:bc06:0:b0:32a:8764:ecf1 with SMTP id
 38308e7fff4ca-32b305a2930mr8945001fa.4.1749730836240; Thu, 12 Jun 2025
 05:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610105338.8166-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250610105338.8166-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 12 Jun 2025 08:20:24 -0400
X-Gm-Features: AX0GCFt_G8IDREkiLGFZvfp8ckIRZQKTzQ1w2HU0-HtCyraui5l54w_Y5s2s7H4
Message-ID: <CAK-6q+jDa4=DFndeQVzpaWemDPxf5Pr6Mrimm8ruDSsTriOmSw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 10, 2025 at 6:54=E2=80=AFAM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> Add a module parameter radios to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter radios
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>
> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..bf6554669 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, int, 0444);

this needs to be uint, and I think you had that in the last versions
as I said in the last version.

Sorry but letting that through there will be the next bot detecting
this and somebody else fixing it and I kind of was aware of it.
(Now I have some half of an idea to maybe get rid of that parameter).

- Alex

